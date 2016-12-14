package org.openpaas.paasta.portal.api.service;

import org.cloudfoundry.client.lib.CloudCredentials;
import org.cloudfoundry.client.lib.CloudFoundryClient;
import org.junit.Before;
import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.openpaas.paasta.portal.api.common.Common;
import org.openpaas.paasta.portal.api.config.ApiApplication;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.SpringApplicationConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import static org.junit.Assert.*;
import static org.openpaas.paasta.portal.api.common.Common.AUTHORIZATION_HEADER_KEY;

/**
 * org.openpaas.paasta.portal.api.service
 *
 * @author rex
 * @version 1.0
 * @since 2016.08.18
 */
@RunWith(SpringJUnit4ClassRunner.class)
@SpringApplicationConfiguration(classes = {ApiApplication.class})
@WebAppConfiguration
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class RouteServiceTest extends Common {

    @Autowired
    private RouteService routeService;

    @Before
    public void setUp() throws Exception {

    }

    @Test
    public void getCheckRouteExists() throws Exception {
        String domain = "115.68.46.29.xip.io";
        String route = "test-false.115.68.46.29.xip.io";
        CloudCredentials adminCredentials = new CloudCredentials("admin", "admin");
        CloudFoundryClient cloudFoundryClient = new CloudFoundryClient(adminCredentials, getTargetURL(apiTarget), "app-test-org", "app-test-space", true);

        Boolean result = routeService.getCheckRouteExists(domain, route, cloudFoundryClient);

        assertFalse(result);
    }

}