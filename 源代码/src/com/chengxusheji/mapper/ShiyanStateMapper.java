package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.ShiyanState;

public interface ShiyanStateMapper {
	/*添加实验状态信息*/
	public void addShiyanState(ShiyanState shiyanState) throws Exception;

	/*按照查询条件分页查询实验状态记录*/
	public ArrayList<ShiyanState> queryShiyanState(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有实验状态记录*/
	public ArrayList<ShiyanState> queryShiyanStateList(@Param("where") String where) throws Exception;

	/*按照查询条件的实验状态记录数*/
	public int queryShiyanStateCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条实验状态记录*/
	public ShiyanState getShiyanState(int shiyanStateId) throws Exception;

	/*更新实验状态记录*/
	public void updateShiyanState(ShiyanState shiyanState) throws Exception;

	/*删除实验状态记录*/
	public void deleteShiyanState(int shiyanStateId) throws Exception;

}
