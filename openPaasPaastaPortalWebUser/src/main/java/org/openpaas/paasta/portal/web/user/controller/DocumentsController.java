package org.openpaas.paasta.portal.web.user.controller;

import org.openpaas.paasta.portal.web.user.common.Common;
import org.openpaas.paasta.portal.web.user.common.Constants;
import org.openpaas.paasta.portal.web.user.model.Support;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * org.openpaas.paasta.portal.web.user.controller
 *
 * @author yjkim
 * @version 1.0
 * @since 2016.10.18
 */
@Controller
@RequestMapping(value = {"/documents"})
public class DocumentsController extends Common {

    /**
     * 문서 메인 페이지 이동
     *
     * @return documents main
     */
    @RequestMapping(value = {"/documentsMain"}, method = RequestMethod.GET)
    public ModelAndView getDocumentsMain() {

        return new ModelAndView(){
            {
                setViewName("/documents/documentsMain");
            }
        };
    }

    /**
     * 문서 조회 페이지 이동
     *
     * @param documentNo the documents no
     * @return documents view form
     */
    @RequestMapping(value = {"/documentsMain/view/{documentNo}"}, method = RequestMethod.GET)
    public ModelAndView getDocumentsView(@PathVariable("documentNo") String documentNo) {
        return new ModelAndView() {{
            setViewName("/documents/documentsDetailForm");
                                    addObject("DOCUMENT_NO", documentNo);
        }};
    }

    /**
     * 문서 상세 페이지 이동
     *
     * @param req
     * @return documents view form
     */
    @RequestMapping(value = {"/documentsMain/view"}, method = RequestMethod.POST)
    public ModelAndView getDocumentsView2(HttpServletRequest req) {

        ModelAndView mv = new ModelAndView();

        mv.addObject("DOCUMENT_NO", req.getParameter("documentNo"));
        mv.setViewName("/documents/documentsDetailForm");

        return mv;

    }
    /**
     * 문서 목록 조회
     *
     * @param param the param
     * @return documents list
     */
    @RequestMapping(value = {"/getDocumentsList"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getDocumentsList(@RequestBody Support param) {
        param.setUserId(commonService.getUserId());

        return commonService.procRestTemplate("/documents/getDocumentsList", HttpMethod.POST, param, null);
    }


    /**
     * 문서 조회
     *
     *@param param the param
     * @return get Document
     * @throws Exception the exception
     */
    @RequestMapping(value = {"/getDocument"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getDocument(@RequestBody Support param) throws Exception{
        return commonService.procRestTemplate("/documents/getDocument", HttpMethod.POST, param, null);
    }


}
