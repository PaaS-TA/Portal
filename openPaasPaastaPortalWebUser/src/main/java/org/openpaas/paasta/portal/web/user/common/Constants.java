package org.openpaas.paasta.portal.web.user.common;

/**
 * Constants 클래스
 *
 * @author 김도준
 * @version 1.0
 * @since 2016.07.28 최초작성
 */
public class Constants {

    /**
     * 생성자
     */
    public Constants() {};

    /**
     * 등록/수정/삭제 상태 읽기
     */
    public static final String CUD_R = "R";
    /**
     * 카탈로그 타입 전체
     */
    public static final String CATALOG_TYPE_ALL = "all";
    /**
     * 카탈로그 타입 내역
     */
    public static final String CATALOG_TYPE_HISTORY = "catalogHistory";
    /**
     * 구분 문자
     */
    public static final String STRING_SEPARATOR = " :: ";
    /**
     * 내 문의 페이지 번호
     */
    public static final int MY_QUESTION_PAGE_NO = 1;
    /**
     * 내 문의 페이지 크기
     */
    public static final int MY_QUESTION_PAGE_SIZE = 10;
    /**
     * 내 문의 제한 파일 크기
     */
    public static final int MY_QUESTION_LIMIT_FILE_SIZE_MB = 10;
    /**
     * 문의 구분 아이디
     */
    public static final String QUESTION_CLASSIFICATION_ID = "QUESTION_CLASSIFICATION";
    /**
     * 문서 구분
     */
    public static final String DOCUMENTS_CLASSIFICATION = "DOCUMENTS_CLASSIFICATION";
    /**
     * 공지 구분
     */
    public static final String NOTICE_CLASSIFICATION = "SUPPORT_NOTICE";
    /**
     * 페이지 제한
     */
    public static final int PAGE_LIMIT = 20;
    /**
     * 페이지 제한
     */
    public static final int PAGE_OFFSET = 0;
    /**
     * 검색 타입 전체
     */
    public static final String SEARCH_TYPE_ALL = "ALL";
    /**
     * 검색 타입 제목
     */
    public static final String SEARCH_TYPE_TITLE = "title";
    /**
     * 검색 타입 사용자 아이디
     */
    public static final String SEARCH_TYPE_USERID = "userid";
    /**
     * 검색 타입 제목 내용
     */
    public static final String SEARCH_TYPE_TITLE_CONTENT = "title_content";
    /**
     * 검색 타입 문서
     */
    public static final String SEARCH_TYPE_DOCUMENTS = "DOCUMENTS";
    /**
     * ABACUS DELETED APP
     */
    public static final String ABACUS_DELETED_APP = "CF_DELETED_APP";
    /**
     * 카탈로그 애플리케이션 디스크 크기
     */
    public static final String CATALOG_APP_DISK_SIZE = "APP_DISK_SIZE";
    /**
     * 카탈로그 애플리케이션 메모리 크기
     */
    public static final String CATALOG_APP_MEMORY_SIZE = "APP_MEMORY_SIZE";
    /**
     * 사용유무 사용
     */
    public static final String USE_YN_Y = "Y";
    /**
     * 사용유무 미사용
     */
    public static final String USE_YN_N = "N";
    /**
     * 결과 코드 성공
     */
    public static final String RESULT_STATUS_SUCCESS = "SUCCESS";
    /**
     * 결과 코드 실패
     */
    public static final String RESULT_STATUS_FAIL = "FAIL";
    /**
     * 결과 코드 실패(중복)
     */
    public static final String RESULT_STATUS_FAIL_DUPLICATED = "DUPLICATED";
    /**
     * 등록/수정/삭제 상태 등록
     */
    public static final String CUD_C = "C";
    /**
     * 등록/수정/삭제 상태 수정
     */
    public static final String CUD_U = "U";
    /**
     * 값 없음
     */
    public static final String NONE_VALUE = "NONE";
    /**
     * 카탈로그 타입 스타터
     */
    public static final String CATALOG_TYPE_STARTER = "starter";
    /**
     * 카탈로그 타입 빌드팩
     */
    public static final String CATALOG_TYPE_BUILD_PACK = "buildPack";
    /**
     * 카탈로그 타입 서비스팩
     */
    public static final String CATALOG_TYPE_SERVICE_PACK = "servicePack";
    /**
     * 내 문의 상태 대기
     */
    public static final String MY_QUESTION_STATUS_WAITING = "waiting";
}
