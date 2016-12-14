package org.openpaas.paasta.portal.web.admin.controller;

import org.openpaas.paasta.portal.web.admin.model.Support;
import org.openpaas.paasta.portal.web.admin.service.CommonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Map;

/**
 * Created by YJKim on 2016-07-25.
 */
@Controller
@RequestMapping(value = {"/support"})
public class SupportNoticeController {

    @Autowired
    private CommonService commonService;

    /**
     * 공지 목록 조회
     *
     * @param param
     * @return notice list map
     * @throws Exception the exception
     */
    @RequestMapping(value = {"/getNoticeList"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getNoticeList(@RequestBody Support param) throws Exception{
        return commonService.procRestTemplate("/support/getNoticeList", HttpMethod.POST, param, null);
    }

    /**
     * 공지 조회
     *
     * @param param
     * @return notice map
     * @throws Exception the exception
     */
    @RequestMapping(value = {"/getNotice"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getNotice(@RequestBody Support param) throws Exception{
        return commonService.procRestTemplate("/support/getNotice", HttpMethod.POST, param, null);
    }

    /**
     * 공지 등록
     *
     * @param param
     * @return insert Notice result map
     * @throws Exception the exception
     */
    @RequestMapping(value = {"/insertNotice"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> insertNotice(@RequestBody Support param) throws Exception{

        return commonService.procRestTemplate("/support/insertNotice", HttpMethod.POST, param, null);
    }

    /**
     * 공지 수정
     *
     * @param param
     * @return update Notice result map
     * @throws Exception the exception
     */
    @RequestMapping(value = {"/updateNotice"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> updateNotice(@RequestBody Support param) throws Exception{

        return commonService.procRestTemplate("/support/updateNotice", HttpMethod.PUT, param, null);
    }

    /**
     * 공지 삭제
     *
     * @param param
     * @return delete Notice result map
     * @throws Exception the exception
     */
    @RequestMapping(value = {"/deleteNotice"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> deleteNotice(@RequestBody Support param) throws Exception{

        return commonService.procRestTemplate("/support/deleteNotice", HttpMethod.POST, param, null);
    }



}
