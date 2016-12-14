package org.openpaas.paasta.portal.api.service;

import org.cloudfoundry.client.lib.CloudCredentials;
import org.cloudfoundry.client.lib.CloudFoundryClient;
import org.cloudfoundry.client.lib.domain.CloudApplication;
import org.junit.Before;
import org.junit.Test;
import org.springframework.security.oauth2.common.DefaultOAuth2AccessToken;
import org.springframework.security.oauth2.common.OAuth2AccessToken;

import java.io.IOException;
import java.net.URL;
import java.util.List;

/**
 * Created by ijlee on 2016-07-27.
 */
public class LogServiceTest {
    private CloudFoundryClient cfc;
    private OAuth2AccessToken token;

    private String host = "https://api.115.68.46.29.xip.io";
    private String org = "OCP";
    private String space = "dev";

    private URL targetUrl;

    @Before
    public void init() throws IOException {

        String username = "admin";
        String password = "admin";

        targetUrl = new URL(host);

        CloudCredentials credentials = new CloudCredentials(username, password);

        token = new CloudFoundryClient(credentials, targetUrl,true).login();
        cfc = new CloudFoundryClient(new CloudCredentials(new DefaultOAuth2AccessToken(token)), targetUrl, org, space, true);
    }
    /**
     * 앱 로그 정보 가져오기(API)
     *
     */
    @Test
    public void getLog() {

        List<CloudApplication> list = cfc.getApplications();
        String sAppName = list.get(0).getName();
        System.out.println("getRecentLogs \n"+cfc.getRecentLogs(sAppName));

    }

}