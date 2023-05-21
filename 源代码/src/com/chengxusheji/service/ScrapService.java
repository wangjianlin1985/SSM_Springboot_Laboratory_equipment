package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Device;
import com.chengxusheji.po.Scrap;

import com.chengxusheji.mapper.ScrapMapper;
@Service
public class ScrapService {

	@Resource ScrapMapper scrapMapper;
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

    /*添加设备报废记录*/
    public void addScrap(Scrap scrap) throws Exception {
    	scrapMapper.addScrap(scrap);
    }

    /*按照查询条件分页查询设备报废记录*/
    public ArrayList<Scrap> queryScrap(Device deviceObj,String reason,String scrapDate,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != deviceObj &&  deviceObj.getDeviceNo() != null  && !deviceObj.getDeviceNo().equals(""))  where += " and t_scrap.deviceObj='" + deviceObj.getDeviceNo() + "'";
    	if(!reason.equals("")) where = where + " and t_scrap.reason like '%" + reason + "%'";
    	if(!scrapDate.equals("")) where = where + " and t_scrap.scrapDate like '%" + scrapDate + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return scrapMapper.queryScrap(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Scrap> queryScrap(Device deviceObj,String reason,String scrapDate) throws Exception  { 
     	String where = "where 1=1";
    	if(null != deviceObj &&  deviceObj.getDeviceNo() != null && !deviceObj.getDeviceNo().equals(""))  where += " and t_scrap.deviceObj='" + deviceObj.getDeviceNo() + "'";
    	if(!reason.equals("")) where = where + " and t_scrap.reason like '%" + reason + "%'";
    	if(!scrapDate.equals("")) where = where + " and t_scrap.scrapDate like '%" + scrapDate + "%'";
    	return scrapMapper.queryScrapList(where);
    }

    /*查询所有设备报废记录*/
    public ArrayList<Scrap> queryAllScrap()  throws Exception {
        return scrapMapper.queryScrapList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(Device deviceObj,String reason,String scrapDate) throws Exception {
     	String where = "where 1=1";
    	if(null != deviceObj &&  deviceObj.getDeviceNo() != null && !deviceObj.getDeviceNo().equals(""))  where += " and t_scrap.deviceObj='" + deviceObj.getDeviceNo() + "'";
    	if(!reason.equals("")) where = where + " and t_scrap.reason like '%" + reason + "%'";
    	if(!scrapDate.equals("")) where = where + " and t_scrap.scrapDate like '%" + scrapDate + "%'";
        recordNumber = scrapMapper.queryScrapCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取设备报废记录*/
    public Scrap getScrap(int scrapId) throws Exception  {
        Scrap scrap = scrapMapper.getScrap(scrapId);
        return scrap;
    }

    /*更新设备报废记录*/
    public void updateScrap(Scrap scrap) throws Exception {
        scrapMapper.updateScrap(scrap);
    }

    /*删除一条设备报废记录*/
    public void deleteScrap (int scrapId) throws Exception {
        scrapMapper.deleteScrap(scrapId);
    }

    /*删除多条设备报废信息*/
    public int deleteScraps (String scrapIds) throws Exception {
    	String _scrapIds[] = scrapIds.split(",");
    	for(String _scrapId: _scrapIds) {
    		scrapMapper.deleteScrap(Integer.parseInt(_scrapId));
    	}
    	return _scrapIds.length;
    }
}
