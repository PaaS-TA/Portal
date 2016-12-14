package org.openpaas.paasta.portal.api.controller;

import org.openpaas.paasta.portal.api.model.Support;
import org.openpaas.paasta.portal.api.service.SupportNoticeService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletResponse;
import java.util.Map;

/**
 * org.openpaas.paasta.portal.api.controller
 *
 * @author yjkim
 * @version 1.0
 * @since 2016.07.28
 */
@RestController
@RequestMapping(value = {"/support"})
public class SupportNoticeController {
    private static final Logger LOGGER = LoggerFactory.getLogger(SupportNoticeController.class);

    @Autowired
    private SupportNoticeService supportNoticeService;


    /**
     * 공지 목록 조회
     *
     * @param response   the response
     * @return notice list
     * @throws Exception the exception
     */
    @RequestMapping(value = {"/getNoticeList"}, method = RequestMethod.POST, consumes = "application/json")
    public Map<String, Object> getNoticeList(@RequestBody Support param, HttpServletResponse response) throws Exception{
        LOGGER.info("getNoticeList :: param :: {}, param.toString()");
        return supportNoticeService.getNoticeList(param);
    }

    /**
     * 공지 조회
     *
     * @param response   the response
     * @return notice
     * @throws Exception the exception
     */
    @RequestMapping(value = {"/getNotice"}, method = RequestMethod.POST, consumes = "application/json")
    public Map<String, Object> getNotice(@RequestBody Support param, HttpServletResponse response) throws Exception{
        LOGGER.info("getNoticeList :: param :: {}, param.toString()");
        return supportNoticeService.getNotice(param);
    }

    /**
     * 공지 등록
     *
     * @param response   the response
     * @return insert notice
     * @throws Exception the exception
     */
    @RequestMapping(value = {"/insertNotice"}, method = RequestMethod.POST, consumes = "application/json")
    public Map<String, Object> insertNotice(@RequestBody Support param, HttpServletResponse response) throws Exception{
        LOGGER.info("insertNotice :: param :: {}, param.toString()");

        return supportNoticeService.insertNotice(param);
    }

    /**
     * 공지 수정
     *
     * @param response   the response
     * @return update notice
     * @throws Exception the exception
     */
    @RequestMapping(value = {"/updateNotice"}, method = RequestMethod.PUT, consumes = "application/json")
    public Map<String, Object> updateNotice(@RequestBody Support param, HttpServletResponse response) throws Exception{
        LOGGER.info("updateNotice :: param :: {}, param.toString()");

        return supportNoticeService.updateNotice(param);
    }

    /**
     * 공지 삭제
     *
     * @param response   the response
     * @return delete notice
     * @throws Exception the exception
     */
    @RequestMapping(value = {"/deleteNotice"}, method = RequestMethod.POST, consumes = "application/json")
    public Map<String, Object> deleteNotice(@RequestBody Support param, HttpServletResponse response) throws Exception{
        LOGGER.info("deleteNotice :: param :: {}, param.toString()");

        return supportNoticeService.deleteNotice(param);
    }

}
