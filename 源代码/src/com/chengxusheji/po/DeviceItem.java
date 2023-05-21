package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class DeviceItem {
    /*记录id*/
    private Integer deviceItemId;
    public Integer getDeviceItemId(){
        return deviceItemId;
    }
    public void setDeviceItemId(Integer deviceItemId){
        this.deviceItemId = deviceItemId;
    }

    /*实验名称*/
    private Shiyan shiyanObj;
    public Shiyan getShiyanObj() {
        return shiyanObj;
    }
    public void setShiyanObj(Shiyan shiyanObj) {
        this.shiyanObj = shiyanObj;
    }

    /*所需设备*/
    private Device deviceObj;
    public Device getDeviceObj() {
        return deviceObj;
    }
    public void setDeviceObj(Device deviceObj) {
        this.deviceObj = deviceObj;
    }

    /*所需数量*/
    @NotNull(message="必须输入所需数量")
    private Integer deviceCount;
    public Integer getDeviceCount() {
        return deviceCount;
    }
    public void setDeviceCount(Integer deviceCount) {
        this.deviceCount = deviceCount;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonDeviceItem=new JSONObject(); 
		jsonDeviceItem.accumulate("deviceItemId", this.getDeviceItemId());
		jsonDeviceItem.accumulate("shiyanObj", this.getShiyanObj().getShiyanName());
		jsonDeviceItem.accumulate("shiyanObjPri", this.getShiyanObj().getShiyanId());
		jsonDeviceItem.accumulate("deviceObj", this.getDeviceObj().getDeviceName());
		jsonDeviceItem.accumulate("deviceObjPri", this.getDeviceObj().getDeviceNo());
		jsonDeviceItem.accumulate("deviceCount", this.getDeviceCount());
		return jsonDeviceItem;
    }}