package org.openpaas.paasta.portal.api.controller;

import org.openpaas.paasta.portal.api.model.AdminMain;
import org.openpaas.paasta.portal.api.service.AdminMainService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

/**
 * 운영자 메인 컨트롤러
 *
 * @author rex
 * @version 1.0
 * @since 2016.09.08
 */
@RestController
@RequestMapping(value = {"/adminMain"})
public class AdminMainController {

    private final AdminMainService adminMainService;

    @Autowired
    public AdminMainController(AdminMainService adminMainService) {
        this.adminMainService = adminMainService;
    }


    /**
     * 전체 조직 수, 영역 수, APPLICATION 수, 사용자 수 목록 조회
     *
     * @param param the param
     * @return total count list
     */
    @RequestMapping(value = {"/getTotalCountList"}, method = RequestMethod.POST, consumes = "application/json")
    public Map<String, Object> getTotalCountList(@RequestBody AdminMain param) {
        return adminMainService.getTotalCountList(param);
    }


    /**
     * 전체 조직 통계 목록 조회
     * 조직별 App 사용량, 스페이스별 App 사용량 정보를 조회
     * @param param the param
     * @return total organization list
     */
    @RequestMapping(value = {"/getTotalOrganizationList"}, method = RequestMethod.POST, consumes = "application/json")
    public Map<String, Object> getTotalOrganizationList(@RequestBody AdminMain param) {
        return adminMainService.getTotalOrganizationList(param);
    }


    /**
     * 전체 영역 통계 목록 조회
     *
     * @param param the param
     * @return total space list
     */
    @RequestMapping(value = {"/getTotalSpaceList"}, method = RequestMethod.POST, consumes = "application/json")
    public Map<String, Object> getTotalSpaceList(@RequestBody AdminMain param) {
        return adminMainService.getTotalSpaceList(param);
    }
}
