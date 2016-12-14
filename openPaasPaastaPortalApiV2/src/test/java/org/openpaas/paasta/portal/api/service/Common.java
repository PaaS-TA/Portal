package org.openpaas.paasta.portal.api.service;

import org.cloudfoundry.client.CloudFoundryClient;
import org.cloudfoundry.operations.DefaultCloudFoundryOperations;
import org.cloudfoundry.reactor.ConnectionContext;
import org.cloudfoundry.reactor.TokenProvider;
import org.cloudfoundry.reactor.client.ReactorCloudFoundryClient;
import org.junit.Before;
import org.junit.runner.RunWith;
import org.openpaas.paasta.portal.api.Application;
import org.openpaas.paasta.portal.api.util.CfUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

/**
 * Service를 테스트 하기 위한 기본 클레스
 * Created by mg on 2016-10-19.
 */
@RunWith(SpringRunner.class)
@SpringBootTest(classes = Application.class)
public class Common {
    @Autowired
    public ConnectionContext connectionContext;

    private final String TEST_USERNAME       = "admin";
    private final String TEST_PASSWORD       = "admin";
    private final String TEST_CLIENT_ID      = "cf";
    private final String TEST_CLIENT_SECRET  = "";

    public TokenProvider tokenProvider;
    public ReactorCloudFoundryClient cloudFoundryClient;
    public DefaultCloudFoundryOperations cloudFoundryOperations;

    private final String TEST_ORGANIZATION   = "OCP";
    private final String TEST_SPACE          = "dev";




    public Common() {
        tokenProvider = CfUtils.tokenProvider(TEST_USERNAME, TEST_PASSWORD, TEST_CLIENT_ID, TEST_CLIENT_SECRET);
    }

    @Before
    public void set(){
        cloudFoundryClient = CfUtils.cloudFoundryClient(connectionContext, tokenProvider);
        cloudFoundryOperations = CfUtils.cloudFoundryOperations(connectionContext, tokenProvider, TEST_ORGANIZATION, TEST_SPACE);
    }
}
