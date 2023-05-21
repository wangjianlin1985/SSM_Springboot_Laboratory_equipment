package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Repair {
    /*维修id*/
    private Integer repairId;
    public Integer getRepairId(){
        return repairId;
    }
    public void setRepairId(Integer repairId){
        this.repairId = repairId;
    }

    /*维修的设备*/
    private Device deviceObj;
    public Device getDeviceObj() {
        return deviceObj;
    }
    public void setDeviceObj(Device deviceObj) {
        this.deviceObj = deviceObj;
    }

    /*故障数量*/
    @NotNull(message="必须输入故障数量")
    private Integer repairCount;
    public Integer getRepairCount() {
        return repairCount;
    }
    public void setRepairCount(Integer repairCount) {
        this.repairCount = repairCount;
    }

    /*设备问题*/
    @NotEmpty(message="设备问题不能为空")
    private String question;
    public String getQuestion() {
        return question;
    }
    public void setQuestion(String question) {
        this.question = question;
    }

    /*故障日期*/
    @NotEmpty(message="故障日期不能为空")
    private String questionDate;
    public String getQuestionDate() {
        return questionDate;
    }
    public void setQuestionDate(String questionDate) {
        this.questionDate = questionDate;
    }

    /*维修内容*/
    @NotEmpty(message="维修内容不能为空")
    private String repairContent;
    public String getRepairContent() {
        return repairContent;
    }
    public void setRepairContent(String repairContent) {
        this.repairContent = repairContent;
    }

    /*维修费用*/
    @NotNull(message="必须输入维修费用")
    private Float repairMoney;
    public Float getRepairMoney() {
        return repairMoney;
    }
    public void setRepairMoney(Float repairMoney) {
        this.repairMoney = repairMoney;
    }

    /*备注信息*/
    private String repairMemo;
    public String getRepairMemo() {
        return repairMemo;
    }
    public void setRepairMemo(String repairMemo) {
        this.repairMemo = repairMemo;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonRepair=new JSONObject(); 
		jsonRepair.accumulate("repairId", this.getRepairId());
		jsonRepair.accumulate("deviceObj", this.getDeviceObj().getDeviceName());
		jsonRepair.accumulate("deviceObjPri", this.getDeviceObj().getDeviceNo());
		jsonRepair.accumulate("repairCount", this.getRepairCount());
		jsonRepair.accumulate("question", this.getQuestion());
		jsonRepair.accumulate("questionDate", this.getQuestionDate().length()>19?this.getQuestionDate().substring(0,19):this.getQuestionDate());
		jsonRepair.accumulate("repairContent", this.getRepairContent());
		jsonRepair.accumulate("repairMoney", this.getRepairMoney());
		jsonRepair.accumulate("repairMemo", this.getRepairMemo());
		return jsonRepair;
    }}