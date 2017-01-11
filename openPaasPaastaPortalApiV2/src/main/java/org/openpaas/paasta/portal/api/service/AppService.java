package org.openpaas.paasta.portal.api.service;

import org.cloudfoundry.doppler.Envelope;
import org.cloudfoundry.doppler.RecentLogsRequest;
import org.cloudfoundry.operations.DefaultCloudFoundryOperations;
import org.cloudfoundry.operations.applications.ApplicationDetail;
import org.cloudfoundry.operations.applications.ApplicationSummary;
import org.cloudfoundry.operations.applications.GetApplicationRequest;
import org.cloudfoundry.reactor.doppler.ReactorDopplerClient;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Flux;

import java.util.List;

/**
 * Created by mg on 2016-10-19.
 */
@Service
public class AppService extends CommonService{

    public List<ApplicationSummary> getAppSummery(DefaultCloudFoundryOperations cloudFoundryOperations) {
        return cloudFoundryOperations.applications().list().collectList().block();
    }

    public ApplicationDetail getAppDetail(DefaultCloudFoundryOperations cloudFoundryOperations, String appName) {
        return cloudFoundryOperations.applications().get(
                GetApplicationRequest.builder()
                        .name(appName).build())
                .block();
    }

    public Flux<Envelope> getRecentLog(ReactorDopplerClient reactorDopplerClient, String appId) {

        RecentLogsRequest recentLogsRequest = RecentLogsRequest.builder()
                .applicationId(appId)
                .build();

        Flux<Envelope> getRecentLog = reactorDopplerClient.recentLogs(recentLogsRequest);

        return getRecentLog;
    }

}
