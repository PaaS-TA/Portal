package org.openpaas.paasta.portal.api.controller;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;
import org.openpaas.paasta.portal.api.common.Common;
import org.openpaas.paasta.portal.api.common.Constants;
import org.openpaas.paasta.portal.api.service.AppAutoScaleModalService;
import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

import static org.slf4j.LoggerFactory.getLogger;

@RestController
@Transactional
@JsonIgnoreProperties(ignoreUnknown = true)
@RequestMapping(value = {"/app"})
public class AppAutoScaleModalController extends Common {

    private final Logger LOGGER = getLogger(this.getClass());
    @Autowired
    private AppAutoScaleModalService appAutoScaleModalService;

    @ResponseBody
    @RequestMapping(value = {"/getAppAutoScaleInfo"}, method = RequestMethod.POST)
    public Map<String, Object> getAppAutoScaleInfo(@RequestBody HashMap appAutoScale, HttpServletResponse response) {

        String guid = (null == appAutoScale.get("guid")) ? "" : appAutoScale.get("guid").toString();
        LOGGER.info("guid : "+ guid+" : request : "+ response.toString());


        Map<String, Object> resultMap;
        resultMap = appAutoScaleModalService.getAppAutoScaleInfo(appAutoScale);
        return resultMap;
    }

    @ResponseBody
    @RequestMapping(value = {"/getAppAutoScaleList"}, method = RequestMethod.POST)
    public Map<String, Object> getAppAutoScaleList(@RequestBody HashMap appAutoScale, HttpServletResponse response) {

        String guid = (null == appAutoScale.get("guid")) ? "" : appAutoScale.get("guid").toString();
        LOGGER.info("guid : " + guid + " : request : " + response.toString());


        Map<String, Object> resultMap;
        resultMap = appAutoScaleModalService.getAppAutoScaleList(appAutoScale);
        return resultMap;
    }

    @ResponseBody
    @RequestMapping(value = {"/insertAppAutoScale"}, method = RequestMethod.POST)
    public Map<String, Object> insertAppAutoScale(@RequestBody HashMap<String, Object> appAutoScale, HttpServletResponse response) {
        int iRst  = appAutoScaleModalService.insertAppAutoScale(appAutoScale);
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("RESULT", Constants.RESULT_STATUS_SUCCESS);

        return resultMap;
    }
    @ResponseBody
    @RequestMapping(value = {"/updateAppAutoScale"}, method = RequestMethod.POST)
    public Map<String, Object> updateAppAutoScale(@RequestBody HashMap<String, Object> appAutoScale, HttpServletResponse response) {
        int iRst  = appAutoScaleModalService.updateAppAutoScale(appAutoScale);
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("RESULT", Constants.RESULT_STATUS_SUCCESS);

        return resultMap;
    }
    @ResponseBody
    @RequestMapping(value = {"/deleteAppAutoScale"}, method = RequestMethod.POST)
    public Map<String, Object> deleteAppAutoScale(@RequestBody HashMap<String, Object> appAutoScale, HttpServletResponse response) {
        String guid = (null == appAutoScale.get("guid")) ? "" : appAutoScale.get("guid").toString();
        int iRst  = appAutoScaleModalService.deleteAppAutoScale(guid);
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("RESULT", Constants.RESULT_STATUS_SUCCESS);

        return resultMap;
    }
}
