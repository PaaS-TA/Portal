package org.openpaas.paasta.portal.api.cloudfoundry.operations;

import org.cloudfoundry.operations.organizations.OrganizationSummary;
import org.junit.Test;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

/**
 * Created by mg on 2016-08-16.
 */
public class Organization extends Common{

    private Mono<String> organizationId = Mono.just("bd-org");

    @Test
    public void showOrganizations() {

        System.out.println(">>> Show Organizations");

        for (OrganizationSummary organization : getOrganizations().toIterable()) {
            System.out.println(organization);
        }

        System.out.println("<<< Show Organizations");
    }

    @Test
    public void showOrganizations2() {
        System.out.println(">>> Show Organizations2");

        Flux<OrganizationSummary> orgs = getOrganizations().cache();
        System.out.println("Orgs Count="+orgs.count().block());
        
        orgs
                .subscribe( o -> System.out.println("FOUND Organization : " + o) );
        //.subscribe( a -> System.out.println("Apps Name: " + a.getName()) );

        System.out.println("<<< Show Organizations2");

    }

    private Flux<OrganizationSummary> getOrganizations() {
        return cloudFoundryOperations.organizations()
                .list();
    }
}
