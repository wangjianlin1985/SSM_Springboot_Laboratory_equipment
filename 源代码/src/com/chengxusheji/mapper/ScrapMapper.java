package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Scrap;

public interface ScrapMapper {
	/*添加设备报废信息*/
	public void addScrap(Scrap scrap) throws Exception;

	/*按照查询条件分页查询设备报废记录*/
	public ArrayList<Scrap> queryScrap(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有设备报废记录*/
	public ArrayList<Scrap> queryScrapList(@Param("where") String where) throws Exception;

	/*按照查询条件的设备报废记录数*/
	public int queryScrapCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条设备报废记录*/
	public Scrap getScrap(int scrapId) throws Exception;

	/*更新设备报废记录*/
	public void updateScrap(Scrap scrap) throws Exception;

	/*删除设备报废记录*/
	public void deleteScrap(int scrapId) throws Exception;

}
