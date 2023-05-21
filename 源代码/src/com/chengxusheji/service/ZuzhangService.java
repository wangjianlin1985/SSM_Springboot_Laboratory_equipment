package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;

import com.chengxusheji.po.Admin;
import com.chengxusheji.po.Zuzhang;

import com.chengxusheji.mapper.ZuzhangMapper;
@Service
public class ZuzhangService {

	@Resource ZuzhangMapper zuzhangMapper;
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

    /*添加组长记录*/
    public void addZuzhang(Zuzhang zuzhang) throws Exception {
    	zuzhangMapper.addZuzhang(zuzhang);
    }

    /*按照查询条件分页查询组长记录*/
    public ArrayList<Zuzhang> queryZuzhang(String account,String name,String birthDate,String telephone,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(!account.equals("")) where = where + " and t_zuzhang.account like '%" + account + "%'";
    	if(!name.equals("")) where = where + " and t_zuzhang.name like '%" + name + "%'";
    	if(!birthDate.equals("")) where = where + " and t_zuzhang.birthDate like '%" + birthDate + "%'";
    	if(!telephone.equals("")) where = where + " and t_zuzhang.telephone like '%" + telephone + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return zuzhangMapper.queryZuzhang(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Zuzhang> queryZuzhang(String account,String name,String birthDate,String telephone) throws Exception  { 
     	String where = "where 1=1";
    	if(!account.equals("")) where = where + " and t_zuzhang.account like '%" + account + "%'";
    	if(!name.equals("")) where = where + " and t_zuzhang.name like '%" + name + "%'";
    	if(!birthDate.equals("")) where = where + " and t_zuzhang.birthDate like '%" + birthDate + "%'";
    	if(!telephone.equals("")) where = where + " and t_zuzhang.telephone like '%" + telephone + "%'";
    	return zuzhangMapper.queryZuzhangList(where);
    }

    /*查询所有组长记录*/
    public ArrayList<Zuzhang> queryAllZuzhang()  throws Exception {
        return zuzhangMapper.queryZuzhangList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(String account,String name,String birthDate,String telephone) throws Exception {
     	String where = "where 1=1";
    	if(!account.equals("")) where = where + " and t_zuzhang.account like '%" + account + "%'";
    	if(!name.equals("")) where = where + " and t_zuzhang.name like '%" + name + "%'";
    	if(!birthDate.equals("")) where = where + " and t_zuzhang.birthDate like '%" + birthDate + "%'";
    	if(!telephone.equals("")) where = where + " and t_zuzhang.telephone like '%" + telephone + "%'";
        recordNumber = zuzhangMapper.queryZuzhangCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取组长记录*/
    public Zuzhang getZuzhang(String account) throws Exception  {
        Zuzhang zuzhang = zuzhangMapper.getZuzhang(account);
        return zuzhang;
    }

    /*更新组长记录*/
    public void updateZuzhang(Zuzhang zuzhang) throws Exception {
        zuzhangMapper.updateZuzhang(zuzhang);
    }

    /*删除一条组长记录*/
    public void deleteZuzhang (String account) throws Exception {
        zuzhangMapper.deleteZuzhang(account);
    }

    /*删除多条组长信息*/
    public int deleteZuzhangs (String accounts) throws Exception {
    	String _accounts[] = accounts.split(",");
    	for(String _account: _accounts) {
    		zuzhangMapper.deleteZuzhang(_account);
    	}
    	return _accounts.length;
    } 
	
	
	/*保存业务逻辑错误信息字段*/
	private String errMessage;
	public String getErrMessage() { return this.errMessage; }
	
	/*验证用户登录*/
	public boolean checkLogin(Admin admin) throws Exception { 
		Zuzhang db_zuzhang = (Zuzhang) zuzhangMapper.getZuzhang(admin.getUsername());
		if(db_zuzhang == null) { 
			this.errMessage = " 账号不存在 ";
			System.out.print(this.errMessage);
			return false;
		} else if( !db_zuzhang.getPassword().equals(admin.getPassword())) {
			this.errMessage = " 密码不正确! ";
			System.out.print(this.errMessage);
			return false;
		}
		
		return true;
	}
	
}
