package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.UserInfo;

public interface UserInfoMapper {
	/*添加采购员信息*/
	public void addUserInfo(UserInfo userInfo) throws Exception;

	/*按照查询条件分页查询采购员记录*/
	public ArrayList<UserInfo> queryUserInfo(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有采购员记录*/
	public ArrayList<UserInfo> queryUserInfoList(@Param("where") String where) throws Exception;

	/*按照查询条件的采购员记录数*/
	public int queryUserInfoCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条采购员记录*/
	public UserInfo getUserInfo(String user_name) throws Exception;

	/*更新采购员记录*/
	public void updateUserInfo(UserInfo userInfo) throws Exception;

	/*删除采购员记录*/
	public void deleteUserInfo(String user_name) throws Exception;

}
