package org.openpaas.paasta.portal.web.admin.controller;

import org.openpaas.paasta.portal.web.admin.common.Common;
import org.openpaas.paasta.portal.web.admin.model.UserManagement;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.Map;

/**
 * 사용자 정보 컨트롤러
 *
 * @author rex
 * @version 1.0
 * @since 2016.08.31
 */
@Controller
@RequestMapping(value = {"/userManagement"})
public class UserManagementController extends Common {

    /**
     * 사용자 정보 메인페이지 이동
     *
     * @return user info main
     */
    @RequestMapping(value = {"/userManagementMain"}, method = RequestMethod.GET)
    public ModelAndView getUserInfoMain() {
        return new ModelAndView(){{setViewName("/userManagement/userManagementMain");}};
    }


    /**
     * 사용자 정보 목록 조회
     *
     * @param param the param
     * @return user info list
     */
    @RequestMapping(value = {"/getUserInfoList"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getUserInfoList(@RequestBody UserManagement param) {
        return commonService.procRestTemplate("/userManagement/getUserInfoList", HttpMethod.POST, param, this.getToken());
    }


    /**
     * 비밀번호 초기화
     *
     * @param param the param
     * @return map map
     */
    @RequestMapping(value = {"/setResetPassword"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> setResetPassword(@RequestBody UserManagement param) {
        return commonService.procRestTemplate("/userManagement/setResetPassword", HttpMethod.POST, param, this.getToken());
    }


    /**
     * 운영권한 부여
     *
     * @param param the param
     * @return map map
     */
    @RequestMapping(value = {"/updateOperatingAuthority"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> updateOperatingAuthority(@RequestBody UserManagement param) {
        return commonService.procRestTemplate("/userManagement/updateOperatingAuthority", HttpMethod.POST, param, this.getToken());
    }


    /**
     * 사용자 계정 삭제
     *
     * @param param the param
     * @return map map
     */
    @RequestMapping(value = {"/deleteUserAccount"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> deleteUserAccount(@RequestBody UserManagement param) {
        return commonService.procRestTemplate("/userManagement/deleteUserAccount", HttpMethod.POST, param, this.getToken());
    }
}
