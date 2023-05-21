package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Shiyan {
    /*实验id*/
    private Integer shiyanId;
    public Integer getShiyanId(){
        return shiyanId;
    }
    public void setShiyanId(Integer shiyanId){
        this.shiyanId = shiyanId;
    }

    /*实验名称*/
    @NotEmpty(message="实验名称不能为空")
    private String shiyanName;
    public String getShiyanName() {
        return shiyanName;
    }
    public void setShiyanName(String shiyanName) {
        this.shiyanName = shiyanName;
    }

    /*实验时间*/
    @NotEmpty(message="实验时间不能为空")
    private String shiyanTime;
    public String getShiyanTime() {
        return shiyanTime;
    }
    public void setShiyanTime(String shiyanTime) {
        this.shiyanTime = shiyanTime;
    }

    /*实验内容*/
    @NotEmpty(message="实验内容不能为空")
    private String shiyanContent;
    public String getShiyanContent() {
        return shiyanContent;
    }
    public void setShiyanContent(String shiyanContent) {
        this.shiyanContent = shiyanContent;
    }

    /*实验状态*/
    private ShiyanState shiyanStateObj;
    public ShiyanState getShiyanStateObj() {
        return shiyanStateObj;
    }
    public void setShiyanStateObj(ShiyanState shiyanStateObj) {
        this.shiyanStateObj = shiyanStateObj;
    }

    /*组长姓名*/
    private Zuzhang zuzhangObj;
    public Zuzhang getZuzhangObj() {
        return zuzhangObj;
    }
    public void setZuzhangObj(Zuzhang zuzhangObj) {
        this.zuzhangObj = zuzhangObj;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonShiyan=new JSONObject(); 
		jsonShiyan.accumulate("shiyanId", this.getShiyanId());
		jsonShiyan.accumulate("shiyanName", this.getShiyanName());
		jsonShiyan.accumulate("shiyanTime", this.getShiyanTime().length()>19?this.getShiyanTime().substring(0,19):this.getShiyanTime());
		jsonShiyan.accumulate("shiyanContent", this.getShiyanContent());
		jsonShiyan.accumulate("shiyanStateObj", this.getShiyanStateObj().getShiyanStateName());
		jsonShiyan.accumulate("shiyanStateObjPri", this.getShiyanStateObj().getShiyanStateId());
		jsonShiyan.accumulate("zuzhangObj", this.getZuzhangObj().getName());
		jsonShiyan.accumulate("zuzhangObjPri", this.getZuzhangObj().getAccount());
		return jsonShiyan;
    }}