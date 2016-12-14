package org.openpaas.paasta.portal.web.admin.model;

import java.util.List;

/**
 * org.openpaas.paasta.portal.web.admin.model
 *
 * @author rex
 * @version 1.0
 * @since 2016.06.17
 */
public class CommonCode {

    private String id;
    private String orgId;
    private String name;
    private String key;
    private String orgKey;
    private String value;
    private String groupId;
    private String useYn;
    private int order;
    private String summary;
    private String userId;
    private String created;
    private String lastModified;

    private String procType;
    private int pageNo;
    private int pageSize;

    private String searchType;
    private String searchKeyword;

    private String reqCud;
    private List<CommonCode> commonCodeList;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getOrgId() {
        return orgId;
    }

    public void setOrgId(String orgId) {
        this.orgId = orgId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public String getOrgKey() {
        return orgKey;
    }

    public void setOrgKey(String orgKey) {
        this.orgKey = orgKey;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public String getGroupId() {
        return groupId;
    }

    public void setGroupId(String groupId) {
        this.groupId = groupId;
    }

    public String getUseYn() {
        return useYn;
    }

    public void setUseYn(String useYn) {
        this.useYn = useYn;
    }

    public int getOrder() {
        return order;
    }

    public void setOrder(int order) {
        this.order = order;
    }

    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getCreated() {
        return created;
    }

    public void setCreated(String created) {
        this.created = created;
    }

    public String getLastModified() {
        return lastModified;
    }

    public void setLastModified(String lastModified) {
        this.lastModified = lastModified;
    }

    public String getProcType() {
        return procType;
    }

    public void setProcType(String procType) {
        this.procType = procType;
    }

    public int getPageNo() {
        return pageNo;
    }

    public void setPageNo(int pageNo) {
        this.pageNo = pageNo;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public String getSearchType() {
        return searchType;
    }

    public void setSearchType(String searchType) {
        this.searchType = searchType;
    }

    public String getSearchKeyword() {
        return searchKeyword;
    }

    public void setSearchKeyword(String searchKeyword) {
        this.searchKeyword = searchKeyword;
    }

    public String getReqCud() {
        return reqCud;
    }

    public void setReqCud(String reqCud) {
        this.reqCud = reqCud;
    }

    public List<CommonCode> getCommonCodeList() {
        return commonCodeList;
    }

    public void setCommonCodeList(List<CommonCode> commonCodeList) {
        this.commonCodeList = commonCodeList;
    }

    @Override
    public String toString() {
        return "CommonCode{" +
                "id='" + id + '\'' +
                ", orgId='" + orgId + '\'' +
                ", name='" + name + '\'' +
                ", key='" + key + '\'' +
                ", orgKey='" + orgKey + '\'' +
                ", value='" + value + '\'' +
                ", groupId='" + groupId + '\'' +
                ", useYn='" + useYn + '\'' +
                ", order=" + order +
                ", summary='" + summary + '\'' +
                ", userId='" + userId + '\'' +
                ", created='" + created + '\'' +
                ", lastModified='" + lastModified + '\'' +
                ", procType='" + procType + '\'' +
                ", pageNo=" + pageNo +
                ", pageSize=" + pageSize +
                ", searchType='" + searchType + '\'' +
                ", searchKeyword='" + searchKeyword + '\'' +
                ", reqCud='" + reqCud + '\'' +
                ", commonCodeList=" + commonCodeList +
                '}';
    }
}
