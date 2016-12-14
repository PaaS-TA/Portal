package org.openpaas.paasta.portal.api.cloudfoundry;

import org.cloudfoundry.reactor.TokenProvider;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.openpaas.paasta.portal.api.util.CfUtils;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/**
 * Created by mg on 2016-08-10.
 */
@RunWith(SpringJUnit4ClassRunner.class)
public class Connection {


    private static final String TEST_API_HOST       = "api.115.68.46.29.xip.io";
    private static final String TEST_USERNAME       = "admin";
    private static final String TEST_PASSWORD       = "admin";
    private static final String TEST_CLIENT_ID      = "cloudfoundry";
    private static final String TEST_CLIENT_SECRET  = "";
    private static final String TEST_ORGANIZATION   = "OCP";
    private static final String TEST_SPACE          = "dev";

//    private static final String TEST_API_HOST       = "api.run.pivotal.io";
//    private static final String TEST_USERNAME       = "juhyun@bluedigm.com";
//    private static final String TEST_PASSWORD       = "hju8558";
//    private static final String TEST_CLIENT_ID      = "cloudfoundry";
//    private static final String TEST_CLIENT_SECRET  = "";
//    private static final String TEST_ORGANIZATION   = "bd-org";
//    private static final String TEST_SPACE          = "test";

    @Test
    public void connection() {
        String token = "";


        TokenProvider tokenProvider = CfUtils.tokenProvider(TEST_USERNAME, TEST_PASSWORD, TEST_CLIENT_ID, TEST_CLIENT_ID);

        token = tokenProvider.getToken(CfUtils.connectionContext(TEST_API_HOST, true)).block();

        if ( token == null || "".equals(token) ) System.out.println("token is null.");
        else System.out.println("token: " + token);
    }

}
