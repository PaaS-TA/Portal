package org.openpaas.paasta.portal.web.user.controller;

import org.openpaas.paasta.portal.web.user.common.Common;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
 * 도메인 정보 조회, 추가, 삭제 등 도메인 관리의 API 를 호출 받는 컨트롤러이다.
 *
 * @author 김도준
 * @version 1.0
 * @since 2016 -07-26
 */
@Controller
@RequestMapping(value = {"/domain"})
public class DomainController extends Common {

    private static final Logger LOGGER = LoggerFactory.getLogger(DomainController.class);


    /**
     * 도메인 목록을 가져온다.
     *
     * @param status 도메인 종류 (private / shared)
     * @return List (자바 클래스)
     * @author 김도준
     * @since 2016.7.27 최초작성
     */
    @RequestMapping(value = {"/getDomains/{status}"}, method = RequestMethod.POST)
    @ResponseBody
    public List getDomains(@PathVariable String status) {
        LOGGER.info("Start getDomains");

        ResponseEntity rssResponse = commonService.procRestTemplate("/domain/getDomains/"+status, HttpMethod.POST, "", getToken(), List.class);
        List domains = (List) rssResponse.getBody();

        LOGGER.info(rssResponse.getBody().toString());

        return domains;
    }

    /**
     * 신규 도메인을 추가한다.
     *
     * @param body (자바 Map 클래스)
     * @return boolean (자바 클래스)
     * @throws Exception
     * @author 김도준
     * @version 1.0
     * @since 2016.7.27 최초작성
     */
    @RequestMapping(value = {"/addDomain"}, method = RequestMethod.POST)
    @ResponseBody
    public boolean addDomain(@RequestBody Map body) {
        LOGGER.info("Start addDomain");

        ResponseEntity rssResponse = commonService.procRestTemplate("/domain/addDomain/", HttpMethod.POST, body,getToken(), Boolean.class);

        LOGGER.info(rssResponse.getBody().toString());
        LOGGER.info("End addDomain");

        return true;
    }

    /**
     * 도메인을 삭제한다.
     *
     * @param body (자바 Map 클래스)
     * @return boolean (자바 클래스)
     * @throws Exception
     * @author 김도준
     * @version 1.0
     * @since 2016.7.27 최초작성
     */
    @RequestMapping(value = {"/deleteDomain"}, method = RequestMethod.POST)
    @ResponseBody
    public boolean deleteDomain(@RequestBody Map body) {
        LOGGER.info("Start deleteDomain");

        ResponseEntity rssResponse = commonService.procRestTemplate("/domain/deleteDomain/", HttpMethod.POST, body, getToken(), Boolean.class);
        LOGGER.info(rssResponse.getBody().toString());
        LOGGER.info("End deleteDomain");

        return true;
    }
}




