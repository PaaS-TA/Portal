package org.openpaas.paasta.portal.autoscaling.service;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import org.openpaas.paasta.portal.autoscaling.common.Common;
import org.openpaas.paasta.portal.autoscaling.model.App;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import java.util.HashMap;
import java.util.Map;


/**
 * Auto 스케일링 서비스 - 포탈에서 설정된 앱들의 Auto 스케일링 동작을 수행한다.
 *
 * @author 조민구
 * @version 1.0
 * @since 2016.11.4 최초작성
 */
@Component
@EnableAsync
public class AutoScalingService {

    private static final Logger LOGGER = LoggerFactory.getLogger(AutoScalingService.class);
    /**
     * The Monitor api url.
     */
    @Value("${paasta.portal.api.monitor}")
    public String monitor_api_url;
    /**
     * The Common.
     */
    @Autowired
    public Common common;
    /**
     * The Rest template.
     */
    @Autowired
    public RestTemplate restTemplate;
    @Autowired
    private StringRedisTemplate redis;


    /**
     * 앱들을 Auto 스케일링 쓰레드로 처리한다.
     *
     * @param guid the guid
     * @throws InterruptedException the interrupted exception
     * @throws JSONException        the json exception
     */
    @Async
    public void threadAppAutoScaling(String guid) throws InterruptedException, JSONException {

        ValueOperations<String, String> redisValue = redis.opsForValue();

        Double memQuota;
        int memQuotaMb;
        String result = "";

        HashMap map = new HashMap();
        map.put("guid", guid);


        //Auto Scaling 설정 정보 DB 조회
        Map appInfoList = common.procRestTemplate("/app/getAppAutoScaleInfo", HttpMethod.POST, map, null);
        //LOGGER.info("appInfo: " + appInfoList);
        Map appInfo = (Map) appInfoList.get("list");

        try {
            if (appInfo.get("autoIncreaseYn") == null || (appInfo.get("autoIncreaseYn").equals("N") && appInfo.get("autoDecreaseYn").equals("N"))) {
                LOGGER.info("---------------------------------------------------------------------------");
                LOGGER.info("threadAppAutoScaling Stop !!!!! - " + appInfo.get("app") + " (" + guid + ")");
                redisValue.set(guid, "stop");
                return;
            }
        } catch (Exception e) {
            return;
        }

        App app = new App();
        app.setGuid(guid);
        app.setName((String) appInfo.get("app"));
        app.setOrgName((String) appInfo.get("org"));
        app.setSpaceName((String) appInfo.get("space"));

        try {

            //CF API - 메모리 할당량 조회
            HttpEntity rssResponse = common.procRestTemplate("/app/getAppStats", HttpMethod.POST, app, common.getToken(), String.class);
            String rspApp = (String) rssResponse.getBody();
            JSONObject jsonObjCf = new JSONObject(rspApp);
            memQuota = jsonObjCf.getJSONObject("0").getJSONObject("stats").getDouble("mem_quota");
            memQuotaMb = (int) (memQuota / 1024 / 1024);

        } catch (Exception e) {
            LOGGER.info("getAppStats: " + e.getMessage() + " : " + app.getName() + " (" + guid + ")");
            Thread.sleep((int) appInfo.get("checkTimeSec") * 1000);
            threadAppAutoScaling(guid);
            return;
        }

        while (true) {

            //스케일링 정지/재시작 신호 감지시..
            if (redisValue.get(guid) == null || redisValue.get(guid).equals("stop")) {
                LOGGER.info("threadAppAutoScaling Stop !!!!! - " + appInfo.get("app") + " (" + guid + ")");
                return;

            } else if (redisValue.get(guid).equals("restart")) {
                redisValue.set(guid, "running");
                LOGGER.info("---------------------------------------------------------------------------");
                LOGGER.info("threadAppAutoScaling Restart !!!!! - " + app.getName() + " (" + guid + ")");
                Thread.sleep(30000);
                threadAppAutoScaling(guid);
                return;
            }


            try {
                //CPU, 메모리 사용량 조회
                restTemplate = new RestTemplate();
                result = restTemplate.getForObject(monitor_api_url + "/container/metrics/" + guid, String.class);

            } catch (Exception e) {
                LOGGER.info("Metrics Server can't connect.");
                Thread.sleep((int) appInfo.get("checkTimeSec") * 1000);
                continue;
            }

            JSONArray jsonArray = new JSONArray(result);

            int instanceCnt = jsonArray.length();


            Long totMemoryBytes = Long.valueOf(0);
            Double totCpuPercentage = Double.valueOf(0);
            //인스턴스 평균값 구하기
            for (int i = 0; i < instanceCnt; i++) {
                JSONObject jsonObj = jsonArray.getJSONObject(i);
                totMemoryBytes += (Long.parseLong(jsonObj.getString("memoryBytes")) / jsonArray.length());
                totCpuPercentage += (Double.parseDouble(jsonObj.getString("cpuPercentage")) / jsonArray.length());
            }

            LOGGER.info("AutoScaling Operating !!!!! - " + app.getName() + " (" + guid + ")" + " memoryUsageBytes: " + totMemoryBytes / memQuota + "% cpuPercentage: " + totCpuPercentage);

            //메모리 점유율 초과
            if (totMemoryBytes / memQuota * 100 >= (int) appInfo.get("memoryMaxSize") && appInfo.get("autoIncreaseYn").equals("Y")) {

                //인스턴스 max 갯수보다 작다면 동작
                if ((int) appInfo.get("instanceMaxCnt") > instanceCnt) {
                    app.setInstances(instanceCnt + 1);
                    try {
                        common.procRestTemplate("/app/updateApp", HttpMethod.POST, app, common.getToken(), Boolean.class);
                    } catch (Exception e) {
                        LOGGER.info("instance Scale Out Fail!");
                        Thread.sleep((int) appInfo.get("checkTimeSec") * 10000);
                        continue;
                    }

                    LOGGER.info("---------------------------------------------------------------------------");
                    LOGGER.info(instanceCnt + 1 + " instance Scale Out !!!!!");
                    Thread.sleep(120000);
                    threadAppAutoScaling(guid);
                    return;
                }
                //메모리 점유율 하향
            } else if (totMemoryBytes / memQuota * 100 <= (int) appInfo.get("memoryMinSize") && appInfo.get("autoDecreaseYn").equals("Y")) {

                //인스턴스 min 갯수보다 크다면 동작
                if ((int) appInfo.get("instanceMinCnt") < instanceCnt) {
                    app.setInstances(instanceCnt - 1);
                    try {
                        common.procRestTemplate("/app/updateApp", HttpMethod.POST, app, common.getToken(), Boolean.class);
                    } catch (Exception e) {
                        LOGGER.info("instance Scale Out Fail!");
                        Thread.sleep((int) appInfo.get("checkTimeSec") * 10000);
                        continue;
                    }

                    LOGGER.info("---------------------------------------------------------------------------");
                    LOGGER.info(instanceCnt - 1 + " instance Scale Out !!!!!");
                    Thread.sleep(120000);
                    threadAppAutoScaling(guid);
                    return;
                }
            }


            Thread.sleep((int) appInfo.get("checkTimeSec") * 1000);


        }
    }
}
