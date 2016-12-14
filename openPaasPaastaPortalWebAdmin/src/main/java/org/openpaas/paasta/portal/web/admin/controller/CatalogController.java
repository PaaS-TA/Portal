package org.openpaas.paasta.portal.web.admin.controller;

import org.openpaas.paasta.portal.web.admin.common.Common;
import org.openpaas.paasta.portal.web.admin.common.Constants;
import org.openpaas.paasta.portal.web.admin.model.Catalog;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

/**
 * 카탈로그 컨트롤러
 *
 * @author rex
 * @version 1.0
 * @since 2016.07.04
 */
@Controller
@RequestMapping(value = {"/catalog"})
class CatalogController extends Common {

    /**
     * 카탈로그 메인페이지 이동
     *
     * @return the catalog main
     */
    @RequestMapping(value = {"/catalogMain"}, method = RequestMethod.GET)
    public ModelAndView getCatalogMain() {
        return new ModelAndView(){{setViewName("/catalog/catalogMain");}};
    }


    /**
     * 카탈로그 메인페이지 이동
     *
     * @param tabName the tab name
     * @return catalog main
     */
    @RequestMapping(value = {"/catalogMain/{tabName}"}, method = RequestMethod.GET)
    public ModelAndView getCatalogMain(@PathVariable("tabName") String tabName) {
        String reqTabName = Constants.TAB_NAME_STARTER;

        if (Constants.TAB_NAME_BUILD_PACK.equals(tabName)) reqTabName = Constants.TAB_NAME_BUILD_PACK;
        if (Constants.TAB_NAME_SERVICE_PACK.equals(tabName)) reqTabName = Constants.TAB_NAME_SERVICE_PACK;
        if (Constants.TAB_NAME_STARTER.equals(tabName)) reqTabName = Constants.TAB_NAME_STARTER;

        String finalReqTabName = reqTabName;
        return new ModelAndView() {{
            setViewName("/catalog/catalogMain");
            addObject("TAB_NAME", finalReqTabName);
        }};
    }


    /**
     * 앱 개발환경 목록 조회
     *
     * @param param the param
     * @return build pack list
     */
    @RequestMapping(value = {"/getBuildPackList"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getBuildPackList(@RequestBody Catalog param) {
        return commonService.procRestTemplate("/catalog/getBuildPackList", HttpMethod.POST, param, this.getToken());
    }


    /**
     * 서비스 목록 조회
     *
     * @param param the param
     * @return service pack list
     */
    @RequestMapping(value = {"/getServicePackList"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getServicePackList(@RequestBody Catalog param) {
        return commonService.procRestTemplate("/catalog/getServicePackList", HttpMethod.POST, param, this.getToken());
    }


    /**
     * 앱 개발환경 카탈로그 목로 조회
     *
     * @param param the param
     * @return build pack catalog list
     */
    @RequestMapping(value = {"/getBuildPackCatalogList"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getBuildPackCatalogList(@RequestBody Catalog param) {
        return commonService.procRestTemplate("/catalog/getBuildPackCatalogList", HttpMethod.POST, param, null);
    }


    /**
     * 서비스 카탈로그 목록 조회
     *
     * @param param the param
     * @return service pack catalog list
     */
    @RequestMapping(value = {"/getServicePackCatalogList"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getServicePackCatalogList(@RequestBody Catalog param) {
        return commonService.procRestTemplate("/catalog/getServicePackCatalogList", HttpMethod.POST, param, null);
    }


    /**
     * 앱 개발환경 카탈로그 개수 조회
     *
     * @param param the param
     * @return build pack catalog count
     */
    @RequestMapping(value = {"/getBuildPackCatalogCount"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getBuildPackCatalogCount(@RequestBody Catalog param) {
        return commonService.procRestTemplate("/catalog/getBuildPackCatalogCount", HttpMethod.POST, param, null);
    }


    /**
     * 서비스 카탈로그 개수 조회
     *
     * @param param the param
     * @return service pack catalog count
     */
    @RequestMapping(value = {"/getServicePackCatalogCount"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getServicePackCatalogCount(@RequestBody Catalog param) {
        return commonService.procRestTemplate("/catalog/getServicePackCatalogCount", HttpMethod.POST, param, null);
    }


    /**
     * 앱 개발환경 저장페이지 이동
     *
     * @return build pack form
     */
    @RequestMapping(value = {"/buildPackForm"}, method = RequestMethod.GET)
    public ModelAndView getBuildPackForm() {
        return new ModelAndView() {{
            setViewName("/catalog/buildPackForm");
            addObject("INSERT_FLAG", Constants.CUD_C);
        }};
    }


    /**
     * 앱 개발환경 수정페이지 이동
     *
     * @param req the req
     * @return build pack form
     */
    @RequestMapping(value = {"/buildPackForm"}, method = RequestMethod.POST)
    public ModelAndView getBuildPackForm(HttpServletRequest req) {
        return new ModelAndView() {{
            setViewName("/catalog/buildPackForm");
            addObject("INSERT_FLAG", Constants.CUD_U);
            addObject("REQUEST_NO", req.getParameter("no"));
        }};
    }


    /**
     * 서비스 저장페이지 이동
     *
     * @return service pack form
     */
    @RequestMapping(value = {"/servicePackForm"}, method = RequestMethod.GET)
    public ModelAndView getServicePackForm() {
        return new ModelAndView(){{setViewName("/catalog/servicePackForm");
                                    addObject("INSERT_FLAG", Constants.CUD_C);}};
    }


    /**
     * 서비스 수정페이지 이동
     *
     * @param req the req
     * @return service pack form
     */
    @RequestMapping(value = {"/servicePackForm"}, method = RequestMethod.POST)
    public ModelAndView getServicePackForm(HttpServletRequest req) {
        return new ModelAndView() {{
            setViewName("/catalog/servicePackForm");
            addObject("INSERT_FLAG", Constants.CUD_U);
            addObject("REQUEST_NO", req.getParameter("no"));
        }};
    }


    /**
     * 앱 개발환경 카탈로그 저장
     *
     * @param param the param
     * @return map map
     */
    @RequestMapping(value = {"/insertBuildPackCatalog"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> insertBuildPackCatalog(@RequestBody Catalog param) throws Exception {
        return commonService.procRestTemplate("/catalog/insertBuildPackCatalog", HttpMethod.POST, commonService.setUserId(param), null);
    }


    /**
     * 서비스 카탈로그 저장
     *
     * @param param the param
     * @return map map
     */
    @RequestMapping(value = {"/insertServicePackCatalog"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> insertServicePackCatalog(@RequestBody Catalog param) throws Exception {
        return commonService.procRestTemplate("/catalog/insertServicePackCatalog", HttpMethod.POST, commonService.setUserId(param), null);
    }


    /**
     * 앱 개발환경 카탈로그 수정
     *
     * @param param the param
     * @return map map
     */
    @RequestMapping(value = {"/updateBuildPackCatalog"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> updateBuildPackCatalog(@RequestBody Catalog param) throws Exception {
        return commonService.procRestTemplate("/catalog/updateBuildPackCatalog", HttpMethod.PUT, commonService.setUserId(param), null);
    }


    /**
     * 서비스 카탈로그 수정
     *
     * @param param the param
     * @return map map
     */
    @RequestMapping(value = {"/updateServicePackCatalog"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> updateServicePackCatalog(@RequestBody Catalog param) throws Exception {
        return commonService.procRestTemplate("/catalog/updateServicePackCatalog", HttpMethod.PUT, commonService.setUserId(param), null);
    }


    /**
     * 앱 개발환경 카탈로그 삭제
     *
     * @param param the param
     * @return map map
     */
    @RequestMapping(value = {"/deleteBuildPackCatalog"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> deleteBuildPackCatalog(@RequestBody Catalog param) {
        return commonService.procRestTemplate("/catalog/deleteBuildPackCatalog", HttpMethod.POST, param, null);
    }


    /**
     * 서비스 카탈로그 삭제
     *
     * @param param the param
     * @return map map
     */
    @RequestMapping(value = {"/deleteServicePackCatalog"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> deleteServicePackCatalog(@RequestBody Catalog param) {
        return commonService.procRestTemplate("/catalog/deleteServicePackCatalog", HttpMethod.POST, param, null);
    }


    /**
     * 앱 개발환경 카탈로그 삭제 가능여부 조회
     *
     * @param param the param
     * @return check delete build pack catalog count
     */
    @RequestMapping(value = {"/getCheckDeleteBuildPackCatalogCount"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getCheckDeleteBuildPackCatalogCount(@RequestBody Catalog param) {
        return commonService.procRestTemplate("/catalog/getCheckDeleteBuildPackCatalogCount", HttpMethod.POST, param, null);
    }


    /**
     * 서비스 카탈로그 삭제 가능여부 조회
     *
     * @param param the param
     * @return check delete service pack catalog count
     */
    @RequestMapping(value = {"/getCheckDeleteServicePackCatalogCount"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getCheckDeleteServicePackCatalogCount(@RequestBody Catalog param) {
        return commonService.procRestTemplate("/catalog/getCheckDeleteServicePackCatalogCount", HttpMethod.POST, param, null);
    }


    /**
     * 이미지 파일 업로드
     *
     * @param multipartFile the multipart file
     * @return map map
     * @throws Exception the exception
     */
    @RequestMapping(value = {"/uploadThumbnailImage"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> uploadThumbnailImage(@RequestParam("file") MultipartFile multipartFile) throws Exception {
        return commonService.procRestTemplate("/catalog/uploadThumbnailImage", multipartFile, null);
    }


    /**
     * 이미지 파일 삭제
     *
     * @param param the param
     * @return map map
     */
    @RequestMapping(value = {"/deleteThumbnailImage"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> deleteThumbnailImage(@RequestBody Catalog param) {
        return commonService.procRestTemplate("/catalog/deleteThumbnailImage", HttpMethod.POST, param, null);
    }


    /**
     * 앱 샘플 파일 업로드
     *
     * @param multipartFile the multipart file
     * @return map map
     * @throws Exception the exception
     */
    @RequestMapping(value = {"/uploadAppSampleFile"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> uploadAppSampleFile(@RequestParam("file") MultipartFile multipartFile) throws Exception {
        return commonService.procRestTemplate("/catalog/uploadAppSampleFile", multipartFile, null);
    }


    /**
     * 앱 샘플 파일 삭제
     *
     * @param param the param
     * @return map map
     */
    @RequestMapping(value = {"/deleteAppSampleFile"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> deleteAppSampleFile(@RequestBody Catalog param) {
        return commonService.procRestTemplate("/catalog/deleteAppSampleFile", HttpMethod.POST, param, null);
    }


    /**
     * 앱 템플릿 카탈로그 개수 조회
     *
     * @param param the param
     * @return starter catalog count
     */
    @RequestMapping(value = {"/getStarterCatalogCount"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> getStarterCatalogCount(@RequestBody Catalog param) {
        return commonService.procRestTemplate("/catalog/getStarterCatalogCount", HttpMethod.POST, param, null);
    }


    /**
     * 앱 템플릿명 목록 조회
     *
     * @param param the param
     * @return starter names list
     */
    @RequestMapping(value = {"/getStarterNamesList"}, method = RequestMethod.POST) // names
    @ResponseBody
    public Map<String, Object> getStarterNamesList(@RequestBody Catalog param) {
        return commonService.procRestTemplate("/catalog/getStarterNamesList", HttpMethod.POST, param, null);
    }


    /**
     * 앱 개발환경명 목록 조회
     *
     * @param param the param
     * @return build pack names list
     */
    @RequestMapping(value = {"/getBuildPackNamesList"}, method = RequestMethod.POST) // names
    @ResponseBody
    public Map<String, Object> getBuildPackNamesList(@RequestBody Catalog param) {
        return commonService.procRestTemplate("/catalog/getBuildPackNamesList", HttpMethod.POST, param, null);
    }


    /**
     * 서비스명 목록 조회
     *
     * @param param the param
     * @return service pack names list
     */
    @RequestMapping(value = {"/getServicePackNamesList"}, method = RequestMethod.POST) // names
    @ResponseBody
    public Map<String, Object> getServicePackNamesList(@RequestBody Catalog param) {
        return commonService.procRestTemplate("/catalog/getServicePackNamesList", HttpMethod.POST, param, null);
    }


    /**
     * 앱 템플릿 카탈로그 조회
     *
     * @param param the param
     * @return one starter catalog
     */
    @RequestMapping(value = {"/getOneStarterCatalog"}, method = RequestMethod.POST) // names
    @ResponseBody
    public Map<String, Object> getOneStarterCatalog(@RequestBody Catalog param) {
        return commonService.procRestTemplate("/catalog/getOneStarterCatalog", HttpMethod.POST, param, null);
    }


    /**
     * 앱 템플릿 카탈로그 저장
     *
     * @param param the param
     * @return map map
     */
    @RequestMapping(value = {"/insertStarterCatalog"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> insertStarterCatalog(@RequestBody Catalog param) throws Exception {
        return commonService.procRestTemplate("/catalog/insertStarterCatalog", HttpMethod.POST, commonService.setUserId(param), null);
    }


    /**
     * 앱 템플릿 카탈로그 수정
     *
     * @param param the param
     * @return map map
     */
    @RequestMapping(value = {"/updateStarterCatalog"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> updateStarterCatalog(@RequestBody Catalog param) throws Exception {
        return commonService.procRestTemplate("/catalog/updateStarterCatalog", HttpMethod.PUT, commonService.setUserId(param), null);
    }


    /**
     * 앱 템플릿 카탈로그 삭제
     *
     * @param param the param
     * @return map map
     */
    @RequestMapping(value = {"/deleteStarterCatalog"}, method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> deleteStarterCatalog(@RequestBody Catalog param) {
        return commonService.procRestTemplate("/catalog/deleteStarterCatalog", HttpMethod.POST, param, null);
    }


    /**
     * 앱 템플릿 저장페이지 이동
     *
     * @return starter form
     */
    @RequestMapping(value = {"/starterForm"}, method = RequestMethod.GET)
    public ModelAndView getStarterForm() {
        ModelAndView mv = new ModelAndView();

    //    mv.addObject("status", status);
        mv.addObject("INSERT_FLAG", Constants.CUD_C);
        mv.addObject("REQUEST_NO", -1);

        mv.setViewName("/catalog/starterForm");

        return mv;
    }


    /**
     * 앱 템플릿 수정페이지 이동
     *
     * @param req the req
     * @return starter form
     */
    @RequestMapping(value = {"/starterForm"}, method = RequestMethod.POST)
    public ModelAndView getStarterForm(HttpServletRequest req) {
        ModelAndView mv = new ModelAndView();

    //    mv.addObject("status", status);
        mv.addObject("INSERT_FLAG", Constants.CUD_U);
        mv.addObject("CONSTANT_CUD", Constants.CUD_U);
        mv.addObject("REQUEST_NO", req.getParameter("no"));

        mv.setViewName("/catalog/starterForm");

        return mv;
    }
}
