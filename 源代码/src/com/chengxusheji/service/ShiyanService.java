package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.ShiyanState;
import com.chengxusheji.po.Zuzhang;
import com.chengxusheji.po.Shiyan;

import com.chengxusheji.mapper.ShiyanMapper;
@Service
public class ShiyanService {

	@Resource ShiyanMapper shiyanMapper;
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

    /*添加实验记录*/
    public void addShiyan(Shiyan shiyan) throws Exception {
    	shiyanMapper.addShiyan(shiyan);
    }

    /*按照查询条件分页查询实验记录*/
    public ArrayList<Shiyan> queryShiyan(String shiyanName,String shiyanTime,ShiyanState shiyanStateObj,Zuzhang zuzhangObj,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(!shiyanName.equals("")) where = where + " and t_shiyan.shiyanName like '%" + shiyanName + "%'";
    	if(!shiyanTime.equals("")) where = where + " and t_shiyan.shiyanTime like '%" + shiyanTime + "%'";
    	if(null != shiyanStateObj && shiyanStateObj.getShiyanStateId()!= null && shiyanStateObj.getShiyanStateId()!= 0)  where += " and t_shiyan.shiyanStateObj=" + shiyanStateObj.getShiyanStateId();
    	if(null != zuzhangObj &&  zuzhangObj.getAccount() != null  && !zuzhangObj.getAccount().equals(""))  where += " and t_shiyan.zuzhangObj='" + zuzhangObj.getAccount() + "'";
    	int startIndex = (currentPage-1) * this.rows;
    	return shiyanMapper.queryShiyan(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Shiyan> queryShiyan(String shiyanName,String shiyanTime,ShiyanState shiyanStateObj,Zuzhang zuzhangObj) throws Exception  { 
     	String where = "where 1=1";
    	if(!shiyanName.equals("")) where = where + " and t_shiyan.shiyanName like '%" + shiyanName + "%'";
    	if(!shiyanTime.equals("")) where = where + " and t_shiyan.shiyanTime like '%" + shiyanTime + "%'";
    	if(null != shiyanStateObj && shiyanStateObj.getShiyanStateId()!= null && shiyanStateObj.getShiyanStateId()!= 0)  where += " and t_shiyan.shiyanStateObj=" + shiyanStateObj.getShiyanStateId();
    	if(null != zuzhangObj &&  zuzhangObj.getAccount() != null && !zuzhangObj.getAccount().equals(""))  where += " and t_shiyan.zuzhangObj='" + zuzhangObj.getAccount() + "'";
    	return shiyanMapper.queryShiyanList(where);
    }

    /*查询所有实验记录*/
    public ArrayList<Shiyan> queryAllShiyan()  throws Exception {
        return shiyanMapper.queryShiyanList("where 1=1");
    }
    
    /*查询所有实验记录*/
    public ArrayList<Shiyan> zzQueryAllShiyan(String account)  throws Exception {
        return shiyanMapper.queryShiyanList("where t_shiyan.zuzhangObj='" + account + "' and (t_shiyan.shiyanStateObj=1 or t_shiyan.shiyanStateObj =2) ");
    }
    
    /*查询所有实验记录*/
    public ArrayList<Shiyan> zzQueryAllShiyan2(String account)  throws Exception {
        return shiyanMapper.queryShiyanList("where t_shiyan.zuzhangObj='" + account + "'");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(String shiyanName,String shiyanTime,ShiyanState shiyanStateObj,Zuzhang zuzhangObj) throws Exception {
     	String where = "where 1=1";
    	if(!shiyanName.equals("")) where = where + " and t_shiyan.shiyanName like '%" + shiyanName + "%'";
    	if(!shiyanTime.equals("")) where = where + " and t_shiyan.shiyanTime like '%" + shiyanTime + "%'";
    	if(null != shiyanStateObj && shiyanStateObj.getShiyanStateId()!= null && shiyanStateObj.getShiyanStateId()!= 0)  where += " and t_shiyan.shiyanStateObj=" + shiyanStateObj.getShiyanStateId();
    	if(null != zuzhangObj &&  zuzhangObj.getAccount() != null && !zuzhangObj.getAccount().equals(""))  where += " and t_shiyan.zuzhangObj='" + zuzhangObj.getAccount() + "'";
        recordNumber = shiyanMapper.queryShiyanCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取实验记录*/
    public Shiyan getShiyan(int shiyanId) throws Exception  {
        Shiyan shiyan = shiyanMapper.getShiyan(shiyanId);
        return shiyan;
    }

    /*更新实验记录*/
    public void updateShiyan(Shiyan shiyan) throws Exception {
        shiyanMapper.updateShiyan(shiyan);
    }

    /*删除一条实验记录*/
    public void deleteShiyan (int shiyanId) throws Exception {
        shiyanMapper.deleteShiyan(shiyanId);
    }

    /*删除多条实验信息*/
    public int deleteShiyans (String shiyanIds) throws Exception {
    	String _shiyanIds[] = shiyanIds.split(",");
    	for(String _shiyanId: _shiyanIds) {
    		shiyanMapper.deleteShiyan(Integer.parseInt(_shiyanId));
    	}
    	return _shiyanIds.length;
    }
}
