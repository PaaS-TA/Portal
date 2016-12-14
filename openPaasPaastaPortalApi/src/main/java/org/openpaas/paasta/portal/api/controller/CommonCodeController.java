package org.openpaas.paasta.portal.api.controller;

import org.openpaas.paasta.portal.api.model.CommonCode;
import org.openpaas.paasta.portal.api.service.CommonCodeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.util.Map;

/**
 * 공통코드 컨트롤러
 *
 * @author rex
 * @version 1.0
 * @since 2016.06.15
 */
@RestController
@RequestMapping(value = {"/commonCode"})
public class CommonCodeController {

    private final CommonCodeService commonCodeService;

    @Autowired
    public CommonCodeController(CommonCodeService commonCodeService) {
        this.commonCodeService = commonCodeService;
    }


    /**
     * 공통코드 목록 조회
     *
     * @param codeId the code id
     * @return common code
     */
    @RequestMapping(value = {"/getCommonCode/{codeId}"}, method = RequestMethod.GET, consumes = "application/json")
    public Map<String, Object> getCommonCode(@PathVariable("codeId") String codeId) {
        return commonCodeService.getCommonCodeById(codeId);
    }


    /**
     * 공통코드 목록 조회
     *
     * @param param   the param
     * @return common code
     */
    @RequestMapping(value = {"/getCommonCode"}, method = RequestMethod.POST, consumes = "application/json")
    public Map<String, Object> getCommonCode(@RequestBody CommonCode param) {
        return commonCodeService.getCommonCode(param);
    }


    /**
     * 공통코드 저장
     *
     * @param param the param
     * @param res   the res
     * @return map map
     */
    @RequestMapping(value = {"/insertCommonCode"}, method = RequestMethod.POST, consumes = "application/json")
    public Map<String, Object> insertCommonCode(@RequestBody CommonCode param, HttpServletResponse res) throws Exception {
        return commonCodeService.insertCommonCode(param, res);
    }


    /**
     * 공통코드 수정
     *
     * @param param the param
     * @param res   the res
     * @return map map
     */
    @RequestMapping(value = {"/updateCommonCode"}, method = RequestMethod.PUT, consumes = "application/json")
    public Map<String, Object> updateCommonCode(@RequestBody CommonCode param, HttpServletResponse res) throws Exception {
        return commonCodeService.updateCommonCode(param, res);
    }


    /**
     * 공통코드 삭제
     *
     * @param param the param
     * @return map map
     */
    @RequestMapping(value = {"/deleteCommonCode"}, method = RequestMethod.POST, consumes = "application/json")
    public Map<String, Object> deleteCommonCode(@RequestBody CommonCode param) {
        return commonCodeService.deleteCommonCode(param);
    }
}
