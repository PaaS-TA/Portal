package org.openpaas.paasta.portal.api.service;

import org.cloudfoundry.client.CloudFoundryClient;
import org.cloudfoundry.client.v2.organizations.ListOrganizationsRequest;
import org.cloudfoundry.client.v2.organizations.OrganizationResource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by mg on 2016-10-25.
 */
@Service
public class OrganizationService {
    private static final Logger LOGGER = LoggerFactory.getLogger(OrganizationService.class);

    public String getOrganizationId(CloudFoundryClient cloudFoundryClient, String organizationName) {
        LOGGER.info("Get Organization Id: organizationName={}", organizationName);
        List<OrganizationResource> organizationList = cloudFoundryClient.organizations().list(ListOrganizationsRequest.builder().name(organizationName).build()).block().getResources();

        LOGGER.info("Get OrganizationId: Result size={}", organizationList.size());
        return organizationList.get(0).getMetadata().getId();
    }
}
