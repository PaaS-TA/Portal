package org.openpaas.paasta.portal.web.user.controller;

import org.openpaas.paasta.portal.web.user.common.Common;
import org.openpaas.paasta.portal.web.user.model.Service;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Map;

/**
 * 서비스 컨트롤 - 서비스 목록 , 서비스 상세 정보, 서비스 인스턴스 추가, 서비스 인스턴스 수정, 서비스 인스턴스 삭제 등 서비스 인스턴스 관리를  제공한다.
 *
 * @author 조민구
 * @version 1.0
 * @since 2016.4.4 최초작성
 */
@Controller
public class ServiceController extends Common {

    private static final Logger LOGGER = LoggerFactory.getLogger(ServiceController.class);


    /**
     * 서비스 인스턴스를 조회한다.
     *
     * @param service the service
     * @return String rspApp
     */
    @RequestMapping(value = {"/service/getServiceInstance"}, method = RequestMethod.POST)
    @ResponseBody
    public String getServiceInstance(@RequestBody Service service) {

        String rspApp = "";


        LOGGER.info("getServiceInstance Start : " + service.getGuid());

        ResponseEntity rssResponse = commonService.procRestTemplate("/service/getServiceInstance", HttpMethod.POST, service, getToken(), String.class);
        rspApp = (String) rssResponse.getBody();

        LOGGER.info("getServiceInstance End ");

        return rspApp;
    }

    /**
     * 서비스 인스턴스 이름을 변경한다.
     *
     * @param service the service
     * @return String rspApp
     */
    @RequestMapping(value = {"/service/renameInstanceService"}, method = RequestMethod.POST)
    @ResponseBody
    public String renameInstanceService(@RequestBody Service service) {

        String rspApp = "";

        LOGGER.info("renameInstanceService Start : " + service.getGuid());

        ResponseEntity rssResponse = commonService.procRestTemplate("/service/renameInstanceService", HttpMethod.POST, service, getToken(), String.class);
        rspApp = (String) rssResponse.getBody();

        LOGGER.info("renameInstanceService End ");

        return rspApp;
    }


    /**
     * 앱-서비스 연결을 해제한다.
     *
     * @param service the service
     * @return String rspApp
     */
    @RequestMapping(value = {"/service/deleteInstanceService"}, method = RequestMethod.POST)
    @ResponseBody
    public String deleteInstanceService(@RequestBody Service service) {

        String rspApp = "";


        LOGGER.info("deleteInstanceService Start : " + service.getGuid());

        ResponseEntity rssResponse = commonService.procRestTemplate("/service/deleteInstanceService", HttpMethod.POST, service, getToken(), String.class);
        rspApp = (String) rssResponse.getBody();

        LOGGER.info("deleteInstanceService End ");

        return rspApp;
    }


    /**
     * 바운드앱에 의해 앱-서비스 연결을 해제한다,
     *
     * @param service the service
     * @return String rspApp
     */
    @RequestMapping(value = {"/service/deleteInstanceServiceForBoundApp"}, method = RequestMethod.POST)
    @ResponseBody
    public String deleteInstanceServiceForBoundApp(@RequestBody Service service) {
        String rspApp = "";
        ResponseEntity rssResponse = commonService.procRestTemplate("/service/deleteInstanceServiceForBoundApp", HttpMethod.POST, service, getToken(), String.class);
        rspApp = (String) rssResponse.getBody();

        return rspApp;
    }


    /**
     * 유저 프로바이디드 서비스 인스턴스를 조회한다.
     *
     * @param body the service
     * @return Map<String Object> rspApp
     */
    @RequestMapping(value = {"/service/getUserProvidedService"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getUserProvidedService(@RequestBody Map body) {
        LOGGER.info("getUserProvidedService Start");

        ResponseEntity rssResponse = commonService.procRestTemplate("/service/getUserProvidedService", HttpMethod.POST, body, getToken(), Map.class);
        Map<String, Object> userProvidedServiceInstance = (Map) rssResponse.getBody();

        LOGGER.info("getUserProvidedService End ");

        return userProvidedServiceInstance;
    }


    /**
     * 유저 프로바이드 서비스를 생성한다.
     *
     * @param body the body
     * @return boolean boolean
     */
    @RequestMapping(value = {"/service/createUserProvidedService"}, method = RequestMethod.POST)
    @ResponseBody
    public boolean createUserProvidedService(@RequestBody Map body) {

        LOGGER.info("createUserProvidedService Start ");

        commonService.procRestTemplate("/service/createUserProvidedService", HttpMethod.POST, body, getToken(), Boolean.class);

        LOGGER.info("createUserProvidedService End ");

        return true;
    }

    /**
     * 유저 프로바이드 서비스를 수정한다.
     *
     * @param body the body
     * @return boolean boolean
     */
    @RequestMapping(value = {"/service/updateUserProvidedService"}, method = RequestMethod.POST)
    @ResponseBody
    public boolean updateUserProvidedService(@RequestBody Map body) {

        LOGGER.info("updateUserProvidedService Start ");

        commonService.procRestTemplate("/service/updateUserProvidedService", HttpMethod.POST, body, getToken(), Boolean.class);

        LOGGER.info("updateUserProvidedService End ");

        return true;
    }


    /**
     * 서비스 이미지를 가져온다.
     *
     * @param service the service
     * @return app image url
     * @author 김도준
     * @version 1.0
     * @since 2016.6.30 최초작성
     */
    @RequestMapping(value = {"/service/getServiceImageUrl"}, method = RequestMethod.POST)
    @ResponseBody
    public String getAppImageUrl(@RequestBody Service service) {

        LOGGER.info("getServiceImageUrl Start");

        HttpEntity rssResponse = commonService.procRestTemplate("/service/getServiceImageUrl", HttpMethod.POST, service, getToken(), String.class);
        String imageUrl = (String) rssResponse.getBody();

        LOGGER.info("getServiceImageUrl End");

        return imageUrl;
    }



}
