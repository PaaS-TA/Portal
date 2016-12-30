package gradle.cucumber;

import cucumber.api.java.en.Given;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.containsString;
import static org.hamcrest.Matchers.is;

/**
 * Web 로그인을 테스트한다.
 *
 * @author 조민구
 * @version 1.0
 * @since 2016-09-01
 */
public class LoginStepdefs extends AbstractDefs {

    private static final Logger LOGGER = LoggerFactory.getLogger(LoginStepdefs.class);

    /**
     * feature에 정의된 id, password로 로그인한다.
     * 이 후의 시나리오 테스트를 위해서 로그인 된 세션을 저장한다.
     *
     * @param id 로그인 할 아이디
     * @param password 로그인할 아이디의 비밀번호
     * @throws Throwable
     */
    @Given("i login by \"(.+)\" and \"(.+)\"")
    public void i_try_login_by_id_and_password(String id, String password) throws Throwable {
        LOGGER.info(">> i try login by {} and password", id);

        // SETUP
        restTemplate = new RestTemplate();
        baseUrl = "http://localhost:" +  String.valueOf(port);

        // API URL
        String  url = "/login";

        // BODY
        MultiValueMap<String, Object> body = new LinkedMultiValueMap<>();
        body.add("id", id);
        body.add("password", password);
        body.add("submit", "Login");

        // HEADER
        HttpHeaders reqHeaders = new HttpHeaders();
        reqHeaders.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

        // EXECUTE
        executePost(url, reqHeaders, body, String.class);

        // TEST
        assertThat(lastResponse.getStatusCode().value(), is(302));

        // SESSION 저장
        cookie = lastResponse.getHeaders().get("Set-Cookie").get(0);

        HttpHeaders headers = lastResponse.getHeaders();
        assertThat(headers.get("Location").get(0), containsString("/org/orgMain"));

    }

}
