package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class ShiyanState {
    /*实验状态id*/
    private Integer shiyanStateId;
    public Integer getShiyanStateId(){
        return shiyanStateId;
    }
    public void setShiyanStateId(Integer shiyanStateId){
        this.shiyanStateId = shiyanStateId;
    }

    /*实验状态名称*/
    @NotEmpty(message="实验状态名称不能为空")
    private String shiyanStateName;
    public String getShiyanStateName() {
        return shiyanStateName;
    }
    public void setShiyanStateName(String shiyanStateName) {
        this.shiyanStateName = shiyanStateName;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonShiyanState=new JSONObject(); 
		jsonShiyanState.accumulate("shiyanStateId", this.getShiyanStateId());
		jsonShiyanState.accumulate("shiyanStateName", this.getShiyanStateName());
		return jsonShiyanState;
    }}