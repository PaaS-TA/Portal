package org.openpaas.paasta.portal.api.mapper;

import org.openpaas.paasta.portal.api.config.service.surport.Portal;
import org.openpaas.paasta.portal.api.model.UserManagement;

import java.util.List;

/**
 * org.openpaas.paasta.portal.api.mapper
 *
 * @author rex
 * @version 1.0
 * @since 2016.08.31
 */
@Portal
public interface UserManagementMapper {

    List<UserManagement> getUserInfoList(UserManagement param);

    int updateOperatingAuthority(UserManagement param);
}
