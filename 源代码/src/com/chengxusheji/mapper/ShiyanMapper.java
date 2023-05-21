package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Shiyan;

public interface ShiyanMapper {
	/*添加实验信息*/
	public void addShiyan(Shiyan shiyan) throws Exception;

	/*按照查询条件分页查询实验记录*/
	public ArrayList<Shiyan> queryShiyan(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有实验记录*/
	public ArrayList<Shiyan> queryShiyanList(@Param("where") String where) throws Exception;

	/*按照查询条件的实验记录数*/
	public int queryShiyanCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条实验记录*/
	public Shiyan getShiyan(int shiyanId) throws Exception;

	/*更新实验记录*/
	public void updateShiyan(Shiyan shiyan) throws Exception;

	/*删除实验记录*/
	public void deleteShiyan(int shiyanId) throws Exception;

}
