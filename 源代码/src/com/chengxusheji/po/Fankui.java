package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Fankui {
    /*反馈id*/
    private Integer fankuiId;
    public Integer getFankuiId(){
        return fankuiId;
    }
    public void setFankuiId(Integer fankuiId){
        this.fankuiId = fankuiId;
    }

    /*反馈标题*/
    @NotEmpty(message="反馈标题不能为空")
    private String title;
    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }

    /*反馈内容*/
    @NotEmpty(message="反馈内容不能为空")
    private String content;
    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }

    /*反馈组长*/
    private Zuzhang zuzhangObj;
    public Zuzhang getZuzhangObj() {
        return zuzhangObj;
    }
    public void setZuzhangObj(Zuzhang zuzhangObj) {
        this.zuzhangObj = zuzhangObj;
    }

    /*反馈时间*/
    @NotEmpty(message="反馈时间不能为空")
    private String fankuiTime;
    public String getFankuiTime() {
        return fankuiTime;
    }
    public void setFankuiTime(String fankuiTime) {
        this.fankuiTime = fankuiTime;
    }

    /*解决措施*/
    @NotEmpty(message="解决措施不能为空")
    private String jjcs;
    public String getJjcs() {
        return jjcs;
    }
    public void setJjcs(String jjcs) {
        this.jjcs = jjcs;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonFankui=new JSONObject(); 
		jsonFankui.accumulate("fankuiId", this.getFankuiId());
		jsonFankui.accumulate("title", this.getTitle());
		jsonFankui.accumulate("content", this.getContent());
		jsonFankui.accumulate("zuzhangObj", this.getZuzhangObj().getName());
		jsonFankui.accumulate("zuzhangObjPri", this.getZuzhangObj().getAccount());
		jsonFankui.accumulate("fankuiTime", this.getFankuiTime().length()>19?this.getFankuiTime().substring(0,19):this.getFankuiTime());
		jsonFankui.accumulate("jjcs", this.getJjcs());
		return jsonFankui;
    }}