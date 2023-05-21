package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.DeviceClass;

import com.chengxusheji.mapper.DeviceClassMapper;
@Service
public class DeviceClassService {

	@Resource DeviceClassMapper deviceClassMapper;
    /*每页显示记录数目*/
    private int rows = 10;;
    public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}

    /*保存查询后总的页数*/
    private int totalPage;
    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }
    public int getTotalPage() {
        return totalPage;
    }

    /*保存查询到的总记录数*/
    private int recordNumber;
    public void setRecordNumber(int recordNumber) {
        this.recordNumber = recordNumber;
    }
    public int getRecordNumber() {
        return recordNumber;
    }

    /*添加设备类别记录*/
    public void addDeviceClass(DeviceClass deviceClass) throws Exception {
    	deviceClassMapper.addDeviceClass(deviceClass);
    }

    /*按照查询条件分页查询设备类别记录*/
    public ArrayList<DeviceClass> queryDeviceClass(int currentPage) throws Exception { 
     	String where = "where 1=1";
    	int startIndex = (currentPage-1) * this.rows;
    	return deviceClassMapper.queryDeviceClass(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<DeviceClass> queryDeviceClass() throws Exception  { 
     	String where = "where 1=1";
    	return deviceClassMapper.queryDeviceClassList(where);
    }

    /*查询所有设备类别记录*/
    public ArrayList<DeviceClass> queryAllDeviceClass()  throws Exception {
        return deviceClassMapper.queryDeviceClassList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber() throws Exception {
     	String where = "where 1=1";
        recordNumber = deviceClassMapper.queryDeviceClassCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取设备类别记录*/
    public DeviceClass getDeviceClass(int deviceClassId) throws Exception  {
        DeviceClass deviceClass = deviceClassMapper.getDeviceClass(deviceClassId);
        return deviceClass;
    }

    /*更新设备类别记录*/
    public void updateDeviceClass(DeviceClass deviceClass) throws Exception {
        deviceClassMapper.updateDeviceClass(deviceClass);
    }

    /*删除一条设备类别记录*/
    public void deleteDeviceClass (int deviceClassId) throws Exception {
        deviceClassMapper.deleteDeviceClass(deviceClassId);
    }

    /*删除多条设备类别信息*/
    public int deleteDeviceClasss (String deviceClassIds) throws Exception {
    	String _deviceClassIds[] = deviceClassIds.split(",");
    	for(String _deviceClassId: _deviceClassIds) {
    		deviceClassMapper.deleteDeviceClass(Integer.parseInt(_deviceClassId));
    	}
    	return _deviceClassIds.length;
    }
}
