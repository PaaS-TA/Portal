package org.openpaas.paasta.portal.api.service;

import org.openpaas.paasta.portal.api.mapper.cc.AdminMainCcMapper;
import org.openpaas.paasta.portal.api.model.AdminMain;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.Map;

/**
 * 운영자 메인 서비스
 *
 * @author rex
 * @version 1.0
 * @since 2016.09.08
 */
@Transactional
@Service
public class AdminMainService {

    private final AdminMainCcMapper adminMainCcMapper;

    @Autowired
    public AdminMainService(AdminMainCcMapper adminMainCcMapper) {
        this.adminMainCcMapper = adminMainCcMapper;
    }


    /**
     * 전체 조직 수, 영역 수, APPLICATION 수, 사용자 수 목록 조회
     *
     * @param param the param
     * @return total count list
     */
    public Map<String, Object> getTotalCountList(AdminMain param) {
        return new HashMap<String, Object>(){{put("list", adminMainCcMapper.getTotalCountList(param));}};
    }


    /**
     * 전체 조직 통계 목록 조회
     *조직별 App 사용량, 스페이스별 App 사용량 정보를 조회
     * @param param the param
     * @return total organization list
     */
    public Map<String, Object> getTotalOrganizationList(AdminMain param) {
        return new HashMap<String, Object>(){{put("list", adminMainCcMapper.getTotalOrganizationList(param));}};
    }


    /**
     * 전체 영역 통계 목록 조회
     *
     * @param param the param
     * @return total space list
     */
    public Map<String, Object> getTotalSpaceList(AdminMain param) {
        return new HashMap<String, Object>(){{put("list", adminMainCcMapper.getTotalSpaceList(param));}};
    }
}
