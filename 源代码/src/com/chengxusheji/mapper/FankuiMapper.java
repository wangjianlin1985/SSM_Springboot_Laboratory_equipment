package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Fankui;

public interface FankuiMapper {
	/*添加反馈日志信息*/
	public void addFankui(Fankui fankui) throws Exception;

	/*按照查询条件分页查询反馈日志记录*/
	public ArrayList<Fankui> queryFankui(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有反馈日志记录*/
	public ArrayList<Fankui> queryFankuiList(@Param("where") String where) throws Exception;

	/*按照查询条件的反馈日志记录数*/
	public int queryFankuiCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条反馈日志记录*/
	public Fankui getFankui(int fankuiId) throws Exception;

	/*更新反馈日志记录*/
	public void updateFankui(Fankui fankui) throws Exception;

	/*删除反馈日志记录*/
	public void deleteFankui(int fankuiId) throws Exception;

}
