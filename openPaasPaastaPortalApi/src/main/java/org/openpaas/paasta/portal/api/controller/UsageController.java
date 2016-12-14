package org.openpaas.paasta.portal.api.controller;

import org.openpaas.paasta.portal.api.model.Usage;
import org.openpaas.paasta.portal.api.service.UsageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * 사용량 조회 컨트롤러
 *
 * @author rex
 * @version 1.0
 * @since 2016.09.22
 */
@RestController
@RequestMapping(value = {"/usage"})
public class UsageController {

    private final UsageService usageService;

    @Autowired
    public UsageController(UsageService usageService) {
        this.usageService = usageService;
    }


    /**
     * 사용량 조직 조회
     *
     * @param req the req
     * @return usage organization list
     * @throws Exception the exception
     */
    @RequestMapping(value = {"/getUsageOrganizationList"}, method = RequestMethod.POST, consumes = "application/json")
    public Map<String, Object> getUsageOrganizationList(HttpServletRequest req) throws Exception {
        return usageService.getUsageOrganizationList(req);
    }


    /**
     * 사용량 공간 조회
     *
     * @param param the param
     * @param req   the req
     * @return usage space list
     * @throws Exception the exception
     */
    @RequestMapping(value = {"/getUsageSpaceList"}, method = RequestMethod.POST, consumes = "application/json")
    public Map<String, Object> getUsageSpaceList(@RequestBody Usage param, HttpServletRequest req) throws Exception {
        return usageService.getUsageSpaceList(param, req);
    }


    /**
     * 사용량 조회
     *
     * @param param the param
     * @return usage space list
     * @throws Exception the exception
     */
    @RequestMapping(value = {"/getUsageSearchList"}, method = RequestMethod.POST, consumes = "application/json")
    public Map<String, Object> getUsageSearchList(@RequestBody Usage param) throws Exception {
        return usageService.getUsageSearchList(param);
    }
}
