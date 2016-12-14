package gradle.cucumber;

import org.apache.commons.collections.map.HashedMap;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import org.junit.runner.RunWith;
import org.openpaas.paasta.portal.web.user.config.WebUserApplication;
import org.openpaas.paasta.portal.web.user.model.App;
import org.openpaas.paasta.portal.web.user.model.Space;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.test.IntegrationTest;
import org.springframework.boot.test.SpringApplicationContextLoader;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.web.client.HttpServerErrorException;
import org.springframework.web.client.RestTemplate;

import java.util.Map;

/**
 * Created by mg on 2016-08-26.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = WebUserApplication.class, loader = SpringApplicationContextLoader.class)
@WebAppConfiguration
@IntegrationTest
public class AbstractDefs
{
    private static final Logger LOGGER = LoggerFactory.getLogger(AbstractDefs.class);

    @Value("${local.server.port}")
    protected int port;

    protected static String baseUrl;
    protected static RestTemplate restTemplate;
    protected static ResponseEntity<? extends Object> lastResponse = null;
    protected static String cookie = null;

    protected void executeGet(String url, HttpHeaders requestHeaders, Object body, Class<? extends Object> responseType) {
        if (cookie != null) requestHeaders.add("Cookie", cookie);
        HttpEntity<Object> requestEntity = new HttpEntity<>(body, requestHeaders);
        lastResponse = restTemplate.exchange(baseUrl+url, HttpMethod.GET, requestEntity, responseType);
        viewResponse(lastResponse);

    }

    protected void executePost(String url, HttpHeaders requestHeaders, Object body, Class<? extends Object> responseType) {
        if (cookie != null) requestHeaders.add("Cookie", cookie);
        HttpEntity<Object> requestEntity = new HttpEntity<>(body, requestHeaders);
        lastResponse = restTemplate.exchange(baseUrl+url, HttpMethod.POST, requestEntity, responseType);
        viewResponse(lastResponse);
    }

    protected void executeDelete(String url, HttpHeaders requestHeaders, Object body, Class<? extends Object> responseType) {
        if (cookie != null) requestHeaders.add("Cookie", cookie);
        HttpEntity<Object> requestEntity = new HttpEntity<>(body, requestHeaders);
        lastResponse = restTemplate.exchange(baseUrl+url, HttpMethod.DELETE, requestEntity, responseType);
        viewResponse(lastResponse);
    }

    protected void execute(String url, HttpMethod httpMethod, HttpHeaders requestHeaders, Object body, Class<? extends Object> responseType) {
        if (cookie != null) requestHeaders.add("Cookie", cookie);
        HttpEntity<Object> requestEntity = new HttpEntity<>(body, requestHeaders);
        lastResponse = restTemplate.exchange(baseUrl+url, httpMethod, requestEntity, responseType);
        viewResponse(lastResponse);
    }

    private void viewResponse(ResponseEntity response) {
        LOGGER.info("------> Response");
        LOGGER.info("-> Status Code: {}", response.getStatusCode().toString());

        LOGGER.info("-> Response Body: ");

        Object body = response.getBody();

        if (body != null) {
            LOGGER.info(response.getBody().toString());
        }

        LOGGER.info("-> Response Headers: ");
        HttpHeaders headers = response.getHeaders();
        for( String key : headers.keySet() ) {
            LOGGER.info("{}: {}", key, headers.get(key));
        }

        LOGGER.info("<------ End");
    }


    protected String getApplicationGuidByApllicationName(String organization, String space, String application) {
        String applicationGuid = null;

        // API URL
        String url = "/space/getSpaceSummary";

        // HEADER
        HttpHeaders reqHeaders = new HttpHeaders();

        // BODY
        Map<String, Object> body = new HashedMap();
        body.put("orgName", organization);
        body.put("spaceName", space);

        // REST TEMPLATE
        executePost(url, reqHeaders, body, Space.class);

        Space resSpace = (Space) lastResponse.getBody();

        for(App app : resSpace.getApps() ) {
            if (application.equals(app.getName())) {
                applicationGuid = app.getGuid();
                break;
            }
        }

        return applicationGuid;

    }

    /**
     * service instance 를 조회한다.
     *
     * @param organization
     * @param space
     * @param serviceInstanceName
     * @return
     * @throws JSONException
     */
    protected JSONObject getServiceInstanceInfo(String organization, String space, String serviceInstanceName) throws JSONException, HttpServerErrorException {
        // API URL
        String url = "/service/getServiceInstance";

        // HEADER
        HttpHeaders reqHeaders = new HttpHeaders();

        // BODY
        Map<String, Object> body = new HashedMap();
        body.put("orgName", organization);
        body.put("spaceName", space);
        body.put("name", serviceInstanceName);

        // REST TEMPLATE
        executePost(url, reqHeaders, body, String.class);
        String result = (String) lastResponse.getBody();

        return convertStringToJSONObject(result);
    }

    /**
     * json string 을 json object 로 변환하여 반환한다.
     *
     * @param jsonStr
     * @return
     * @throws JSONException
     */
    protected JSONObject convertStringToJSONObject(String jsonStr) throws JSONException {
        return new JSONObject(jsonStr);
    }
}