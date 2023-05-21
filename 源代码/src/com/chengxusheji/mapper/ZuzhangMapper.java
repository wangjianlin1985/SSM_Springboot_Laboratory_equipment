package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Zuzhang;

public interface ZuzhangMapper {
	/*添加组长信息*/
	public void addZuzhang(Zuzhang zuzhang) throws Exception;

	/*按照查询条件分页查询组长记录*/
	public ArrayList<Zuzhang> queryZuzhang(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有组长记录*/
	public ArrayList<Zuzhang> queryZuzhangList(@Param("where") String where) throws Exception;

	/*按照查询条件的组长记录数*/
	public int queryZuzhangCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条组长记录*/
	public Zuzhang getZuzhang(String account) throws Exception;

	/*更新组长记录*/
	public void updateZuzhang(Zuzhang zuzhang) throws Exception;

	/*删除组长记录*/
	public void deleteZuzhang(String account) throws Exception;

}
