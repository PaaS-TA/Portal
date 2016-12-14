package org.openpaas.paasta.portal.web.admin.controller;

import org.openpaas.paasta.portal.web.admin.common.Common;
import org.openpaas.paasta.portal.web.admin.model.Menu;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.Map;

/**
 * 메뉴 컨트롤러
 *
 * @author rex
 * @version 1.0
 * @since 2016.09.29
 */
@Controller
@RequestMapping(value = {"/menu"})
public class MenuController extends Common {

    /**
     * Gets menu main.
     *
     * @return the menu main
     */
    @RequestMapping(value = {"/menuMain"}, method = RequestMethod.GET)
    public ModelAndView getMenuMain() {
        return new ModelAndView(){{setViewName("/menu/menuMain");}};
    }


    /**
     * Gets menu max no list.
     *
     * @param param the param
     * @return menu max no list
     */
    @RequestMapping(value = {"/getMenuMaxNoList"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getMenuMaxNoList(@RequestBody Menu param) {
        return commonService.procRestTemplate("/menu/getMenuMaxNoList", HttpMethod.POST, param, null);
    }


    /**
     * Gets menu list.
     *
     * @param param the param
     * @return the menu list
     */
    @RequestMapping(value = {"/getMenuList"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getMenuList(@RequestBody Menu param) {
        return commonService.procRestTemplate("/menu/getMenuList", HttpMethod.POST, param, null);
    }


    /**
     * Gets menu detail.
     *
     * @param param the param
     * @return the menu detail
     */
    @RequestMapping(value = {"/getMenuDetail"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getMenuDetail(@RequestBody Menu param) {
        return commonService.procRestTemplate("/menu/getMenuDetail", HttpMethod.POST, param, null);
    }


    /**
     * Insert menu.
     *
     * @param param the param
     * @return the map
     * @throws Exception the exception
     */
    @RequestMapping(value = {"/insertMenu"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> insertMenu(@RequestBody Menu param) throws Exception {
        return commonService.procRestTemplate("/menu/insertMenu", HttpMethod.POST, commonService.setUserId(param), null);
    }


    /**
     * Update menu.
     *
     * @param param the param
     * @return the map
     * @throws Exception the exception
     */
    @RequestMapping(value = {"/updateMenu"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> updateMenu(@RequestBody Menu param) throws Exception {
        return commonService.procRestTemplate("/menu/updateMenu", HttpMethod.PUT, commonService.setUserId(param), null);
    }


    /**
     * Delete menu.
     *
     * @param param the param
     * @return the map
     */
    @RequestMapping(value = {"/deleteMenu"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> deleteMenu(@RequestBody Menu param) {
        return commonService.procRestTemplate("/menu/deleteMenu", HttpMethod.POST, param, null);
    }
}
