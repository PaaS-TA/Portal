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
 * 내 문의 관련 API 를 호출 하는 컨트롤러이다.
 *
 * @author 김도준
 * @version 1.0
 * @since 2016.08.22 최초작성
 */
@Controller
@RequestMapping(value = {"/myQuestion"})
class MyQuestionController extends Common {

    /**
     * 내 문의 메인페이지로 이동한다.
     *
     * @return ModelAndView(Spring 클래스)
     */
    @RequestMapping(value = {"/myQuestionMain"}, method = RequestMethod.GET)
    public ModelAndView getMyQuestionMain() {
        return new ModelAndView(){{setViewName("/user/myQuestionMain");}};
    }


    /**
     * 내 문의 등록페이지로 이동한다.
     *
     * @return ModelAndView(Spring 클래스)
     */
    @RequestMapping(value = {"/myQuestionMain/create"}, method = RequestMethod.GET)
    public ModelAndView getMyQuestionInsertForm() {
        return new ModelAndView() {{
            setViewName("/user/myQuestionInsertForm");
            addObject("INSERT_FLAG", Constants.CUD_C);
        }};
    }


    /**
     * 내 문의 수정페이지로 이동한다.
     *
     * @param myQuestionNo 내 문의 번호(String)
     * @return ModelAndView(Spring 클래스)
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
     * 내 문의 상세페이지로 이동한다.
     *
     * @param myQuestionNo 내 문의 번호(String)
     * @return ModelAndView(Spring 클래스)
     */
    @RequestMapping(value = {"/myQuestionMain/detail/{myQuestionNo}"}, method = RequestMethod.GET)
    public ModelAndView getMyQuestionDetailForm(@PathVariable("myQuestionNo") String myQuestionNo) {
        return new ModelAndView() {{
            setViewName("/user/myQuestionDetailForm");
            addObject("MY_QUESTION_NO", myQuestionNo);
        }};
    }


    /**
     * 내 문의 목록을 조회한다.
     *
     * @param param Support(모델클래스)
     * @return Map(자바클래스)
     * @throws Exception Exception(자바클래스)
     */
    @RequestMapping(value = {"/getMyQuestionList"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getMyQuestionList(@RequestBody Support param) throws Exception {
        return commonService.procRestTemplate("/support/myQuestion/getMyQuestionList", HttpMethod.POST, commonService.setUserId(param), null);
    }


    /**
     * 내 문의 답변을 조회한다.
     *
     * @param param Support(모델클래스)
     * @return Map(자바클래스)
     */
    @RequestMapping(value = {"/getMyQuestionAnswer"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getMyQuestionAnswer(@RequestBody Support param) {
        return commonService.procRestTemplate("/support/myQuestion/getMyQuestionAnswer", HttpMethod.POST, param, null);
    }


    /**
     * 파일을 업로드한다.
     *
     * @param multipartFile the multipart file
     * @return Map(자바클래스)
     * @throws Exception Exception(자바클래스)
     */
    @RequestMapping(value = {"/uploadFile"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> uploadFile(@RequestParam("file") MultipartFile multipartFile) throws Exception {
        return commonService.procRestTemplate("/support/myQuestion/uploadFile", multipartFile, null);
    }


    /**
     * 파일을 삭제한다.
     *
     * @param param Support(모델클래스)
     * @return Map(자바클래스)
     */
    @RequestMapping(value = {"/deleteFile"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> deleteFile(@RequestBody Support param) {
        return commonService.procRestTemplate("/support/myQuestion/deleteFile", HttpMethod.POST, param, null);
    }


    /**
     * 내 문의를 저장한다.
     *
     * @param param Support(모델클래스)
     * @return Map(자바클래스)
     * @throws Exception Exception(자바클래스)
     */
    @RequestMapping(value = {"/insertMyQuestion"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> insertMyQuestion(@RequestBody Support param) throws Exception {
        return commonService.procRestTemplate("/support/myQuestion/insertMyQuestion", HttpMethod.POST, commonService.setUserId(param), null);
    }


    /**
     * 내 문의를 수정한다.
     *
     * @param param Support(모델클래스)
     * @return Map(자바클래스)
     * @throws Exception Exception(자바클래스)
     */
    @RequestMapping(value = {"/updateMyQuestion"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> updateMyQuestion(@RequestBody Support param) throws Exception {
        return commonService.procRestTemplate("/support/myQuestion/updateMyQuestion", HttpMethod.PUT, commonService.setUserId(param), null);
    }


    /**
     * 내 문의를 삭제한다.
     *
     * @param param Support(모델클래스)
     * @return Map(자바클래스)
     */
    @RequestMapping(value = {"/deleteMyQuestion"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> deleteMyQuestion(@RequestBody Support param) {
        return commonService.procRestTemplate("/support/myQuestion/deleteMyQuestion", HttpMethod.POST, param, null);
    }


    /**
     * 내 문의를 조회한다. (내 계정)
     *
     * @return String(자바클래스)
     */
    @RequestMapping(value = {"/getMyQuestionsInMyAccount"}, method = RequestMethod.POST)
    @ResponseBody
    public String getMyQuestionsInMyAccount() {
        ResponseEntity rssResponse = commonService.procRestTemplate("/support/myAccount/getMyQuestions", HttpMethod.POST, "", getToken(), String.class);
        return (String) rssResponse.getBody();
    }
}
