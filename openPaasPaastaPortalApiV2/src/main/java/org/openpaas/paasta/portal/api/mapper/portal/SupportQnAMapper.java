package org.openpaas.paasta.portal.api.mapper.portal;

import org.openpaas.paasta.portal.api.config.datasource.surport.Portal;
import org.openpaas.paasta.portal.api.model.Support;

import java.util.List;

/**
 * Created by YJKim on 2016-07-28.
 */
@Portal
public interface SupportQnAMapper {
    List<Support> getQnAList(Support param);

    Support getQuestion(Support param);
    Support getAnswer(Support param);

    int insertAnswer(Support param);
    int updateAnswer(Support param);
    int deleteAnswer(Support param);

    int updateQuestionStatus(Support param);

}

