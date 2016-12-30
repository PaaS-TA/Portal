package org.openpaas.paasta.portal.web.user.controller;

import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import org.openpaas.paasta.common.security.userdetails.User;
import org.openpaas.paasta.portal.web.user.common.Common;
import org.openpaas.paasta.portal.web.user.model.Org;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 조직 컨트롤러 - 조직 목록, 조직 이름 변경, 조직 생성 및 삭제 등을 제공한다.
 *
 * @author 조민구
 * @version 1.0
 * @since 2016.4.4 최초작성
 */
@Controller
public class OrgController extends Common {

    private static final Logger LOGGER = LoggerFactory.getLogger(OrgController.class);


    /**
     * 조직 메인 화면이다.
     *
     * @param response 응답 객체
     * @param session  세션
     * @return ModelAndView (자바 클래스)
     * @throws JSONException
     */
    @RequestMapping(value = {"/org/orgMain"}, method = RequestMethod.GET)
    public ModelAndView orgMain(HttpServletResponse response, HttpSession session) throws JSONException {

        ModelAndView model = new ModelAndView();
        String currentOrg = (String) session.getAttribute("currentOrg");

        String orgList = getOrgs(response, session);
        if (orgList != null && !orgList.equals("[]") && currentOrg == null) {
            JSONArray jsonArray = new JSONArray(orgList);
            JSONObject jsonObj = jsonArray.getJSONObject(0);
            LOGGER.info("getOrgSummary Start : " + jsonObj.getString("name"));
            session.setAttribute("currentOrg", jsonObj.getString("name"));
        }
        model.setViewName("/org/orgMain");

        return model;
    }


    /**
     * 조직 생성 화면이다.
     *
     * @author 김도준
     * @version 1.0
     * @since 2016.6.17 최초작성
     * @return ModelAndView(자바클래스)
     */
    @RequestMapping(value = {"/org/createOrgMain"}, method = RequestMethod.GET)
    public ModelAndView createOrgMainPage() {

        ModelAndView model = new ModelAndView();
        LOGGER.info("createOrgMain Start");


        LOGGER.info("createOrgMain End");
        model.setViewName("/org/createOrgMain");
        return model;
    }


    /**
     * 조직 요약 정보를 조회한다.
     *
     * @param org the org
     * @return Org rspOrg
     */
    @RequestMapping(value = {"/org/getOrgSummary"}, method = RequestMethod.POST)
    @ResponseBody
    public Org getOrgSummary(@RequestBody Org org) {

        Org rspOrg = null;

        LOGGER.info("getOrgSummary Start : " + org.getOrgName());
        if(org.getOrgName()==null){
            throw new IllegalArgumentException("조직정보가 존재하지 않습니다.");
        }
        ResponseEntity rssResponse = commonService.procRestTemplate("/org/getOrgSummary", HttpMethod.POST, org, getToken(), Org.class);
        rspOrg = (Org) rssResponse.getBody();

        LOGGER.info("getOrgSummary End ");

        return rspOrg;
    }


    /**
     * 조직명을 변경한다.
     *
     * @param org 조직 객체
     * @return ModelAndView modelgetUsersForOrg(userRole)
     */
    @RequestMapping(value = {"/org/renameOrg"}, method = RequestMethod.POST)
    @ResponseBody
    public boolean renameOrg(@RequestBody Org org) {

        LOGGER.info("Rename Org Start : " + org.getOrgName() + " : " + org.getNewOrgName());

        commonService.procRestTemplate("/org/renameOrg", HttpMethod.POST, org, getToken(), Boolean.class);
        LOGGER.info("Rename Org End ");

        return true;
    }

    /**
     * 조직을 생성한다.
     *
     * @param org 조직 객체
     * @return boolean (자바 클래스)
     * @author 김도준
     * @version 1.0
     * @since 2016.6.27 최초작성
     */
    @RequestMapping(value = {"/org/createOrg"}, method = RequestMethod.POST)
    @ResponseBody
    public boolean createOrg(@RequestBody Org org) {

        LOGGER.info("createOrg Start : " + org.getNewOrgName());

        commonService.procRestTemplate("/org/createOrg", HttpMethod.POST, org, getToken(), Boolean.class);
        LOGGER.info("createOrg End ");

        return true;
    }


    /**
     * 조직을 삭제한다.
     *
     * @param org 조직 객체
     * @return ModelAndView (자바 클래스)
     */
    @RequestMapping(value = {"/org/deleteOrg"}, method = RequestMethod.POST)
    @ResponseBody
    public boolean deleteOrg(@RequestBody Org org) {

        LOGGER.info("deleteOrg Start : " + org.getOrgName());

        commonService.procRestTemplate("/org/deleteOrg", HttpMethod.POST, org, getToken(), Boolean.class);
        LOGGER.info("deleteOrg End ");

        return true;
    }


    /**
     * 조직 목록을 조회한다.
     *
     * @param response 응답 객체
     * @param session  세션
     * @return String 문자열 형태의 조직 리스트
     * @author 김도준
     * @version 1.0
     * @since 2016.5.25 최초작성
     */
    @RequestMapping(value = {"/org/getOrgs"}, method = RequestMethod.POST)
    @ResponseBody
    public String getOrgs(HttpServletResponse response, HttpSession session) {

        String orgList = null;

        LOGGER.info("getOrgs Start");

        ResponseEntity rssResponse = commonService.procRestTemplate("/org/getOrgs", HttpMethod.POST, "", getToken(), String.class);
        orgList = (String) rssResponse.getBody();

        if (orgList == null) {
            LOGGER.info("Organization not found");
            return null;
        }

        LOGGER.info("getOrgs End");

        return orgList;
    }


    /**
     * 조직 세션값을 삽입한다.
     *
     * @param org  조직 객체
     * @param session 세션
     * @return boolean 작업 성공 여부
     * @throws IOException
     * @author 김도준
     * @version 1.0
     * @since 2016.5.25 최초작성
     */
    @RequestMapping(value = {"/org/setOrgSession"}, method = RequestMethod.POST)
    @ResponseBody
    public boolean setOrgSession(@RequestBody Org org, HttpSession session) throws IOException {
        LOGGER.info("setOrgSession Start");

        session.setAttribute("currentOrg", org.getOrgName());

        LOGGER.info("setOrgSession End");
        return true;
    }


    /**
     * 해당 조직에 대해 유저가 가진 모든 Role을 제거한다.
     *
     * @param org (조직 클래스)
     * @return boolean 작업 성공 여부
     * @author 김도준
     * @version 1.0
     * @since 2016.6.28 최초작성
     */
    @RequestMapping(value = {"/org/removeOrgFromUser"}, method = RequestMethod.POST)
    @ResponseBody
    public boolean removeOrgFromUser(@RequestBody Org org) {


        LOGGER.info("removeOrgFromUser Start : " + org.getOrgName());

        commonService.procRestTemplate("/org/removeOrgFromUser", HttpMethod.POST, org, getToken(), Boolean.class);
        LOGGER.info("removeOrgFromUser End ");

        return true;
    }


    /**
     * 해당 조직의 사용자 목록을 가져온다.
     *
     * @param body (자바 Map 클래스)
     * @return Map (자바 Map 클래스)
     * @author 김도준
     * @version 1.0
     * @since 2016.6.28 최초작성
     */
    @RequestMapping(value = {"/org/getUsersForOrg"}, method = RequestMethod.POST)
    @ResponseBody
    public Map getUsersForOrg(@RequestBody Map body) {

        LOGGER.info("getUsersForOrg Start");

        ResponseEntity rssResponse = commonService.procRestTemplate("/org/getUsersForOrg", HttpMethod.POST, body, getToken(), Map.class);
        Map users = (Map) rssResponse.getBody();

        LOGGER.info("getUsersForOrg End ");

        return users;
    }

    /**
     * 특정 유저에게 특정 조직에 대한 특정 역할을 부여한다.
     *
     * @param body (자바 Map 클래스)
     * @return boolean 작업 성공 여부
     * @author 김도준
     * @version 1.0
     * @since 2016.8.16 최초작성
     */
    @RequestMapping(value = {"/org/setOrgRole"}, method = RequestMethod.POST)
    @ResponseBody
    public boolean setOrgRole(@RequestBody Map body) {

        commonService.procRestTemplate("/org/setOrgRole", HttpMethod.POST, body, getToken(), boolean.class);

        return true;
    }

    /**
     * 특정 조직에 대한 특정 유저의 특정 역할을 제거한다.
     *
     * @param body (자바 Map 클래스)
     * @return boolean 작업 성공여부
     * @author 김도준
     * @version 1.0
     * @since 2016.8.16 최초작성
     */
    @RequestMapping(value = {"/org/unsetOrgRole"}, method = RequestMethod.POST)
    @ResponseBody
    public boolean unsetOrgRole(@RequestBody Map body) {

        commonService.procRestTemplate("/org/unsetOrgRole", HttpMethod.POST, body, getToken(), boolean.class);

        return true;
    }

    /**
     * 조직의 모든 사용자를 조회한다.
     *
     * @param body the body
     * @return the users for org async
     */
    @RequestMapping(value = {"/org/getAllUsers"}, method = RequestMethod.POST)
    @ResponseBody
    public List getUsersForOrg_async(@RequestBody Map body) {

        LOGGER.info("getAllUsers Start");
        User user = (User)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        body.put("userId",user.getUsername());
        ResponseEntity rssResponse = commonService.procRestTemplate("/org/getAllUsers", HttpMethod.POST, body, getToken(), List.class);
        List users = (List) rssResponse.getBody();

        LOGGER.info("getAllUsers End ");

        return users;
    }


    /**
     * 해당 조직롤의 사용자를 조회한다.
     *
     * @param body the body
     * @return the users for org role
     */
    @RequestMapping(value = {"/org/getUsersForOrgRole"}, method = RequestMethod.POST)
    @ResponseBody
    public List getUsersForOrgRole(@RequestBody Map body) {

        LOGGER.info("getUsersForOrgRole Start");
        User user = (User)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        body.put("userId",user.getUsername());
        ResponseEntity rssResponse = commonService.procRestTemplate("/org/getUsersForOrgRole", HttpMethod.POST, body, getToken(), List.class);
        List users = (List) rssResponse.getBody();

        LOGGER.info("getUsersForOrgRole End ");

        return users;
    }


    /**
     * 조직에 사용자를  이메일 인증을 통해 초대한다.
     *
     * @param body the body
     * @return map map
     * @throws Exception
     */
    @RequestMapping(value = {"/invite/inviteEmailSend"}, method = RequestMethod.POST)
    @ResponseBody
    public Map inviteEmailSend(@RequestBody Map body) {
        LOGGER.info("inviteEmailSend Start"+body.toString());
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        body.put("userId", user.getUsername());

        ResponseEntity rssResponse = commonService.procRestTemplate("/invite/inviteEmailSend", HttpMethod.POST, body, getToken(), Map.class);
        Map users = (Map) rssResponse.getBody();

        LOGGER.info("inviteEmailSend End ");

        return users;
    }

    /**
     * 조직에 사용자를  이메일 인증을 통해 초대한다.
     *
     * @param code the code
     * @return model and view
     * @throws Exception
     */
    @RequestMapping(value = {"/invitations/accept"})
    @ResponseBody
    public ModelAndView inviteAccept(@RequestParam(value = "code", required = false) String code){
//            HttpServletRequest request, HttpServletResponse response) {
        LOGGER.info("inviteAccept Start"+code);
        ModelAndView model = new ModelAndView();
        Map body = new HashMap();

        String addUserUrl = "/invitations/userInfo";
        body.put("code", code);
        ResponseEntity response = commonService.procRestTemplate(addUserUrl, HttpMethod.POST, body, null, HashMap.class);
        Map data = (Map) response.getBody();
        Map user = (Map)data.getOrDefault("userDetail", null);
        int listSize = (int) data.getOrDefault("listSize", 0);
        if(listSize==0){
            String urlPath = "/invitations/accept";
            model.addObject("error", "초대정보가 존재하지 않습니다.");
            return model;
        }
        if(user!= null){
            String urlPath = "/invitations/accept";
            ResponseEntity inviteResponse =commonService.procRestTemplate(urlPath, HttpMethod.POST, body, null, HashMap.class);
            Map inviteData = (Map) inviteResponse.getBody();
            model.addObject("success", inviteData.getOrDefault("success",null));
            model.addObject("error", inviteData.getOrDefault("error",null));
            model.setViewName("/invitations/accept");
             LOGGER.info("inviteEmailSend End ");
        }else{
            LOGGER.info("inviteAddUser");
            model.addObject("code", code);
            model.setViewName("/invitations/authUser");
        }
        return model;
    }

    /**
     * 조직의 사용자에게 초대 이메일을 재전송한다.
     *
     * @param body the body
     * @return map map
     * @throws Exception
     */
    @RequestMapping(value = {"/invite/inviteEmailReSend"}, method = RequestMethod.POST)
    @ResponseBody
    public Map inviteEmailReSend(@RequestBody Map body) {
        LOGGER.info("inviteEmailReSend Start"+body.toString());
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        body.put("userId", user.getUsername());

        ResponseEntity rssResponse = commonService.procRestTemplate("/invite/inviteEmailReSend", HttpMethod.POST, body, getToken(), Map.class);
        Map users = (Map) rssResponse.getBody();

        LOGGER.info("inviteEmailReSend End ");
        return users;
    }

    /**
     * 조직의 사용자에게 초대 이메일을 취소한다.
     *
     * @param body the body
     * @return map map
     * @throws Exception
     */
    @RequestMapping(value = {"/invite/cancelInvite"}, method = RequestMethod.POST)
    @ResponseBody
    public Map cancelInvite(@RequestBody Map body) {
        LOGGER.info("cancelInvite Start"+body.toString());
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        body.put("userId", user.getUsername());

        ResponseEntity rssResponse = commonService.procRestTemplate("/invite/cancelInvite", HttpMethod.POST, body, getToken(), Map.class);
        Map users = (Map) rssResponse.getBody();

        LOGGER.info("cancelInvite End ");
        return users;
    }

    /**
     * 조직에 사용자를 이메일 인증을 통해 초대한다.
     *
     * @param body the body
     * @return map map
     * @throws Exception
     */
    @RequestMapping(value = {"/invite/inviteEmailSendCnt"}, method = RequestMethod.POST)
    @ResponseBody
    public Map inviteEmailSendCnt(@RequestBody Map body) {
        LOGGER.info("inviteEmailSendCnt Start"+body.toString());
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        body.put("userId", user.getUsername());
        ResponseEntity rssResponse = commonService.procRestTemplate("/invite/inviteEmailSendCnt", HttpMethod.POST, body, getToken(), Map.class);
        Map users = (Map) rssResponse.getBody();
        LOGGER.info("inviteEmailSendCnt End ");

        return users;
    }


    /**
     * 사용자 멤버을 조직에서 제거한다.
     *
     * @param body the body
     * @return map map
     * @throws Exception the exception
     */
    @RequestMapping(value = {"/org/deleteUserOrg"}, method = RequestMethod.POST)
    @ResponseBody
    public Map deleteUserOrg(@RequestBody Map body) throws Exception {
        LOGGER.info("deleteUserOrg Start"+body.toString());
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        body.put("userId", user.getUsername());
        ResponseEntity rssResponse = null;
        if(stringNullCheck((String)body.getOrDefault("orgName","")) && stringNullCheck((String)body.getOrDefault("userGuid",""))){
            rssResponse = commonService.procRestTemplate("/org/deleteUserOrg", HttpMethod.POST, body, getToken(), Map.class);
        }else{
            throw new Exception("조직이나 사용자 정보가 없습니다.");
        }
        Map users = (Map) rssResponse.getBody();

        LOGGER.info("deleteUserOrg End ");

        return users;
    }

}
