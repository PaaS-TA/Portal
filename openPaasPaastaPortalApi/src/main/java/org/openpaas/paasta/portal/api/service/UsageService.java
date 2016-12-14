package org.openpaas.paasta.portal.api.service;

import org.cloudfoundry.client.lib.domain.CloudOrganization;
import org.cloudfoundry.client.lib.domain.CloudSpace;
import org.cloudfoundry.client.lib.util.JsonUtil;
import org.openpaas.paasta.portal.api.common.Constants;
import org.openpaas.paasta.portal.api.model.Org;
import org.openpaas.paasta.portal.api.model.Usage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestTemplate;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static java.util.stream.Collectors.toList;

/**
 * 사용량 조회 서비스
 *
 * @author rex
 * @version 1.0
 * @since 2016.09.22
 */
@Transactional
@Service
public class UsageService {

    private final OrgService orgService;
    private final SpaceService spaceService;

    @Value("${cloudfoundry.authorization}")
    private String cfAuthorizationHeaderKey;

    @Value("${abacus.url}")
    private String abacusUrl;


    /**
     * Instantiates a new Usage service.
     *  @param orgService     the org service
     * @param spaceService the space service
     */
    @Autowired
    public UsageService(OrgService orgService, SpaceService spaceService) {
        this.orgService = orgService;
        this.spaceService = spaceService;
    }


    /**
     * Gets usage organization list.
     *
     * @param req the req
     * @return usage organization list
     * @throws Exception the exception
     */
    public Map<String, Object> getUsageOrganizationList(HttpServletRequest req) throws Exception {
        List<Map<String, Object>> resultList = new ArrayList<>();
        List<CloudOrganization> organizationList = orgService.getOrgs(req.getHeader(cfAuthorizationHeaderKey));

        organizationList.stream().collect(toList()).forEach(cloudOrganization -> resultList.add(new HashMap<String, Object>() {{
            put("name", cloudOrganization.getName());
            put("value", cloudOrganization.getName());
            put("guid", cloudOrganization.getMeta().getGuid());
        }}));

        return new HashMap<String, Object>(){{put("list", resultList);}};
    }


    /**
     * Gets usage space list.
     *
     * @param param the param
     * @param req   the req
     * @return usage space list
     * @throws Exception the exception
     */
    public Map<String, Object> getUsageSpaceList(Usage param, HttpServletRequest req) throws Exception {
        List<Map<String, Object>> resultList = new ArrayList<>();
        List<CloudSpace> spaceList = spaceService.getSpaces(new Org() {{
            setOrgName(param.getOrgName());
        }}, req.getHeader(cfAuthorizationHeaderKey));

        spaceList.stream().collect(toList()).forEach(cloudOrganization -> resultList.add(new HashMap<String, Object>() {{
            put("name", cloudOrganization.getName());
            put("value", cloudOrganization.getName());
            put("guid", cloudOrganization.getMeta().getGuid());
        }}));

        return new HashMap<String, Object>(){{put("list", resultList);}};
    }


    /**
     * Gets usage search list.
     *
     * @param param the param
     * @return usage space list
     * @throws Exception the exception
     */
    public Map<String, Object> getUsageSearchList(Usage param) throws Exception {
        String reqUrl = abacusUrl + "/org/{org_id}/space/{space_id}/from/{from_month}/to/{to_month}";

        return new HashMap<String, Object>() {{
            put("RESULT_ABACUS", JsonUtil.convertJsonToMap(new RestTemplate().getForObject(reqUrl, String.class, new HashMap<String, Object>() {{
                put("org_id", param.getOrgGuid());
                put("space_id", param.getSpaceGuid());
                put("from_month", param.getFromMonth());
                put("to_month", param.getToMonth());
            }})));
            put("RESULT", Constants.RESULT_STATUS_SUCCESS);
        }};
    }
}
