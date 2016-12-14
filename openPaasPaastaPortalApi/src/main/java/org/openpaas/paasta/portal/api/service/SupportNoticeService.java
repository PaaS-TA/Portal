package org.openpaas.paasta.portal.api.service;

import org.openpaas.paasta.portal.api.common.Common;
import org.openpaas.paasta.portal.api.common.Constants;
import org.openpaas.paasta.portal.api.mapper.SupportNoticeMapper;
import org.openpaas.paasta.portal.api.model.Support;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.sql.Timestamp;
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
public class SupportNoticeService extends Common{

    @Autowired
    private SupportNoticeMapper supportNoticeMapper;

    /**
     * 공지 목록 조회
     *
     * @param param the param
     * @return notice list (map)
     * @throws Exception the exception
     */
    public Map<String, Object> getNoticeList(Support param) throws Exception {
        Map<String, Object> resultMap = new HashMap<>();

        resultMap.put("list", supportNoticeMapper.getNoticeList(param));
        resultMap.put("RESULT", Constants.RESULT_STATUS_SUCCESS);

        return resultMap;
    }

    /**
     * 공지 조회
     *
     * @param param the param
     * @return notice (map)
     * @throws Exception the exception
     */
    public Map<String, Object> getNotice(Support param) throws Exception {
        Map<String, Object> resultMap = new HashMap<>();

        resultMap.put("info", supportNoticeMapper.getNotice(param));
        resultMap.put("RESULT", Constants.RESULT_STATUS_SUCCESS);

        return resultMap;
    }

    /**
     * 공지 등록
     *
     * @param param the param
     * @return result (map)
     * @throws Exception the exception
     */
    public Map<String, Object> insertNotice(Support param) throws Exception {
        Map<String, Object> resultMap = new HashMap<>();

        supportNoticeMapper.insertNotice(param);

        resultMap.put("RESULT", Constants.RESULT_STATUS_SUCCESS);

        return resultMap;
    }

    /**
     * 공지 수정
     *
     * @param param the param
     * @return result (map)
     * @throws Exception the exception
     */
    public Map<String, Object> updateNotice(Support param) throws Exception {
        Map<String, Object> resultMap = new HashMap<>();

        supportNoticeMapper.updateNotice(param);
        resultMap.put("RESULT", Constants.RESULT_STATUS_SUCCESS);

        return resultMap;
    }

    /**
     * 공지 삭제
     *
     * @param param the param
     * @return result (map)
     * @throws Exception the exception
     */
    public Map<String, Object> deleteNotice(Support param) throws Exception {
        Map<String, Object> resultMap = new HashMap<>();

        supportNoticeMapper.deleteNotice(param);
        resultMap.put("RESULT", Constants.RESULT_STATUS_SUCCESS);

        return resultMap;
    }

}
