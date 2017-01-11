package org.openpaas.paasta.portal.autoscaling.common;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

import java.util.HashMap;
import java.util.Map;

/**
 * 공통 클래스
 *
 * @author 김도준
 * @version 1.0
 * @since 2016.07.28
 */
@Service
public class Common {

    private static final String AUTHORIZATION_HEADER_KEY = "Authorization";
    private static final String CF_AUTHORIZATION_HEADER_KEY = "cf-Authorization";
    private final RestTemplate restTemplate;

    @Value("${paasta.portal.api.url}")
    private String apiUrl;

    @Value("${paasta.portal.api.authorization.base64}")
    private String base64Authorization;

    /**
     * Instantiates a new Common service.
     *
     * @param restTemplate the rest template
     */
    @Autowired
    public Common(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }


    /**
     * REST TEMPLATE 처리
     *
     * @param reqUrl     the req url
     * @param httpMethod the http method
     * @param obj        the obj
     * @param reqToken   the req token
     * @return map map
     */
    public Map<String, Object> procRestTemplate(String reqUrl, HttpMethod httpMethod, Object obj, String reqToken) {

        HttpHeaders reqHeaders = new HttpHeaders();
        reqHeaders.add(AUTHORIZATION_HEADER_KEY, base64Authorization);
        if (null != reqToken && !"".equals(reqToken)) reqHeaders.add(CF_AUTHORIZATION_HEADER_KEY, reqToken);

        HttpEntity<Object> reqEntity = new HttpEntity<>(obj, reqHeaders);

        ResponseEntity<Map> resEntity = restTemplate.exchange(apiUrl + reqUrl, httpMethod, reqEntity, Map.class);
        Map<String, Object> resultMap = resEntity.getBody();

        return resultMap;
    }


    /**
     * REST TEMPLATE 처리
     *
     * @param reqUrl   the req url
     * @param file     the file
     * @param reqToken the req token
     * @return map map
     * @throws Exception the exception
     */
    public Map<String, Object> procRestTemplate(String reqUrl, MultipartFile file, String reqToken) throws Exception {
        HttpHeaders reqHeaders = new HttpHeaders();
        reqHeaders.add(AUTHORIZATION_HEADER_KEY, base64Authorization);
        if (null != reqToken && !"".equals(reqToken)) reqHeaders.add(CF_AUTHORIZATION_HEADER_KEY, reqToken);

        final MultiValueMap<String, Object> data = new LinkedMultiValueMap<String, Object>();

        ByteArrayResource resource = new ByteArrayResource(file.getBytes()) {
            @Override
            public String getFilename() throws IllegalStateException {
                return file.getOriginalFilename();
            }
        };

        data.add("file", resource);
        final HttpEntity<MultiValueMap<String, Object>> requestEntity = new HttpEntity<MultiValueMap<String, Object>>(data, reqHeaders);
        final ResponseEntity<Map> resEntity = restTemplate.exchange(apiUrl + reqUrl, HttpMethod.POST, requestEntity, Map.class);

        Map resultMap = resEntity.getBody();

        return resultMap;
    }


    /**
     * REST TEMPLATE 처리
     *
     * @param <T>          the type parameter
     * @param reqUrl       the req url
     * @param httpMethod   the http method
     * @param obj          the obj
     * @param reqToken     the req token
     * @param responseType the response type
     * @return response entity
     */
    public <T> ResponseEntity<T> procRestTemplate(String reqUrl, HttpMethod httpMethod, Object obj, String reqToken, Class<T> responseType) {

        HttpHeaders reqHeaders = new HttpHeaders();
        reqHeaders.add(AUTHORIZATION_HEADER_KEY, base64Authorization);

        if (null != reqToken && !"".equals(reqToken)) reqHeaders.add(CF_AUTHORIZATION_HEADER_KEY, reqToken);

        HttpEntity<Object> reqEntity = new HttpEntity<>(obj, reqHeaders);
        ResponseEntity<T> result = restTemplate.exchange(apiUrl + reqUrl, httpMethod, reqEntity, responseType);

        return result;
    }


    public String getToken() {

        Map<String, Object> resBody = new HashMap();
        resBody.put("id", "admin");
        resBody.put("password", "admin");

    Map result;

    result = procRestTemplate("/login", HttpMethod.POST, resBody, null);

        return (String) result.get("token");
    }

}

