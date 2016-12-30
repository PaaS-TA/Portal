package org.openpaas.paasta.portal.api.mapper.portal;

import org.openpaas.paasta.portal.api.config.datasource.surport.Portal;
import org.openpaas.paasta.portal.api.model.UserManagement;

import java.util.List;

/**
 * org.openpaas.paasta.portal.api.mapper
 *
 * @author 김도준
 * @version 1.0
 * @since 2016.08.31
 */
@Portal
public interface UserManagementMapper {

    List<UserManagement> getUserInfoList(UserManagement param);

    int updateOperatingAuthority(UserManagement param);
}
