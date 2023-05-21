package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.DeviceClass;

public interface DeviceClassMapper {
	/*添加设备类别信息*/
	public void addDeviceClass(DeviceClass deviceClass) throws Exception;

	/*按照查询条件分页查询设备类别记录*/
	public ArrayList<DeviceClass> queryDeviceClass(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有设备类别记录*/
	public ArrayList<DeviceClass> queryDeviceClassList(@Param("where") String where) throws Exception;

	/*按照查询条件的设备类别记录数*/
	public int queryDeviceClassCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条设备类别记录*/
	public DeviceClass getDeviceClass(int deviceClassId) throws Exception;

	/*更新设备类别记录*/
	public void updateDeviceClass(DeviceClass deviceClass) throws Exception;

	/*删除设备类别记录*/
	public void deleteDeviceClass(int deviceClassId) throws Exception;

}
