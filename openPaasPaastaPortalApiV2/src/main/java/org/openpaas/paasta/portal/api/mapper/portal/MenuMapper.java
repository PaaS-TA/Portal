package org.openpaas.paasta.portal.api.mapper.portal;

import org.openpaas.paasta.portal.api.config.datasource.surport.Portal;
import org.openpaas.paasta.portal.api.model.Menu;

import java.util.List;

/**
 * org.openpaas.paasta.portal.api.mapper
 *
 * @author 김도준
 * @version 1.0
 * @since 2016.09.29
 */
@Portal
public interface MenuMapper {

    int getMenuMaxNoList(Menu param);

    List<Menu> getMenuList(Menu param);

    List<Menu> getMenuDetail(Menu param);

    int insertMenu(Menu param);

    int updateMenu(Menu param);

    int deleteMenu(Menu param);
}
