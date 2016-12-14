package org.openpaas.paasta.portal.api.controller;

import org.openpaas.paasta.portal.api.model.Menu;
import org.openpaas.paasta.portal.api.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

/**
 * 메뉴 컨트롤러
 *
 * @author rex
 * @version 1.0
 * @since 2016.09.29
 */
@RestController
@RequestMapping(value = {"/menu"})
public class MenuController {

    private final MenuService menuService;

    /**
     * Instantiates a new Menu controller.
     *
     * @param menuService the menu service
     */
    @Autowired
    public MenuController(MenuService menuService) {
        this.menuService = menuService;
    }


    /**
     * Gets menu max no list.
     *
     * @param param the param
     * @return menu max no list
     */
    @RequestMapping(value = {"/getMenuMaxNoList"}, method = RequestMethod.POST, consumes = "application/json")
    public Map<String, Object> getMenuMaxNoList(@RequestBody Menu param) {
        return menuService.getMenuMaxNoList(param);
    }


    /**
     * Gets menu list.
     *
     * @param param the param
     * @return the menu list
     */
    @RequestMapping(value = {"/getMenuList"}, method = RequestMethod.POST, consumes = "application/json")
    public Map<String, Object> getMenuList(@RequestBody Menu param) {
        return menuService.getMenuList(param);
    }


    /**
     * Gets menu detail.
     *
     * @param param the param
     * @return menu detail
     */
    @RequestMapping(value = {"/getMenuDetail"}, method = RequestMethod.POST, consumes = "application/json")
    public Map<String, Object> getMenuDetail(@RequestBody Menu param) {
        return menuService.getMenuDetail(param);
    }


    /**
     * Insert menu.
     *
     * @param param the param
     * @return the map
     */
    @RequestMapping(value = {"/insertMenu"}, method = RequestMethod.POST, consumes = "application/json")
    public Map<String, Object> insertMenu(@RequestBody Menu param) {
        return menuService.insertMenu(param);
    }


    /**
     * Update menu.
     *
     * @param param the param
     * @return the map
     */
    @RequestMapping(value = {"/updateMenu"}, method = RequestMethod.PUT, consumes = "application/json")
    public Map<String, Object> updateMenu(@RequestBody Menu param) {
        return menuService.updateMenu(param);
    }


    /**
     * Delete menu.
     *
     * @param param the param
     * @return the map
     */
    @RequestMapping(value = {"/deleteMenu"}, method = RequestMethod.POST, consumes = "application/json")
    public Map<String, Object> deleteMenu(@RequestBody Menu param) {
        return menuService.deleteMenu(param);
    }


    /**
     * Gets user menu list.
     *
     * @return user menu list
     */
    @RequestMapping(value = {"/getUserMenuList"}, method = RequestMethod.POST, consumes = "application/json")
    public Map<String, Object> getUserMenuList() {
        return menuService.getUserMenuList();
    }
}
