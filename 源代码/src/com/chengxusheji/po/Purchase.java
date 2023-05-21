package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Purchase {
    /*采购id*/
    private Integer purchaseId;
    public Integer getPurchaseId(){
        return purchaseId;
    }
    public void setPurchaseId(Integer purchaseId){
        this.purchaseId = purchaseId;
    }

    /*采购设备*/
    private Device deviceObj;
    public Device getDeviceObj() {
        return deviceObj;
    }
    public void setDeviceObj(Device deviceObj) {
        this.deviceObj = deviceObj;
    }

    /*供应商*/
    @NotEmpty(message="供应商不能为空")
    private String supplier;
    public String getSupplier() {
        return supplier;
    }
    public void setSupplier(String supplier) {
        this.supplier = supplier;
    }

    /*采购数量*/
    @NotNull(message="必须输入采购数量")
    private Integer purchaseCount;
    public Integer getPurchaseCount() {
        return purchaseCount;
    }
    public void setPurchaseCount(Integer purchaseCount) {
        this.purchaseCount = purchaseCount;
    }

    /*采购单价*/
    @NotNull(message="必须输入采购单价")
    private Float price;
    public Float getPrice() {
        return price;
    }
    public void setPrice(Float price) {
        this.price = price;
    }

    /*采购日期*/
    @NotEmpty(message="采购日期不能为空")
    private String purchaseDate;
    public String getPurchaseDate() {
        return purchaseDate;
    }
    public void setPurchaseDate(String purchaseDate) {
        this.purchaseDate = purchaseDate;
    }

    /*采购人*/
    private UserInfo userObj;
    public UserInfo getUserObj() {
        return userObj;
    }
    public void setUserObj(UserInfo userObj) {
        this.userObj = userObj;
    }

    /*采购备注*/
    private String purchaseMemo;
    public String getPurchaseMemo() {
        return purchaseMemo;
    }
    public void setPurchaseMemo(String purchaseMemo) {
        this.purchaseMemo = purchaseMemo;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonPurchase=new JSONObject(); 
		jsonPurchase.accumulate("purchaseId", this.getPurchaseId());
		jsonPurchase.accumulate("deviceObj", this.getDeviceObj().getDeviceName());
		jsonPurchase.accumulate("deviceObjPri", this.getDeviceObj().getDeviceNo());
		jsonPurchase.accumulate("supplier", this.getSupplier());
		jsonPurchase.accumulate("purchaseCount", this.getPurchaseCount());
		jsonPurchase.accumulate("price", this.getPrice());
		jsonPurchase.accumulate("purchaseDate", this.getPurchaseDate().length()>19?this.getPurchaseDate().substring(0,19):this.getPurchaseDate());
		jsonPurchase.accumulate("userObj", this.getUserObj().getName());
		jsonPurchase.accumulate("userObjPri", this.getUserObj().getUser_name());
		jsonPurchase.accumulate("purchaseMemo", this.getPurchaseMemo());
		return jsonPurchase;
    }}