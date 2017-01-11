package org.openpaas.paasta.portal.web.user.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

/**
 * (사용되지 않음)
 * 각각의 에러 유형에 따른 기본 에러 페이지.
 *
 * @author 조민구
 * @version 1.0
 * @since 2016 -08-02
 */
@Controller
@RequestMapping("/common/error")
public class CommonErrorController {

    private static final Logger LOGGER = LoggerFactory.getLogger(CommonErrorController.class);


    /**
     * Throwable string.
     *
     * @param request the request
     * @param model   the model
     * @return the string
     */
    @RequestMapping(value = "/throwable")
    public String throwable(HttpServletRequest request, Model model) {
        LOGGER.info("throwable");
        pageErrorLog(request);
        model.addAttribute("msg", "예외가 발생하였습니다.");
        return "common/error";
    }

    /**
     * Exception string.
     *
     * @param request the request
     * @param model   the model
     * @return the string
     */
    @RequestMapping(value = "/exception")
    public String exception(HttpServletRequest request, Model model) {
        LOGGER.info("exception");
        pageErrorLog(request);
        model.addAttribute("msg", "예외가 발생하였습니다.");
        return "common/error";
    }

    /**
     * Page error 400 string.
     *
     * @param request the request
     * @param model   the model
     * @return the string
     */
    @RequestMapping(value = "/400")
    public String pageError400(HttpServletRequest request, Model model) {
        LOGGER.info("page error code 400");
        pageErrorLog(request);
        model.addAttribute("msg", "잘못된 요청입니다.");
        return "common/error";
    }

    /**
     * Page error 403 string.
     *
     * @param request the request
     * @param model   the model
     * @return the string
     */
    @RequestMapping(value = "/403")
    public String pageError403(HttpServletRequest request, Model model) {
        LOGGER.info("page error code 403");
        pageErrorLog(request);
        model.addAttribute("msg", "접근이 금지되었습니다.");
        return "common/error";
    }

    /**
     * Page error 404 string.
     *
     * @param request the request
     * @param model   the model
     * @return the string
     */
    @RequestMapping(value = "/404")
    public String pageError404(HttpServletRequest request, Model model) {
        LOGGER.info("page error code 404");
        pageErrorLog(request);
        model.addAttribute("msg", "요청하신 페이지는 존재하지 않습니다.");
        return "common/error";
    }

    /**
     * Page error 405 string.
     *
     * @param request the request
     * @param model   the model
     * @return the string
     */
    @RequestMapping(value = "/405")
    public String pageError405(HttpServletRequest request, Model model) {
        LOGGER.info("page error code 405");
        pageErrorLog(request);
        model.addAttribute("msg", "요청된 메소드가 허용되지 않습니다.");
        return "common/error";
    }

    /**
     * Page error 500 string.
     *
     * @param request the request
     * @param model   the model
     * @return the string
     */
    @RequestMapping(value = "/500")
    public String pageError500(HttpServletRequest request, Model model) {
        LOGGER.info("page error code 500");
        pageErrorLog(request);
        model.addAttribute("msg", "시스템 오류가 발생하였습니다.");
        return "common/error";
    }

    /**
     * Page error 503 string.
     *
     * @param request the request
     * @param model   the model
     * @return the string
     */
    @RequestMapping(value = "/503")
    public String pageError503(HttpServletRequest request, Model model) {
        LOGGER.info("page error code 503");
        pageErrorLog(request);
        model.addAttribute("msg", "서비스를 사용할 수 없습니다.");
        return "common/error";
    }

    private void pageErrorLog(HttpServletRequest request) {
        LOGGER.info("status_code : " + request.getAttribute("javax.servlet.error.status_code"));
        LOGGER.info("exception_type : " + request.getAttribute("javax.servlet.error.exception_type"));
        LOGGER.info("message : " + request.getAttribute("javax.servlet.error.message"));
        LOGGER.info("request_uri : " + request.getAttribute("javax.servlet.error.request_uri"));
        LOGGER.info("exception : " + request.getAttribute("javax.servlet.error.exception"));
        LOGGER.info("servlet_name : " + request.getAttribute("javax.servlet.error.servlet_name"));
    }
}