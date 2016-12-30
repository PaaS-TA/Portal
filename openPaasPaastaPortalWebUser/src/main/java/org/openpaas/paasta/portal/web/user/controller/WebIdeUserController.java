package org.openpaas.paasta.portal.web.user.controller;

import org.openpaas.paasta.portal.web.user.common.Common;
import org.openpaas.paasta.portal.web.user.model.WebIdeUser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * WEB IDE 관리 컨트롤러 - WEB IDE 신청자를 관리하는 컨트롤러이다.
 *
 * @author 조민구
 * @version 1.0
 * @since 2016.8.29 최초작성
 */
@Controller
public class WebIdeUserController extends Common {

    private static final Logger LOGGER = LoggerFactory.getLogger(WebIdeUserController.class);

    /**
     * WEB IDE 사용자 정보를 조회한다.
     *
     * @param webIdeUser the webIdeUser
     * @return ModelAndView model
     */
    @RequestMapping(value = {"/webIdeUser/getUser"}, method = RequestMethod.POST)
    @ResponseBody
    public String getUser(@RequestBody WebIdeUser webIdeUser)  {

        String rspApp = "";
        LOGGER.info("getUser Start : " + webIdeUser.getUserId());

        ResponseEntity rssResponse = commonService.procRestTemplate("/webIdeUser/getUser", HttpMethod.POST, webIdeUser, getToken(), String.class);
        rspApp = (String) rssResponse.getBody();

        LOGGER.info("getUser End ");

        return rspApp;
    }

    /**
     * WEB IDE 사용자를 신청한다.
     *
     * @param webIdeUser the webIdeUser
     * @return ModelAndView model
     */
    @RequestMapping(value = {"/webIdeUser/insertUser"}, method = RequestMethod.POST)
    @ResponseBody
    public String insertUser(@RequestBody WebIdeUser webIdeUser)  {

        String rspApp = "";
        LOGGER.info("insertUser Start : " + webIdeUser.getUserId());

        ResponseEntity rssResponse = commonService.procRestTemplate("/webIdeUser/insertUser", HttpMethod.POST, webIdeUser, getToken(), String.class);
        rspApp = (String) rssResponse.getBody();

        LOGGER.info("insertUser End ");

        return rspApp;
    }

    /**
     * WEB IDE 사용자 신청을 취소한다.
     *
     * @param webIdeUser the webIdeUser
     * @return ModelAndView model
     */
    @RequestMapping(value = {"/webIdeUser/deleteUser"}, method = RequestMethod.POST)
    @ResponseBody
    public String deleteUser(@RequestBody WebIdeUser webIdeUser)  {

        String rspApp = "";
        LOGGER.info("deleteUser Start : " + webIdeUser.getUserId());

        ResponseEntity rssResponse = commonService.procRestTemplate("/webIdeUser/deleteUser", HttpMethod.POST, webIdeUser, getToken(), String.class);
        rspApp = (String) rssResponse.getBody();

        LOGGER.info("deleteUser End ");

        return rspApp;
    }

}

