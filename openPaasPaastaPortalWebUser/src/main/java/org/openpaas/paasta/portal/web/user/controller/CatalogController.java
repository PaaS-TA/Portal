package org.openpaas.paasta.portal.web.user.controller;

import org.openpaas.paasta.portal.web.user.common.Common;
import org.openpaas.paasta.portal.web.user.common.Constants;
import org.openpaas.paasta.portal.web.user.model.Catalog;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.Map;

/**
 * 서비스 카탈로그, 개발 환경 카탈로그, 앱 템플릿 카탈로그 정보 조회 및 관리 등의 API 를 호출 하는 컨트롤러이다.
 *
 * @author 김도준
 * @version 1.0
 * @since 2016.07.28 최초작성
 */
@Controller
@RequestMapping(value = {"/catalog"})
class CatalogController extends Common {

    /**
     * 카탈로그 메인페이지로 이동한다.
     *
     * @return ModelAndView(Spring 클래스)
     */
    @RequestMapping(value = {"/catalogMain"}, method = RequestMethod.GET)
    public ModelAndView getCatalogMain() {
        return new ModelAndView(){{setViewName("/catalog/catalogMain");}};
    }


    /**
     * 카탈로그 메인페이지로 이동한다.
     *
     * @param catalogType 카탈로그 타입(String)
     * @return ModelAndView(Spring 클래스)
     */
    @RequestMapping(value = {"/catalogMain/{catalogType}"}, method = RequestMethod.GET)
    public ModelAndView getCatalogMain(@PathVariable("catalogType") String catalogType) {
        return new ModelAndView() {{
            setViewName("/catalog/catalogMain");
            addObject("CATALOG_TYPE", catalogType);
        }};
    }


    /**
     * 카탈로그 메인페이지로 이동한다.
     *
     * @param catalogType    카탈로그 타입(String)
     * @param catalogSubType 카탈로그 하위 타입(String)
     * @return ModelAndView(Spring 클래스)
     */
    @RequestMapping(value = {"/catalogMain/{catalogType}/{catalogSubType}"}, method = RequestMethod.GET)
    public ModelAndView getCatalogMain(@PathVariable("catalogType") String catalogType, @PathVariable("catalogSubType") String catalogSubType) {
        return new ModelAndView() {{
            setViewName("/catalog/catalogMain");
            addObject("CATALOG_TYPE", catalogType);
            addObject("CATALOG_SUB_TYPE", catalogSubType);
        }};
    }


    /**
     * 카탈로그 저장페이지로 이동한다.
     *
     * @param catalogType 카탈로그 타입(String)
     * @param catalogNo   카탈로그 번호(String)
     * @return 카탈로그 타입(String)
     */
    @RequestMapping(value = {"/catalogMain/create/{catalogType}/{catalogNo}"}, method = RequestMethod.GET)
    public ModelAndView getCatalogInsertForm(@PathVariable("catalogType") String catalogType, @PathVariable("catalogNo") String catalogNo) {
        String viewName = "/catalog/";

        if (Constants.CATALOG_TYPE_STARTER.equals(catalogType)) viewName += "catalogStarterInsertForm";
        if (Constants.CATALOG_TYPE_BUILD_PACK.equals(catalogType)) viewName += "catalogBuildPackInsertForm";
        if (Constants.CATALOG_TYPE_SERVICE_PACK.equals(catalogType)) viewName += "catalogServicePackInsertForm";

        String finalViewName = viewName;
        return new ModelAndView() {{
            setViewName(finalViewName);
            addObject("CATALOG_NO", catalogNo);
        }};
    }


    /**
     * 카탈로그 좌측 메뉴 목록 조회
     *
     * @param param Catalog(모델클래스)
     * @return Map(자바클래스)
     */
    @RequestMapping(value = {"/getCatalogLeftMenuList"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getCatalogLeftMenuList(@RequestBody Catalog param) {
        return commonService.procRestTemplate("/catalog/getCatalogLeftMenuList", HttpMethod.POST, param, null);
    }


    /**
     * 카탈로그 내역 목록 조회
     *
     * @param param Catalog(모델클래스)
     * @return Map(자바클래스)
     */
    @RequestMapping(value = {"/getCatalogHistoryList"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getCatalogHistoryList(@RequestBody Catalog param) {
        return commonService.procRestTemplate("/catalog/getCatalogHistoryList", HttpMethod.POST, param, null);
    }


    /**
     * 앱 템플릿명 목록 조회
     *
     * @param param Catalog(모델클래스)
     * @return Map(자바클래스)
     */
    @RequestMapping(value = {"/getStarterNamesList"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getStarterNamesList(@RequestBody Catalog param) {
        return commonService.procRestTemplate("/catalog/getStarterNamesList", HttpMethod.POST, param, null);
    }


    /**
     * 앱 개발환경 카탈로그 목록 조회
     *
     * @param param Catalog(모델클래스)
     * @return Map(자바클래스)
     */
    @RequestMapping(value = {"/getBuildPackCatalogList"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getBuildPackCatalogList(@RequestBody Catalog param) {
        return commonService.procRestTemplate("/catalog/getBuildPackCatalogList", HttpMethod.POST, param, null);
    }


    /**
     * 서비스 카탈로그 목록 조회
     *
     * @param param Catalog(모델클래스)
     * @return Map(자바클래스)
     */
    @RequestMapping(value = {"/getServicePackCatalogList"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getServicePackCatalogList(@RequestBody Catalog param) {
        return commonService.procRestTemplate("/catalog/getServicePackCatalogList", HttpMethod.POST, param, null);
    }


    /**
     * 카탈로그 공간 목록 조회
     *
     * @param param Catalog(모델클래스)
     * @return Map(자바클래스)
     */
    @RequestMapping(value = {"/getCatalogSpaceList"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getCatalogSpaceList(@RequestBody Catalog param) {
        return commonService.procRestTemplate("/catalog/getCatalogSpaceList", HttpMethod.POST, param, this.getToken());
    }


    /**
     * 카탈로그 도메인 목록 조회
     *
     * @param param Catalog(모델클래스)
     * @return Map(자바클래스)
     */
    @RequestMapping(value = {"/getCatalogDomainList"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getCatalogDomainList(@RequestBody Catalog param) {
        return commonService.procRestTemplate("/catalog/getCatalogDomainList", HttpMethod.POST, param, this.getToken());
    }


    /**
     * 카탈로그 서비스 이용사양 목록 조회
     *
     * @param param Catalog(모델클래스)
     * @return Map(자바클래스)
     */
    @RequestMapping(value = {"/getCatalogServicePlanList"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getCatalogServicePlanList(@RequestBody Catalog param) {
        return commonService.procRestTemplate("/catalog/getCatalogServicePlanList", HttpMethod.POST, param, this.getToken());
    }


    /**
     * 카탈로그 서비스 이용사양 목록 조회
     *
     * @param param Catalog(모델클래스)
     * @return Map(자바클래스)
     */
    @RequestMapping(value = {"/getCatalogMultiServicePlanList"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getCatalogMultiServicePlanList(@RequestBody Catalog param) {
        return commonService.procRestTemplate("/catalog/getCatalogMultiServicePlanList", HttpMethod.POST, param, this.getToken());
    }


    /**
     * 카탈로그 앱 목록 조회
     *
     * @param param Catalog(모델클래스)
     * @return Map(자바클래스)
     */
    @RequestMapping(value = {"/getCatalogAppList"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getCatalogAppList(@RequestBody Catalog param) {
        return commonService.procRestTemplate("/catalog/getCatalogAppList", HttpMethod.POST, param, this.getToken());
    }


    /**
     * 카탈로그 앱 이름 생성여부 조회
     *
     * @param param Catalog(모델클래스)
     * @return Map(자바클래스)
     */
    @RequestMapping(value = {"/getCheckCatalogApplicationNameExists"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getCheckCatalogApplicationNameExists(@RequestBody Catalog param) {
        return commonService.procRestTemplate("/catalog/getCheckCatalogApplicationNameExists", HttpMethod.POST, param, this.getToken());
    }


    /**
     * 카탈로그 서비스 이름 생성여부 조회
     *
     * @param param Catalog(모델클래스)
     * @return Map(자바클래스)
     */
    @RequestMapping(value = {"/getCheckCatalogServiceInstanceNameExists"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getCheckCatalogServiceInstanceNameExists(@RequestBody Catalog param) {
        return commonService.procRestTemplate("/catalog/getCheckCatalogServiceInstanceNameExists", HttpMethod.POST, param, this.getToken());
    }


    /**
     * 카탈로그 앱 URL 생성여부 조회
     *
     * @param param Catalog(모델클래스)
     * @return Map(자바클래스)
     */
    @RequestMapping(value = {"/getCheckCatalogRouteExists"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getCheckCatalogRouteExists(@RequestBody Catalog param) {
        return commonService.procRestTemplate("/catalog/getCheckCatalogRouteExists", HttpMethod.POST, param, this.getToken());
    }


    /**
     * 카탈로그 앱 템플릿 구성 조회
     *
     * @param param Catalog(모델클래스)
     * @return Map(자바클래스)
     */
    @RequestMapping(value = {"/getCatalogStarterRelationList"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getCatalogStarterRelationList(@RequestBody Catalog param) {
        return commonService.procRestTemplate("/catalog/getCatalogStarterRelationList", HttpMethod.POST, param, null);
    }


    /**
     * 카탈로그 앱 템플릿 실행
     *
     * @param param Catalog(모델클래스)
     * @return Map(자바클래스)
     * @throws Exception Exception(자바클래스)
     */
    @RequestMapping(value = {"/executeCatalogStarter"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> executeCatalogStarter(@RequestBody Catalog param) throws Exception {
        return commonService.procRestTemplate("/catalog/executeCatalogStarter", HttpMethod.POST, commonService.setUserId(param), this.getToken());
    }


    /**
     * 카탈로그 앱 템플릿 내역 저장
     *
     * @param param Catalog(모델클래스)
     * @return Map(자바클래스)
     * @throws Exception Exception(자바클래스)
     */
    @RequestMapping(value = {"/insertCatalogHistoryStarter"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> insertCatalogHistoryStarter(@RequestBody Catalog param) throws Exception {
        return commonService.procRestTemplate("/catalog/insertCatalogHistoryStarter", HttpMethod.POST, commonService.setUserId(param), null);
    }


    /**
     * 카탈로그 앱 개발환경 실행
     *
     * @param param Catalog(모델클래스)
     * @return Map(자바클래스)
     * @throws Exception Exception(자바클래스)
     */
    @RequestMapping(value = {"/executeCatalogBuildPack"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> executeCatalogBuildPack(@RequestBody Catalog param) throws Exception {
        return commonService.procRestTemplate("/catalog/executeCatalogBuildPack", HttpMethod.POST, commonService.setUserId(param), this.getToken());
    }


    /**
     * 카탈로그 앱 개발환경 내역 저장
     *
     * @param param Catalog(모델클래스)
     * @return Map(자바클래스)
     * @throws Exception Exception(자바클래스)
     */
    @RequestMapping(value = {"/insertCatalogHistoryBuildPack"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> insertCatalogHistoryBuildPack(@RequestBody Catalog param) throws Exception {
        return commonService.procRestTemplate("/catalog/insertCatalogHistoryBuildPack", HttpMethod.POST, commonService.setUserId(param), null);
    }


    /**
     * 카탈로그 서비스 실행
     *
     * @param param Catalog(모델클래스)
     * @return Map(자바클래스)
     * @throws Exception Exception(자바클래스)
     */
    @RequestMapping(value = {"/executeCatalogServicePack"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> executeCatalogServicePack(@RequestBody Catalog param) throws Exception {
        return commonService.procRestTemplate("/catalog/executeCatalogServicePack", HttpMethod.POST, commonService.setUserId(param), this.getToken());
    }


    /**
     * 카탈로그 서비스 실행 내역 저장
     *
     * @param param Catalog(모델클래스)
     * @return Map(자바클래스)
     * @throws Exception Exception(자바클래스)
     */
    @RequestMapping(value = {"/insertCatalogHistoryServicePack"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> insertCatalogHistoryServicePack(@RequestBody Catalog param) throws Exception {
        return commonService.procRestTemplate("/catalog/insertCatalogHistoryServicePack", HttpMethod.POST, commonService.setUserId(param), null);
    }


    /**
     * 카탈로그 앱 서비스 바인드 (POST)
     *
     * @param param Catalog(모델클래스)
     * @return Map(자바클래스)
     * @throws Exception Exception(자바클래스)
     */
    @RequestMapping(value = {"/appBindServiceV2"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> setAppBindServiceV2(@RequestBody Catalog param) throws Exception {
        return commonService.procRestTemplate("/catalog/appBindServiceV2", HttpMethod.POST, commonService.setUserId(param), this.getToken());
    }
}
