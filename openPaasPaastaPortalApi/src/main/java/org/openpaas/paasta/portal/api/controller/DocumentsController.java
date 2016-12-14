package org.openpaas.paasta.portal.api.controller;

import org.openpaas.paasta.portal.api.model.Support;
import org.openpaas.paasta.portal.api.service.DocumentsService;
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
@RequestMapping(value = {"/documents"})
public class DocumentsController {
    private static final Logger LOGGER = LoggerFactory.getLogger(DocumentsController.class);

    @Autowired
    private DocumentsService documentsService;


    /**
     * 문서 목록 조회
     *
     * @param response   the response
     * @return Document list
     * @throws Exception the exception
     */
    @RequestMapping(value = {"/getDocumentsList"}, method = RequestMethod.POST, consumes = "application/json")
    public Map<String, Object> getDocumentsList(@RequestBody Support param, HttpServletResponse response) throws Exception{
        LOGGER.info("getDocumentsList :: param :: {}, param.toString()");
        return documentsService.getDocumentsList(param);
    }

    /**
     * 문서 조회
     *
     * @param response   the response
     * @return Document
     * @throws Exception the exception
     */
    @RequestMapping(value = {"/getDocument"}, method = RequestMethod.POST, consumes = "application/json")
    public Map<String, Object> getDocument(@RequestBody Support param, HttpServletResponse response) throws Exception{
        LOGGER.info("getDocument :: param :: {}, param.toString()");
        return documentsService.getDocument(param);
    }

    /**
     * 문서 등록
     *
     * @param response   the response
     * @return insert Document
     * @throws Exception the exception
     */
    @RequestMapping(value = {"/insertDocument"}, method = RequestMethod.POST, consumes = "application/json")
    public Map<String, Object> insertDocument(@RequestBody Support param, HttpServletResponse response) throws Exception{
        LOGGER.info("insertDocument :: param :: {}, param.toString()");

        return documentsService.insertDocument(param);
    }

    /**
     * 문서 수정
     *
     * @param response   the response
     * @return update Document
     * @throws Exception the exception
     */
    @RequestMapping(value = {"/updateDocument"}, method = RequestMethod.PUT, consumes = "application/json")
    public Map<String, Object> updateDocument(@RequestBody Support param, HttpServletResponse response) throws Exception{
        LOGGER.info("updateDocument :: param :: {}, param.toString()");

        return documentsService.updateDocument(param);
    }

    /**
     * 문서 삭제
     *
     * @param response   the response
     * @return delete Document
     * @throws Exception the exception
     */
    @RequestMapping(value = {"/deleteDocument"}, method = RequestMethod.POST, consumes = "application/json")
    public Map<String, Object> deleteDocument(@RequestBody Support param, HttpServletResponse response) throws Exception{
        LOGGER.info("deleteDocument :: param :: {}, param.toString()");

        return documentsService.deleteDocument(param);
    }

}
