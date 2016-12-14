package org.openpaas.paasta.portal.web.user.controller;

import org.openpaas.paasta.portal.web.user.common.Common;
import org.openpaas.paasta.portal.web.user.common.Constants;
import org.openpaas.paasta.portal.web.user.model.Usage;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.Map;

/**
 * 사용량 조회 컨트롤러
 *
 * @author rex
 * @version 1.0
 * @since 2016.09.22
 */
@Controller
@RequestMapping(value = {"/usage"})
public class UsageController extends Common {

    /**
     * 사용량 조회 메인페이지 이동
     *
     * @return usage main
     */
    @RequestMapping(value = {"/usageMain"}, method = RequestMethod.GET)
    public ModelAndView getUsageMain() {
        return new ModelAndView(){{setViewName("/user/usageMain");}};
    }


    /**
     * 사용량 조직 조회
     *
     * @param param the param
     * @return usage organization list
     */
    @RequestMapping(value = {"/getUsageOrganizationList"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getUsageOrganizationList(@RequestBody Usage param) {
        return commonService.procRestTemplate("/usage/getUsageOrganizationList", HttpMethod.POST, param, this.getToken());
    }


    /**
     * 사용량 공간 조회
     *
     * @param param the param
     * @return usage space list
     */
    @RequestMapping(value = {"/getUsageSpaceList"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getUsageSpaceList(@RequestBody Usage param) {
        return commonService.procRestTemplate("/usage/getUsageSpaceList", HttpMethod.POST, param, this.getToken());
    }


    /**
     * 사용량 조회
     *
     * @param param the param
     * @return usage search list
     */
    @RequestMapping(value = {"/getUsageSearchList"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getUsageSearchList(@RequestBody Usage param) {
        return commonService.procRestTemplate("/usage/getUsageSearchList", HttpMethod.POST, param, null);
    }
}
