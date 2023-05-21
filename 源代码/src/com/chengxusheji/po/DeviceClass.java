package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class DeviceClass {
    /*设备类别id*/
    private Integer deviceClassId;
    public Integer getDeviceClassId(){
        return deviceClassId;
    }
    public void setDeviceClassId(Integer deviceClassId){
        this.deviceClassId = deviceClassId;
    }

    /*设备类别名称*/
    @NotEmpty(message="设备类别名称不能为空")
    private String deviceClassName;
    public String getDeviceClassName() {
        return deviceClassName;
    }
    public void setDeviceClassName(String deviceClassName) {
        this.deviceClassName = deviceClassName;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonDeviceClass=new JSONObject(); 
		jsonDeviceClass.accumulate("deviceClassId", this.getDeviceClassId());
		jsonDeviceClass.accumulate("deviceClassName", this.getDeviceClassName());
		return jsonDeviceClass;
    }}