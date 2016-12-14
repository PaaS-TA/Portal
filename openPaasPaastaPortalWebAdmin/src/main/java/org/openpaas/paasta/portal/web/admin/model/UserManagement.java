package org.openpaas.paasta.portal.web.admin.model;

/**
 * org.openpaas.paasta.portal.web.admin.model
 *
 * @author rex
 * @version 1.0
 * @since 2016.08.31
 */
public class UserManagement {

    private String userId;
    private String userGuid;
    private String status;
    private String statusValue;
    private String tellPhone;
    private String zipCode;
    private String address;
    private String addressDetail;
    private String userName;
    private String adminYn;
    private String refreshToken;

    private int pageNo;
    private int pageSize;
    private String searchKeyword;
    private int totalCount;

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getUserGuid() {
        return userGuid;
    }

    public void setUserGuid(String userGuid) {
        this.userGuid = userGuid;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getStatusValue() {
        return statusValue;
    }

    public void setStatusValue(String statusValue) {
        this.statusValue = statusValue;
    }

    public String getTellPhone() {
        return tellPhone;
    }

    public void setTellPhone(String tellPhone) {
        this.tellPhone = tellPhone;
    }

    public String getZipCode() {
        return zipCode;
    }

    public void setZipCode(String zipCode) {
        this.zipCode = zipCode;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getAddressDetail() {
        return addressDetail;
    }

    public void setAddressDetail(String addressDetail) {
        this.addressDetail = addressDetail;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getAdminYn() {
        return adminYn;
    }

    public void setAdminYn(String adminYn) {
        this.adminYn = adminYn;
    }

    public String getRefreshToken() {
        return refreshToken;
    }

    public void setRefreshToken(String refreshToken) {
        this.refreshToken = refreshToken;
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

    public String getSearchKeyword() {
        return searchKeyword;
    }

    public void setSearchKeyword(String searchKeyword) {
        this.searchKeyword = searchKeyword;
    }

    public int getTotalCount() {
        return totalCount;
    }

    public void setTotalCount(int totalCount) {
        this.totalCount = totalCount;
    }

    @Override
    public String toString() {
        return "UserManagement{" +
                "userId='" + userId + '\'' +
                ", userGuid='" + userGuid + '\'' +
                ", status='" + status + '\'' +
                ", statusValue='" + statusValue + '\'' +
                ", tellPhone='" + tellPhone + '\'' +
                ", zipCode='" + zipCode + '\'' +
                ", address='" + address + '\'' +
                ", addressDetail='" + addressDetail + '\'' +
                ", userName='" + userName + '\'' +
                ", adminYn='" + adminYn + '\'' +
                ", refreshToken='" + refreshToken + '\'' +
                ", pageNo=" + pageNo +
                ", pageSize=" + pageSize +
                ", searchKeyword='" + searchKeyword + '\'' +
                ", totalCount=" + totalCount +
                '}';
    }
}
