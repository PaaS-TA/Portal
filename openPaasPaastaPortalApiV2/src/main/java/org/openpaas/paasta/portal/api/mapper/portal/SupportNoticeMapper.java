package org.openpaas.paasta.portal.api.mapper.portal;

import org.openpaas.paasta.portal.api.config.datasource.surport.Portal;
import org.openpaas.paasta.portal.api.model.Support;

import java.util.List;

/**
 * Created by YJKim on 2016-07-28.
 */
@Portal
public interface SupportNoticeMapper {
    List<Support> getNoticeList(Support param);
    Support getNotice(Support param);
    int insertNotice(Support param);
    int updateNotice(Support param);
    int deleteNotice(Support param);

}

