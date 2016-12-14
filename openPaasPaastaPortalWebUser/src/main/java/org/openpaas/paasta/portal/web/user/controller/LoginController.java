package org.openpaas.paasta.portal.web.user.controller;

import org.openpaas.paasta.portal.web.user.common.Common;
import org.openpaas.paasta.portal.web.user.common.Constants;
import org.openpaas.paasta.portal.web.user.model.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

/**
 * Login Controller
 *
 * @author nawkm
 * @version 1.0
 * @since 2016.4.4 최초작성
 *
 */
@Controller
public class LoginController extends Common {

    private static final Logger LOGGER = LoggerFactory.getLogger(LoginController.class);

    @RequestMapping(value = {"/", "index"}, method = RequestMethod.GET)
    public ModelAndView indevPage() {
        return new ModelAndView("/index");
    }

    /**
     * 로그인 화면
     *
     * @param error  the error
     * @param logout the logout
     * @param locale the locale
     * @return ModelAndView model
     */
    @RequestMapping(value = {"/login"}, method = RequestMethod.GET)
    public ModelAndView loginPage(@RequestParam(value = "error", required = false) String error,
                                   @RequestParam(value = "logout", required = false) String logout,
                                   Locale locale, HttpServletRequest request) {

        ModelAndView model = new ModelAndView();

        if (error != null) {
            model.addObject("error", "Invalid login.");
        }

        if (logout != null) {
            model.addObject("message", "Logged out successfully.");
        }

        LOGGER.info("ROLE_ADMIN : " + request.isUserInRole("ROLE_ADMIN"));
        LOGGER.info("ROLE_USER : " + request.isUserInRole("ROLE_USER"));

        if(!(request.isUserInRole("ROLE_USER") || request.isUserInRole("ROLE_ADMIN"))){
            model.setViewName("/login");
        }else{
            model.setViewName("redirect:/org/orgMain");
        }

        return model;
    }


    @RequestMapping(value = "/requestEmailAuthentication", method = RequestMethod.POST)
    public ModelAndView requestEmailAuthentication (HttpServletRequest request, HttpServletResponse response) {
        String id = (null == request.getParameter("id")) ? "" : request.getParameter("id").toString();
        ModelAndView model = new ModelAndView();

        User userDetail = new User();
        userDetail.setUserId(id);
        Map result = commonService.procRestTemplate("/requestEmailAuthentication", HttpMethod.POST, userDetail, null);

        model.setViewName("/user/addUser");
        if ((Boolean) result.get("bRtn")) {
            model.addObject("success", "인증이메일 보내기가 성공하였습니다.");
            model.addObject("id", id);
        } else {

            model.addObject("error",  result.getOrDefault("error","") +" 인증이메일 보내기가 실패하였습니다.");
        }

        return model;

    }
}
