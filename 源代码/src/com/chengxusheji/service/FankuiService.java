package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Zuzhang;
import com.chengxusheji.po.Fankui;

import com.chengxusheji.mapper.FankuiMapper;
@Service
public class FankuiService {

	@Resource FankuiMapper fankuiMapper;
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

    /*添加反馈日志记录*/
    public void addFankui(Fankui fankui) throws Exception {
    	fankuiMapper.addFankui(fankui);
    }

    /*按照查询条件分页查询反馈日志记录*/
    public ArrayList<Fankui> queryFankui(String title,Zuzhang zuzhangObj,String fankuiTime,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(!title.equals("")) where = where + " and t_fankui.title like '%" + title + "%'";
    	if(null != zuzhangObj &&  zuzhangObj.getAccount() != null  && !zuzhangObj.getAccount().equals(""))  where += " and t_fankui.zuzhangObj='" + zuzhangObj.getAccount() + "'";
    	if(!fankuiTime.equals("")) where = where + " and t_fankui.fankuiTime like '%" + fankuiTime + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return fankuiMapper.queryFankui(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Fankui> queryFankui(String title,Zuzhang zuzhangObj,String fankuiTime) throws Exception  { 
     	String where = "where 1=1";
    	if(!title.equals("")) where = where + " and t_fankui.title like '%" + title + "%'";
    	if(null != zuzhangObj &&  zuzhangObj.getAccount() != null && !zuzhangObj.getAccount().equals(""))  where += " and t_fankui.zuzhangObj='" + zuzhangObj.getAccount() + "'";
    	if(!fankuiTime.equals("")) where = where + " and t_fankui.fankuiTime like '%" + fankuiTime + "%'";
    	return fankuiMapper.queryFankuiList(where);
    }

    /*查询所有反馈日志记录*/
    public ArrayList<Fankui> queryAllFankui()  throws Exception {
        return fankuiMapper.queryFankuiList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(String title,Zuzhang zuzhangObj,String fankuiTime) throws Exception {
     	String where = "where 1=1";
    	if(!title.equals("")) where = where + " and t_fankui.title like '%" + title + "%'";
    	if(null != zuzhangObj &&  zuzhangObj.getAccount() != null && !zuzhangObj.getAccount().equals(""))  where += " and t_fankui.zuzhangObj='" + zuzhangObj.getAccount() + "'";
    	if(!fankuiTime.equals("")) where = where + " and t_fankui.fankuiTime like '%" + fankuiTime + "%'";
        recordNumber = fankuiMapper.queryFankuiCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取反馈日志记录*/
    public Fankui getFankui(int fankuiId) throws Exception  {
        Fankui fankui = fankuiMapper.getFankui(fankuiId);
        return fankui;
    }

    /*更新反馈日志记录*/
    public void updateFankui(Fankui fankui) throws Exception {
        fankuiMapper.updateFankui(fankui);
    }

    /*删除一条反馈日志记录*/
    public void deleteFankui (int fankuiId) throws Exception {
        fankuiMapper.deleteFankui(fankuiId);
    }

    /*删除多条反馈日志信息*/
    public int deleteFankuis (String fankuiIds) throws Exception {
    	String _fankuiIds[] = fankuiIds.split(",");
    	for(String _fankuiId: _fankuiIds) {
    		fankuiMapper.deleteFankui(Integer.parseInt(_fankuiId));
    	}
    	return _fankuiIds.length;
    }
}
