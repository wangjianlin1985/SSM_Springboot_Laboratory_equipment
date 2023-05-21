package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Scrap {
    /*报废id*/
    private Integer scrapId;
    public Integer getScrapId(){
        return scrapId;
    }
    public void setScrapId(Integer scrapId){
        this.scrapId = scrapId;
    }

    /*报废的设备*/
    private Device deviceObj;
    public Device getDeviceObj() {
        return deviceObj;
    }
    public void setDeviceObj(Device deviceObj) {
        this.deviceObj = deviceObj;
    }

    /*报废数量*/
    @NotNull(message="必须输入报废数量")
    private Integer scrapCount;
    public Integer getScrapCount() {
        return scrapCount;
    }
    public void setScrapCount(Integer scrapCount) {
        this.scrapCount = scrapCount;
    }

    /*报废原因*/
    @NotEmpty(message="报废原因不能为空")
    private String reason;
    public String getReason() {
        return reason;
    }
    public void setReason(String reason) {
        this.reason = reason;
    }

    /*报废日期*/
    @NotEmpty(message="报废日期不能为空")
    private String scrapDate;
    public String getScrapDate() {
        return scrapDate;
    }
    public void setScrapDate(String scrapDate) {
        this.scrapDate = scrapDate;
    }

    /*报废备注*/
    private String scrapMemo;
    public String getScrapMemo() {
        return scrapMemo;
    }
    public void setScrapMemo(String scrapMemo) {
        this.scrapMemo = scrapMemo;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonScrap=new JSONObject(); 
		jsonScrap.accumulate("scrapId", this.getScrapId());
		jsonScrap.accumulate("deviceObj", this.getDeviceObj().getDeviceName());
		jsonScrap.accumulate("deviceObjPri", this.getDeviceObj().getDeviceNo());
		jsonScrap.accumulate("scrapCount", this.getScrapCount());
		jsonScrap.accumulate("reason", this.getReason());
		jsonScrap.accumulate("scrapDate", this.getScrapDate().length()>19?this.getScrapDate().substring(0,19):this.getScrapDate());
		jsonScrap.accumulate("scrapMemo", this.getScrapMemo());
		return jsonScrap;
    }}