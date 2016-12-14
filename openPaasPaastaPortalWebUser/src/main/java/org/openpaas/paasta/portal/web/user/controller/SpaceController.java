package org.openpaas.paasta.portal.web.user.controller;

import org.openpaas.paasta.common.security.userdetails.User;
import org.openpaas.paasta.portal.web.user.common.Common;
import org.openpaas.paasta.portal.web.user.common.Constants;
import org.openpaas.paasta.portal.web.user.model.Org;
import org.openpaas.paasta.portal.web.user.model.Space;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

/**
 * Org Controller
 *
 * @author nawkm
 * @version 1.0
 * @since 2016.4.4 최초작성
 */
@Controller
public class SpaceController extends Common {

    private static final Logger LOGGER = LoggerFactory.getLogger(SpaceController.class);

    /**
     * 영역 메인 화면
     *
     * @return ModelAndView model
     */
    @RequestMapping(value = {"/space/spaceMain"}, method = RequestMethod.GET)
    public ModelAndView loginPage() {

        LOGGER.info("login : " + SecurityContextHolder.getContext().getAuthentication().getName());

        ModelAndView model = new ModelAndView();

        model.setViewName("/space/spaceMain");
        return model;
    }

    /**
     * 영역 메인 화면
     *
     * @param spaceName the space name
     * @return model and view
     */
    @RequestMapping(value = {"/space/spaceMain/{spaceName}"}, method = RequestMethod.GET)
    public ModelAndView spaceMain(@PathVariable("spaceName") String spaceName) {
        return new ModelAndView(){{setViewName("/space/spaceMain");
                                    addObject("SPACE_NAME", spaceName);
        }};
    }

    /**
     * 영역 메인 화면
     *
     * @param viewMode the view mode
     * @return model and view
     */
    @RequestMapping(value = {"/space/spaceMain/viewMode/{viewMode}"}, method = RequestMethod.GET)
    public ModelAndView spaceMainViewMode(@PathVariable("viewMode") String viewMode) {
        return new ModelAndView(){{setViewName("/space/spaceMain");
                                    addObject("VIEW_MODE", viewMode);
        }};
    }

    /**
     * 영역 요약 정보 조회
     *
     * @param space the space
     * @return Space rspSpace
     */
    @RequestMapping(value = {"/space/getSpaceSummary"}, method = RequestMethod.POST)
    @ResponseBody
    public Space getSpaceSummary(@RequestBody Space space) {

        Space rspSpace = new Space();

        LOGGER.info("getSpaceSummary Start : " + space.getSpaceName());

        ResponseEntity rssResponse = commonService.procRestTemplate("/space/getSpaceSummary", HttpMethod.POST, space, getToken(), Space.class);
        rspSpace = (Space) rssResponse.getBody();

        LOGGER.info("getSpaceSummary End ");

        return rspSpace;
    }


    /**
     * 영역 생성
     *
     * @param space the space
     * @return boolean
     */
    @RequestMapping(value = {"/space/createSpace"}, method = RequestMethod.POST)
    @ResponseBody
    public boolean createSpace(@RequestBody Space space) {

        LOGGER.info("createSpace Start : " + space.getOrgName() + " : " + space.getNewSpaceName());

        commonService.procRestTemplate("/space/createSpace", HttpMethod.POST, space, getToken(), Boolean.class);
        LOGGER.info("createSpace End ");

        return true;
    }


    /**
     * 영역명 변경
     *
     * @param space the space
     * @return boolean
     */
    @RequestMapping(value = {"/space/renameSpace"}, method = RequestMethod.POST)
    @ResponseBody
    public boolean renameSpace(@RequestBody Space space) {

        LOGGER.info("Rename Space Start : " + space.getSpaceName() + " : " + space.getNewSpaceName());

        commonService.procRestTemplate("/space/renameSpace", HttpMethod.POST, space, getToken(), Boolean.class);
        LOGGER.info("Rename Space End ");

        return true;
    }

    /**
     * 조직 삭제
     *
     * @param space the space
     * @return boolean
     */
    @RequestMapping(value = {"/space/deleteSpace"}, method = RequestMethod.POST)
    @ResponseBody
    public boolean deleteSpace(@RequestBody Space space) {

        LOGGER.info("deleteSpace Start : " + space.getOrgName());

        commonService.procRestTemplate("/space/deleteSpace", HttpMethod.POST, space, getToken(), Boolean.class);
        LOGGER.info("deleteSpace End ");

        return true;
    }

    /**
     * 스페이스 목록 조회
     *
     * @param org the org
     * @return String spaces
     * @author kimdojun
     * @version 1.0
     * @since 2016.5.25 최초작성
     */
    @RequestMapping(value = {"/space/getSpaces"}, method = RequestMethod.POST)
    @ResponseBody
    public String getSpaces(@RequestBody Org org) {

        String spaces = null;
        LOGGER.info(org.getOrgName());


        LOGGER.info("getSpaces Start : ");

        ResponseEntity rssResponse = commonService.procRestTemplate("/space/getSpaces", HttpMethod.POST, org, getToken(), String.class);
        spaces = (String) rssResponse.getBody();

        if (spaces == null) {
            LOGGER.info("Space not found");
            return null;
        }

        LOGGER.info("getSpaces End");

        return spaces;
    }

    /**
     * 영역(스페이스) 세션값 삽입
     *
     * @param space   the space
     * @param session the session
     * @return boolean space session
     * @author kimdojun
     * @version 1.0
     * @since 2016.5.26 최초작성
     */
    @RequestMapping(value = {"/space/setSpaceSession"}, method = RequestMethod.POST)
    @ResponseBody
    public boolean setSpaceSession(@RequestBody Space space, HttpSession session) {
        LOGGER.info("setSpaceSession Start");

        session.setAttribute("currentSpace", space.getSpaceName());
       
        LOGGER.info("setSpaceSession End");
        return true;
    }

    /**
     * 해당 영역에 특정 Role을 가진 유저목록
     *
     * @param body the body
     * @return boolean users for org
     * @author kimdojun
     * @version 1.0
     * @since 2016.6.28 최초작성
     */
    @RequestMapping(value = {"/space/getUsersForSpace"}, method = RequestMethod.POST)
    @ResponseBody
    public Map getUsersForOrg(@RequestBody Map body) {

        LOGGER.info("getUsersForSpace Start");

        ResponseEntity rssResponse = commonService.procRestTemplate("/space/getUsersForSpace", HttpMethod.POST, body, getToken(), Map.class);
        Map users = (Map) rssResponse.getBody();

        LOGGER.info("getUsersForSpace End ");

        return users;
    }

    /**
     * 특정 유저에게 특정 영역에 대한 특정 역할을 부여
     *
     * @param body the body
     * @return boolean org role
     * @author kimdojun
     * @version 1.0
     * @since 2016.8.18 최초작성
     */
    @RequestMapping(value = {"/space/setSpaceRole"}, method = RequestMethod.POST)
    @ResponseBody
    public boolean setOrgRole(@RequestBody Map body) {

        commonService.procRestTemplate("/space/setSpaceRole", HttpMethod.POST, body, getToken(), boolean.class);

        return true;
    }

    /**
     * 특정 영역에 대한 특정 유저의 특정 역할을 제거
     *
     * @param body the body
     * @return boolean boolean
     * @author kimdojun
     * @version 1.0
     * @since 2016.8.18 최초작성
     */
    @RequestMapping(value = {"/space/unsetSpaceRole"}, method = RequestMethod.POST)
    @ResponseBody
    public boolean unsetOrgRole(@RequestBody Map body) {

        commonService.procRestTemplate("/space/unsetSpaceRole", HttpMethod.POST, body, getToken(), boolean.class);

        return true;
    }


    @RequestMapping(value = {"/space/getUsersForSpaceRole"}, method = RequestMethod.POST)
    @ResponseBody
    public List getUsersForSpaceRole(@RequestBody Map body) {

        LOGGER.info("getUsersForSpaceRole Start");
        User user = (User)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        body.put("userId",user.getUsername());
        ResponseEntity rssResponse = commonService.procRestTemplate("/space/getUsersForSpaceRole", HttpMethod.POST, body, getToken(), List.class);
        List users = (List) rssResponse.getBody();

        LOGGER.info("getUsersForSpaceRole End ");

        return users;
    }
}
