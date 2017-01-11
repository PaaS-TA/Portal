package org.openpaas.paasta.portal.api.reactor;

import org.cloudfoundry.operations.applications.ApplicationSummary;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import reactor.core.publisher.Flux;

/**
 * Created by mg on 2016-08-04.
 */
@RunWith(SpringJUnit4ClassRunner.class)
public class FluxTests {

    @Test
    public void subscribe() {
        Flux<String> flux = Flux.just("just", "subscribe");
        flux.subscribe(x -> System.out.println("result="+x));


        Flux<ApplicationSummary> apps = Flux.just(ApplicationSummary.builder()
                                                        .name("test")
                                                        .diskQuota(1111)
                                                        .id("asdfasdf")
                                                        .instances(1)
                                                        .memoryLimit(512)
                                                        .requestedState("")
                                                        .runningInstances(1)
                                                        .build()
                                                 , ApplicationSummary.builder()
                                                        .name("tset2")
                                                        .diskQuota(1111)
                                                        .id("asdfasdf")
                                                        .instances(1)
                                                        .memoryLimit(512)
                                                        .requestedState("")
                                                        .runningInstances(1)
                                                        .build());
        apps.subscribe(x -> System.out.println("app name="+x.getName()));





    }
}
