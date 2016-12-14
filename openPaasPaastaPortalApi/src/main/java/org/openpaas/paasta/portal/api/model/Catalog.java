package org.openpaas.paasta.portal.api.model;

import java.util.List;
import java.util.UUID;

/**
 * org.openpaas.paasta.portal.api.model
 *
 * @author rex
 * @version 1.0
 * @since 2016.07.04
 */
public class Catalog {

    private int no;
    private String name;
    private String classification;
    private String classificationValue;
    private String classificationSummary;
    private String summary;
    private String description;
    private String thumbImgName;
    private String thumbImgPath;
    private String useYn;
    private String userId;
    private String created;
    private String lastModified;
    private String buildPackName;
    private String servicePackName;
    private int starterCategoryNo;
    private int servicePackCategoryNo;
    private int buildPackCategoryNo;

    private String searchKeyword;
    private String searchTypeColumn;
    private String searchTypeUseYn;

    private List<Integer> servicePackCategoryNoList;

    private int catalogNo;
    private String catalogType;
    private String servicePlan;
    private String appName;
    private String orgName;
    private String spaceName;
    private String serviceInstanceName;

    private UUID appGuid;
    private UUID serviceInstanceGuid;

    private List<Catalog> servicePlanList;

    private int limitSize;

    private String hostName;
    private String domainName;
    private String routeName;

    private String appSampleStartYn;
    private String appSampleFileName;
    private String appSampleFilePath;
    private int appSampleFileSize;
    private String appBindYn;

    private String parameter;
    private int diskSize;
    private int MemorySize;

    public int getNo() {
        return this.no;
    }

    public void setNo(int no) {
        this.no = no;
    }

    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getClassification() {
        return this.classification;
    }

    public void setClassification(String classification) {
        this.classification = classification;
    }

    public String getClassificationValue() {
        return this.classificationValue;
    }

    public void setClassificationValue(String classificationValue) {
        this.classificationValue = classificationValue;
    }

    public String getClassificationSummary() {
        return this.classificationSummary;
    }

    public void setClassificationSummary(String classificationSummary) {
        this.classificationSummary = classificationSummary;
    }

    public String getSummary() {
        return this.summary;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }

    public String getDescription() {
        return this.description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getThumbImgName() {
        return this.thumbImgName;
    }

    public void setThumbImgName(String thumbImgName) {
        this.thumbImgName = thumbImgName;
    }

    public String getThumbImgPath() {
        return this.thumbImgPath;
    }

    public void setThumbImgPath(String thumbImgPath) {
        this.thumbImgPath = thumbImgPath;
    }

    public String getUseYn() {
        return this.useYn;
    }

    public void setUseYn(String useYn) {
        this.useYn = useYn;
    }

    public String getUserId() {
        return this.userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getCreated() {
        return this.created;
    }

    public void setCreated(String created) {
        this.created = created;
    }

    public String getLastModified() {
        return this.lastModified;
    }

    public void setLastModified(String lastModified) {
        this.lastModified = lastModified;
    }

    public String getBuildPackName() {
        return this.buildPackName;
    }

    public void setBuildPackName(String buildPackName) {
        this.buildPackName = buildPackName;
    }

    public String getServicePackName() {
        return this.servicePackName;
    }

    public void setServicePackName(String servicePackName) {
        this.servicePackName = servicePackName;
    }

    public int getStarterCategoryNo() {
        return this.starterCategoryNo;
    }

    public void setStarterCategoryNo(int starterCategoryNo) {
        this.starterCategoryNo = starterCategoryNo;
    }

    public int getServicePackCategoryNo() {
        return this.servicePackCategoryNo;
    }

    public void setServicePackCategoryNo(int servicePackCategoryNo) {
        this.servicePackCategoryNo = servicePackCategoryNo;
    }

    public int getBuildPackCategoryNo() {
        return this.buildPackCategoryNo;
    }

    public void setBuildPackCategoryNo(int buildPackCategoryNo) {
        this.buildPackCategoryNo = buildPackCategoryNo;
    }

    public String getSearchKeyword() {
        return this.searchKeyword;
    }

    public void setSearchKeyword(String searchKeyword) {
        this.searchKeyword = searchKeyword;
    }

    public String getSearchTypeColumn() {
        return this.searchTypeColumn;
    }

    public void setSearchTypeColumn(String searchTypeColumn) {
        this.searchTypeColumn = searchTypeColumn;
    }

    public String getSearchTypeUseYn() {
        return this.searchTypeUseYn;
    }

    public void setSearchTypeUseYn(String searchTypeUseYn) {
        this.searchTypeUseYn = searchTypeUseYn;
    }

    public List<Integer> getServicePackCategoryNoList() {
        return this.servicePackCategoryNoList;
    }

    public void setServicePackCategoryNoList(List<Integer> servicePackCategoryNoList) {
        this.servicePackCategoryNoList = servicePackCategoryNoList;
    }

    public int getCatalogNo() {
        return this.catalogNo;
    }

    public void setCatalogNo(int catalogNo) {
        this.catalogNo = catalogNo;
    }

    public String getCatalogType() {
        return this.catalogType;
    }

    public void setCatalogType(String catalogType) {
        this.catalogType = catalogType;
    }

    public String getServicePlan() {
        return this.servicePlan;
    }

    public void setServicePlan(String servicePlan) {
        this.servicePlan = servicePlan;
    }

    public String getAppName() {
        return this.appName;
    }

    public void setAppName(String appName) {
        this.appName = appName;
    }

    public String getOrgName() {
        return this.orgName;
    }

    public void setOrgName(String orgName) {
        this.orgName = orgName;
    }

    public String getSpaceName() {
        return this.spaceName;
    }

    public void setSpaceName(String spaceName) {
        this.spaceName = spaceName;
    }

    public String getServiceInstanceName() {
        return this.serviceInstanceName;
    }

    public void setServiceInstanceName(String serviceInstanceName) {
        this.serviceInstanceName = serviceInstanceName;
    }

    public UUID getAppGuid() {
        return this.appGuid;
    }

    public void setAppGuid(UUID appGuid) {
        this.appGuid = appGuid;
    }

    public UUID getServiceInstanceGuid() {
        return this.serviceInstanceGuid;
    }

    public void setServiceInstanceGuid(UUID serviceInstanceGuid) {
        this.serviceInstanceGuid = serviceInstanceGuid;
    }

    public List<Catalog> getServicePlanList() {
        return this.servicePlanList;
    }

    public void setServicePlanList(List<Catalog> servicePlanList) {
        this.servicePlanList = servicePlanList;
    }

    public int getLimitSize() {
        return this.limitSize;
    }

    public void setLimitSize(int limitSize) {
        this.limitSize = limitSize;
    }

    public String getHostName() {
        return this.hostName;
    }

    public void setHostName(String hostName) {
        this.hostName = hostName;
    }

    public String getDomainName() {
        return this.domainName;
    }

    public void setDomainName(String domainName) {
        this.domainName = domainName;
    }

    public String getRouteName() {
        return this.routeName;
    }

    public void setRouteName(String routeName) {
        this.routeName = routeName;
    }

    public String getAppSampleStartYn() {
        return this.appSampleStartYn;
    }

    public void setAppSampleStartYn(String appSampleStartYn) {
        this.appSampleStartYn = appSampleStartYn;
    }

    public String getAppSampleFileName() {
        return this.appSampleFileName;
    }

    public void setAppSampleFileName(String appSampleFileName) {
        this.appSampleFileName = appSampleFileName;
    }

    public String getAppSampleFilePath() {
        return this.appSampleFilePath;
    }

    public void setAppSampleFilePath(String appSampleFilePath) {
        this.appSampleFilePath = appSampleFilePath;
    }

    public int getAppSampleFileSize() {
        return this.appSampleFileSize;
    }

    public void setAppSampleFileSize(int appSampleFileSize) {
        this.appSampleFileSize = appSampleFileSize;
    }

    public String getAppBindYn() {
        return this.appBindYn;
    }

    public void setAppBindYn(String appBindYn) {
        this.appBindYn = appBindYn;
    }

    public String getParameter() {
        return this.parameter;
    }

    public void setParameter(String parameter) {
        this.parameter = parameter;
    }

    public int getDiskSize() {
        return this.diskSize;
    }

    public void setDiskSize(int diskSize) {
        this.diskSize = diskSize;
    }

    public int getMemorySize() {
        return this.MemorySize;
    }

    public void setMemorySize(int memorySize) {
        this.MemorySize = memorySize;
    }

    @Override
    public String toString() {
        return "Catalog{" +
                "no=" + no +
                ", name='" + name + '\'' +
                ", classification='" + classification + '\'' +
                ", classificationValue='" + classificationValue + '\'' +
                ", classificationSummary='" + classificationSummary + '\'' +
                ", summary='" + summary + '\'' +
                ", description='" + description + '\'' +
                ", thumbImgName='" + thumbImgName + '\'' +
                ", thumbImgPath='" + thumbImgPath + '\'' +
                ", useYn='" + useYn + '\'' +
                ", userId='" + userId + '\'' +
                ", created='" + created + '\'' +
                ", lastModified='" + lastModified + '\'' +
                ", buildPackName='" + buildPackName + '\'' +
                ", servicePackName='" + servicePackName + '\'' +
                ", starterCategoryNo=" + starterCategoryNo +
                ", servicePackCategoryNo=" + servicePackCategoryNo +
                ", buildPackCategoryNo=" + buildPackCategoryNo +
                ", searchKeyword='" + searchKeyword + '\'' +
                ", searchTypeColumn='" + searchTypeColumn + '\'' +
                ", searchTypeUseYn='" + searchTypeUseYn + '\'' +
                ", servicePackCategoryNoList=" + servicePackCategoryNoList +
                ", catalogNo=" + catalogNo +
                ", catalogType='" + catalogType + '\'' +
                ", servicePlan='" + servicePlan + '\'' +
                ", appName='" + appName + '\'' +
                ", orgName='" + orgName + '\'' +
                ", spaceName='" + spaceName + '\'' +
                ", serviceInstanceName='" + serviceInstanceName + '\'' +
                ", appGuid=" + appGuid +
                ", serviceInstanceGuid=" + serviceInstanceGuid +
                ", servicePlanList=" + servicePlanList +
                ", limitSize=" + limitSize +
                ", hostName='" + hostName + '\'' +
                ", domainName='" + domainName + '\'' +
                ", routeName='" + routeName + '\'' +
                ", appSampleStartYn='" + appSampleStartYn + '\'' +
                ", appSampleFileName='" + appSampleFileName + '\'' +
                ", appSampleFilePath='" + appSampleFilePath + '\'' +
                ", appSampleFileSize=" + appSampleFileSize +
                ", appBindYn='" + appBindYn + '\'' +
                ", parameter='" + parameter + '\'' +
                ", diskSize=" + diskSize +
                ", MemorySize=" + MemorySize +
                '}';
    }
}
