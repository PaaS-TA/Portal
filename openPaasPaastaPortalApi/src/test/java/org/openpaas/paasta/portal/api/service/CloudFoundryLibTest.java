package org.openpaas.paasta.portal.api.service;

import com.amazonaws.util.json.JSONArray;
import org.cloudfoundry.client.lib.CloudCredentials;
import org.cloudfoundry.client.lib.CloudFoundryClient;
import org.cloudfoundry.client.lib.domain.CloudService;
import org.cloudfoundry.client.lib.domain.CloudSpace;
import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;
import org.openpaas.paasta.portal.api.common.CustomCloudFoundryClient;
import org.springframework.security.oauth2.common.DefaultOAuth2AccessToken;
import org.springframework.security.oauth2.common.OAuth2AccessToken;

import java.io.IOException;
import java.net.URL;
import java.util.List;

/**
 * Created by mg on 2016-05-02.
 */
@Ignore
public class CloudFoundryLibTest {

    private CloudFoundryClient cfc;
    private OAuth2AccessToken token;

    private String host = "https://api.115.68.46.30.xip.io";
    private String org = "OCP";
    private String space = "dev";

    private URL targetUrl;

    @Before
    public void init() throws IOException {

        String username = "junit-test-user";
        String password = "1234";

        targetUrl = new URL(host);

        CloudCredentials credentials = new CloudCredentials(username, password);

        token = new CloudFoundryClient(credentials, targetUrl,true).login();
        cfc = new CloudFoundryClient(new CloudCredentials(new DefaultOAuth2AccessToken(token)), targetUrl,true);

    }

    @Test
    public void cfTarget() {
        System.out.println("");
    }

    @Test
    public void getSpaces() {

        System.out.println("\ncfc.getSpaces():\n");

        List<CloudSpace> csList = cfc.getSpaces();

        JSONArray ja = new JSONArray(csList);

        System.out.println("jsonArray: \n"+ja);
/*

        for (int i = 0; i < csList.size(); i++ ) {
            System.out.println("List< CloudSpace > index (" + i + ") "+ csList.get(i).getName());
        }
*/

    }

    @Test
    public void createService() {
        CloudService cs = new CloudService();
        cs.setLabel("CubridDB");
        cs.setPlan("utf8");
        cs.setName("client-test-cubrid");
        cfc.createService(cs);
    }

    @Test
    public void getServices() {

        List<CloudService> csList = cfc.getServices();

        System.out.println("Service List : \n");

        for (CloudService cs : csList) {
            System.out.println("name : " + cs.getName());
        }


    }

    @Test
    public void renameOrg() {

    }

    @Test
    public void updatePassword() throws Exception {
        String username = "mingu@bluedigm.com";
        String password = "mingu2";

        CustomCloudFoundryClient cfc2 = new CustomCloudFoundryClient(new CloudCredentials(username, password), targetUrl, true);
        cfc2.login();
        cfc2.updatePassword("mingu2");
    }

    @Test
    public void deleteUser() throws Exception {
    }

}