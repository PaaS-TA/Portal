package org.openpaas.paasta.portal.web.user.controller;

import org.openpaas.paasta.portal.web.user.common.Common;
import org.openpaas.paasta.portal.web.user.common.Constants;
import org.openpaas.paasta.portal.web.user.model.Support;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
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
@RequestMapping(value = {"/board"})
public class BoardController extends Common {


    /**
     * 게시판 메인 화면 이동
     *
     * @return board main
     */
    @RequestMapping(value = {"/boardMain"}, method = RequestMethod.GET)
    public ModelAndView getBoardMain() {

        return new ModelAndView(){
            {
                setViewName("/board/boardMain");
            }//
        };
    }

    /**
     * 게시판 게시글 조회/수정 화면 이동
     *
     * @param  req
     * @return board view form
     */
    @RequestMapping(value = {"/boardMain/view"}, method = RequestMethod.POST)
    public ModelAndView getBoardView(HttpServletRequest req) {

        ModelAndView mv = new ModelAndView();

        mv.addObject("INSERT_FLAG", Constants.CUD_U);
        mv.addObject("BOARD_NO", req.getParameter("boardNo"));
        mv.addObject("PARENT_NO", req.getParameter("parentNo"));
        mv.addObject("GROUP_NO", req.getParameter("groupNo"));
        mv.setViewName("/board/boardDetailForm");

        return mv;

    }

    /**
     * 게시판 게시글 등록화면 이동
     *
     * @param  req
     * @return board insert form
     */
    @RequestMapping(value = {"/boardMain/create"}, method = RequestMethod.GET)
    public ModelAndView getBoardCreate(HttpServletRequest req) {

        ModelAndView mv = new ModelAndView();

        mv.addObject("INSERT_FLAG", Constants.CUD_C);
        mv.addObject("BOARD_NO", -1);
        mv.addObject("PARENT_NO", -1);
        mv.addObject("GROUP_NO", -1);
        mv.setViewName("/board/boardDetailForm");

        return mv;

    }

    /**
     * 게시판 답글 등록 화면 이동
     *
     * @param  req
     * @return board insert form
     */
    @RequestMapping(value = {"/boardMain/reply"}, method = RequestMethod.GET)
    public ModelAndView getBoardReply(HttpServletRequest req) {

        ModelAndView mv = new ModelAndView();

        mv.addObject("INSERT_FLAG", Constants.CUD_R);
        mv.addObject("BOARD_NO", req.getParameter("boardNo"));
        mv.addObject("PARENT_NO", req.getParameter("parentNo"));
        mv.addObject("GROUP_NO", req.getParameter("groupNo"));
        mv.setViewName("/board/boardDetailForm");

        return mv;

    }


    /**
     * 게시판 게시글 목록 조회
     *
     * @param param the param
     * @return board list
     */
    @RequestMapping(value = {"/getBoardList"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getBoardList(@RequestBody Support param) {
        param.setUserId(commonService.getUserId());

        return commonService.procRestTemplate("/support/getBoardList", HttpMethod.POST, param, null);
    }

    /**
     * 게시판 게시글 조회
     *
     *
     * @return get board
     * @throws Exception the exception
     */
    @RequestMapping(value = {"/getBoard"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getBoard(@RequestBody Support param) throws Exception{

        return commonService.procRestTemplate("/support/getBoard", HttpMethod.POST, param, null);
    }

    /**
     * 게시판 게시글 등록
     *
     * @param param the param
     * @return map
     * @throws Exception the exception
     */
    @RequestMapping(value = {"/insertBoard"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> insertBoard(@RequestBody Support param) throws Exception {
        param.setUserId(commonService.getUserId());

        return commonService.procRestTemplate("/support/insertBoard", HttpMethod.POST, param, null);
    }


    /**
     * 게시판 게시글 수정
     *
     * @param param the param
     * @return map
     * @throws Exception the exception
     */
    @RequestMapping(value = {"/updateBoard"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> updateBoard(@RequestBody Support param) throws Exception {
        param.setUserId(commonService.getUserId());

        return commonService.procRestTemplate("/support/updateBoard", HttpMethod.PUT, param, null);
    }

    /**
     * 게시판 게시글 삭제
     *
     * @param param the param
     * @return map
     * @throws Exception the exception
     */
    @RequestMapping(value = {"/deleteBoard"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> deleteBoard(@RequestBody Support param) throws Exception {
        return commonService.procRestTemplate("/support/deleteBoard", HttpMethod.POST, param, null);
    }

    /**
     * 게시판 댓글 수 조회
     *
     *
     * @return get board
     * @throws Exception the exception
     */
    @RequestMapping(value = {"/getReplyNum"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getReplyNum(@RequestBody Support param) throws Exception{

        return commonService.procRestTemplate("/support/getReplyNum", HttpMethod.POST, param, null);
    }

    /**
     * 게시판 댓글 수 조회
     *
     *
     * @return get board Comment
     * @throws Exception the exception
     */
    @RequestMapping(value = {"/getCommentReplyNum"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getCommentReplyNum(@RequestBody Support param) throws Exception{

        return commonService.procRestTemplate("/support/getCommentReplyNum", HttpMethod.POST, param, null);
    }



    /**
     * 파일 업로드
     *
     * @param multipartFile the multipart file
     * @return map
     * @throws Exception the exception
     */
    @RequestMapping(value = {"/uploadFile"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> uploadFile(@RequestParam("file") MultipartFile multipartFile) throws Exception {
        return commonService.procRestTemplate("/file/uploadFile", multipartFile, null);
    }


    /**
     * 파일 삭제
     *
     * @param param the param
     * @return map
     */
    @RequestMapping(value = {"/deleteFile"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> deleteFile(@RequestBody Support param) {
        return commonService.procRestTemplate("/file/deleteFile", HttpMethod.POST, param, null);
    }


    /**
     * 게시판 댓글 목록 조회
     *
     *
     *
     * @return Board list
     * @throws Exception the exception
     */
    @RequestMapping(value = {"/getBoardCommentList"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getBoardCommentList(@RequestBody Support param) throws Exception{
        return commonService.procRestTemplate("/support/getBoardCommentList", HttpMethod.POST, param, null);
    }


    /**
     * 게시판 댓글 등록
     *
     * @param param the param
     * @return map
     * @throws Exception the exception
     */
    @RequestMapping(value = {"/insertBoardComment"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> insertBoardComment(@RequestBody Support param) throws Exception {
        param.setUserId(commonService.getUserId());
        return commonService.procRestTemplate("/support/insertBoardComment", HttpMethod.POST, param, null);
    }


    /**
     * 게시판 댓글 수정
     *
     * @param param the param
     * @return map
     * @throws Exception the exception
     */
    @RequestMapping(value = {"/updateBoardComment"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> updateBoardComment(@RequestBody Support param) throws Exception {
        param.setUserId(commonService.getUserId());
        return commonService.procRestTemplate("/support/updateBoardComment", HttpMethod.PUT, param, null);
    }


    /**
     * 게시판 댓글 삭제
     *
     * @param param the param
     * @return map
     * @throws Exception the exception
     */
    @RequestMapping(value = {"/deleteBoardComment"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> deleteBoardComment(@RequestBody Support param) throws Exception {
        return commonService.procRestTemplate("/support/deleteBoardComment", HttpMethod.POST, param, null);
    }

}
