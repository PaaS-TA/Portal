package org.openpaas.paasta.portal.web.user.model;

import java.util.Map;

/**
 * User 정보를 담고 있는 Model 클래스
 * @author 조민구
 * @version 1.0
 * @since 2016-05-19
 */
public class User {
    private String userId;

    private String password;
    private String userName;
    private String status;
    private String tellPhone;
    private String zipCode;
    private String address;
    private String addressDetail;
    private String adminYn;
    private int count;
    private String refreshToken;

	/**
	 * User 클래스의 기본 생성자
	 */
	public User() {
        //empty
    }

	/**
	 * User 정보를 담고 있는 Map 을 입력받아 User 객체를 만드는 생성자
	 * @param user User 정보를 담고 있는 Map
	 */
	public User(Map user) {
        this.userId = (user.containsKey("userId")) ? (String) user.get("userId") : null;
        this.userName = (user.containsKey("userName")) ? (String) user.get("userName") : null;
        this.password = (user.containsKey("password")) ? (String) user.get("password") : null;
        this.status = (user.containsKey("status")) ? (String) user.get("status") : null;
        this.addressDetail = (user.containsKey("addressDetail")) ? (String) user.get("addressDetail") : null;
        this.address = (user.containsKey("address")) ? (String) user.get("address") : null;
        this.tellPhone = (user.containsKey("tellPhone")) ? (String) user.get("tellPhone") : null;
        this.zipCode = (user.containsKey("zipCode")) ? (String) user.get("zipCode") : null;
        this.adminYn = (user.containsKey("adminYn")) ? (String) user.get("adminYn") : null;
        this.refreshToken = (user.containsKey("refreshToken")) ? (String) user.get("refreshToken") : null;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
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

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
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

    public String getPassword() {
        return password;
    }

}
