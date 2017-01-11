package org.openpaas.paasta.portal.api.service;

import org.openpaas.paasta.portal.api.common.Common;
import org.openpaas.paasta.portal.api.mapper.AppAutoScaleModalMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;

/**
 * org.openpaas.paasta.portal.api.service.AppAutoScaleModalService.Class
 * 내  용 :자동 인스턴스 증가. 감소 관련 모달 서비스 기능 클래스객체
 * 작성일 : 2016. 07.12.
 * 작성자 : 이인정
 */
@Transactional
@Service
public class AppAutoScaleModalService extends Common {

    /** 로그객체*/
    private  static final Logger LOGGER = LoggerFactory.getLogger(AppAutoScaleModalService.class);

    @Autowired
    private AppAutoScaleModalMapper appAutoScaleModalMapper;

    /**
     * getAppAutoScaleInfo(HashMap appAutoScale)
     * 앱의 자동인스턴스 증가, 감소 관련 정보를 가져온다.
     *
     * @param appAutoScale 자동인스턴스 증가, 감소 관련 모델 파라메터
     * @return {mode, list}
     */
    public HashMap<String, Object> getAppAutoScaleInfo(HashMap appAutoScale)  {

        HashMap<String, Object> resultMap = new HashMap<>();
        resultMap.put("list", appAutoScaleModalMapper.getAppAutoScaleInfo((String) appAutoScale.get("guid")));
        resultMap.put("mode", (String) appAutoScale.get("mode"));

        return resultMap;

    }

    /**
     * getAppAutoScaleInfo(HashMap appAutoScale)
     * 앱의 자동인스턴스 증가, 감소 관련 정보를 가져온다.
     *
     * @param appAutoScale 자동인스턴스 증가, 감소 관련 모델 파라메터
     * @return {mode, list}
     */
    public HashMap<String, Object> getAppAutoScaleList(HashMap appAutoScale) {

        HashMap<String, Object> resultMap = new HashMap<>();
        resultMap.put("list", appAutoScaleModalMapper.getAppAutoScaleList((String) appAutoScale.get("guid")));
        resultMap.put("mode", (String) appAutoScale.get("mode"));

        return resultMap;

    }


    /**
     * insertAppAutoScale (HashMap<String,Object> appAutoScale)
     * 앱의 자동인스턴스 증가, 감소 관련 정보를 저장한다.
     *
     * @param appAutoScale 자동인스턴스 증가, 감소 관련 모델 파라메터
     * @return {결과 값}
     */
    public int insertAppAutoScale (HashMap<String,Object> appAutoScale) {

        LOGGER.info("SERVICE insertAppAutoScale map : ",  appAutoScale.toString());

        int result = appAutoScaleModalMapper.insertAppAutoScale(appAutoScale);
        return result;

    }

    /**
     * updateAppAutoScale (HashMap<String,Object> appAutoScale)
     * 앱의 자동인스턴스 증가, 감소 관련 정보를 수정한다.
     *
     * @param appAutoScale 자동인스턴스 증가, 감소 관련 모델 파라메터
     * @return {결과 값}
     */
    public int updateAppAutoScale(HashMap<String,Object> appAutoScale) {

        LOGGER.info("SERVICE updateAppAutoScale  : ",  appAutoScale.toString());
        int result = 0;
        result = appAutoScaleModalMapper.updateAppAutoScale(appAutoScale);
        return result;


    }

    /**
     * deleteAppAutoScale (HashMap<String,Object> appAutoScale)
     * 앱의 자동인스턴스 증가, 감소 관련 정보를 삭제한다..
     *
     * @param guid 자동인스턴스 증가, 감소 관련 모델 아이디
     * @return {결과 값}
     */
    public int deleteAppAutoScale(String guid)  {
        LOGGER.info("SERVICE deleteAppAutoScale guid : ",  guid);

        int resultMap = appAutoScaleModalMapper.deleteAppAutoScale(guid);
        return resultMap;

    }
}
