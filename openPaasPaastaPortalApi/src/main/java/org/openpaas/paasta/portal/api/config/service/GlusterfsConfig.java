package org.openpaas.paasta.portal.api.config.service;

import org.javaswift.joss.client.factory.AccountConfig;
import org.javaswift.joss.client.factory.AccountFactory;
import org.javaswift.joss.client.factory.AuthenticationMethod;
import org.javaswift.joss.model.Account;
import org.javaswift.joss.model.Container;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.env.Environment;

/**
 * Created by mg on 2016-07-05.
 */
@Configuration
public class GlusterfsConfig {

    @Autowired
    private Environment env;

    @Bean
    public AccountConfig accountConfig(){
        String tenantName = env.getRequiredProperty("spring.glusterfs.tenantName");
        String username = env.getRequiredProperty("spring.glusterfs.username");
        String password = env.getRequiredProperty("spring.glusterfs.password");
        String authUrl = env.getRequiredProperty("spring.glusterfs.authUrl");


        AccountConfig config = new AccountConfig();
        config.setUsername(username);
        config.setTenantName(tenantName);
        config.setPassword(password);
        config.setAuthUrl(authUrl + "/tokens");
        config.setAuthenticationMethod(AuthenticationMethod.KEYSTONE);
        if(authUrl.contains("localhost")) {
            config.setPreferredRegion("Local");
        } else {
            config.setPreferredRegion("Public");
        }
        return config;
    }

    @Bean
    public AccountFactory accountFactory(AccountConfig accountConfig){
        return new AccountFactory(accountConfig);
    }

    @Bean
    public Account account(AccountFactory accountFactory){
        return accountFactory.createAccount();
    }

    @Bean
    public Container container(Account account) {
        String containerName = env.getRequiredProperty("spring.glusterfs.container");

        Container container = account.getContainer(containerName);
        if(!container.exists()){
            container.create();
            container.makePublic();
        }

        return container;
    }
}
