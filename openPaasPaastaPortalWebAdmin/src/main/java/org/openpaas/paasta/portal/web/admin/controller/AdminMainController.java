package org.openpaas.paasta.portal.web.admin.controller;

import org.openpaas.paasta.portal.web.admin.common.Common;
import org.openpaas.paasta.portal.web.admin.model.AdminMain;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.Map;

/**
 * 메인 컨트롤러
 *
 * @author rex
 * @version 1.0
 * @since 2016.09.08
 */
@Controller
@RequestMapping(value = {"/main"})
public class AdminMainController extends Common {

    /**
     * 관리자포탈 조직 선택 메인페이지 이동
     *
     * @param organizationId the organization id
     * @return admin main
     */
    @RequestMapping(value = {"/organization/{organizationId}"}, method = RequestMethod.GET)
    public ModelAndView getAdminMain(@PathVariable("organizationId") String organizationId) {
        return new ModelAndView(){{setViewName("/main/main");
                                    addObject("ORGANIZATION_ID", organizationId);
        }};
    }


    /**
     * 전체 조직 수, 영역 수, APPLICATION 수, 사용자 수 목록 조회
     *
     * @param param the param
     * @return total count list
     */
    @RequestMapping(value = {"/getTotalCountList"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getTotalCountList(@RequestBody AdminMain param) {
        return commonService.procRestTemplate("/adminMain/getTotalCountList", HttpMethod.POST, param, null);
    }


    /**
     * 전체 조직 통계 목록 조회
     * *
     *
     * @param param the param
     * @return total organization list
     */
    @RequestMapping(value = {"/getTotalOrganizationList"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getTotalOrganizationList(@RequestBody AdminMain param) {
        return commonService.procRestTemplate("/adminMain/getTotalOrganizationList", HttpMethod.POST, param, null);
    }


    /**
     * 전체 영역 통계 목록 조회
     * *
     *
     * @param param the param
     * @return total space list
     */
    @RequestMapping(value = {"/getTotalSpaceList"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getTotalSpaceList(@RequestBody AdminMain param) {
        return commonService.procRestTemplate("/adminMain/getTotalSpaceList", HttpMethod.POST, param, null);
    }

}
