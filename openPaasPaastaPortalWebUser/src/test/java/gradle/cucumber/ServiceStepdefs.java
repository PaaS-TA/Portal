package gradle.cucumber;

import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import org.apache.commons.collections.map.HashedMap;
import org.codehaus.jettison.json.JSONArray;
import org.codehaus.jettison.json.JSONException;
import org.codehaus.jettison.json.JSONObject;
import org.springframework.http.HttpHeaders;
import org.springframework.web.client.HttpServerErrorException;

import java.util.HashMap;
import java.util.Map;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.is;
import static org.hamcrest.Matchers.not;

/**
 * Service 의 동작을 테스트한다.
 *
 * Created by mg on 2016-09-05.
 */
public class ServiceStepdefs extends AbstractDefs {
    private String testOrganization;
    private String testSpace;

    /**
     * 테스트 대상(Organization, Space) 지정한다.
     *
     * @param organization
     * @param space
     * @throws Throwable
     */
    @Then("^i will test in organization \"(.+)\", space \"(.+)\"")
    public void i_will_test_in_organization_space(String organization, String space) throws Throwable {
        testOrganization = organization;
        testSpace = space;

        assertThat(testOrganization, is(organization));
        assertThat(testSpace, is(space));
    }

    /**
     * Service Instance 생성을 테스트한다.
     *
     * @param serviceInstanceName
     * @param planName
     * @param serviceName
     * @throws Throwable
     */
    @When("^create service instance \"(.+)\" with plan \"(.+)\" and service \"(.+)\"")
    public void create_service_with_plan(String serviceInstanceName, String planName, String serviceName) throws Throwable {
        // API URL
        final String SERVICE_PACK_CATALOG_LIST_PROC_URL = "/catalog/getServicePackCatalogList";
        final String CATALOG_SERVICE_PLAN_LIST_PROC_URL = "/catalog/getCatalogServicePlanList";
        final String CATALOG_SERVICE_PACK_CF_RUN_PROC_URL = "/catalog/executeCatalogServicePack";

        // HEADER
        HttpHeaders reqHeaders = new HttpHeaders();

        // BODY
        Map<String, Object> servicePackListbody = new HashedMap();
        //param = {reqCatalogType : CATALOG_TYPE_SERVICE_PACK, searchTypeUseYn : 'Y'};
        servicePackListbody.put("reqCatalogType","servicePack");
        servicePackListbody.put("searchTypeUseYn", "Y");

        Map<String, Object> planListBody = new HashedMap();
        planListBody.put("orgName ", testOrganization);
        planListBody.put("spaceName", testSpace);
        planListBody.put("servicePackName", serviceName);

        // REST TEMPLATE :: GET SERVICE INFO
        executePost(SERVICE_PACK_CATALOG_LIST_PROC_URL, reqHeaders, servicePackListbody, String.class);
        int catalogNo = findCatalogNoByServiceName(convertStringToJSONObject((String)lastResponse.getBody()), serviceName);

        executePost(CATALOG_SERVICE_PLAN_LIST_PROC_URL, reqHeaders, planListBody, String.class);
        String planGuid = findPlanGuidByPlanName(convertStringToJSONObject((String)lastResponse.getBody()), planName);

        // REST TEMPLATE :: EXECUTE CREATE SERVICE INSTANCE
        Map<String, Object> executeBody = new HashedMap();
        executeBody.put("orgName", testOrganization);
        executeBody.put("spaceName", testSpace);
        executeBody.put("serviceInstanceName", serviceInstanceName);
        executeBody.put("catalogNo", catalogNo);
        executeBody.put("appName", "");
        executeBody.put("appBindYn", "M");
        executeBody.put("servicePlan", planGuid);

        executePost(CATALOG_SERVICE_PACK_CF_RUN_PROC_URL, reqHeaders, executeBody, Map.class);

        Map<String, Object> resultMap = (HashMap) lastResponse.getBody();
        System.out.println(resultMap);

        // TEST
        assertThat(lastResponse.getStatusCode().value(), is(200));

    }

    private int findCatalogNoByServiceName(JSONObject jsonBody, String service) throws JSONException {
        int catalogNo = 0;

        JSONArray serviceJsonList = jsonBody.getJSONArray("list");
        int serviceLength = serviceJsonList.length();

        for (int i = 0; i < serviceLength; i++) {
            JSONObject jsonObject = serviceJsonList.getJSONObject(i);
            if (service.equals(jsonObject.get("servicePackName"))) {
                catalogNo = (Integer) jsonObject.get("no");
            }
        }

        return catalogNo;
    }

    private String findPlanGuidByPlanName(JSONObject jsonBody, String plan) throws JSONException {
        String planGuid = null;

        JSONArray planJsonList = jsonBody.getJSONArray("list");
        int serviceLength = planJsonList.length();

        for (int i = 0; i < serviceLength; i++) {
            JSONObject jsonObject = planJsonList.getJSONObject(i);
            if (plan.equals(jsonObject.get("name"))) {
                planGuid = (String) jsonObject.get("guid");
            }
        }

        return planGuid;
    }

    /**
     * Service 를 조회하여 생성이 제대로 됐는지 확인한다.
     *
     * @param serviceInstanceName
     * @param planName
     * @throws Throwable
     */
    @Then("^service instance \"(.+)\" successfully created with plan \"(.+)\" and service \"(.+)\"")
    public void service_successfully_created_with_plan(String serviceInstanceName, String planName, String serviceName) throws Throwable {
        JSONObject jsonObject = getServiceInstanceInfo(testOrganization, testSpace, serviceInstanceName);

        // TEST
        assertThat(jsonObject.get("name"), is(serviceInstanceName));
        assertThat(jsonObject.getJSONObject("service").get("label"), is(serviceName));
        assertThat(jsonObject.getJSONObject("service").get("plan"), is(planName));

    }

    /**
     * Service 바인드를 테스트한다.
     *
     * @param serviceInstanceName
     * @param applicationName
     * @throws Throwable
     */
    @When("^bind service instance \"(.+)\" and application \"(.+)\"")
    public void bind_service_and_application(String serviceInstanceName, String applicationName) throws Throwable {
        // API URL
        String url = "/app/bindService";

        // HEADER
        HttpHeaders reqHeaders = new HttpHeaders();

        // BODY
        Map<String, Object> body = new HashedMap();
        body.put("orgName",testOrganization);
        body.put("spaceName",testSpace);
        body.put("name",applicationName);
        body.put("serviceName",serviceInstanceName);

        // REST TEMPLATE
        executePost(url, reqHeaders, body, String.class);
        String result = (String) lastResponse.getBody();

        System.out.println(result);
        //JSONObject jsonObject = convertStringToJSONObject(result);

        // TEST
        assertThat(lastResponse.getStatusCode().value(), is(200));

    }

    // Service 조회하여 바인드 확인 : : service, application

    /**
     * Service 를 조회하여 바인드가 제대로 됐는지 확인한다.
     *
     * @throws Throwable
     */
    @Then("^service instance \"(.+)\" and application \"(.+)\" successfully bound")
    public void service_instance_and_application_successfully_bound(String serviceInstanceName, String applicationName) throws Throwable {
        JSONObject jsonObject = getServiceInstanceInfo(testOrganization, testSpace, serviceInstanceName);

        // TEST
        assertThat(jsonObject.getJSONArray("bindings").getJSONObject(0).get("appGuid"), is(getApplicationGuidByApllicationName(testOrganization, testSpace, applicationName)));

    }

    /**
     * Service 언바인드를 테스트한다.
     *
     * @param serviceInstanceName
     * @param applicationName
     * @throws Throwable
     */
    @When("^unbind service instance \"(.+)\" and application \"(.+)\"")
    public void unbind_service_and_application(String serviceInstanceName, String applicationName) throws Throwable {
        // API URL
        String url = "/app/unbindService";

        // HEADER
        HttpHeaders reqHeaders = new HttpHeaders();

        // BODY
        Map<String, Object> body = new HashedMap();
        body.put("orgName",testOrganization);
        body.put("spaceName",testSpace);
        body.put("name",applicationName);
        body.put("serviceName",serviceInstanceName);

        // REST TEMPLATE
        executePost(url, reqHeaders, body, String.class);
        String result = (String) lastResponse.getBody();

        System.out.println(result);
        //JSONObject jsonObject = convertStringToJSONObject(result);

        // TEST
        assertThat(lastResponse.getStatusCode().value(), is(200));

    }

    // Service 조회하여 바인드 확인 : : service, application

    /**
     * Service 를 조회하여 언바인드가 제대로 됐는지 확인한다.
     *
     * @throws Throwable
     */
    @Then("^service instance \"(.+)\" and application \"(.+)\" successfully unbound")
    public void service_instance_and_application_successfully_unbound(String serviceInstanceName, String applicationName) throws Throwable {
        String applicationGuid = null;

        JSONObject jsonObject = getServiceInstanceInfo(testOrganization, testSpace, serviceInstanceName);
        applicationGuid = getApplicationGuidByApllicationName(testOrganization, testSpace, applicationName);

        // TEST
        int bindLength = jsonObject.getJSONArray("bindings").length();
        if (bindLength != 0) {
            for (int i=0; i < bindLength; i++) {
                assertThat(jsonObject.getJSONArray("bindings").getJSONObject(0).get("appGuid"), not(applicationGuid));
            }
        } else if (bindLength != 0) {
            assertThat(0, is(0));
        }
    }

    /**
     * Service 삭제를 테스트한다.
     *
     * @param serviceInstanceName
     * @throws Throwable
     */
    @When("^delete service instance \"(.+)\"")
    public void delete_service_instance(String serviceInstanceName) throws Throwable {
        // API URL
        String url = "/service/deleteInstanceService";

        // HEADER
        HttpHeaders reqHeaders = new HttpHeaders();

        // BODY
        Map<String, Object> body = new HashedMap();
        body.put("orgName", testOrganization);
        body.put("spaceName", testSpace);
        body.put("guid", getServiceInstanceInfo(testOrganization, testSpace, serviceInstanceName).getJSONObject("meta").get("guid"));

        // REST TEMPLATE
        executePost(url, reqHeaders, body, String.class);

        // TEST
        assertThat(lastResponse.getStatusCode().value(), is(200));

    }

    // Service 조회하여 삭제 확인 : service

    /**
     * Service Instance 를 조회하여 삭제가 제대로 됐는지 확인한다.
     *
     * @throws Throwable
     */
    @Then("^service instance \"(.+)\" successfully deleted")
    public void service_instance_successfully_deleted(String serviceInstanceName) throws Throwable {
        int statusCodeValue = 0;

        try {
            getServiceInstanceInfo(testOrganization, testSpace, serviceInstanceName);
        } catch (HttpServerErrorException e) {
            statusCodeValue = e.getStatusCode().value();
        }
        assertThat(statusCodeValue, is(500));

    }
}
