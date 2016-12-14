package org.openpaas.paasta.portal.api.config.cloudfoundry;

import org.cloudfoundry.client.CloudFoundryClient;
import org.cloudfoundry.doppler.DopplerClient;
import org.cloudfoundry.operations.DefaultCloudFoundryOperations;
import org.cloudfoundry.reactor.DefaultConnectionContext;
import org.cloudfoundry.reactor.TokenProvider;
import org.cloudfoundry.reactor.client.ReactorCloudFoundryClient;
import org.cloudfoundry.reactor.doppler.ReactorDopplerClient;
import org.cloudfoundry.reactor.tokenprovider.PasswordGrantTokenProvider;
import org.cloudfoundry.reactor.uaa.ReactorUaaClient;
import org.cloudfoundry.uaa.UaaClient;
import org.openpaas.paasta.portal.api.util.CfUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * Created by mg on 2016-08-03.
 */

@Configuration
public class CloudfoundryConfig {

    @Bean
    DefaultConnectionContext connectionContext(@Value("${cf.apiHost}") String apiHost,
                                               @Value("${cf.sslSkipValidation}") Boolean sslSkipValidation) {
        return CfUtils.connectionContext(apiHost, sslSkipValidation);
    }


    @Bean
    PasswordGrantTokenProvider tokenProvider(@Value("${cf.clientId}") String clientId,
                                             @Value("${cf.clientSecret}") String clientSecret,
                                             @Value("${cf.username}") String username,
                                             @Value("${cf.password}") String password) {
        return CfUtils.tokenProvider(username, password, clientId, clientSecret);
    }

    @Bean
    ReactorCloudFoundryClient cloudFoundryClient(DefaultConnectionContext connectionContext, TokenProvider tokenProvider) {
        return CfUtils.cloudFoundryClient(connectionContext, tokenProvider);
    }

    @Bean
    ReactorDopplerClient dopplerClient(DefaultConnectionContext connectionContext, TokenProvider tokenProvider) {
        return CfUtils.dopplerClient(connectionContext, tokenProvider);
    }

    @Bean
    ReactorUaaClient uaaClient(DefaultConnectionContext connectionContext, TokenProvider tokenProvider) {
        return CfUtils.uaaClient(connectionContext, tokenProvider);
    }
}
