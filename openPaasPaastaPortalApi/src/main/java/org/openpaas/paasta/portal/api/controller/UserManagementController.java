package org.openpaas.paasta.portal.api.controller;

import org.openpaas.paasta.portal.api.model.UserManagement;
import org.openpaas.paasta.portal.api.service.UserManagementService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

/**
 * 사용자 정보 컨트롤러
 *
 * @author rex
 * @version 1.0
 * @since 2016.08.31
 */
@RestController
@RequestMapping(value = {"/userManagement"})
public class UserManagementController {

    private final UserManagementService userManagementService;

    @Autowired
    public UserManagementController(UserManagementService userManagementService) {
        this.userManagementService = userManagementService;
    }


    /**
     * 사용자 정보 목록 조회
     *
     * @return user info list
     */
    @RequestMapping(value = {"/getUserInfoList"}, method = RequestMethod.POST, consumes = "application/json")
    public Map<String, Object> getUserInfoList(@RequestBody UserManagement param) {
        return userManagementService.getUserInfoList(param);
    }


    /**
     * 비밀번호 초기화
     *
     * @param param the param
     * @return reset password
     * @throws Exception the exception
     */
    @RequestMapping(value = {"/setResetPassword"}, method = RequestMethod.POST, consumes = "application/json")
    public Map<String, Object> setResetPassword(@RequestBody UserManagement param) throws Exception {
        return userManagementService.setResetPassword(param);
    }


    /**
     * 운영권한 부여
     *
     * @param param the param
     * @return the map
     */
    @RequestMapping(value = {"/updateOperatingAuthority"}, method = RequestMethod.POST, consumes = "application/json")
    public Map<String, Object> updateOperatingAuthority(@RequestBody UserManagement param) {
        return userManagementService.updateOperatingAuthority(param);
    }


    /**
     * 사용자 계정 삭제
     *
     * @param param the param
     * @return map map
     * @throws Exception the exception
     */
    @RequestMapping(value = {"/deleteUserAccount"}, method = RequestMethod.POST, consumes = "application/json")
    public Map<String, Object> deleteUserAccount(@RequestBody UserManagement param) throws Exception {
        return userManagementService.deleteUserAccount(param);
    }
}
