package org.openpaas.paasta.portal.web.admin.controller;

import org.openpaas.paasta.portal.web.admin.common.Common;
import org.openpaas.paasta.portal.web.admin.model.CommonCode;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.Map;

/**
 * 공통코드 컨트롤러
 *
 * @author rex
 * @version 1.0
 * @since 2016.06.17
 */
@Controller
@RequestMapping(value = {"/commonCode"})
public class CommonCodeController extends Common {

    /**
     * 공통코드 메인페이지 이동
     *
     * @return common code main
     */
    @RequestMapping(value = {"/commonCodeMain"}, method = RequestMethod.GET)
    public ModelAndView getCommonCodeMain() {
        return new ModelAndView(){{setViewName("/commonCode/commonCodeMain");}};
    }


    /**
     * 공통코드 목록 조회
     *
     * @param codeId the code id
     * @return common code
     */
    @RequestMapping(value = {"/getCommonCode/{codeId}"}, method = RequestMethod.GET)
    @ResponseBody
    public Map<String, Object> getCommonCode(@PathVariable("codeId") String codeId) {
        return commonService.procRestTemplate("/commonCode/getCommonCode/" + codeId, HttpMethod.GET, new CommonCode(), null);
    }


    /**
     * 공통코드 목록 조회
     *
     * @param param the param
     * @return common code
     */
    @RequestMapping(value = {"/getCommonCode"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getCommonCode(@RequestBody CommonCode param) {
        return commonService.procRestTemplate("/commonCode/getCommonCode", HttpMethod.POST, param, null);
    }


    /**
     * 공통코드 저장
     *
     * @param param the param
     * @return map map
     */
    @RequestMapping(value = {"/insertCommonCode"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> insertCommonCode(@RequestBody CommonCode param) {
        param.setUserId(commonService.getUserId());

        return commonService.procRestTemplate("/commonCode/insertCommonCode", HttpMethod.POST, param, null);
    }


    /**
     * 공통코드 수정
     *
     * @param param the param
     * @return map map
     */
    @RequestMapping(value = {"/updateCommonCode"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> updateCommonCode(@RequestBody CommonCode param) {
        param.setUserId(commonService.getUserId());

        return commonService.procRestTemplate("/commonCode/updateCommonCode", HttpMethod.PUT, param, null);
    }


    /**
     * 공통코드 삭제
     *
     * @param param the param
     * @return map map
     */
    @RequestMapping(value = {"/deleteCommonCode"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> deleteCommonCode(@RequestBody CommonCode param) {
        return commonService.procRestTemplate("/commonCode/deleteCommonCode", HttpMethod.POST, param, null);
    }
}
