package org.openpaas.paasta.portal.api.service;

import org.cloudfoundry.operations.DefaultCloudFoundryOperations;
import org.cloudfoundry.reactor.client.ReactorCloudFoundryClient;
import org.cloudfoundry.reactor.doppler.ReactorDopplerClient;
import org.cloudfoundry.reactor.uaa.ReactorUaaClient;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * Created by mg on 2016-10-19.
 */
public class CommonService {
    @Autowired
    ReactorCloudFoundryClient cloudFoundryClient;
    @Autowired
    ReactorUaaClient uaaClient;
    @Autowired
    ReactorDopplerClient dopplerClient;

}
