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
public class SupportBoardController {

    @Autowired
    private CommonService commonService;

    /**
     * 게시판 목록 조회
     *
     * @param param
     * @return Board list
     * @throws Exception the exception
     */
    @RequestMapping(value = {"/getBoardList"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getBoardList(@RequestBody Support param) throws Exception{
        return commonService.procRestTemplate("/support/getBoardList", HttpMethod.POST, param, null);
    }

    /**
     * 게시판 조회
     *
     * @param param
     * @return get Board
     * @throws Exception the exception
     */
    @RequestMapping(value = {"/getBoard"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getBoard(@RequestBody Support param) throws Exception{
        return commonService.procRestTemplate("/support/getBoard", HttpMethod.POST, param, null);
    }


    /**
     * 게시판 댓글 목록 조회
     *
     * @param param
     * @return Board list
     * @throws Exception the exception
     */
    @RequestMapping(value = {"/getBoardCommentList"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getBoardCommentList(@RequestBody Support param) throws Exception{
        return commonService.procRestTemplate("/support/getBoardCommentList", HttpMethod.POST, param, null);
    }

    /**
     * 게시판 삭제
     *
     * @param param
     * @return delete Board
     * @throws Exception the exception
     */
    @RequestMapping(value = {"/deleteBoard"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> deleteBoard(@RequestBody Support param) throws Exception{

        return commonService.procRestTemplate("/support/deleteBoard", HttpMethod.POST, param, null);
    }

    /**
     * 게시판 댓글 삭제
     *
     *
     * @return delete Board
     * @throws Exception the exception
     */
/*
    @RequestMapping(value = {"/deleteBoardComment"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> deleteBoardComment(@RequestBody Support param) throws Exception{

        return commonService.procRestTemplate("/support/deleteBoardComment", HttpMethod.POST, param, null);
    }
*/


}
