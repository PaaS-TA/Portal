package org.openpaas.paasta.portal.api.service;

import org.cloudfoundry.client.lib.CloudCredentials;
import org.cloudfoundry.client.lib.CloudFoundryClient;
import org.openpaas.paasta.portal.api.common.Common;
import org.springframework.security.oauth2.common.OAuth2AccessToken;
import org.springframework.stereotype.Service;

import java.net.MalformedURLException;
import java.net.URISyntaxException;

/**
 * Created by mg on 2016-07-19.
 */
@Service
public class LoginService extends Common {

    /**
     * id, password 방식으로 CloudFoundry 인증 토큰을 OAuth2AccessToken 형태로 반환한다.
     *
     * @param id
     * @param password
     * @return OAuth2AccessToken
     * @throws MalformedURLException
     * @throws URISyntaxException
     */
    public OAuth2AccessToken login(String id, String password) throws MalformedURLException, URISyntaxException {
        return new CloudFoundryClient(new CloudCredentials(id, password), getTargetURL(apiTarget), true).login();
    }


}
