package org.openpaas.paasta.portal.web.user.controller;

import org.openpaas.paasta.portal.web.user.common.Common;
import org.openpaas.paasta.portal.web.user.model.Usage;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.Map;

/**
 * 사용량 관련 API 를 호출 하는 컨트롤러이다.
 *
 * @author 김도준
 * @version 1.0
 * @since 2016.09.22 최초작성
 */
@Controller
@RequestMapping(value = {"/usage"})
public class UsageController extends Common {

    /**
     * 사용량 조회 메인페이지로 이동한다.
     *
     * @return ModelAndView(Spring 클래스)
     */
    @RequestMapping(value = {"/usageMain"}, method = RequestMethod.GET)
    public ModelAndView getUsageMain() {
        return new ModelAndView(){{setViewName("/user/usageMain");}};
    }


    /**
     * 사용량 조직을 조회한다.
     *
     * @param param Usage(모델클래스)
     * @return Map(자바클래스)
     */
    @RequestMapping(value = {"/getUsageOrganizationList"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getUsageOrganizationList(@RequestBody Usage param) {
        return commonService.procRestTemplate("/usage/getUsageOrganizationList", HttpMethod.POST, param, this.getToken());
    }


    /**
     * 사용량 공간을 조회한다.
     *
     * @param param Usage(모델클래스)
     * @return Map(자바클래스)
     */
    @RequestMapping(value = {"/getUsageSpaceList"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getUsageSpaceList(@RequestBody Usage param) {
        return commonService.procRestTemplate("/usage/getUsageSpaceList", HttpMethod.POST, param, this.getToken());
    }


    /**
     * 사용량을 조회한다.
     *
     * @param param Usage(모델클래스)
     * @return Map(자바클래스)
     */
    @RequestMapping(value = {"/getUsageSearchList"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getUsageSearchList(@RequestBody Usage param) {
        return commonService.procRestTemplate("/usage/getUsageSearchList", HttpMethod.POST, param, null);
    }
}
