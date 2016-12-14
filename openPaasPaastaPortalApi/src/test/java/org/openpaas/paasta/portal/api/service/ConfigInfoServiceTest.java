package org.openpaas.paasta.portal.api.service;

import com.google.gson.Gson;
import org.junit.Before;
import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.openpaas.paasta.portal.api.common.CommonTest;
import org.openpaas.paasta.portal.api.config.ApiApplication;
import org.openpaas.paasta.portal.api.model.App;
import org.openpaas.paasta.portal.api.model.AppAutoScale;
import org.openpaas.paasta.portal.api.model.ConfigInfo;
import org.openpaas.paasta.portal.api.model.WebIdeUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.SpringApplicationConfiguration;
import org.springframework.http.MediaType;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

import static org.junit.Assert.assertTrue;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;


@RunWith(SpringJUnit4ClassRunner.class)
@SpringApplicationConfiguration(classes = {ApiApplication.class})
@WebAppConfiguration
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class ConfigInfoServiceTest extends CommonTest {

    @Autowired
    private ConfigInfoService configInfoService;

    private static MockMvc mvc;
    ConfigInfo configInfo = new ConfigInfo();

    @Test
    public void getValue() throws Exception {

        List<ConfigInfo> list = configInfoService.getValue(configInfo);

        assertTrue(list != null);
    }


    @Test
    public void updateValue() throws Exception {
        Gson gson = new Gson();

        configInfo.setName("email_auth_test_yn");
        configInfo.setValue("Y");

        configInfoService.updateValue(configInfo);
    }


}