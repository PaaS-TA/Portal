package org.openpaas.paasta.portal.web.admin.controller;

import org.openpaas.paasta.portal.web.admin.model.Support;
import org.openpaas.paasta.portal.web.admin.service.CommonService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;
import java.util.Map;

/**
 * Created by Dojun on 2016-09-06.
 */

@Controller
@RequestMapping(value = {"/orgSpaceList"})
public class OrgSpaceListController {

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



}
