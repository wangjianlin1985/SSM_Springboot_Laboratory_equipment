package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.DeviceItem;

public interface DeviceItemMapper {
	/*添加实验设备条目信息*/
	public void addDeviceItem(DeviceItem deviceItem) throws Exception;

	/*按照查询条件分页查询实验设备条目记录*/
	public ArrayList<DeviceItem> queryDeviceItem(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;
	
	/*按照查询条件分页查询实验设备条目记录*/
	public ArrayList<DeviceItem> zzQueryDeviceItem(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有实验设备条目记录*/
	public ArrayList<DeviceItem> queryDeviceItemList(@Param("where") String where) throws Exception;

	/*按照查询条件的实验设备条目记录数*/
	public int queryDeviceItemCount(@Param("where") String where) throws Exception; 
	
	/*按照查询条件的实验设备条目记录数*/
	public int zzQueryDeviceItemCount(@Param("where") String where) throws Exception;

	/*根据主键查询某条实验设备条目记录*/
	public DeviceItem getDeviceItem(int deviceItemId) throws Exception;

	/*更新实验设备条目记录*/
	public void updateDeviceItem(DeviceItem deviceItem) throws Exception;

	/*删除实验设备条目记录*/
	public void deleteDeviceItem(int deviceItemId) throws Exception;

}
