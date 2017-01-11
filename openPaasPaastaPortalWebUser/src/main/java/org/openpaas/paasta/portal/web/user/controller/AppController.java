package org.openpaas.paasta.portal.web.user.controller;

import org.openpaas.paasta.portal.web.user.common.Common;
import org.openpaas.paasta.portal.web.user.model.App;
import org.openpaas.paasta.portal.web.user.model.Catalog;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

/**
 * 앱 컨트롤러 - 애플리케이션 정보 조회, 구동, 정지 등의 API 를 호출 받는 컨트롤러이다.
 *
 * @author 조민구
 * @version 1.0
 * @since 2016.4.4 최초작성
 */
@Controller
public class AppController extends Common {

    private static final Logger LOGGER = LoggerFactory.getLogger(AppController.class);

    @Autowired
    private RestTemplate restTemplate;

    @Value("${paasta.portal.api.autoSchedulerUrl}")
    private String autoSchedulerUrl;

    /**
     * 앱 메인의 화면이다.
     *
     * @return ModelAndView model
     */
    @RequestMapping(value = {"/app/appMain"}, method = RequestMethod.GET)
    public ModelAndView loginPage() {

        LOGGER.info("login : " + SecurityContextHolder.getContext().getAuthentication().getName());

        ModelAndView model = new ModelAndView();


        try {

            LOGGER.info("Authorization : " + getToken());

        } catch (Exception ex) {
            model.setViewName("index");
            return model;
        }

        model.setViewName("/app/appMain");
        return model;
    }


    /**
     * 앱 요약 정보를 조회한다.
     *
     * @param app the app
     * @return String rspApp
     */
    @RequestMapping(value = {"/app/getAppSummary"}, method = RequestMethod.POST)
    @ResponseBody
    public String getApp(@RequestBody App app) {

        String rspApp = "";

        LOGGER.info("getAppSummary Start : " + app.getGuid());

        rspApp = commonService.procRestTemplate("/app/getAppSummary", HttpMethod.POST, app, getToken(), String.class).getBody();

        LOGGER.info("getAppSummary End ");

        return rspApp;
    }

    /**
     * 앱 상태 정보를 조회한다.
     *
     * @param app the app
     * @return String rspApp
     */
    @RequestMapping(value = {"/app/getAppStats"}, method = RequestMethod.POST)
    @ResponseBody
    public String getAppStats(@RequestBody App app) {

        String rspApp = "";

        LOGGER.info("getApp Start : " + app.getGuid());


        HttpEntity rssResponse = commonService.procRestTemplate("/app/getAppStats", HttpMethod.POST, app, getToken(), String.class);
        rspApp = (String) rssResponse.getBody();

        LOGGER.info("getApp End ");

        return rspApp;
    }


    /**
     * 앱 명을 변경한다.
     *
     * @param app the app
     * @return boolean boolean
     */
    @RequestMapping(value = {"/app/renameApp"}, method = RequestMethod.POST)
    @ResponseBody
    public boolean renameOrg(@RequestBody App app) {


        LOGGER.info("Rename App Start : " + app.getName() + " : " + app.getNewName());

        commonService.procRestTemplate("/app/renameApp", HttpMethod.POST, app, getToken(), Boolean.class);
        LOGGER.info("Rename App End ");

        return true;
    }

    /**
     * 앱을 삭제한다.
     *
     * @param app the apps
     * @return boolean boolean
     */
    @RequestMapping(value = {"/app/deleteApp"}, method = RequestMethod.POST)
    @ResponseBody
    public boolean deleteApp(@RequestBody App app) {


        LOGGER.info("deleteApp Start : " + app.getName());

        commonService.procRestTemplate("/app/deleteApp", HttpMethod.POST, app, getToken(), Boolean.class);
        LOGGER.info("deleteApp End ");

        return true;
    }


    /**
     * 앱을 실행한다.
     *
     * @param app the apps
     * @return boolean boolean
     */
    @RequestMapping(value = {"/app/startApp"}, method = RequestMethod.POST)
    @ResponseBody
    public boolean startApp(@RequestBody App app) {


        LOGGER.info("startApp Start : " + app.getName());

        commonService.procRestTemplate("/app/startApp", HttpMethod.POST, app, getToken(), Boolean.class);
        LOGGER.info("startApp End ");

        return true;
    }


    /**
     * 앱을 중지한다.
     *
     * @param app the apps
     * @return boolean boolean
     */
    @RequestMapping(value = {"/app/stopApp"}, method = RequestMethod.POST)
    @ResponseBody
    public boolean stopApp(@RequestBody App app) {


        LOGGER.info("stopApp Start : " + app.getName());

        commonService.procRestTemplate("/app/stopApp", HttpMethod.POST, app, getToken(), Boolean.class);
        LOGGER.info("stopApp End ");

        return true;
    }


    /**
     * 앱 인스턴스을 변경한다.
     *
     * @param app the apps
     * @return boolean boolean
     */
    @RequestMapping(value = {"/app/updateApp"}, method = RequestMethod.POST)
    @ResponseBody
    public boolean updateApp(@RequestBody App app) {


        LOGGER.info("updateApp Start : " + app.getName());

        commonService.procRestTemplate("/app/updateApp", HttpMethod.POST, app, getToken(), Boolean.class);

        try {
            //Auto Scaling 재시작
            restTemplate.getForObject(autoSchedulerUrl + "/autoScalingRestart/" + app.getGuid(), String.class);
        } catch (Exception e) {
            LOGGER.info("autoScalingRestart : " + e.getMessage());
        }
        LOGGER.info("updateApp End ");


        return true;
    }


    /**
     * 앱을 리스테이징한다.
     *
     * @param app the apps
     * @return boolean boolean
     */
    @RequestMapping(value = {"/app/restageApp"}, method = RequestMethod.POST)
    @ResponseBody
    public boolean stageApp(@RequestBody App app) {


        LOGGER.info("restageApp Start : " + app.getName());

        commonService.procRestTemplate("/app/restageApp", HttpMethod.POST, app, getToken(), Boolean.class);
        LOGGER.info("restageApp End ");

        return true;
    }


    /**
     * 앱 이벤트를 조회한다.
     *
     * @param app the apps
     * @return String rspApp
     */
    @RequestMapping(value = {"/app/getAppEvents"}, method = RequestMethod.POST)
    @ResponseBody
    public String getAppEvents(@RequestBody App app) {

        String rspApp = "";

        LOGGER.info("getAppEvents Start : " + app.getGuid());

        HttpEntity rssResponse = commonService.procRestTemplate("/app/getAppEvents", HttpMethod.POST, app, getToken(), String.class);
        rspApp = (String) rssResponse.getBody();
        LOGGER.info("getAppEvents End ");

        return rspApp;
    }


    /**
     * 앱-서비스를 연결한다.
     *
     * @param catalog the apps
     * @return String rspApp
     */
    @RequestMapping(value = {"/app/bindService"}, method = RequestMethod.POST)
    @ResponseBody
    public String bindService(@RequestBody Catalog catalog) {

        String rspApp = "";

        LOGGER.info("bindService Start : " + catalog.getAppName());

        HttpEntity rssResponse = commonService.procRestTemplate("/app/bindService", HttpMethod.POST, catalog, getToken(), String.class);
        rspApp = (String) rssResponse.getBody();

        LOGGER.info("bindService End ");

        return rspApp;
    }


    /**
     * 앱-서비스의 연결을 해제한다.
     *
     * @param app the app
     * @return string string
     */
    @RequestMapping(value = {"/app/unbindService"}, method = RequestMethod.POST)
    @ResponseBody
    public String unbindService(@RequestBody App app) {

        String rspApp = "";

        LOGGER.info("unbindService Start : " + app.getGuid());

        HttpEntity rssResponse = commonService.procRestTemplate("/app/unbindService", HttpMethod.POST, app, getToken(), String.class);
        rspApp = (String) rssResponse.getBody();

        LOGGER.info("unbindService End ");

        return rspApp;
    }


    /**
     * 앱 세션값을 삽입한다.
     *
     * @param app     (자바 App 클래스)
     * @param session 세션
     * @return void
     * @author 김도준
     * @version 1.0
     * @since 2016.5.26 최초작성
     */
    @RequestMapping(value = {"/app/setAppSession"}, method = RequestMethod.POST)
    @ResponseBody
    public void setAppSession(@RequestBody App app, HttpSession session) {
        LOGGER.info("setAppSession Start");

        session.setAttribute("currentApp", app.getName());
        session.setAttribute("currentAppGuid", app.getGuid());

        LOGGER.info("setAppSession End");
    }


    /**
     * 앱 환경변수를 조회한다.
     *
     * @param app (자바 App 클래스)
     * @return Map (자바 클래스)
     * @author 김도준
     * @version 1.0
     * @since 2016.6.30 최초작성
     */
    @RequestMapping(value = {"/app/getApplicationEnv"}, method = RequestMethod.POST)
    @ResponseBody
    public Map getApplicationEnv(@RequestBody App app) {

        Map appEnv = new HashMap();


        LOGGER.info("getApplicationEnv Start");

        HttpEntity rssResponse = commonService.procRestTemplate("/app/getApplicationEnv", HttpMethod.POST, app, getToken(), Map.class);
        appEnv = (Map) rssResponse.getBody();

        LOGGER.info("getApplicationEnv End");

        return appEnv;
    }

    /**
     * 앱 환경변수 중 사용자 정의 환경변수를 추가, 수정한다.
     *
     * @param app (자바 App 클래스)
     * @return Map boolean
     * @author 김도준
     * @version 1.0
     * @since 2016.6.30 최초작성
     */
    @RequestMapping(value = {"/app/updateApplicationEnv"}, method = RequestMethod.POST)
    @ResponseBody
    public boolean updateApplicationEnv(@RequestBody App app) {

        LOGGER.info("updateApplicationEnv Start");

        commonService.procRestTemplate("/app/updateApplicationEnv", HttpMethod.POST, app, getToken(), boolean.class);
        LOGGER.info("updateApplicationEnv end");

        return true;
    }

    /**
     * 앱 uri(route + domain) 추가한다.
     *
     * @param app (자바 App 클래스)
     * @return boolean boolean
     * @author 김도준
     * @version 1.0
     * @since 2016.7.7 최초작성
     */
    @RequestMapping(value = {"/app/addApplicationRoute"}, method = RequestMethod.POST)
    @ResponseBody
    public boolean addApplicationRoute(@RequestBody App app) {

        LOGGER.info("addApplicationRoute Start");

        commonService.procRestTemplate("/app/addApplicationRoute", HttpMethod.POST, app, getToken(), boolean.class);
        LOGGER.info("addApplicationRoute end");

        return true;
    }

    /**
     * 앱 uri(route + domain) 제거한다.
     *
     * @param app (자바 App 클래스)
     * @return boolean boolean
     * @author 김도준
     * @version 1.0
     * @since 2016.7.7 최초작성
     */
    @RequestMapping(value = {"/app/removeApplicationRoute"}, method = RequestMethod.POST)
    @ResponseBody
    public boolean removeApplicationRoute(@RequestBody App app) {

        LOGGER.info("removeApplicationRoute Start");

        commonService.procRestTemplate("/app/removeApplicationRoute", HttpMethod.POST, app, getToken(), boolean.class);
        LOGGER.info("removeApplicationRoute end");

        return true;
    }

    /**
     * 라우트를 삭제한다.
     *
     * @param body (자바 Map 클래스)
     * @return boolean boolean
     * @author 김도준
     * @version 1.0
     * @since 2016.8.18 최초작성
     */
    @RequestMapping(value = {"/app/deleteRoute"}, method = RequestMethod.POST)
    @ResponseBody
    public boolean deleteRoute(@RequestBody Map body) {

        LOGGER.info("deleteRoute Start");

        commonService.procRestTemplate("/app/deleteRoute", HttpMethod.POST, body, getToken(), boolean.class);
        LOGGER.info("deleteRoute end");

        return true;
    }

    /**
     * 인덱스에 의해 앱 인스턴스를 중지시킨다.
     *
     * @param param (자바 App 클래스)
     * @return map map
     */
    @RequestMapping(value = {"/app/executeTerminateAppInstanceByIndex"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> executeTerminateAppInstanceByIndex(@RequestBody App param) {
        return commonService.procRestTemplate("/app/executeTerminateAppInstanceByIndex", HttpMethod.POST, param, this.getToken());
    }


    /**
     * 앱 이미지를 조회한다.
     *
     * @param app (자바 App 클래스)
     * @return imageUrl 이미지 url
     * @author 김도준
     * @version 1.0
     * @since 2016.6.30 최초작성
     */
    @RequestMapping(value = {"/app/getAppImageUrl"}, method = RequestMethod.POST)
    @ResponseBody
    public String getAppImageUrl(@RequestBody App app) {

        LOGGER.info("getAppImageUrl Start");

        HttpEntity rssResponse = commonService.procRestTemplate("/app/getAppImageUrl", HttpMethod.POST, app, getToken(), String.class);
        String imageUrl = (String) rssResponse.getBody();

        LOGGER.info("getAppImageUrl End");

        return imageUrl;
    }
}
