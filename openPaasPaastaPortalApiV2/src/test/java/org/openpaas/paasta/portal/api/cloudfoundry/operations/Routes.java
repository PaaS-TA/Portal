package org.openpaas.paasta.portal.api.cloudfoundry.operations;

import org.cloudfoundry.operations.routes.Level;
import org.cloudfoundry.operations.routes.ListRoutesRequest;
import org.cloudfoundry.operations.routes.Route;
import org.junit.Test;
import reactor.core.publisher.Flux;

/**
 * Created by mg on 2016-08-16.
 */
public class Routes extends Common{

    @Test
    public void showRoutes() {
        System.out.println(">>> Routes");
        for (Route r : getRoutes().toIterable()) {
            System.out.println("FOUND: "+r);
        }
        System.out.println("<<< Routes");
    }



    private Flux<Route> getRoutes() {
        return cloudFoundryOperations.routes().list(ListRoutesRequest.builder()
                .level(Level.SPACE)
                .build()
        );
    }
}
