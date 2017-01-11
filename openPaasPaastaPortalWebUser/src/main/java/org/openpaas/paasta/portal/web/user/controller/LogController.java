package org.openpaas.paasta.portal.web.user.controller;

import org.openpaas.paasta.portal.web.user.common.Common;
import org.openpaas.paasta.portal.web.user.model.App;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

/**
 * 로그 컨트롤러 - 앱-최근로그를 조회한다.
 *
 * @author 이인정
 * @version 1.0
 * @since 2016.7.11 최초작성
 */
@Controller
public class LogController extends Common {

    private static final Logger LOGGER = LoggerFactory.getLogger(LogController.class);

    /**
     * 앱-최근로그 조회
     *
     * @param app      the app
     * @param response the response
     * @return ModelAndView model
     */
    @RequestMapping(value = {"/log/getRecentLogs"}, method = RequestMethod.POST)
    @ResponseBody
    public Map getRecentLogs(@RequestBody App app, HttpServletResponse response)  {

        Map rspApp = new HashMap();
        LOGGER.info("getRecentLogs Start : " + app.getName());

        ResponseEntity rssResponse = commonService.procRestTemplateV2("/app/getRecentLogs", HttpMethod.POST, app, getToken(), Map.class);
        rspApp = (HashMap) rssResponse.getBody();

        LOGGER.info("getRecentLogs End ");

        return rspApp;
    }

}

