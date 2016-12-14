package org.openpaas.paasta.portal.api.controller;

import org.openpaas.paasta.portal.api.model.Support;
import org.openpaas.paasta.portal.api.service.SupportBoardService;
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
public class SupportBoardController {
    private static final Logger LOGGER = LoggerFactory.getLogger(SupportBoardController.class);

    @Autowired
    private SupportBoardService supportBoardService;


    /**
     * 게시판 목록 조회
     *
     * @param response   the response
     * @return Board list
     * @throws Exception the exception
     */
    @RequestMapping(value = {"/getBoardList"}, method = RequestMethod.POST, consumes = "application/json")
    public Map<String, Object> getBoardList(@RequestBody Support param, HttpServletResponse response) throws Exception{
        LOGGER.info("getBoardList :: param :: {}, param.toString()");
        return supportBoardService.getBoardList(param);
    }

    /**
     * 게시판 조회
     *
     * @param response   the response
     * @return Board
     * @throws Exception the exception
     */
    @RequestMapping(value = {"/getBoard"}, method = RequestMethod.POST, consumes = "application/json")
    public Map<String, Object> getBoard(@RequestBody Support param, HttpServletResponse response) throws Exception{
        LOGGER.info("getBoard :: param :: {}, param.toString()");
        return supportBoardService.getBoard(param);
    }

    /**
     * 게시판 댓글 목록 조회
     *
     * @param response   the response
     * @return Board list
     * @throws Exception the exception
     */
    @RequestMapping(value = {"/getBoardCommentList"}, method = RequestMethod.POST, consumes = "application/json")
    public Map<String, Object> getBoardCommentList(@RequestBody Support param, HttpServletResponse response) throws Exception{
        LOGGER.info("getBoardCommentList :: param :: {}, param.toString()");
        return supportBoardService.getBoardCommentList(param);
    }

    /**
     * 게시판 게시글 등록
     *
     * @param response   the response
     * @return insert Board
     * @throws Exception the exception
     */
    @RequestMapping(value = {"/insertBoard"}, method = RequestMethod.POST, consumes = "application/json")
    public Map<String, Object> insertBoard(@RequestBody Support param, HttpServletResponse response) throws Exception{
        LOGGER.info("insertBoard :: param :: {}, param.toString()");

        return supportBoardService.insertBoard(param);
    }

    /**
     * 게시판 게시글 수정
     *
     * @param response   the response
     * @return update Board
     * @throws Exception the exception
     */
    @RequestMapping(value = {"/updateBoard"}, method = RequestMethod.PUT, consumes = "application/json")
    public Map<String, Object> updateBoard(@RequestBody Support param, HttpServletResponse response) throws Exception{
        LOGGER.info("updateBoard :: param :: {}, param.toString()");

        return supportBoardService.updateBoard(param);
    }

    /**
     * 게시판 게시글 삭제
     *
     * @param response   the response
     * @return delete Board
     * @throws Exception the exception
     */
    @RequestMapping(value = {"/deleteBoard"}, method = RequestMethod.POST, consumes = "application/json")
    public Map<String, Object> deleteBoard(@RequestBody Support param, HttpServletResponse response) throws Exception{
        LOGGER.info("deleteBoard :: param :: {}, param.toString()");

        return supportBoardService.deleteBoard(param);
    }


    /**
     * 게시판 댓글 수 조회
     *
     * @param response   the response
     * @return Board reply number
     * @throws Exception the exception
     */
    @RequestMapping(value = {"/getReplyNum"}, method = RequestMethod.POST, consumes = "application/json")
    public Map<String, Object> getReplyNum(@RequestBody Support param, HttpServletResponse response) throws Exception{
        LOGGER.info("getReplyNum :: param :: {}, param.toString()");
        return supportBoardService.getReplyNum(param);
    }

    /**
     * 게시판 댓글 수 조회
     *
     * @param response   the response
     * @return Board
     * @throws Exception the exception
     */
    @RequestMapping(value = {"/getCommentReplyNum"}, method = RequestMethod.POST, consumes = "application/json")
    public Map<String, Object> getCommentReplyNum(@RequestBody Support param, HttpServletResponse response) throws Exception{
        LOGGER.info("getCommentReplyNum :: param :: {}, param.toString()");
        return supportBoardService.getCommentReplyNum(param);
    }


    /**
     * 게시판 댓글 등록
     *
     * @param response   the response
     * @return insert Board Comment
     * @throws Exception the exception
     */
    @RequestMapping(value = {"/insertBoardComment"}, method = RequestMethod.POST, consumes = "application/json")
    public Map<String, Object> insertBoardComment(@RequestBody Support param, HttpServletResponse response) throws Exception{
        LOGGER.info("insertBoardComment :: param :: {}, param.toString()");

        return supportBoardService.insertBoardComment(param);
    }

    /**
     * 게시판 댓글 수정
     *
     * @param response   the response
     * @return update Board Comment
     * @throws Exception the exception
     */
    @RequestMapping(value = {"/updateBoardComment"}, method = RequestMethod.PUT, consumes = "application/json")
    public Map<String, Object> updateBoardComment(@RequestBody Support param, HttpServletResponse response) throws Exception{
        LOGGER.info("updateBoardComment :: param :: {}, param.toString()");

        return supportBoardService.updateBoardComment(param);
    }

    /**
     * 게시판 댓글 삭제
     *
     * @param response   the response
     * @return delete Board Comment
     * @throws Exception the exception
     */
    @RequestMapping(value = {"/deleteBoardComment"}, method = RequestMethod.POST, consumes = "application/json")
    public Map<String, Object> deleteBoardComment(@RequestBody Support param, HttpServletResponse response) throws Exception{
        LOGGER.info("deleteBoardComment :: param :: {}, param.toString()");

        return supportBoardService.deleteBoardComment(param);
    }



}
