package org.openpaas.paasta.portal.api.cloudfoundry.operations;

import org.cloudfoundry.doppler.LogMessage;
import org.cloudfoundry.operations.CloudFoundryOperations;
import org.cloudfoundry.operations.applications.ApplicationSummary;
import org.cloudfoundry.operations.applications.LogsRequest;
import org.junit.Test;
import reactor.core.publisher.Flux;
import static org.cloudfoundry.operations.applications.LogsRequest.Builder;
import java.sql.Timestamp;

/**
 * Created by mg on 2016-08-16.
 */
//@Ignore
public class Applications extends Common{


    @Test
    public void showApps() {
        System.out.println(">>> Show Applications");

//        Flux<ApplicationSummary> apps = getApps().cache();
//        System.out.println("Apps Count="+apps.count().block());
//        apps
//                .subscribe( a -> System.out.println("FOUND Application : " + a) );

        Flux<ApplicationSummary> apps = getApps();
        apps.toIterable().forEach(applicationSummary -> {
            System.out.println("itor: " + applicationSummary);
        });

        apps.collectList().block();

        System.out.println("<<< Show Applications");

    }

    @Test
    public void tailLogs() {
        String appName = "portal-api";

        streamLogs(cloudFoundryOperations, appName);



        // 1 sec = 1000


        int sec = 20;
        try {
            Thread.sleep(sec*1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

    }

    @Test
    public void tailLogsV2() {
        String appName = "portal-api";

        streamLogsV2(cloudFoundryOperations, appName);



        // 1 sec = 1000


        int sec = 20;
        try {
            Thread.sleep(sec*1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

    }

    private Flux<ApplicationSummary> getApps() {

        return cloudFoundryOperations.applications().list();
    }

    private void streamLogs(CloudFoundryOperations cloudFoundryOperations, String app) {
        cloudFoundryOperations.applications().logs(LogsRequest.builder()
                .name(app)
                .build()).subscribe((msg) -> {
                    System.out.printf(String.valueOf(getLogStr(msg)));
                },
                (error) -> {
                    error.printStackTrace();
                }
        );
    }

    private org.cloudfoundry.operations.applications.Applications applications(){
        return cloudFoundryOperations.applications();
    }

    private void streamLogsV2(CloudFoundryOperations cloudFoundryOperations, String app) {
        org.cloudfoundry.operations.applications.Applications applications =  applications();

        Builder logsRequest = LogsRequest.builder();
        Builder builder = logsRequest.name(app);
        Flux<LogMessage> logMessageFlux = applications.logs(builder.build());
        logMessageFlux.subscribe((msg) -> {
                    System.out.printf(String.valueOf(getLogStr(msg)));
                },
                (error) -> {
                    error.printStackTrace();
                }
        );
    }

    private StringBuffer getLogStr(LogMessage msg) {
        return new StringBuffer()
                .append(new Timestamp(msg.getTimestamp()/1000000).toLocalDateTime())
                .append(" [")
                .append(msg.getSourceType())
                .append("/")
                .append(msg.getSourceInstance())
                .append("] [")
                .append(msg.getMessageType())
                .append("] ")
                .append(msg.getMessage());
    }
}
