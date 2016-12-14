package org.openpaas.paasta.portal.api.config;

import org.javaswift.joss.client.factory.AccountConfig;
import org.javaswift.joss.client.factory.AccountFactory;
import org.javaswift.joss.client.factory.AuthenticationMethod;
import org.javaswift.joss.model.Account;
import org.javaswift.joss.model.Container;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * Created by mg on 2016-07-05.
 */
@Configuration
public class GlusterfsConfig {

    @Bean
    public AccountConfig accountConfig(@Value("${glusterfs.tenantName}") String tenantName,
                                       @Value("${glusterfs.username}") String username,
                                       @Value("${glusterfs.password}") String password,
                                       @Value("${glusterfs.authUrl}") String authUrl) {
        AccountConfig config = new AccountConfig();
        config.setUsername(username);
        config.setTenantName(tenantName);
        config.setPassword(password);
        config.setAuthUrl(authUrl + "/tokens");
        config.setAuthenticationMethod(AuthenticationMethod.KEYSTONE);
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
    public Container container(Account account,
                               @Value("${glusterfs.containerName}") String containerName) {

        Container container = account.getContainer(containerName);
        if(!container.exists()){
            container.create();
            container.makePublic();
        }

        return container;
    }
}
