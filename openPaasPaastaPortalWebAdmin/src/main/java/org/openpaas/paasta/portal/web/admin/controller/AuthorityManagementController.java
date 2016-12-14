package org.openpaas.paasta.portal.web.admin.controller;

import org.openpaas.paasta.portal.web.admin.common.Common;
import org.openpaas.paasta.portal.web.admin.service.CommonService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.Map;

/**
 * Created by Dojun on 2016-09-19.
 */
@Controller
@RequestMapping(value = {"/authority"})
public class AuthorityManagementController extends Common{

    @Autowired
    private CommonService commonService;

    @RequestMapping(value = {"/authorityMain"}, method = RequestMethod.GET)
    public ModelAndView getOrgSpaceListMain() {
        return new ModelAndView(){{setViewName("/authority/authorityMain");}};
    }

    @RequestMapping(value = {"/getAuthorityGroups"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getAuthorityGroups(@RequestBody Map param) throws Exception {
        return commonService.procRestTemplate("/authority/getAuthorityGroups", HttpMethod.POST, param, null);
    }

    @RequestMapping(value = {"/getGroupMembersInfo"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getUaaUserInfo(@RequestBody Map param) throws Exception {
        return commonService.procRestTemplate("/authority/getGroupMembersInfo", HttpMethod.POST, param, null);
    }

    @RequestMapping(value = {"/createAuthorityGroup"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> createAuthorityGroup(@RequestBody Map param) throws Exception {
        return commonService.procRestTemplate("/authority/createAuthorityGroup", HttpMethod.POST, param, null);
    }

    @RequestMapping(value = {"/deleteAuthorityGroup"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> deleteAuthorityGroup(@RequestBody Map param) throws Exception {
        return commonService.procRestTemplate("/authority/deleteAuthorityGroup", HttpMethod.POST, param, null);
    }

    @RequestMapping(value = {"/addGroupMembers"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> addGroupMembers(@RequestBody Map param) throws Exception {
        return commonService.procRestTemplate("/authority/addGroupMembers", HttpMethod.POST, param, null);
    }

    @RequestMapping(value = {"/deleteGroupMembers"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> deleteGroupMembers(@RequestBody Map param) throws Exception {
        return commonService.procRestTemplate("/authority/deleteGroupMembers", HttpMethod.POST, param, null);
    }

    @RequestMapping(value = {"/getUserInfo"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getUserNameList(@RequestBody Map param) throws Exception {
        return commonService.procRestTemplate("/user/getUserInfo", HttpMethod.GET, param, null);
    }
}
