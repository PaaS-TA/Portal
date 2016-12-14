package org.openpaas.paasta.portal.api.mapper.portal;

import org.openpaas.paasta.portal.api.config.datasource.surport.Portal;

import java.util.HashMap;

@Portal
public interface AppAutoScaleModalMapper {

    HashMap<String,Object> getAppAutoScaleInfo(String guid);

    int insertAppAutoScale(HashMap<String, Object> appAutoScale);

    int updateAppAutoScale(HashMap<String, Object> appAutoScale);

    int deleteAppAutoScale(String guid);
}
