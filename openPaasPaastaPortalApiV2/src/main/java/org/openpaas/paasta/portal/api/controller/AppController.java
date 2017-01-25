package org.openpaas.paasta.portal.api.controller;

import org.cloudfoundry.client.CloudFoundryClient;
import org.cloudfoundry.doppler.Envelope;
import org.cloudfoundry.reactor.TokenProvider;
import org.cloudfoundry.reactor.doppler.ReactorDopplerClient;
import org.openpaas.paasta.portal.api.model.App;
import org.openpaas.paasta.portal.api.service.AppService;
import org.openpaas.paasta.portal.api.service.OrganizationService;
import org.openpaas.paasta.portal.api.util.CfUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;
import java.util.stream.Stream;

/**
 * 앱 컨트롤러 - 애플리케이션 정보 조회, 구동, 정지 등의 API 를 호출 하는 컨트롤러이다.
 *
 * @author 조민구
 * @version 1.0
 * @since 2016.12.4 최초작성
 */
@RestController
@RequestMapping(value = {"app"})
public class AppController extends BaseController {
    private static final Logger LOGGER = LoggerFactory.getLogger(AppController.class);

    @Autowired
    AppService appService;
    @Autowired
    OrganizationService organizationService;

    /**
     * 앱 최근 로그
     *
     * @param app     the app
     * @param request the request
     * @return Space respSpace
     * @throws Exception the exception
     */
    @RequestMapping(value = {"/getRecentLogs"}, method = RequestMethod.POST)
    public Map getSpaceSummary(@RequestBody App app, HttpServletRequest request) throws Exception {

        LOGGER.info("getRecentLog Start : appGuid={}", app.getGuid().toString());

        // Get CloudFoundry class
        TokenProvider tokenProvider = getTokenProvider(request.getHeader(AUTHORIZATION_HEADER_KEY));
        CloudFoundryClient cloudFoundryClient = CfUtils.cloudFoundryClient(connectionContext, tokenProvider);
        ReactorDopplerClient reactorDopplerClient = CfUtils.dopplerClient(connectionContext, tokenProvider);

        Map mapLog = new HashMap();
        try {
            Stream<Envelope> list = appService.getRecentLog(reactorDopplerClient, app.getGuid().toString()).toStream();

            mapLog.put("log", list.toArray());

        } catch (Exception e) {
            mapLog.put("log", "");
        }

        return mapLog;
    }
}
