package org.openpaas.paasta.portal.api.service;

import com.google.gson.Gson;
import org.apache.commons.collections.map.HashedMap;
import org.cloudfoundry.client.lib.CloudCredentials;
import org.junit.*;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.openpaas.paasta.portal.api.common.Common;
import org.openpaas.paasta.portal.api.common.CustomCloudFoundryClient;
import org.openpaas.paasta.portal.api.config.ApiApplication;
import org.openpaas.paasta.portal.api.model.Support;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.SpringApplicationConfiguration;
import org.springframework.http.MediaType;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.transaction.TransactionConfiguration;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.WebApplicationContext;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.put;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

/**
 * Created by YJKim on 2016-07-28.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@SpringApplicationConfiguration(classes = {ApiApplication.class})
@WebAppConfiguration
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
@TransactionConfiguration(defaultRollback = true)
@Transactional("portalTransactionManager")
public class ClientServiceTest extends Common {

    @Autowired
    ClientService clientService;

    @Test
    public void test01_getClientList() throws Exception {

        Map<String, Object> param = new HashedMap();
        param.put("page_offset", 0);

        CloudCredentials adminCredentials = new CloudCredentials(getPropertyValue("test.admin.id"), getPropertyValue("test.admin.password"));
        CustomCloudFoundryClient adminCcfc =  new CustomCloudFoundryClient(adminCredentials, getTargetURL(apiTarget), true);

        clientService.getClientList(adminCcfc, param);

    }

    @Test
    public void test02_getClient() throws Exception {

        Map<String, Object> param = new HashedMap();
        param.put("client_id", "admin");

        CloudCredentials adminCredentials = new CloudCredentials(getPropertyValue("test.admin.id"), getPropertyValue("test.admin.password"));
        CustomCloudFoundryClient adminCcfc =  new CustomCloudFoundryClient(adminCredentials, getTargetURL(apiTarget), true);

        clientService.getClient(adminCcfc, param);

    }

    @Test
    public void test03_registerUpdateDeleteClient() throws Exception {

        Map<String, Object> param = new HashedMap();
        param.put("client_id", "testRegisterUpdateDelete");
        param.put("client_secret", "testRegisterUpdateDelete");
        param.put("scope", "uaa.none");
        param.put("authorized_grant_types", "client_credentials");

        // Test other options? ///////////////////////////
        // name authorities access_token_validiity refresh_token_validity
        // redirect_uri autoapprove signup_redirect_url
        // clone del_attrs
        ////////////////////////////////////////////////


        CloudCredentials adminCredentials = new CloudCredentials(getPropertyValue("test.admin.id"), getPropertyValue("test.admin.id"));
        CustomCloudFoundryClient adminCcfc =  new CustomCloudFoundryClient(adminCredentials, getTargetURL(apiTarget), true);

        clientService.registerClient(adminCcfc, param);

        clientService.updateClient(adminCcfc, param);

        clientService.deleteClient(adminCcfc, param);

    }

//    @Test (expected = Exception.class)
//    public void test04_exceptionTest() throws Exception {
//
//        Map<String, Object> param = new HashedMap();
//        param.put("page_offset", 0);
//
//        CloudCredentials adminCredentials = new CloudCredentials(getPropertyValue("test.admin.id"), getPropertyValue("test.admin.password"));
//        CustomCloudFoundryClient adminCcfc =  new CustomCloudFoundryClient(adminCredentials, getTargetURL(apiTarget), true);
//
//        clientService.getClientList(adminCcfc, param);
//
//    }




}
