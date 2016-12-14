package gradle.cucumber;

import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import org.apache.commons.collections.map.HashedMap;
import org.openpaas.paasta.portal.web.user.model.Org;
import org.openpaas.paasta.portal.web.user.model.Space;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.web.client.HttpClientErrorException;

import java.util.Map;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.is;

/**
 * Organization과 Space 동작을 테스트한다.
 *
 * Created by mg on 2016-09-01.
 */
public class OrgAndSpaceStepdefs extends AbstractDefs {

    private static final Logger LOGGER = LoggerFactory.getLogger(OrgAndSpaceStepdefs.class);


    @When("create organization \"(.+)\"")
    public void create_organization_organization(String organization) throws Throwable {
        LOGGER.info(">> create organization '{}'", organization);
        // API URL
        String url = "/org/createOrg";

        // HEADER
        HttpHeaders reqHeaders = new HttpHeaders();

        // BODY
        Map<String, Object> body = new HashedMap();
        body.put("newOrgName", organization);

        // REST TEMPLATE
        executePost(url, reqHeaders, body, Boolean.class);

        // TEST
        assertThat(lastResponse.getStatusCode().value(), is(200));

    }

    @Then("\"(.+)\" organization successfully created")
    public void organization_successfully_created(String organization) throws Throwable {
        LOGGER.info(">> '{}' organization successfully created", organization);
        // API URL
        String url = "/org/getOrgSummary";

        // HEADER
        HttpHeaders reqHeaders = new HttpHeaders();

        // BODY
        Map<String, Object> body = new HashedMap();
        body.put("orgName", organization);

        // REST TEMPLATE
        executePost(url, reqHeaders, body, Org.class);

        // TEST
        assertThat(lastResponse.getStatusCode().value(), is(200));
    }

    @When("create space \"(.+)\" in organization \"(.+)\"")
    public void create_space_space_in_organization(String space, String organization) throws Throwable {
        LOGGER.info(">> create space {} in organization '{}", space, organization);
        // API URL
        String url = "/space/createSpace";

        // HEADER
        HttpHeaders reqHeaders = new HttpHeaders();

        // BODY
        Map<String, Object> body = new HashedMap();
        body.put("orgName", organization);
        body.put("newSpaceName", space);

        // REST TEMPLATE
        executePost(url, reqHeaders, body, Boolean.class);

        // TEST
        assertThat(lastResponse.getStatusCode().value(), is(200));

    }

    @Then("\"(.+)\" space in organization \"(.+)\" successfully created")
    public void space_in_organization_successfully_created(String space, String organization) throws Throwable {
        LOGGER.info(">> '{}'space in organization '{}' successfully created", space, organization);
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

        // TEST
        assertThat(lastResponse.getStatusCode().value(), is(200));
    }

    @When("delete space \"(.+)\" in organization \"(.+)\"")
    public void delete_space_in_organization(String space, String organization) throws Throwable {
        LOGGER.info(">> delete space '{}' in organization '{}'", space, organization);
        // API URL
        String url = "/space/deleteSpace";

        // HEADER
        HttpHeaders reqHeaders = new HttpHeaders();

        // BODY
        Map<String, Object> body = new HashedMap();
        body.put("orgName", organization);
        body.put("spaceName", space);

        // REST TEMPLATE
        executePost(url, reqHeaders, body, Boolean.class);

        // TEST
        assertThat(lastResponse.getStatusCode().value(), is(200));

    }

    @Then("\"(.+)\" space in organization \"(.+)\" successfully delete")
    public void space_in_organization_successfully_delete(String space, String organization) throws Throwable {
        LOGGER.info(">> '{}' space in organization '{}' successfully delete", space, organization);
        // API URL
        String url = "/space/getSpaceSummary";

        // HEADER
        HttpHeaders reqHeaders = new HttpHeaders();

        // BODY
        Map<String, Object> body = new HashedMap();
        body.put("currentOrg", organization);
        body.put("spaceName", space);

        // REST TEMPLATE
        int statusCode = 0;
        try {
            executePost(url, reqHeaders, body, Org.class);
        } catch (HttpClientErrorException e) {
            // TEST
            statusCode = e.getStatusCode().value();
        }
        assertThat(statusCode, is(400));

    }

    @When("delete organization \"(.+)\"")
    public void delete_organization(String organization) throws Throwable {
        LOGGER.info(">> delete organization '{}'", organization);
        // API URL
        String url = "/org/deleteOrg";

        // HEADER
        HttpHeaders reqHeaders = new HttpHeaders();

        // BODY
        Map<String, Object> body = new HashedMap();
        body.put("orgName", organization);

        // REST TEMPLATE
        executePost(url, reqHeaders, body, Boolean.class);

        // TEST
        assertThat(lastResponse.getStatusCode().value(), is(200));

    }

    @Then("\"(.+)\" organization successfully delete")
    public void organization_successfully_delete(String organization) throws Throwable {
        LOGGER.info(">> '{}' organization successfully delete", organization);
        // API URL
        String url = "/org/getOrgSummary";

        // HEADER
        HttpHeaders reqHeaders = new HttpHeaders();

        // BODY
        Map<String, Object> body = new HashedMap();
        body.put("orgName", organization);

        // REST TEMPLATE
        int statusCode = 0;
        try {
            executePost(url, reqHeaders, body, Org.class);
        } catch (HttpClientErrorException e) {
        // TEST
            statusCode = e.getStatusCode().value();
        }
        assertThat(statusCode, is(400));
    }

}
