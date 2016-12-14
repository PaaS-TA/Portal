package org.openpaas.paasta.portal.web.user.controller;

import org.openpaas.paasta.portal.web.user.common.Common;
import org.openpaas.paasta.portal.web.user.common.Constants;
import org.openpaas.paasta.portal.web.user.model.Support;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import java.util.Map;

/**
 * 내 문의 컨트롤러
 *
 * @author rex
 * @version 1.0
 * @since 2016.08.22
 */
@Controller
@RequestMapping(value = {"/myQuestion"})
class MyQuestionController extends Common {

    /**
     * 내 문의 메인페이지 이동
     *
     * @return my question main
     */
    @RequestMapping(value = {"/myQuestionMain"}, method = RequestMethod.GET)
    public ModelAndView getMyQuestionMain() {
        return new ModelAndView(){{setViewName("/user/myQuestionMain");}};
    }


    /**
     * 내 문의 등록페이지 이동
     *
     * @return my question insert form
     */
    @RequestMapping(value = {"/myQuestionMain/create"}, method = RequestMethod.GET)
    public ModelAndView getMyQuestionInsertForm() {
        return new ModelAndView() {{
            setViewName("/user/myQuestionInsertForm");
            addObject("INSERT_FLAG", Constants.CUD_C);
        }};
    }


    /**
     * 내 문의 수정페이지 이동
     *
     * @param myQuestionNo the my question no
     * @return my question insert form
     */
    @RequestMapping(value = {"/myQuestionMain/update/{myQuestionNo}"}, method = RequestMethod.GET)
    public ModelAndView getMyQuestionInsertForm(@PathVariable("myQuestionNo") String myQuestionNo) {
        return new ModelAndView() {{
            setViewName("/user/myQuestionInsertForm");
            addObject("INSERT_FLAG", Constants.CUD_U);
            addObject("MY_QUESTION_NO", myQuestionNo);
        }};
    }


    /**
     * 내 문의 상세페이지 이동
     *
     * @param myQuestionNo the my question no
     * @return my question detail form
     */
    @RequestMapping(value = {"/myQuestionMain/detail/{myQuestionNo}"}, method = RequestMethod.GET)
    public ModelAndView getMyQuestionDetailForm(@PathVariable("myQuestionNo") String myQuestionNo) {
        return new ModelAndView() {{
            setViewName("/user/myQuestionDetailForm");
            addObject("MY_QUESTION_NO", myQuestionNo);
        }};
    }


    /**
     * 내 문의 목록 조회
     *
     * @param param the param
     * @return my question list
     * @throws Exception the exception
     */
    @RequestMapping(value = {"/getMyQuestionList"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getMyQuestionList(@RequestBody Support param) throws Exception {
        return commonService.procRestTemplate("/support/myQuestion/getMyQuestionList", HttpMethod.POST, commonService.setUserId(param), null);
    }


    /**
     * 내 문의 답변 조회
     *
     * @param param the param
     * @return my question answer list
     */
    @RequestMapping(value = {"/getMyQuestionAnswer"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getMyQuestionAnswer(@RequestBody Support param) {
        return commonService.procRestTemplate("/support/myQuestion/getMyQuestionAnswer", HttpMethod.POST, param, null);
    }


    /**
     * 파일 업로드
     *
     * @param multipartFile the multipart file
     * @return map map
     * @throws Exception the exception
     */
    @RequestMapping(value = {"/uploadFile"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> uploadFile(@RequestParam("file") MultipartFile multipartFile) throws Exception {
        return commonService.procRestTemplate("/support/myQuestion/uploadFile", multipartFile, null);
    }


    /**
     * 파일 삭제
     *
     * @param param the param
     * @return map map
     */
    @RequestMapping(value = {"/deleteFile"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> deleteFile(@RequestBody Support param) {
        return commonService.procRestTemplate("/support/myQuestion/deleteFile", HttpMethod.POST, param, null);
    }


    /**
     * 내 문의 저장
     *
     * @param param the param
     * @return map map
     * @throws Exception the exception
     */
    @RequestMapping(value = {"/insertMyQuestion"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> insertMyQuestion(@RequestBody Support param) throws Exception {
        return commonService.procRestTemplate("/support/myQuestion/insertMyQuestion", HttpMethod.POST, commonService.setUserId(param), null);
    }


    /**
     * 내 문의 수정
     *
     * @param param the param
     * @return map map
     * @throws Exception the exception
     */
    @RequestMapping(value = {"/updateMyQuestion"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> updateMyQuestion(@RequestBody Support param) throws Exception {
        return commonService.procRestTemplate("/support/myQuestion/updateMyQuestion", HttpMethod.PUT, commonService.setUserId(param), null);
    }


    /**
     * 내 문의 삭제
     *
     * @param param the param
     * @return map map
     */
    @RequestMapping(value = {"/deleteMyQuestion"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> deleteMyQuestion(@RequestBody Support param) {
        return commonService.procRestTemplate("/support/myQuestion/deleteMyQuestion", HttpMethod.POST, param, null);
    }


    /**
     * 내 문의 조회 (내 계정)
     *
     * @return my questions
     */
    @RequestMapping(value = {"/getMyQuestionsInMyAccount"}, method = RequestMethod.POST)
    @ResponseBody
    public String getMyQuestionsInMyAccount() {
        ResponseEntity rssResponse = commonService.procRestTemplate("/support/myAccount/getMyQuestions", HttpMethod.POST, "", getToken(), String.class);
        return (String) rssResponse.getBody();
    }
}
