package org.openpaas.paasta.portal.web.user.controller;

import org.openpaas.paasta.common.security.userdetails.User;
import org.openpaas.paasta.portal.web.user.common.Common;
import org.openpaas.paasta.portal.web.user.common.Constants;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

/**
 * User Controller
 *
 * @author mg
 * @version 1.0
 * @since 2016.5.23 최초작성
 */
@Controller
@RequestMapping(value = {"/user"})
public class UserController extends Common {

    private static final Logger LOGGER = LoggerFactory.getLogger(UserController.class);

    /**
     * 조직 메인 화면
     *
     * @param
     * @return ModelAndView model
     */
    @RequestMapping(value = {"/myPage"}, method = RequestMethod.GET)
    public ModelAndView getMyPage() {
        LOGGER.info("> into myPage...");

        String userId = SecurityContextHolder.getContext().getAuthentication().getName();
        String urlPath = "/user/getUserAndOrgs/" + userId;

        LOGGER.info("login : " + userId);

        ResponseEntity rssResponse = commonService.procRestTemplate(urlPath, HttpMethod.GET, null, getToken(), HashMap.class);
        Map<String, Object> result = (HashMap) rssResponse.getBody();


        ModelAndView model = new ModelAndView();

        model.addObject("user", result.get("User"));
        model.addObject("orgs", result.get("Orgs"));
        model.setViewName("/user/myPage");

        return model;
    }

    @RequestMapping(value = {"/updateUser/{userId:.+}"}, method = RequestMethod.PUT)
    @ResponseBody
    public Map updateUser(@PathVariable String userId, @RequestBody Map body) {
        LOGGER.info("> into updateUser...");

        String urlPath = "/user/updateUser/" + userId;

        ResponseEntity rssResponse = commonService.procRestTemplate(urlPath, HttpMethod.PUT, body, getToken(), HashMap.class);
        Map<String, Object> result = (HashMap) rssResponse.getBody();

        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (body.containsKey("userName")) user.setName((String) body.get("userName"));
        if (body.containsKey("imgPath")) user.setImgPath((String) body.get("imgPath"));


        Authentication authentication = new UsernamePasswordAuthenticationToken(user, user.getPassword(), user.getAuthorities());
        SecurityContextHolder.getContext().setAuthentication(authentication);

        return result;
    }

    /**
     * @return ModelAndView
     */
    @RequestMapping(value = {"/updateUserEmail"}, method = RequestMethod.GET)
    public ModelAndView getUpdateUserEmailPage() {
        LOGGER.info("> into getUpdateEmailPage...");

        // get id of current user
        String userId = SecurityContextHolder.getContext().getAuthentication().getName();

        LOGGER.info("login : " + userId);

        ModelAndView model = new ModelAndView();

        model.addObject("oldUserId", userId);
        model.setViewName("/user/updateEmail");

        return model;
    }

    @RequestMapping(value = {"/updateUserEmail/{userId:.+}"}, method = RequestMethod.PUT)
    @ResponseBody
    public Map updateUserEmail(@PathVariable String userId, @RequestBody Map body) throws Throwable {
        LOGGER.info("> into updateUserEmail...");

        Map<String, Object> result = new HashMap<>();
        String urlPath = "/user/updateUserEmail/" + userId;

        ResponseEntity rssResponse = commonService.procRestTemplate(urlPath, HttpMethod.PUT, body, getToken(), HashMap.class);
        result = (HashMap) rssResponse.getBody();

        return result;
    }

    /**
     * @return ModelAndView
     */
    @RequestMapping(value = {"/updateUserPassword"}, method = RequestMethod.GET)
    public ModelAndView getpdateUserPasswordPage() {
        LOGGER.info("> into getUpdatePasswordPage...");

        ModelAndView model = new ModelAndView();
        String userId = SecurityContextHolder.getContext().getAuthentication().getName();

        model.addObject("userId", userId);
        model.setViewName("/user/updatePassword");

        return model;
    }

    @RequestMapping(value = {"/updateUserPassword/{userId:.+}"}, method = RequestMethod.PUT)
    @ResponseBody
    public Map updateUserPassword(@PathVariable String userId, @RequestBody Map body) throws Throwable {
        LOGGER.info("> into updateUserPassword...");

        Map<String, Object> result = new HashMap<>();
        String urlPath = "/user/updateUserPassword/" + userId;

        ResponseEntity rssResponse = commonService.procRestTemplate(urlPath, HttpMethod.PUT, body, getToken(), HashMap.class);
        result = (HashMap) rssResponse.getBody();

        return result;
    }

    @RequestMapping(value = {"/deleteUser/{userId:.+}"}, method = RequestMethod.PUT)
    @ResponseBody
    public Map deleteUser(@PathVariable String userId, @RequestBody Map body) throws Throwable {
        LOGGER.info("> into deleteUser...");

        Map<String, Object> result = new HashMap<>();
        String urlPath = "/user/deleteUser/" + userId;

        ResponseEntity rssResponse = commonService.procRestTemplate(urlPath, HttpMethod.PUT, body, getToken(), HashMap.class);
        result = (HashMap) rssResponse.getBody();

        return result;
    }

    /**
     * role에 따른 조직 및 영역 조회
     *
     * @return String
     * @author kimdojun
     * @version 1.0
     * @author kimdojun
     * @version 1.0
     * <p>
     * keyOfRole값을 파라미터로 보내 유저가 해당 role을 가지고 있는 모든 org 또는 space 정보를 가져온다.
     * ex: 'managed_organizations' 을 입력하여 해당 유저가 Org Manager role을 가지고 있는 모든 org를 확인할 수 있다.
     * <p>
     * 조직 role           keyOfRole 값
     * ORG MANAGER:        managed_organizations
     * BILLING MANAGER:    billing_managed_organizations
     * ORG AUDITOR:        audited_organizations
     * ORG USER:           organizations
     * <p>
     * 영역 role
     * SPACE MANAGER:      managed_spaces
     * SPACE DEVELOPER:    spaces
     * SPACE AUDITOR:      audited_spaces
     * @since 2016.6.09 최초작성
     */

    @RequestMapping(value = {"/getListForTheUser/{keyOfRole}"}, method = RequestMethod.POST)
    @ResponseBody
    public List getListForUser(@PathVariable String keyOfRole, HttpServletResponse response) {
        LOGGER.info("getListForTheUser Start : ");

        String urlPath = "/user/getListForTheUser/" + keyOfRole;
        List orgOrSpaceList = null;

        ResponseEntity rssResponse = commonService.procRestTemplate(urlPath, HttpMethod.POST, "", getToken(), List.class);
        orgOrSpaceList = (List) rssResponse.getBody();

        LOGGER.info("getListForTheUser End");

        return orgOrSpaceList;
    }

    /**
     * 계정인증 화면
     *
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/addUser")
    public ModelAndView addUser(@RequestParam(value = "error", required = false) String error,
                                @RequestParam(value = "success", required = false) String logout,
                                HttpServletRequest request, HttpServletResponse response) {

        LOGGER.info("addUser : " + request);

        ModelAndView model = new ModelAndView();

        model.setViewName("/user/addUser");

        return model;
    }

    /**
     * 비밀번호 재설정 이메일 발송
     *
     * @param refreshToken
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/resetPassword")
    public ModelAndView resetPassword(
                                      @RequestParam(value = "refreshToken", required = false) String refreshToken,
                                      HttpServletRequest request, HttpServletResponse response) {

        LOGGER.info("resetPassword : " + request);
        ModelAndView model = new ModelAndView();
        model.setViewName("/user/resetPassword");

        if (null != request.getParameter("id")) {
            String id = (null == request.getParameter("id")) ? "" : request.getParameter("id").toString();
            org.openpaas.paasta.portal.web.user.model.User userDetail = new org.openpaas.paasta.portal.web.user.model.User();

            userDetail.setUserId(id);
            Map result = commonService.procRestTemplate("/user/resetPassword", HttpMethod.POST, userDetail, null);
            model.addObject("id", id);
            if ((Integer) result.get("resultUser") < 1) {
                model.addObject("error", "등록된 이메일이 아닙니다.");
            } else {
                if ((Boolean) result.get("resetPassword")) {
                    model.addObject("success", "인증이메일 보내기가 성공하였습니다.");
                    model.addObject("refreshToken", refreshToken);

                } else {
                    model.addObject("success", "인증이메일 보내기가 실패하였습니다.");
                }
            }
        }
        return model;
    }

     /**
     * 계정생성을 위한 이메일통한 인증 프로세서
     * 기간 : 30일 , 접근횟수 3회
     *  controller에 접근 할때마다 1회씩 자동으로 횟수가 증가함.
     *
     * @param request  {refreshToken, userId, status}
     * @param response
     * @return
     */
    @RequestMapping(value = {"/authUser"}, method = RequestMethod.GET)
    public ModelAndView authUser(@RequestParam(value = "refreshToken", required = false) String refreshToken,
                                 @RequestParam(value = "userId", required = false) String userId,
                                 HttpServletRequest request, HttpServletResponse response) {

        org.openpaas.paasta.portal.web.user.model.User userDetail = new org.openpaas.paasta.portal.web.user.model.User();
        userDetail.setUserId(userId);
        Map result = commonService.procRestTemplate("/user/confirmAuthUser", HttpMethod.POST, userDetail, null);
        userDetail.setRefreshToken(refreshToken);
        Integer rtnResult = (Integer) result.getOrDefault("resultUser", 0);

        ModelAndView model = new ModelAndView();
        if (rtnResult > 0) {
            List rtnUser = (List) result.getOrDefault("listResultUser", new ArrayList());
            HashMap rtnUserDetail = (HashMap) rtnUser.get(0);
            if("1".equals(rtnUserDetail.getOrDefault("status",""))){
                model.setViewName("/user/authErrorUser");
                model.addObject("error", userId + "님의 계정은 등록된 아이디 입니다.");
                return model;
            }
            if("".equals(rtnUserDetail.getOrDefault("refreshToken",""))){
                model.setViewName("/user/authErrorUser");
                model.addObject("error", userId + "님의 인증코드가 존재하지 않습니다.");
                return model;
            }

            int accessCnt = (Integer)rtnUserDetail.getOrDefault("authAccessCnt",0);
            Long ldate = (Long)rtnUserDetail.getOrDefault("authAccessTime",0);
            Date accessDate = new Date(ldate);

            int diffday = diffDay(new Date(), accessDate);

            if(diffday > 30) {
                model.setViewName("/user/authErrorUser");
                model.addObject("error", userId + " 인증 기간을" + Integer.toString(diffday) +"일 초과하였습니다. 재인증이 필요합니다.");
                return model;
            }

            if(accessCnt > 3){
                model.setViewName("/user/authErrorUser");
                model.addObject("error",userId + " 인증 접속 3회를 초과하였습니다. 재인증이 필요합니다.");
                return model;
            }

            if("0".equals(rtnUserDetail.getOrDefault("status","")) && rtnUserDetail.getOrDefault("refreshToken","").equals(refreshToken)) {
                model.setViewName("/user/authUser");
                model.addObject("userId", rtnUserDetail.getOrDefault("userId", ""));
                return model;
            }

        } else {
            model.setViewName("/user/authErrorUser");
            model.addObject("userId", userId);
            model.addObject("error", userId + "계정의 인증토큰이 만료되었습니다. ");
        }

        return model;
    }
    /**
     *  이메일 인증이 확인된 사용자의 계정생성
     * @param refreshToken
     * @param userId
     * @param password
     * @param username
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = {"/authUpdateUser" }, method = RequestMethod.POST)
    public ModelAndView authPassword(@RequestParam(value = "refreshToken", required = false) String refreshToken,
                                     @RequestParam(value = "userId", required = false) String userId,
                                     @RequestParam(value = "password", required = false) String password,
                                     @RequestParam(value = "username", required = false) String username,
                                     HttpServletRequest request, HttpServletResponse response)  {

        ModelAndView model = new ModelAndView();
        model.addObject("userId", userId);
        model.setViewName("/user/authUpdateUser");

        if (null != userId) {

            HashMap map = new HashMap();
            map.put("userId", userId);
            map.put("username", username);
            map.put("password", password);

            Map resultMap = commonService.procRestTemplate("/user/authAddUser", HttpMethod.POST, map, null);
            if((Boolean)resultMap.getOrDefault("bRtn",false)) {
                model.addObject("success", "계정생성을 성공하였습니다.");
                model.addObject("userId", userId);
            }  else{
                model.addObject("error", "계정생성을 실패하였습니다.");
                model.addObject("userId", userId);
            }
        }
        return model;
    }

    /**
     * 이메일통한 인증 프로세서
     * 기간 : 30일 , 접근횟수 3회
     *  controller에 접근 할때마다 1회씩 자동으로 횟수가 증가함.
     *
     * @param error
     * @param refreshToken
     * @param userId
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/authPassword")
    public ModelAndView authPassword(@RequestParam(value = "error", required = false) String error,
                                     @RequestParam(value = "refreshToken", required = false) String refreshToken,
                                     @RequestParam(value = "userId", required = false) String userId,
                                     HttpServletRequest request, HttpServletResponse response) {

        ModelAndView model = new ModelAndView();
        LOGGER.info("authPassword : " + request);
        org.openpaas.paasta.portal.web.user.model.User userDetail = new org.openpaas.paasta.portal.web.user.model.User();
        userDetail.setUserId(userId);
        Map result = commonService.procRestTemplate("/user/confirmAuthUser", HttpMethod.POST, userDetail, null);
        Integer rtnResult = (Integer) result.getOrDefault("resultUser", 0);
        List list = (List) result.getOrDefault("listResultUser", new ArrayList());
        if (rtnResult > 0) {
            HashMap user = ((HashMap)list.get(0));

            String status = (String) user.getOrDefault("status", "");
            int accessCnt = (Integer)user.getOrDefault("authAccessCnt",0);
            Long ldate = (Long)user.getOrDefault("authAccessTime",0);
            Date accessDate = new Date(ldate);


            if("".equals(user.getOrDefault("refreshToken",""))|| !refreshToken.equals(user.getOrDefault("refreshToken",""))){
                model.setViewName("/user/authErrorUser");
                model.addObject("error", userId + "님의 인증코드가 일치하지 않습니다.");
                return model;
            }

            int diffday = diffDay(new Date(), accessDate);

            if(diffday > 30) {
                model.setViewName("/user/authErrorUser");
                model.addObject("error", userId + " 인증 기간을" + Integer.toString(diffday) +"일 초과하였습니다. 재인증이 필요합니다.");
                return model;
            }

            if(accessCnt > 3){
                model.setViewName("/user/authErrorUser");
                model.addObject("error",userId + " 인증 접속 3회를 초과하였습니다. 재인증이 필요합니다.");
                return model;
            }

            if("1".equals(status) && refreshToken.equals(user.getOrDefault("refreshToken",""))){
                model.addObject("userId", user.getOrDefault("userId", ""));
                model.addObject("refreshToken", user.getOrDefault("refreshToken", ""));
                model.setViewName("/user/authPassword");
            }else{
                model.setViewName("/user/authErrorUser");
                model.addObject("userId", userId);
                model.addObject("error", userId + " 이메일 인증된 사용자가 아닙니다. ");
            }
        } else {
            model.setViewName("/user/authErrorUser");
            model.addObject("userId", userId);
            model.addObject("error", userId + " 계정의 인증토큰이 만료되었습니다. ");
        }
        return model;
    }

    /**
     *  패스워드 재설정
     *
     * @param userId
     * @param password
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = {"/authResetPassword" }, method = RequestMethod.POST)
    public ModelAndView authResetPassword( @RequestParam(value = "userId", required = false) String userId,
                                            @RequestParam(value = "password", required = false) String password,
                                           HttpServletRequest request, HttpServletResponse response) {
        ModelAndView model = new ModelAndView();
        model.setViewName("/user/authPassword");

        String urlPath = "/user/authResetPassword";
        Map<String, Object> requestBody = new HashMap<>();
        requestBody.put("username", userId);
        requestBody.put("userId", userId);
        requestBody.put("newPassword", password);
        Map resultMap = commonService.procRestTemplate("/user/authResetPassword", HttpMethod.POST, requestBody, null);
        if((Boolean)resultMap.getOrDefault("bRtn",false)) {
            model.addObject("success", "비밀번호 변경을 성공하였습니다.");
            model.addObject("userId", userId);
        }  else{
            model.addObject("error", "비밀번호 변경 실패하였습니다.");
            model.addObject("userId", userId);
        }
        model.addObject("result",resultMap);
        return model;
    }

    @RequestMapping(value = {"/getUploadProfileImgPopup"}, method = RequestMethod.GET)
    public ModelAndView getUploadProfileImgPopup() {
        LOGGER.info("into getUploadProfileImgPopup... ");
        ModelAndView model = new ModelAndView();
        model.setViewName("/user/uploadProfileImgPopup");
        return model;
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
        return commonService.procRestTemplate("/support/myQuestion/uploadFile", multipartFile, null);
    }
    @RequestMapping(value = {"/getUser"}, method = RequestMethod.POST)
    @ResponseBody
    public Map getUser(@RequestBody HashMap body) throws Exception {
        String urlPath   =  "/user/getUser/";
        Map resultMap = new HashMap();
        if("".equals(body.getOrDefault("userId",""))) {
           throw new Exception("사용자 아이디가 존재하지 않습니다.");
        }
        resultMap = commonService.procRestTemplate(urlPath, HttpMethod.POST, body, null);
        return  resultMap;
    }

}
