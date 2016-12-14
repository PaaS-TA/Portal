package org.openpaas.paasta.portal.web.admin.model;

/**
 * org.openpaas.paasta.portal.web.admin.model
 *
 * @author rex
 * @version 1.0
 * @since 2016.09.08
 */
public class AdminMain {

    private int organizationId;
    private String organizationName;
    private int spaceId;
    private String spaceName;
    private int organizationCount;
    private int spaceCount;
    private int applicationCount;
    private int userCount;

    public int getOrganizationId() {
        return organizationId;
    }

    public void setOrganizationId(int organizationId) {
        this.organizationId = organizationId;
    }

    public String getOrganizationName() {
        return organizationName;
    }

    public void setOrganizationName(String organizationName) {
        this.organizationName = organizationName;
    }

    public int getSpaceId() {
        return spaceId;
    }

    public void setSpaceId(int spaceId) {
        this.spaceId = spaceId;
    }

    public String getSpaceName() {
        return spaceName;
    }

    public void setSpaceName(String spaceName) {
        this.spaceName = spaceName;
    }

    public int getOrganizationCount() {
        return organizationCount;
    }

    public void setOrganizationCount(int organizationCount) {
        this.organizationCount = organizationCount;
    }

    public int getSpaceCount() {
        return spaceCount;
    }

    public void setSpaceCount(int spaceCount) {
        this.spaceCount = spaceCount;
    }

    public int getApplicationCount() {
        return applicationCount;
    }

    public void setApplicationCount(int applicationCount) {
        this.applicationCount = applicationCount;
    }

    public int getUserCount() {
        return userCount;
    }

    public void setUserCount(int userCount) {
        this.userCount = userCount;
    }

    @Override
    public String toString() {
        return "AdminMain{" +
                "organizationId=" + organizationId +
                ", organizationName='" + organizationName + '\'' +
                ", spaceId=" + spaceId +
                ", spaceName='" + spaceName + '\'' +
                ", organizationCount=" + organizationCount +
                ", spaceCount=" + spaceCount +
                ", applicationCount=" + applicationCount +
                ", userCount=" + userCount +
                '}';
    }
}
