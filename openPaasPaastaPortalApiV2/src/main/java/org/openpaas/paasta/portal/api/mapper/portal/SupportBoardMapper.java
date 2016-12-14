package org.openpaas.paasta.portal.api.mapper.portal;

import org.openpaas.paasta.portal.api.config.datasource.surport.Portal;
import org.openpaas.paasta.portal.api.model.Support;

import java.util.List;

/**
 * Created by YJKim on 2016-07-28.
 */
@Portal
public interface SupportBoardMapper {
    List<Support> getBoardList(Support param);
    List<Support> getBoardCommentList(Support param);
    Support getBoard(Support param);
//    Support getBoardCommentNum(Support param);

    int insertBoard(Support param);
    int setGroupNo(Support param);
    int updateBoard(Support param);

    Support getReplyNum(Support param);
    int deleteBoard(Support param);
    int deleteAllComments(Support param);


    int insertBoardComment(Support param);
    int setCommentGroupNo(Support param);
    int updateBoardComment(Support param);

    Support getCommentReplyNum(Support param);
    int deleteBoardComment(Support param);


}

