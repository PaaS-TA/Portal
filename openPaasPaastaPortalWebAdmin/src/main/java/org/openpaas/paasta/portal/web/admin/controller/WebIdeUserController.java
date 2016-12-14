package org.openpaas.paasta.portal.web.admin.controller;

import org.openpaas.paasta.portal.web.admin.common.Common;
import org.openpaas.paasta.portal.web.admin.model.ConfigInfo;
import org.openpaas.paasta.portal.web.admin.model.WebIdeUser;
import org.openpaas.paasta.portal.web.admin.service.CommonService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.Map;

/**
 * Org Controller
 *
 * @author nawkm
 * @version 1.0
 * @since 2016.8.29 최초작성
 */
@Controller
public class WebIdeUserController extends Common {

    //private static final Logger LOGGER = LoggerFactory.getLogger(WebIdeUserController.class);

    @Autowired
    private CommonService commonService;

    /**
     * WEB IDE 화면
     *
     * @return
     */
    @RequestMapping(value = {"/webIdeUser/webIdeUserMain"}, method = RequestMethod.GET)
    public ModelAndView webIdeUser() {
        ModelAndView mv = new ModelAndView();

        mv.setViewName("webIdeUser/webIdeUserMain");

        return mv;
    }


    /**
     * WEB IDE 유저 조회
     *
     * @param webIdeUser the ConfigInfo
     * @return ModelAndView model
     */
    @RequestMapping(value = {"/webIdeUser/getUser"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getUser(@RequestBody WebIdeUser webIdeUser)  {

        return commonService.procRestTemplate("/webIdeUser/getUser", HttpMethod.POST, webIdeUser, null);

    }

    /**
     * WEB IDE 정보 수정
     *
     * @param webIdeUser the webIdeUser
     * @return ModelAndView model
     */
    @RequestMapping(value = {"/webIdeUser/updateUser"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> updateValue(@RequestBody WebIdeUser webIdeUser)  {

        return commonService.procRestTemplate("/webIdeUser/updateUser", HttpMethod.POST, webIdeUser, null);
    }


    /**
     * WEB IDE 유저 삭제
     *
     * @param webIdeUser the webIdeUser
     * @return ModelAndView model
     */
    @RequestMapping(value = {"/webIdeUser/deleteUser"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> deleteUser(@RequestBody WebIdeUser webIdeUser)  {

        return commonService.procRestTemplate("/webIdeUser/deleteUser", HttpMethod.POST, webIdeUser, null);

    }

    /**
     * WEB IDE 리스트 조회
     *
     */
    @RequestMapping(value = {"/webIdeUser/getList"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getList(@RequestBody WebIdeUser webIdeUser)  {

        return commonService.procRestTemplate("/webIdeUser/getList", HttpMethod.POST, webIdeUser, null);

    }

}

