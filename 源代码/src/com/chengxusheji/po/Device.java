package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Device {
    /*设备编号*/
    @NotEmpty(message="设备编号不能为空")
    private String deviceNo;
    public String getDeviceNo(){
        return deviceNo;
    }
    public void setDeviceNo(String deviceNo){
        this.deviceNo = deviceNo;
    }

    /*设备类别*/
    private DeviceClass deviceClassObj;
    public DeviceClass getDeviceClassObj() {
        return deviceClassObj;
    }
    public void setDeviceClassObj(DeviceClass deviceClassObj) {
        this.deviceClassObj = deviceClassObj;
    }

    /*设备名称*/
    @NotEmpty(message="设备名称不能为空")
    private String deviceName;
    public String getDeviceName() {
        return deviceName;
    }
    public void setDeviceName(String deviceName) {
        this.deviceName = deviceName;
    }

    /*设备照片*/
    private String devicePhoto;
    public String getDevicePhoto() {
        return devicePhoto;
    }
    public void setDevicePhoto(String devicePhoto) {
        this.devicePhoto = devicePhoto;
    }

    /*设备库存*/
    @NotNull(message="必须输入设备库存")
    private Integer deviceCount;
    public Integer getDeviceCount() {
        return deviceCount;
    }
    public void setDeviceCount(Integer deviceCount) {
        this.deviceCount = deviceCount;
    }

    /*设备说明*/
    @NotEmpty(message="设备说明不能为空")
    private String deviceDesc;
    public String getDeviceDesc() {
        return deviceDesc;
    }
    public void setDeviceDesc(String deviceDesc) {
        this.deviceDesc = deviceDesc;
    }

    /*发布时间*/
    @NotEmpty(message="发布时间不能为空")
    private String addTime;
    public String getAddTime() {
        return addTime;
    }
    public void setAddTime(String addTime) {
        this.addTime = addTime;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonDevice=new JSONObject(); 
		jsonDevice.accumulate("deviceNo", this.getDeviceNo());
		jsonDevice.accumulate("deviceClassObj", this.getDeviceClassObj().getDeviceClassName());
		jsonDevice.accumulate("deviceClassObjPri", this.getDeviceClassObj().getDeviceClassId());
		jsonDevice.accumulate("deviceName", this.getDeviceName());
		jsonDevice.accumulate("devicePhoto", this.getDevicePhoto());
		jsonDevice.accumulate("deviceCount", this.getDeviceCount());
		jsonDevice.accumulate("deviceDesc", this.getDeviceDesc());
		jsonDevice.accumulate("addTime", this.getAddTime().length()>19?this.getAddTime().substring(0,19):this.getAddTime());
		return jsonDevice;
    }}