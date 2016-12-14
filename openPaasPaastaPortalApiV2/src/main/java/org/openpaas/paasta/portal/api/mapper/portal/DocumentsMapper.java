package org.openpaas.paasta.portal.api.mapper.portal;

import org.openpaas.paasta.portal.api.config.datasource.surport.Portal;
import org.openpaas.paasta.portal.api.model.Support;

import java.util.List;

/**
 * Created by YJKim on 2016-07-28.
 */
@Portal
public interface DocumentsMapper {
    List<Support> getDocumentsList(Support param);
    List<Support> getDocumentsListUser(Support param);
    Support getDocument(Support param);
    int insertDocument(Support param);
    int updateDocument(Support param);
    int deleteDocument(Support param);

}

