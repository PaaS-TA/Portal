package org.openpaas.paasta.portal.autoscaling.controller;

import org.codehaus.jettison.json.JSONException;
import org.openpaas.paasta.portal.autoscaling.common.Common;
import org.openpaas.paasta.portal.autoscaling.service.AutoScalingService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.http.HttpMethod;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;


/**
 * Auto 스케일링 컨트롤러 - 포탈에서 설정된 앱들의 Auto 스케일링 동작을 수행한다.
 *
 * @author 조민구
 * @version 1.0
 * @since 2016.11.4 최초작성
 */
@RestController
@Component
@EnableAsync
public class AutoScalingController implements CommandLineRunner {

    private static final Logger LOGGER = LoggerFactory.getLogger(AutoScalingController.class);

    /**
     * The Common.
     */
    @Autowired
    public Common common;

    /**
     * The Auto scaling service.
     */
    @Autowired
    public AutoScalingService autoScalingService;

    @Autowired
    private StringRedisTemplate redis;

    /**
     * Auto 스케일링 run 실행 메서드이다.
     *
     */
    @Override
    public void run(String... args) throws Exception {
        autoScalingStopAll();
        Thread.sleep(30000);
        autoScalingStartAll();
    }

    /**
     * Auto 스케일링을 재시작한다.
     *
     * @param guid the guid
     * @throws JSONException        the json exception
     * @throws InterruptedException the interrupted exception
     */
    @RequestMapping(value = {"/autoScalingRestart/{guid}"}, method = RequestMethod.GET)
    public void autoScalingRestart(@PathVariable String guid) throws JSONException, InterruptedException {
        ValueOperations<String, String> redisValue = redis.opsForValue();

        LOGGER.info("getAppAutoScaleList: guid " + guid + " / redisValue: " + redisValue.get(guid));

        if (redisValue.get(guid) != null && redisValue.get(guid).equals("running")) {
            redisValue.set(guid, "restart");
        } else if (redisValue.get(guid) == null || redisValue.get(guid).equals("stop")) {
            redisValue.set(guid, "restart");
            autoScalingService.threadAppAutoScaling(guid);
        }
    }

    /**
     * Auto 스케일링을 전체 앱에서 시작한다.
     *
     * @throws Exception the exception
     */
    @RequestMapping(value = {"/autoScalingStartAll"}, method = RequestMethod.GET)
    public void autoScalingStartAll() throws Exception {

        ValueOperations<String, String> redisValue = redis.opsForValue();

        Random random = new Random();
        Thread.sleep(random.nextInt(2000)); // 0 ~ 2초 사이의 wait

        HashMap map = new HashMap();
        map.put("guid", null);

        //모든 앱의 Auto Scaling 설정 정보 조회
        Map result = common.procRestTemplate("/app/getAppAutoScaleList", HttpMethod.POST, map, null);
        LOGGER.info("name: " + result.get("list"));

        List<HashMap> list = (List<HashMap>) result.get("list");

        for (int i = 0; i < list.size(); i++) {
            if ("Y".equals(list.get(i).get("autoIncreaseYn")) || "Y".equals(list.get(i).get("autoDecreaseYn"))) {

                String guid = (String) list.get(i).get("guid");
                String app = (String) list.get(i).get("app");

                LOGGER.info("redisValue: " + redisValue.get(guid));

                if (redisValue.get(guid) == null || !redisValue.get(guid).equals("running")) {

                    redisValue.set(guid, "running");
                    LOGGER.info("Running AutoScaling: " + app + "(" + guid + ")");

                    autoScalingService.threadAppAutoScaling((String) list.get(i).get("guid"));

                    Thread.sleep(2300);
                }

            }

        }

    }


    /**
     * Auto 스케일링이 전체 앱에서 정지된다.
     *
     * @throws JSONException        the json exception
     * @throws InterruptedException the interrupted exception
     */
    @RequestMapping(value = {"/autoScalingStopAll"}, method = RequestMethod.GET)
    public void autoScalingStopAll() throws JSONException, InterruptedException {

        ValueOperations<String, String> redisValue = redis.opsForValue();

        HashMap map = new HashMap();
        map.put("guid", null);
        try {
            //모든 앱의 Auto Scaling 설정 정보 조회
            Map result = common.procRestTemplate("/app/getAppAutoScaleList", HttpMethod.POST, map, null);
            LOGGER.info("name: " + result.get("list"));

            List<HashMap> list = (List<HashMap>) result.get("list");

            for (int i = 0; i < list.size(); i++) {
                String guid = (String) list.get(i).get("guid");
                String app = (String) list.get(i).get("app");
                redisValue.set(guid, "stop");
            }

            LOGGER.info("Stop All AutoScaling !!!! ");


        } catch (Exception e) {
            LOGGER.info("getAppAutoScaleList: " + e.getMessage());
        }
    }
}