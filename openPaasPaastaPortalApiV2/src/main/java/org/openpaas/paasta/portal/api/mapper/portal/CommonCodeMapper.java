package org.openpaas.paasta.portal.api.mapper.portal;

import org.openpaas.paasta.portal.api.config.datasource.surport.Portal;
import org.openpaas.paasta.portal.api.model.CommonCode;

import java.util.List;

/**
 * org.openpaas.paasta.portal.api.mapper
 *
 * @author 김도준
 * @version 1.0
 * @since 2016.06.15
 */
@Portal
public interface CommonCodeMapper {

    List<CommonCode> getCommonCodeById(CommonCode param);

    List<CommonCode> getCommonCodeGroup(CommonCode param);

    int getCommonCodeGroupCount(CommonCode param);

    List<CommonCode> getCommonCodeDetail(CommonCode param);

    int getCommonCodeDetailCount(CommonCode param);

    int insertCommonCodeGroup(CommonCode param);

    int insertCommonCodeDetail(CommonCode param);

    int updateCommonCodeGroup(CommonCode commonCode);

    int updateCommonCodeDetail(CommonCode commonCode);

    int deleteCommonCodeGroup(CommonCode param);

    int deleteCommonCodeDetail(CommonCode param);
}
