package org.openpaas.paasta.portal.api.mapper.cc;

import org.openpaas.paasta.portal.api.config.datasource.surport.Cc;

import java.util.List;

/**
 * Created by Dojun on 2016-09-06.
 */
@Cc
public interface SpaceMapper {

    List<Object> getSpacesForAdmin(int orgId);
}
