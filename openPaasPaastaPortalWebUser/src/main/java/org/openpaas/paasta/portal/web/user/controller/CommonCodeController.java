package org.openpaas.paasta.portal.web.user.controller;

import org.openpaas.paasta.portal.web.user.common.Common;
import org.openpaas.paasta.portal.web.user.model.CommonCode;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

/**
 * 코드 목록 조회, 등록, 삭제 등 코드 관리의 API 를 호출 하는 컨트롤러이다.
 *
 * @author 김도준
 * @version 1.0
 * @since 2016.06.17 최초작성
 */
@Controller
@RequestMapping(value = {"/commonCode"})
class CommonCodeController extends Common {

    /**
     * 공통코드 목록를 조회한다.
     *
     * @param codeId String(아이디)
     * @return Map(자바클래스)
     */
    @RequestMapping(value = {"/getCommonCode/{codeId}"}, method = RequestMethod.GET)
    @ResponseBody
    public Map getCommonCode(@PathVariable("codeId") String codeId) {
        Map result = new HashMap();

        if (null != codeId) {
            String sUrl = "/commonCode/getCommonCode/" + codeId;

            ResponseEntity<Map> rssResponse = commonService.procRestTemplate(sUrl, HttpMethod.GET, new CommonCode(), getToken(), Map.class);
            result = rssResponse.getBody();
        }
        return result;
    }


    /**
     * 공통코드 목록를 조회한다.
     *
     * @param param CommonCode(모델클래스)
     * @return Map(자바클래스)
     */
    @RequestMapping(value = {"/getCommonCode"}, method = RequestMethod.POST)
    @ResponseBody
    public Map getCommonCode(@RequestBody CommonCode param) {
        Map result = new HashMap();

        if (null != param) {
            String sUrl = "/commonCode/getCommonCode/";

            ResponseEntity<Map> rssResponse = commonService.procRestTemplate(sUrl, HttpMethod.POST, param, getToken(), Map.class);
            result = rssResponse.getBody();
        }
        return result;
    }

}
