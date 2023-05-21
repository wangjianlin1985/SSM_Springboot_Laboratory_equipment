package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Device;
import com.chengxusheji.po.Repair;

import com.chengxusheji.mapper.RepairMapper;
@Service
public class RepairService {

	@Resource RepairMapper repairMapper;
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

    /*添加设备维修记录*/
    public void addRepair(Repair repair) throws Exception {
    	repairMapper.addRepair(repair);
    }

    /*按照查询条件分页查询设备维修记录*/
    public ArrayList<Repair> queryRepair(Device deviceObj,String questionDate,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != deviceObj &&  deviceObj.getDeviceNo() != null  && !deviceObj.getDeviceNo().equals(""))  where += " and t_repair.deviceObj='" + deviceObj.getDeviceNo() + "'";
    	if(!questionDate.equals("")) where = where + " and t_repair.questionDate like '%" + questionDate + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return repairMapper.queryRepair(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Repair> queryRepair(Device deviceObj,String questionDate) throws Exception  { 
     	String where = "where 1=1";
    	if(null != deviceObj &&  deviceObj.getDeviceNo() != null && !deviceObj.getDeviceNo().equals(""))  where += " and t_repair.deviceObj='" + deviceObj.getDeviceNo() + "'";
    	if(!questionDate.equals("")) where = where + " and t_repair.questionDate like '%" + questionDate + "%'";
    	return repairMapper.queryRepairList(where);
    }

    /*查询所有设备维修记录*/
    public ArrayList<Repair> queryAllRepair()  throws Exception {
        return repairMapper.queryRepairList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(Device deviceObj,String questionDate) throws Exception {
     	String where = "where 1=1";
    	if(null != deviceObj &&  deviceObj.getDeviceNo() != null && !deviceObj.getDeviceNo().equals(""))  where += " and t_repair.deviceObj='" + deviceObj.getDeviceNo() + "'";
    	if(!questionDate.equals("")) where = where + " and t_repair.questionDate like '%" + questionDate + "%'";
        recordNumber = repairMapper.queryRepairCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取设备维修记录*/
    public Repair getRepair(int repairId) throws Exception  {
        Repair repair = repairMapper.getRepair(repairId);
        return repair;
    }

    /*更新设备维修记录*/
    public void updateRepair(Repair repair) throws Exception {
        repairMapper.updateRepair(repair);
    }

    /*删除一条设备维修记录*/
    public void deleteRepair (int repairId) throws Exception {
        repairMapper.deleteRepair(repairId);
    }

    /*删除多条设备维修信息*/
    public int deleteRepairs (String repairIds) throws Exception {
    	String _repairIds[] = repairIds.split(",");
    	for(String _repairId: _repairIds) {
    		repairMapper.deleteRepair(Integer.parseInt(_repairId));
    	}
    	return _repairIds.length;
    }
}
