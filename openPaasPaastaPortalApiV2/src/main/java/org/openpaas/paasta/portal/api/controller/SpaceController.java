package org.openpaas.paasta.portal.api.controller;

import org.cloudfoundry.client.CloudFoundryClient;
import org.cloudfoundry.reactor.TokenProvider;
import org.openpaas.paasta.portal.api.model.Space;
import org.openpaas.paasta.portal.api.service.OrganizationService;
import org.openpaas.paasta.portal.api.service.SpaceService;
import org.openpaas.paasta.portal.api.util.CfUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;

/**
 * 공간 컨트롤러 - 공간 목록 , 공간 이름 변경 , 공간 생성 및 삭제 등을 제공한다.
 *
 * @author 조민구
 * @version 1.0
 * @since 2016.12.4 최초작성
 */
@RestController
@RequestMapping(value = {"space"})
public class SpaceController extends BaseController {
    private static final Logger LOGGER = LoggerFactory.getLogger(SpaceController.class);

    @Autowired
    SpaceService spaceService;
    @Autowired
    OrganizationService organizationService;

    /**
     * 공간 요약 정보 조회
     *
     * @param space   the space
     * @param request the request
     * @return Space respSpace
     * @throws Exception the exception
     */
    @RequestMapping(value = {"/getSpaceSummary"}, method = RequestMethod.POST)
    public Space getSpaceSummary(@RequestBody Space space, HttpServletRequest request) throws Exception {

        LOGGER.info("Get SpaceSummary Start : org={}, space={}", space.getOrgName(), space.getSpaceName());

        // Get CloudFoundry class
        TokenProvider tokenProvider = getTokenProvider(request.getHeader(AUTHORIZATION_HEADER_KEY));
        CloudFoundryClient cloudFoundryClient= CfUtils.cloudFoundryClient(connectionContext, tokenProvider);

        // Service Operation
        String organizationId = organizationService.getOrganizationId(cloudFoundryClient, space.getOrgName());
        String spaceId = spaceService.getSpaceId(cloudFoundryClient, organizationId, space.getSpaceName());
        Space spaceSummary = spaceService.getSpaceSummery(cloudFoundryClient, spaceId);

        LOGGER.info("Get SpaceSummary End ");

        //return respSpace;
        return spaceSummary;
    }
}
