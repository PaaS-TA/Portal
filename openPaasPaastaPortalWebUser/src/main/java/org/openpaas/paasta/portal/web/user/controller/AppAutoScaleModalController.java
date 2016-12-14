package org.openpaas.paasta.portal.web.user.controller;

import org.openpaas.paasta.portal.web.user.common.Common;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import javax.servlet.http.HttpServletResponse;
import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by ijlee on 2016-07-06.
 */
@Controller
@RequestMapping(value = {"/app"})
public class AppAutoScaleModalController extends Common {

    private static final Logger LOGGER = LoggerFactory.getLogger(AppAutoScaleModalController.class);

    @Autowired
    private RestTemplate restTemplate;

    @Value("${paasta.portal.api.autoSchedulerUrl}")
    private String autoSchedulerUrl;

    /**
     * 앱 AutoScaling info
     *
     * @param  appAutoScale the entity
     * @return Map result
     */
    @RequestMapping(value = "/getAppAutoScaleInfo", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getAppAutoScaleInfo(@RequestBody HashMap appAutoScale, HttpServletResponse response) {


        Map result = new HashMap();
        HttpHeaders requestHeaders = new HttpHeaders();
        if(null != appAutoScale) {
            String sMode = (null == appAutoScale.get("mode")) ? "" : appAutoScale.get("mode").toString();
            String sUrl = (null == appAutoScale.get("url")) ? "" : appAutoScale.get("url").toString();
            DecimalFormat df = new DecimalFormat("#0.00");
            String oCpuThresholdMinPer = null==appAutoScale.get("cpuThresholdMinPer") || appAutoScale.get("cpuThresholdMinPer") ==""?"0":appAutoScale.get("cpuThresholdMinPer").toString();
            String oCpuThresholdMaxPer = null==appAutoScale.get("cpuThresholdMaxPer") || appAutoScale.get("cpuThresholdMaxPer") ==""?"0":appAutoScale.get("cpuThresholdMaxPer").toString();
            double pCpuThresholdMinPer = Double.parseDouble(oCpuThresholdMinPer);
            double pCpuThresholdMaxPer = Double.parseDouble(oCpuThresholdMaxPer);

            pCpuThresholdMinPer = Double.parseDouble(df.format(pCpuThresholdMinPer/100));
            pCpuThresholdMaxPer = Double.parseDouble(df.format(pCpuThresholdMaxPer/100));
            appAutoScale.put("cpuThresholdMinPer",pCpuThresholdMinPer);
            appAutoScale.put("cpuThresholdMaxPer",pCpuThresholdMaxPer);

            if(!"".equals(sMode) || !"".equals(sUrl) ) {

                result = commonService.procRestTemplate(sUrl, HttpMethod.POST, appAutoScale, null);
            }


            try {
                if (appAutoScale.get("mode").equals("update") || appAutoScale.get("mode").equals("save")) {
                    //Auto Scaling 재시작
                    restTemplate.getForObject(autoSchedulerUrl + "/autoScalingRestart/" + appAutoScale.get("guid"), String.class);
                }
            } catch (Exception e) {
                LOGGER.info("autoScalingRestart : " + e.getMessage());
            }


        }
        return result;
    }
}
