package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Zuzhang {
    /*账号*/
    @NotEmpty(message="账号不能为空")
    private String account;
    public String getAccount(){
        return account;
    }
    public void setAccount(String account){
        this.account = account;
    }

    /*登录密码*/
    @NotEmpty(message="登录密码不能为空")
    private String password;
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }

    /*姓名*/
    @NotEmpty(message="姓名不能为空")
    private String name;
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }

    /*性别*/
    @NotEmpty(message="性别不能为空")
    private String gender;
    public String getGender() {
        return gender;
    }
    public void setGender(String gender) {
        this.gender = gender;
    }

    /*出生日期*/
    @NotEmpty(message="出生日期不能为空")
    private String birthDate;
    public String getBirthDate() {
        return birthDate;
    }
    public void setBirthDate(String birthDate) {
        this.birthDate = birthDate;
    }

    /*组长照片*/
    private String zuzhangPhoto;
    public String getZuzhangPhoto() {
        return zuzhangPhoto;
    }
    public void setZuzhangPhoto(String zuzhangPhoto) {
        this.zuzhangPhoto = zuzhangPhoto;
    }

    /*联系电话*/
    @NotEmpty(message="联系电话不能为空")
    private String telephone;
    public String getTelephone() {
        return telephone;
    }
    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    /*邮箱*/
    @NotEmpty(message="邮箱不能为空")
    private String email;
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }

    /*家庭地址*/
    private String address;
    public String getAddress() {
        return address;
    }
    public void setAddress(String address) {
        this.address = address;
    }

    /*注册时间*/
    private String regTime;
    public String getRegTime() {
        return regTime;
    }
    public void setRegTime(String regTime) {
        this.regTime = regTime;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonZuzhang=new JSONObject(); 
		jsonZuzhang.accumulate("account", this.getAccount());
		jsonZuzhang.accumulate("password", this.getPassword());
		jsonZuzhang.accumulate("name", this.getName());
		jsonZuzhang.accumulate("gender", this.getGender());
		jsonZuzhang.accumulate("birthDate", this.getBirthDate().length()>19?this.getBirthDate().substring(0,19):this.getBirthDate());
		jsonZuzhang.accumulate("zuzhangPhoto", this.getZuzhangPhoto());
		jsonZuzhang.accumulate("telephone", this.getTelephone());
		jsonZuzhang.accumulate("email", this.getEmail());
		jsonZuzhang.accumulate("address", this.getAddress());
		jsonZuzhang.accumulate("regTime", this.getRegTime().length()>19?this.getRegTime().substring(0,19):this.getRegTime());
		return jsonZuzhang;
    }}