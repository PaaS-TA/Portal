package org.openpaas.paasta.portal.web.admin.controller;

import org.openpaas.paasta.portal.web.admin.common.Common;
import org.openpaas.paasta.portal.web.admin.model.Org;
import org.openpaas.paasta.portal.web.admin.model.Space;
import org.openpaas.paasta.portal.web.admin.service.CommonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.Map;

/**
 * Created by Dojun on 2016-09-06.
 */

@Controller
@RequestMapping(value = {"/orgSpaceList"})
public class OrgSpaceListController extends Common {

    //private static final Logger LOGGER = LoggerFactory.getLogger(OrgSpaceListController.class);

    @Autowired
    private CommonService commonService;

    @RequestMapping(value = {"/orgSpaceListMain"}, method = RequestMethod.GET)
    public ModelAndView getOrgSpaceListMain() {
        return new ModelAndView(){{setViewName("/orgSpaceList/orgSpaceListMain");}};
    }


    @RequestMapping(value = {"/getOrgsForAdmin"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getOrgsForAdmin(@RequestBody Map param) throws Exception {
        return commonService.procRestTemplate("/org/getOrgsForAdmin", HttpMethod.POST, param, null);
    }

    @RequestMapping(value = {"/getSpacesForAdmin"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getSpacesForAdmin(@RequestBody Map param) throws Exception {
        return commonService.procRestTemplate("/space/getSpacesForAdmin", HttpMethod.POST, param, null);
    }


    /**
     * 조직 요약 정보 조회
     *
     * @param org the org
     * @return Org rspOrg
     */
    @RequestMapping(value = {"/getOrgSummary"}, method = RequestMethod.POST)
    @ResponseBody
    public Org getOrgSummary(@RequestBody Org org) {

        Org rspOrg = null;

        if (org.getOrgName() == null) {
            throw new IllegalArgumentException("조직정보가 존재하지 않습니다.");
        }
        ResponseEntity rssResponse = commonService.procRestTemplate("/org/getOrgSummary", HttpMethod.POST, org, getToken(), Org.class);
        rspOrg = (Org) rssResponse.getBody();

        return rspOrg;
    }


    /**
     * 영역 요약 정보 조회
     *
     * @param space the space
     * @return Space rspSpace
     */
    @RequestMapping(value = {"/getSpaceSummary"}, method = RequestMethod.POST)
    @ResponseBody
    public Space getSpaceSummary(@RequestBody Space space) {

        Space rspSpace = new Space();

        ResponseEntity rssResponse = commonService.procRestTemplate("/space/getSpaceSummary", HttpMethod.POST, space, getToken(), Space.class);
        rspSpace = (Space) rssResponse.getBody();

        return rspSpace;
    }



}
