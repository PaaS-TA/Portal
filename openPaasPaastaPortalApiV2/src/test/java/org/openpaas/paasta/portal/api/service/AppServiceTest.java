package org.openpaas.paasta.portal.api.service;

import org.cloudfoundry.doppler.Envelope;
import org.cloudfoundry.doppler.RecentLogsRequest;
import org.cloudfoundry.operations.applications.ApplicationDetail;
import org.cloudfoundry.operations.applications.ApplicationSummary;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import reactor.core.publisher.Flux;

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

        System.out.println("app.toString():     > >>>>>>>>>>" + app.toString());

    }

    /**
     * 앱 로그 정보 가져오기(API)
     */
    @Test
    public void getLog() {
        RecentLogsRequest recentLogsRequest = RecentLogsRequest.builder()
                .applicationId("portal-api")
                .build();
        Flux<Envelope> flux = appService.getRecentLog(reactorDopplerClient, "portal-api");
        System.out.println("app.toString():     > >>>>>>>>>>" + flux.log().cache());
    }

    @Test
    public void valid() {
        RecentLogsRequest recentLogsRequest = RecentLogsRequest.builder()
                .applicationId("portal-api")
                .build();

        System.out.println("recentLogsRequest.recentLogsRequest():     > >>>>>>>>>>" + recentLogsRequest.getApplicationId());

    }

}
