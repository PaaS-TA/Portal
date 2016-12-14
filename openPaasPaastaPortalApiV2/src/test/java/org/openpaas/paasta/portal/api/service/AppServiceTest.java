package org.openpaas.paasta.portal.api.service;

import org.cloudfoundry.operations.DefaultCloudFoundryOperations;
import org.cloudfoundry.operations.applications.ApplicationDetail;
import org.cloudfoundry.operations.applications.ApplicationSummary;
import org.cloudfoundry.reactor.TokenProvider;
import org.cloudfoundry.reactor.client.ReactorCloudFoundryClient;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import org.openpaas.paasta.portal.api.util.CfUtils;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

/**
 * Created by mg on 2016-10-19.
 */
public class AppServiceTest  extends Common {
    @Autowired
    AppService appService;

    @Test
    public void getAppSummery() {
        List<ApplicationSummary> apps = appService.getAppSummery(cloudFoundryOperations);

        apps.iterator().forEachRemaining(applicationSummary -> System.out.println(applicationSummary));
    }

    @Test
    public void getAppDetail() {
        String appName = "portal-api";
        ApplicationDetail app = appService.getAppDetail(cloudFoundryOperations, appName);

        System.out.println(app.toString());
    }
}
