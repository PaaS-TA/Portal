package org.openpaas.paasta.portal.web.user.controller;

import org.openpaas.paasta.portal.web.user.common.Common;
import org.openpaas.paasta.portal.web.user.model.Support;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * DocumentsController.java
 * 문서 조회, 등록, 수정 등 문서 관리에 필요한 API를 호출하는 컨트롤러
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
     * @return ModelAndView
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
     * @param documentNo String(PathVariable)
     * @return ModelAndView
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
     * @return ModelAndView
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
     * @param param Support
     * @return Map
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
     * @param param Support
     * @return Map
     * @throws Exception the exception
     */
    @RequestMapping(value = {"/getDocument"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getDocument(@RequestBody Support param) throws Exception{
        return commonService.procRestTemplate("/documents/getDocument", HttpMethod.POST, param, null);
    }


}
