package org.openpaas.paasta.portal.api.service;

import org.openpaas.paasta.portal.api.common.Constants;
import org.openpaas.paasta.portal.api.mapper.MenuMapper;
import org.openpaas.paasta.portal.api.model.Menu;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

/**
 * 메뉴 서비스
 *
 * @author rex
 * @version 1.0
 * @since 2016.09.29
 */
@Transactional
@Service
public class MenuService {

    private final MenuMapper menuMapper;

    /**
     * Instantiates a new Menu service.
     *
     * @param menuMapper the menu mapper
     */
    @Autowired
    public MenuService(MenuMapper menuMapper) {
        this.menuMapper = menuMapper;
    }


    /**
     * Gets menu max no list.
     *
     * @param param the param
     * @return menu max no list
     */
    public Map<String, Object> getMenuMaxNoList(Menu param) {
        return new HashMap<String, Object>() {{
            put("MAX_NO", menuMapper.getMenuMaxNoList(param));
            put("RESULT", Constants.RESULT_STATUS_SUCCESS);
        }};
    }


    /**
     * Gets menu list.
     *
     * @param param the param
     * @return menu list
     */
    public Map<String, Object> getMenuList(Menu param) {
        HashMap<String, Object> resultMap = (HashMap<String, Object>) this.getRecursiveMenuList(param);

        return new HashMap<String, Object>() {{
            put("RESULT_DATA", new HashMap<String, Object>() {{
                put("id", 0);
                put("text", "ROOT");
                put("item", new ArrayList<Object>() {{
                            add(new HashMap<String, Object>() {{
                                put("id", -1);
                                put("text", "메뉴");
                                put("open", 1);
                                put("item", resultMap.get("item"));
                            }});
                        }}
                );
            }});

            put("RESULT", Constants.RESULT_STATUS_SUCCESS);
        }};
    }


    /**
     * Gets menu list.
     *
     * @param param the param
     * @return menu list
     */
    private Map<String, Object> getRecursiveMenuList(Menu param) {
        List<HashMap<String, Object>> resultList = new ArrayList<>();

        // GET ROOT NODE
        List<Menu> menuList = menuMapper.getMenuList(new Menu() {{
            setParentNo((null != param) ? param.getNo() : 0);
        }});

        for (Menu menuModel : menuList) {
            HashMap<String, Object> menuItemMap = new HashMap<String, Object>() {{
                put("id", menuModel.getNo());
                put("text", menuModel.getMenuName());
            }};

            if (menuModel.getChildCount() > 0) {
                // GET CHILD NODE (RECURSIVE)
                menuItemMap.put("item", this.getRecursiveMenuList(menuModel).get("item"));
            }

            resultList.add(menuItemMap);
        }

        return new HashMap<String, Object>() {{
            put("item", resultList);
        }};
    }


    /**
     * Gets menu detail.
     *
     * @param param the param
     * @return menu detail
     */
    public Map<String, Object> getMenuDetail(Menu param) {
        return new HashMap<String, Object>() {{
            put("RESULT_DATA", menuMapper.getMenuDetail(param));
            put("RESULT", Constants.RESULT_STATUS_SUCCESS);
        }};
    }


    /**
     * Insert menu.
     *
     * @param param the param
     * @return the map
     */
    public Map<String, Object> insertMenu(Menu param) {
        menuMapper.insertMenu(param);

        return new HashMap<String, Object>(){{put("RESULT", Constants.RESULT_STATUS_SUCCESS);}};
    }


    /**
     * Update menu.
     *
     * @param param the param
     * @return the map
     */
    public Map<String, Object> updateMenu(Menu param) {
        menuMapper.updateMenu(param);

        return new HashMap<String, Object>(){{put("RESULT", Constants.RESULT_STATUS_SUCCESS);}};
    }


    /**
     * Delete menu.
     *
     * @param param the param
     * @return the map
     */
    public Map<String, Object> deleteMenu(Menu param) {
        menuMapper.deleteMenu(param);

        return new HashMap<String, Object>(){{put("RESULT", Constants.RESULT_STATUS_SUCCESS);}};
    }


    /**
     * Gets user menu list.
     *
     * @return user menu list
     */
    public Map<String, Object> getUserMenuList() {
        return new HashMap<String, Object>() {{
            put("list", menuMapper.getMenuList(new Menu(){{setParentNo(0); setUseYn(Constants.USE_YN_Y);}}));
            put("RESULT", Constants.RESULT_STATUS_SUCCESS);
        }};

    }
}
