package org.openpaas.paasta.portal.web.user.controller;

import org.openpaas.paasta.portal.web.user.common.Common;
import org.openpaas.paasta.portal.web.user.model.Menu;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Map;

/**
 * 메뉴 컨트롤러
 *
 * @author rex
 * @version 1.0
 * @since 2016.10.10
 */
@Controller
@RequestMapping(value = {"/menu"})
public class MenuController extends Common {

    /**
     * Gets user menu list.
     *
     * @return user menu list
     */
    @RequestMapping(value = {"/getUserMenuList"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getUserMenuList() {
        return commonService.procRestTemplate("/menu/getUserMenuList", HttpMethod.POST, new Menu(), null);
    }
}
