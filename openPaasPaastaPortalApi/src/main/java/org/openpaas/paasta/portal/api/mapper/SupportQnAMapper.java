package org.openpaas.paasta.portal.api.mapper;

import org.openpaas.paasta.portal.api.config.service.surport.Portal;
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

    List<Support> getMyQuestionsInMyAccount(String userId);

    List<Support> getMyQuestionList(Support param);

    int insertMyQuestion(Support param);

    int updateMyQuestion(Support param);

    int deleteMyQuestion(Support param);

}

