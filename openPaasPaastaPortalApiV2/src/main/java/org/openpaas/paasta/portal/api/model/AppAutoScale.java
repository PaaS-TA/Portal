package org.openpaas.paasta.portal.api.model;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

import java.util.Map;

/**
 * 클래스 설명
 *
 * @author injeong
 * @version 1.0
 * @since 2016.7.01 최초작성
 */
@JsonIgnoreProperties(ignoreUnknown = true)
public class AppAutoScale {
    private int no;
    private String guid;

    private String name;

    private String useYn;
    private int instanceMinCnt;

    private int instanceMaxCnt;
    private Map<String, Object> map;


    private double cpuThresholdMinPer;

    private double cpuThresholdMaxPer;

    private int checkTimeSec;
    public AppAutoScale() {

    }

    public int getNo() {
        return no;
    }

    public void setNo(int no) {
        this.no = no;
    }

    public String getGuid() {
        return guid;
    }

    public void setGuid(String guid) {
        this.guid = guid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUseYn() {
        return useYn;
    }

    public void setUseYn(String useYn) {
        this.useYn = useYn;
    }

    public int getInstanceMinCnt() {
        return instanceMinCnt;
    }

    public void setInstanceMinCnt(int instanceMinCnt) {
        this.instanceMinCnt = instanceMinCnt;
    }

    public int getInstanceMaxCnt() {
        return instanceMaxCnt;
    }

    public void setInstanceMaxCnt(int instanceMaxCnt) {
        this.instanceMaxCnt = instanceMaxCnt;
    }

    public Map<String, Object> getMap() {
        return map;
    }

    public void setMap(Map<String, Object> map) {
        this.map = map;
    }

    public double getCheckTimeSec() {
        return checkTimeSec;
    }

    public void setCheckTimeSec(int checkTimeSec) {
        this.checkTimeSec = checkTimeSec;
    }

    public double getCpuThresholdMaxPer() {
        return cpuThresholdMaxPer;
    }

    public void setCpu_threshold_max_per(double cpuThresholdMaxPer) {
        this.cpuThresholdMaxPer = cpuThresholdMaxPer;
    }

    public double getCpuThresholdMinPer() {
        return cpuThresholdMinPer;
    }

    public void setCpuThresholdMinPer(double cpuThresholdMinPer) {
        this.cpuThresholdMinPer = cpuThresholdMinPer;
    }

}
