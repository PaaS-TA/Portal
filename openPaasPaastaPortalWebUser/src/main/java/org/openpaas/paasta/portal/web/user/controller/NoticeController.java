package org.openpaas.paasta.portal.web.user.controller;

import org.openpaas.paasta.portal.web.user.common.Common;
import org.openpaas.paasta.portal.web.user.common.Constants;
import org.openpaas.paasta.portal.web.user.model.Support;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * org.openpaas.paasta.portal.web.user.controller
 *
 * @author rex
 * @version 1.0
 * @since 2016.08.22
 */
@Controller
@RequestMapping(value = {"/notice"})
public class NoticeController extends Common {


    /**
     * 공지 메인 이동
     *
     * @return notice main
     */
    @RequestMapping(value = {"/noticeMain"}, method = RequestMethod.GET)
    public ModelAndView getNoticeMain() {

        return new ModelAndView(){
            {
                setViewName("/notice/noticeMain");
            }//
        };
    }

    /**
     * 공지 조회 페이지 이동
     *
     * @param req
     * @return notice view form
     */
    @RequestMapping(value = {"/noticeMain/view"}, method = RequestMethod.POST)
    public ModelAndView getNoticeView2(HttpServletRequest req) {

        ModelAndView mv = new ModelAndView();

        mv.addObject("NOTICE_NO", req.getParameter("noticeNo"));
        mv.setViewName("/notice/noticeDetailForm");

        return mv;
    }

    /**
     * 공지 목록 조회
     *
     * @param param the param
     * @return notice list
     */
    @RequestMapping(value = {"/getNoticeList"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getNoticeList(@RequestBody Support param) {
        param.setUserId(commonService.getUserId());

        return commonService.procRestTemplate("/support/getNoticeList", HttpMethod.POST, param, null);
    }


    /**
     * 공지 조회
     *
     * @param param
     * @return get Notice
     * @throws Exception the exception
     */
    @RequestMapping(value = {"/getNotice"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getNotice(@RequestBody Support param) throws Exception{

        return commonService.procRestTemplate("/support/getNotice", HttpMethod.POST, param, null);
    }

}
