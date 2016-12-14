package org.openpaas.paasta.portal.api.service;

import org.openpaas.paasta.portal.api.common.Common;
import org.openpaas.paasta.portal.api.common.Constants;
import org.openpaas.paasta.portal.api.mapper.DocumentsMapper;
import org.openpaas.paasta.portal.api.model.Support;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.util.HashMap;
import java.util.Map;

/**
 * org.openpaas.paasta.portal.api.service
 *
 * @author yjkim
 * @version 1.0
 * @since 2016.07.28
 */

@Transactional
@Service
public class DocumentsService extends Common{

    @Autowired
    private DocumentsMapper documentsMapper;

    /**
     * 문서 목록 조회
     *
     * @param param the param
     * @return Document list (map)
     * @throws Exception the exception
     */
    public Map<String, Object> getDocumentsList(Support param) throws Exception {
        Map<String, Object> resultMap = new HashMap<>();

        resultMap.put("list", documentsMapper.getDocumentsList(param));
        resultMap.put("RESULT", Constants.RESULT_STATUS_SUCCESS);

        return resultMap;
    }

    /**
     * 문서 조회
     *
     * @param param the param
     * @return Document (map)
     * @throws Exception the exception
     */
    public Map<String, Object> getDocument(Support param) throws Exception {
        Map<String, Object> resultMap = new HashMap<>();

        resultMap.put("info", documentsMapper.getDocument(param));
        resultMap.put("RESULT", Constants.RESULT_STATUS_SUCCESS);

        return resultMap;
    }

    /**
     * 문서 등록
     *
     * @param param the param
     * @return result (map)
     * @throws Exception the exception
     */
    public Map<String, Object> insertDocument(Support param) throws Exception {
        Map<String, Object> resultMap = new HashMap<>();

        documentsMapper.insertDocument(param);

        resultMap.put("RESULT", Constants.RESULT_STATUS_SUCCESS);

        return resultMap;
    }

    /**
     * 문서 수정
     *
     * @param param the param
     * @return result (map)
     * @throws Exception the exception
     */
    public Map<String, Object> updateDocument(Support param) throws Exception {
        Map<String, Object> resultMap = new HashMap<>();

        documentsMapper.updateDocument(param);

        resultMap.put("RESULT", Constants.RESULT_STATUS_SUCCESS);

        return resultMap;
    }

    /**
     * 문서 삭제
     *
     * @param param the param
     * @return result (map)
     * @throws Exception the exception
     */
    public Map<String, Object> deleteDocument(Support param) throws Exception {
        Map<String, Object> resultMap = new HashMap<>();

        documentsMapper.deleteDocument(param);

        resultMap.put("RESULT", Constants.RESULT_STATUS_SUCCESS);

        return resultMap;
    }


}
