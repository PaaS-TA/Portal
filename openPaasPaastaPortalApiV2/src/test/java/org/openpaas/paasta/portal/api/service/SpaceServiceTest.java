package org.openpaas.paasta.portal.api.service;

import org.cloudfoundry.client.CloudFoundryClient;
import org.cloudfoundry.client.v2.CloudFoundryException;
import org.cloudfoundry.operations.DefaultCloudFoundryOperations;
import org.cloudfoundry.reactor.TokenProvider;
import org.cloudfoundry.reactor.client.ReactorCloudFoundryClient;
import org.junit.Assert;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import org.openpaas.paasta.portal.api.model.Space;
import org.openpaas.paasta.portal.api.util.CfUtils;
import org.springframework.beans.factory.annotation.Autowired;

import java.io.IOException;

/**
 * Created by mg on 2016-10-20.
 */
public class SpaceServiceTest extends Common {
    @Autowired
    SpaceService spaceService;
    @Autowired
    OrganizationService organizationService;

    @Test
    public void getSpaceSummery() throws IOException {
        Space space = new Space();
        space.setOrgName("OCP");
        space.setSpaceName("dev");
        try {
            String organizationId = organizationService.getOrganizationId(cloudFoundryClient, space.getOrgName());
            String spaceId = spaceService.getSpaceId(cloudFoundryClient, organizationId, space.getSpaceName());
            Space spaceSummary = spaceService.getSpaceSummery(cloudFoundryClient, spaceId);

            Assert.assertEquals(spaceSummary.getName(), space.getSpaceName());
        } catch (CloudFoundryException cfe) {

            Assert.fail(cfe.getMessage());
        }
    }
}
