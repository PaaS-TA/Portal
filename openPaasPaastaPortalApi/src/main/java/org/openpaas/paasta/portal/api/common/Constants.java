package org.openpaas.paasta.portal.api.common;

/**
 * org.openpaas.paasta.portal.api.common
 *
 * @author rex
 * @version 1.0
 * @since 2016.06.16
 */
public class Constants {

    public Constants(){};

    public static final String USE_YN_Y = "Y";
    public static final String USE_YN_N = "N";

    public static final int PAGE_NO = 1;
    public static final int PAGE_SIZE = 10;

    public static final String PROC_NAME_COMMON_CODE_GROUP = "CommonCodeGroup";
    public static final String PROC_NAME_COMMON_CODE_DETAIL = "CommonCodeDetail";

    public static final String RESULT_STATUS_SUCCESS = "SUCCESS";
    public static final String RESULT_STATUS_FAIL = "FAIL";
    public static final String RESULT_STATUS_FAIL_DUPLICATED = "DUPLICATED";

    public static final String CUD_C = "C";
    public static final String CUD_U = "U";
    public static final String NONE_VALUE = "NONE";

    public static final String DUPLICATION_SEPARATOR = "::";

    public static final String STARTER_CATALOG_ID = "STARTER_CATALOG";
    public static final String BUILD_PACK_CATALOG_ID = "BUILD_PACK_CATALOG";
    public static final String SERVICE_PACK_CATALOG_ID = "SERVICE_PACK_CATALOG";

    public static final String CATALOG_TYPE_STARTER = "starter";
    public static final String CATALOG_TYPE_BUILD_PACK = "buildPack";
    public static final String CATALOG_TYPE_SERVICE_PACK = "servicePack";

    public static final int CATALOG_HISTORY_LIMIT_SIZE = 3;

    public static final String REQUEST_DOMAIN_STATUS_SHARED = "shared";

    public static final String CREATE_APPLICATION_STAGING_COMMAND = "";
    public static final int CREATE_APPLICATION_DISK_SIZE = 1024;
    public static final int CREATE_APPLICATION_MEMORY_SIZE = 512;

    public static final String MY_QUESTION_STATUS_WAITING = "waiting";

    public static final String CATALOG_EGOV_BUILD_PACK_CHECK_STRING = "egov";
    public static final String CATALOG_EGOV_BUILD_PACK_ENVIRONMENT_KEY = "JBP_CONFIG_COMPONENTS";
    public static final String CATALOG_EGOV_BUILD_PACK_ENVIRONMENT_VALUE = "[containers: Tomcat]";
}
