package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.ShiyanState;

import com.chengxusheji.mapper.ShiyanStateMapper;
@Service
public class ShiyanStateService {

	@Resource ShiyanStateMapper shiyanStateMapper;
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

    /*添加实验状态记录*/
    public void addShiyanState(ShiyanState shiyanState) throws Exception {
    	shiyanStateMapper.addShiyanState(shiyanState);
    }

    /*按照查询条件分页查询实验状态记录*/
    public ArrayList<ShiyanState> queryShiyanState(int currentPage) throws Exception { 
     	String where = "where 1=1";
    	int startIndex = (currentPage-1) * this.rows;
    	return shiyanStateMapper.queryShiyanState(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<ShiyanState> queryShiyanState() throws Exception  { 
     	String where = "where 1=1";
    	return shiyanStateMapper.queryShiyanStateList(where);
    }

    /*查询所有实验状态记录*/
    public ArrayList<ShiyanState> queryAllShiyanState()  throws Exception {
        return shiyanStateMapper.queryShiyanStateList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber() throws Exception {
     	String where = "where 1=1";
        recordNumber = shiyanStateMapper.queryShiyanStateCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取实验状态记录*/
    public ShiyanState getShiyanState(int shiyanStateId) throws Exception  {
        ShiyanState shiyanState = shiyanStateMapper.getShiyanState(shiyanStateId);
        return shiyanState;
    }

    /*更新实验状态记录*/
    public void updateShiyanState(ShiyanState shiyanState) throws Exception {
        shiyanStateMapper.updateShiyanState(shiyanState);
    }

    /*删除一条实验状态记录*/
    public void deleteShiyanState (int shiyanStateId) throws Exception {
        shiyanStateMapper.deleteShiyanState(shiyanStateId);
    }

    /*删除多条实验状态信息*/
    public int deleteShiyanStates (String shiyanStateIds) throws Exception {
    	String _shiyanStateIds[] = shiyanStateIds.split(",");
    	for(String _shiyanStateId: _shiyanStateIds) {
    		shiyanStateMapper.deleteShiyanState(Integer.parseInt(_shiyanStateId));
    	}
    	return _shiyanStateIds.length;
    }
}
