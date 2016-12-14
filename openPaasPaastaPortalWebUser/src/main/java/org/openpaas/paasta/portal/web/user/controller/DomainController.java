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
 * Created by Dojun on 2016-07-26.
 */

@Controller
@RequestMapping(value = {"/domain"})
public class DomainController extends Common {

    private static final Logger LOGGER = LoggerFactory.getLogger(DomainController.class);

    /**
     *도메인 가져오기
     *
     * @author kimdojun
     * @version 1.0
     * @param status
     * @return
     * @throws Exception
     * @since 2016.7.26 최초작성
     *
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
     *도메인 추가
     *
     * @author kimdojun
     * @version 1.0
     * @param body
     * @return
     * @throws Exception
     * @since 2016.7.27 최초작성
     *
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
     *도메인 삭제
     *
     * @author kimdojun
     * @version 1.0
     * @param body
     * @return
     * @throws Exception
     * @since 2016.7.27 최초작성
     *
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




