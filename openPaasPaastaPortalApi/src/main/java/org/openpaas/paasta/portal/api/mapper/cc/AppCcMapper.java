package org.openpaas.paasta.portal.api.mapper.cc;

import org.openpaas.paasta.portal.api.config.service.surport.Cc;

@Cc
public interface AppCcMapper {

    String getAppBuildPack(String guid);

}
