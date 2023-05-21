package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Shiyan;
import com.chengxusheji.po.Device;
import com.chengxusheji.po.DeviceItem;

import com.chengxusheji.mapper.DeviceItemMapper;
@Service
public class DeviceItemService {

	@Resource DeviceItemMapper deviceItemMapper;
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

    /*添加实验设备条目记录*/
    public void addDeviceItem(DeviceItem deviceItem) throws Exception {
    	deviceItemMapper.addDeviceItem(deviceItem);
    }

    /*按照查询条件分页查询实验设备条目记录*/
    public ArrayList<DeviceItem> queryDeviceItem(Shiyan shiyanObj,Device deviceObj,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != shiyanObj && shiyanObj.getShiyanId()!= null && shiyanObj.getShiyanId()!= 0)  where += " and t_deviceItem.shiyanObj=" + shiyanObj.getShiyanId();
    	if(null != deviceObj &&  deviceObj.getDeviceNo() != null  && !deviceObj.getDeviceNo().equals(""))  where += " and t_deviceItem.deviceObj='" + deviceObj.getDeviceNo() + "'";
    	int startIndex = (currentPage-1) * this.rows;
    	return deviceItemMapper.queryDeviceItem(where, startIndex, this.rows);
    }
    
    
    /*按照查询条件分页查询实验设备条目记录*/
    public ArrayList<DeviceItem> zzQueryDeviceItem(String zuzhang,Shiyan shiyanObj,Device deviceObj,int currentPage) throws Exception { 
     	String where = "where t_shiyan.zuzhangObj='" + zuzhang + "'";
    	if(null != shiyanObj && shiyanObj.getShiyanId()!= null && shiyanObj.getShiyanId()!= 0)  where += " and t_deviceItem.shiyanObj=" + shiyanObj.getShiyanId();
    	if(null != deviceObj &&  deviceObj.getDeviceNo() != null  && !deviceObj.getDeviceNo().equals(""))  where += " and t_deviceItem.deviceObj='" + deviceObj.getDeviceNo() + "'";
    	int startIndex = (currentPage-1) * this.rows;
    	return deviceItemMapper.zzQueryDeviceItem(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<DeviceItem> queryDeviceItem(Shiyan shiyanObj,Device deviceObj) throws Exception  { 
     	String where = "where 1=1";
    	if(null != shiyanObj && shiyanObj.getShiyanId()!= null && shiyanObj.getShiyanId()!= 0)  where += " and t_deviceItem.shiyanObj=" + shiyanObj.getShiyanId();
    	if(null != deviceObj &&  deviceObj.getDeviceNo() != null && !deviceObj.getDeviceNo().equals(""))  where += " and t_deviceItem.deviceObj='" + deviceObj.getDeviceNo() + "'";
    	return deviceItemMapper.queryDeviceItemList(where);
    }

    /*查询所有实验设备条目记录*/
    public ArrayList<DeviceItem> queryAllDeviceItem()  throws Exception {
        return deviceItemMapper.queryDeviceItemList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(Shiyan shiyanObj,Device deviceObj) throws Exception {
     	String where = "where 1=1";
    	if(null != shiyanObj && shiyanObj.getShiyanId()!= null && shiyanObj.getShiyanId()!= 0)  where += " and t_deviceItem.shiyanObj=" + shiyanObj.getShiyanId();
    	if(null != deviceObj &&  deviceObj.getDeviceNo() != null && !deviceObj.getDeviceNo().equals(""))  where += " and t_deviceItem.deviceObj='" + deviceObj.getDeviceNo() + "'";
        recordNumber = deviceItemMapper.queryDeviceItemCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }
    
    /*当前查询条件下计算总的页数和记录数*/
    public void zzQueryTotalPageAndRecordNumber(String zuzhang,Shiyan shiyanObj,Device deviceObj) throws Exception {
     	String where = "where t_shiyan.zuzhangObj='" + zuzhang + "'";
    	if(null != shiyanObj && shiyanObj.getShiyanId()!= null && shiyanObj.getShiyanId()!= 0)  where += " and t_deviceItem.shiyanObj=" + shiyanObj.getShiyanId();
    	if(null != deviceObj &&  deviceObj.getDeviceNo() != null && !deviceObj.getDeviceNo().equals(""))  where += " and t_deviceItem.deviceObj='" + deviceObj.getDeviceNo() + "'";
        recordNumber = deviceItemMapper.zzQueryDeviceItemCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }
    

    /*根据主键获取实验设备条目记录*/
    public DeviceItem getDeviceItem(int deviceItemId) throws Exception  {
        DeviceItem deviceItem = deviceItemMapper.getDeviceItem(deviceItemId);
        return deviceItem;
    }

    /*更新实验设备条目记录*/
    public void updateDeviceItem(DeviceItem deviceItem) throws Exception {
        deviceItemMapper.updateDeviceItem(deviceItem);
    }

    /*删除一条实验设备条目记录*/
    public void deleteDeviceItem (int deviceItemId) throws Exception {
        deviceItemMapper.deleteDeviceItem(deviceItemId);
    }

    /*删除多条实验设备条目信息*/
    public int deleteDeviceItems (String deviceItemIds) throws Exception {
    	String _deviceItemIds[] = deviceItemIds.split(",");
    	for(String _deviceItemId: _deviceItemIds) {
    		deviceItemMapper.deleteDeviceItem(Integer.parseInt(_deviceItemId));
    	}
    	return _deviceItemIds.length;
    }
}
