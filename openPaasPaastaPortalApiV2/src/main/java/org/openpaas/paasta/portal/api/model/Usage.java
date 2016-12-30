package org.openpaas.paasta.portal.api.model;

/**
 * org.openpaas.paasta.portal.api.model
 *
 * @author 김도준
 * @version 1.0
 * @since 2016.09.22
 */
public class Usage {

    private String orgName;
    private String spaceName;

    private String orgGuid;
    private String fromMonth;
    private String toMonth;
    private int searchPeriodSum;
    private String monthlyUsageArr;
    private String month;
    private int monthlySum;
    private String spaces;
    private String spaceGuid;
    private String spaceSum;
    private String appUsageArr;
    private String appGuid;
    private String appName;
    private int appInstance;
    private String appMemory;
    private int appUsage;

    public String getOrgName() {
        return orgName;
    }

    public void setOrgName(String orgName) {
        this.orgName = orgName;
    }

    public String getSpaceName() {
        return spaceName;
    }

    public void setSpaceName(String spaceName) {
        this.spaceName = spaceName;
    }

    public String getOrgGuid() {
        return orgGuid;
    }

    public void setOrgGuid(String orgGuid) {
        this.orgGuid = orgGuid;
    }

    public String getFromMonth() {
        return fromMonth;
    }

    public void setFromMonth(String fromMonth) {
        this.fromMonth = fromMonth;
    }

    public String getToMonth() {
        return toMonth;
    }

    public void setToMonth(String toMonth) {
        this.toMonth = toMonth;
    }

    public int getSearchPeriodSum() {
        return searchPeriodSum;
    }

    public void setSearchPeriodSum(int searchPeriodSum) {
        this.searchPeriodSum = searchPeriodSum;
    }

    public String getMonthlyUsageArr() {
        return monthlyUsageArr;
    }

    public void setMonthlyUsageArr(String monthlyUsageArr) {
        this.monthlyUsageArr = monthlyUsageArr;
    }

    public String getMonth() {
        return month;
    }

    public void setMonth(String month) {
        this.month = month;
    }

    public int getMonthlySum() {
        return monthlySum;
    }

    public void setMonthlySum(int monthlySum) {
        this.monthlySum = monthlySum;
    }

    public String getSpaces() {
        return spaces;
    }

    public void setSpaces(String spaces) {
        this.spaces = spaces;
    }

    public String getSpaceGuid() {
        return spaceGuid;
    }

    public void setSpaceGuid(String spaceGuid) {
        this.spaceGuid = spaceGuid;
    }

    public String getSpaceSum() {
        return spaceSum;
    }

    public void setSpaceSum(String spaceSum) {
        this.spaceSum = spaceSum;
    }

    public String getAppUsageArr() {
        return appUsageArr;
    }

    public void setAppUsageArr(String appUsageArr) {
        this.appUsageArr = appUsageArr;
    }

    public String getAppGuid() {
        return appGuid;
    }

    public void setAppGuid(String appGuid) {
        this.appGuid = appGuid;
    }

    public String getAppName() {
        return appName;
    }

    public void setAppName(String appName) {
        this.appName = appName;
    }

    public int getAppInstance() {
        return appInstance;
    }

    public void setAppInstance(int appInstance) {
        this.appInstance = appInstance;
    }

    public String getAppMemory() {
        return appMemory;
    }

    public void setAppMemory(String appMemory) {
        this.appMemory = appMemory;
    }

    public int getAppUsage() {
        return appUsage;
    }

    public void setAppUsage(int appUsage) {
        this.appUsage = appUsage;
    }

    @Override
    public String toString() {
        return "Usage{" +
                "orgName='" + orgName + '\'' +
                ", spaceName='" + spaceName + '\'' +
                ", orgGuid='" + orgGuid + '\'' +
                ", fromMonth='" + fromMonth + '\'' +
                ", toMonth='" + toMonth + '\'' +
                ", searchPeriodSum=" + searchPeriodSum +
                ", monthlyUsageArr='" + monthlyUsageArr + '\'' +
                ", month='" + month + '\'' +
                ", monthlySum=" + monthlySum +
                ", spaces='" + spaces + '\'' +
                ", spaceGuid='" + spaceGuid + '\'' +
                ", spaceSum='" + spaceSum + '\'' +
                ", appUsageArr='" + appUsageArr + '\'' +
                ", appGuid='" + appGuid + '\'' +
                ", appName='" + appName + '\'' +
                ", appInstance=" + appInstance +
                ", appMemory='" + appMemory + '\'' +
                ", appUsage=" + appUsage +
                '}';
    }
}
