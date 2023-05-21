package com.chengxusheji.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.chengxusheji.utils.ExportExcelUtil;
import com.chengxusheji.utils.UserException;
import com.chengxusheji.service.DeviceItemService;
import com.chengxusheji.service.ShiyanService;
import com.chengxusheji.po.Shiyan;
import com.chengxusheji.service.ShiyanStateService;
import com.chengxusheji.po.ShiyanState;
import com.chengxusheji.service.ZuzhangService;
import com.chengxusheji.po.Zuzhang;

//Shiyan管理控制层
@Controller
@RequestMapping("/Shiyan")
public class ShiyanController extends BaseController {

    /*业务层对象*/
    @Resource ShiyanService shiyanService;

    @Resource ShiyanStateService shiyanStateService;
    @Resource ZuzhangService zuzhangService;
    @Resource DeviceItemService deviceItemService;
	@InitBinder("shiyanStateObj")
	public void initBindershiyanStateObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("shiyanStateObj.");
	}
	@InitBinder("zuzhangObj")
	public void initBinderzuzhangObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("zuzhangObj.");
	}
	@InitBinder("shiyan")
	public void initBinderShiyan(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("shiyan.");
	}
	/*跳转到添加Shiyan视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Shiyan());
		/*查询所有的ShiyanState信息*/
		List<ShiyanState> shiyanStateList = shiyanStateService.queryAllShiyanState();
		request.setAttribute("shiyanStateList", shiyanStateList);
		/*查询所有的Zuzhang信息*/
		List<Zuzhang> zuzhangList = zuzhangService.queryAllZuzhang();
		request.setAttribute("zuzhangList", zuzhangList);
		return "Shiyan_add";
	}

	/*客户端ajax方式提交添加实验信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Shiyan shiyan, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        shiyanService.addShiyan(shiyan);
        message = "实验添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	
	/*客户端ajax方式提交添加实验信息*/
	@RequestMapping(value = "/zzAdd", method = RequestMethod.POST)
	public void zzAdd(@Validated Shiyan shiyan, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response,HttpSession session) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
		
		String zuzhang = (String)session.getAttribute("zuzhang");
		Zuzhang zuzhangObj = new Zuzhang();
		zuzhangObj.setAccount(zuzhang);
		shiyan.setZuzhangObj(zuzhangObj);
		
        shiyanService.addShiyan(shiyan);
        message = "实验添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	
	
	/*ajax方式按照查询条件分页查询实验信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(String shiyanName,String shiyanTime,@ModelAttribute("shiyanStateObj") ShiyanState shiyanStateObj,@ModelAttribute("zuzhangObj") Zuzhang zuzhangObj,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (shiyanName == null) shiyanName = "";
		if (shiyanTime == null) shiyanTime = "";
		if(rows != 0)shiyanService.setRows(rows);
		List<Shiyan> shiyanList = shiyanService.queryShiyan(shiyanName, shiyanTime, shiyanStateObj, zuzhangObj, page);
	    /*计算总的页数和总的记录数*/
	    shiyanService.queryTotalPageAndRecordNumber(shiyanName, shiyanTime, shiyanStateObj, zuzhangObj);
	    /*获取到总的页码数目*/
	    int totalPage = shiyanService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = shiyanService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Shiyan shiyan:shiyanList) {
			JSONObject jsonShiyan = shiyan.getJsonObject();
			jsonArray.put(jsonShiyan);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}
	
	
	/*ajax方式按照查询条件分页查询实验信息*/
	@RequestMapping(value = { "/zzlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void zzlist(String shiyanName,String shiyanTime,@ModelAttribute("shiyanStateObj") ShiyanState shiyanStateObj,@ModelAttribute("zuzhangObj") Zuzhang zuzhangObj,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response,HttpSession session) throws Exception {
		if (page==null || page == 0) page = 1;
		if (shiyanName == null) shiyanName = "";
		if (shiyanTime == null) shiyanTime = "";
		if(rows != 0)shiyanService.setRows(rows);
		zuzhangObj = new Zuzhang();
		zuzhangObj.setAccount((String)session.getAttribute("zuzhang"));
		
		List<Shiyan> shiyanList = shiyanService.queryShiyan(shiyanName, shiyanTime, shiyanStateObj, zuzhangObj, page);
	    /*计算总的页数和总的记录数*/
	    shiyanService.queryTotalPageAndRecordNumber(shiyanName, shiyanTime, shiyanStateObj, zuzhangObj);
	    /*获取到总的页码数目*/
	    int totalPage = shiyanService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = shiyanService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Shiyan shiyan:shiyanList) {
			JSONObject jsonShiyan = shiyan.getJsonObject();
			jsonArray.put(jsonShiyan);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}
	

	/*ajax方式按照查询条件分页查询实验信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Shiyan> shiyanList = shiyanService.queryAllShiyan();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Shiyan shiyan:shiyanList) {
			JSONObject jsonShiyan = new JSONObject();
			jsonShiyan.accumulate("shiyanId", shiyan.getShiyanId());
			jsonShiyan.accumulate("shiyanName", shiyan.getShiyanName());
			jsonArray.put(jsonShiyan);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}
	
	/*ajax方式按照查询条件分页查询实验信息*/
	@RequestMapping(value = { "/zzListAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void zzListAll(HttpServletResponse response,HttpSession session) throws Exception {
		String account = (String) session.getAttribute("zuzhang");
		List<Shiyan> shiyanList = shiyanService.zzQueryAllShiyan(account);
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Shiyan shiyan:shiyanList) {
			JSONObject jsonShiyan = new JSONObject();
			jsonShiyan.accumulate("shiyanId", shiyan.getShiyanId());
			jsonShiyan.accumulate("shiyanName", shiyan.getShiyanName());
			jsonArray.put(jsonShiyan);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}
	
	/*ajax方式按照查询条件分页查询实验信息*/
	@RequestMapping(value = { "/zzListAll2" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void zzListAll2(HttpServletResponse response,HttpSession session) throws Exception {
		String account = (String) session.getAttribute("zuzhang");
		List<Shiyan> shiyanList = shiyanService.zzQueryAllShiyan2(account);
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Shiyan shiyan:shiyanList) {
			JSONObject jsonShiyan = new JSONObject();
			jsonShiyan.accumulate("shiyanId", shiyan.getShiyanId());
			jsonShiyan.accumulate("shiyanName", shiyan.getShiyanName());
			jsonArray.put(jsonShiyan);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}
	

	/*前台按照查询条件分页查询实验信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(String shiyanName,String shiyanTime,@ModelAttribute("shiyanStateObj") ShiyanState shiyanStateObj,@ModelAttribute("zuzhangObj") Zuzhang zuzhangObj,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (shiyanName == null) shiyanName = "";
		if (shiyanTime == null) shiyanTime = "";
		List<Shiyan> shiyanList = shiyanService.queryShiyan(shiyanName, shiyanTime, shiyanStateObj, zuzhangObj, currentPage);
	    /*计算总的页数和总的记录数*/
	    shiyanService.queryTotalPageAndRecordNumber(shiyanName, shiyanTime, shiyanStateObj, zuzhangObj);
	    /*获取到总的页码数目*/
	    int totalPage = shiyanService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = shiyanService.getRecordNumber();
	    request.setAttribute("shiyanList",  shiyanList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("shiyanName", shiyanName);
	    request.setAttribute("shiyanTime", shiyanTime);
	    request.setAttribute("shiyanStateObj", shiyanStateObj);
	    request.setAttribute("zuzhangObj", zuzhangObj);
	    List<ShiyanState> shiyanStateList = shiyanStateService.queryAllShiyanState();
	    request.setAttribute("shiyanStateList", shiyanStateList);
	    List<Zuzhang> zuzhangList = zuzhangService.queryAllZuzhang();
	    request.setAttribute("zuzhangList", zuzhangList);
		return "Shiyan/shiyan_frontquery_result"; 
	}

     /*前台查询Shiyan信息*/
	@RequestMapping(value="/{shiyanId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer shiyanId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键shiyanId获取Shiyan对象*/
        Shiyan shiyan = shiyanService.getShiyan(shiyanId);

        List<ShiyanState> shiyanStateList = shiyanStateService.queryAllShiyanState();
        request.setAttribute("shiyanStateList", shiyanStateList);
        List<Zuzhang> zuzhangList = zuzhangService.queryAllZuzhang();
        request.setAttribute("zuzhangList", zuzhangList);
        request.setAttribute("shiyan",  shiyan);
        return "Shiyan/shiyan_frontshow";
	}

	/*ajax方式显示实验修改jsp视图页*/
	@RequestMapping(value="/{shiyanId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer shiyanId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键shiyanId获取Shiyan对象*/
        Shiyan shiyan = shiyanService.getShiyan(shiyanId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonShiyan = shiyan.getJsonObject();
		out.println(jsonShiyan.toString());
		out.flush();
		out.close();
	}
	
	

	/*ajax方式修改实验位领取设备状态*/
	@RequestMapping(value="/{shiyanId}/updateGetDeviceState",method=RequestMethod.GET)
	public void updateGetDeviceState(@PathVariable Integer shiyanId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键shiyanId获取Shiyan对象*/
        Shiyan shiyan = shiyanService.getShiyan(shiyanId);
        String message = "操作成功！";
        boolean success = false;
        if(deviceItemService.queryDeviceItem(shiyan, null).size() == 0) {
        	message = "请先添加该实验所需要的设备！";
        	writeJsonResponse(response, success, message);
        	return;
        }
        
        ShiyanState shiyanStateObj = shiyanStateService.getShiyanState(4);
        shiyan.setShiyanStateObj(shiyanStateObj);
        shiyanService.updateShiyan(shiyan);
        
        success = true;
        writeJsonResponse(response, success, message);
         
	}

	/*ajax方式更新实验信息*/
	@RequestMapping(value = "/{shiyanId}/update", method = RequestMethod.POST)
	public void update(@Validated Shiyan shiyan, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		
		int shiyanId = shiyan.getShiyanId();
		Shiyan shiyan_db = shiyanService.getShiyan(shiyanId);
		int oldStateId = shiyan_db.getShiyanStateObj().getShiyanStateId();
		int newStateId = shiyan.getShiyanStateObj().getShiyanStateId();
		
		/*
		('1', '实验申请待审核');
		('2', '审核通过,待领取设备');
		('3', '实验申请审核不通过');
		('4', '实验领取设备申请');
		('5', '设备领取成功等待归还');
		('6', '实验完毕设备归还成功');*/
		
		if(oldStateId == 1) {
			if((newStateId !=1) && (newStateId !=2) && (newStateId != 3)) {
				message = "实验申请处理状态不正确！";
				writeJsonResponse(response, success, message);
				return;
			}
		}
		
		if(oldStateId == 4) {
			if(newStateId !=4 && newStateId != 5) {
				message = "实验设备领取申请需要选择领取成功状态！";
				writeJsonResponse(response, success, message);
				return;
			}
		}
		
		if(oldStateId == 5) {
			if(newStateId !=5 && newStateId != 6) {
				message = "当前请选择实验设备归还成功！";
				writeJsonResponse(response, success, message);
				return;
			}
		}
		
		
		try {
			shiyanService.updateShiyan(shiyan);
			message = "实验更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "实验更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
	
	 
	
	
    /*删除实验信息*/
	@RequestMapping(value="/{shiyanId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer shiyanId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  shiyanService.deleteShiyan(shiyanId);
	            request.setAttribute("message", "实验删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "实验删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条实验记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String shiyanIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = shiyanService.deleteShiyans(shiyanIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出实验信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(String shiyanName,String shiyanTime,@ModelAttribute("shiyanStateObj") ShiyanState shiyanStateObj,@ModelAttribute("zuzhangObj") Zuzhang zuzhangObj, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(shiyanName == null) shiyanName = "";
        if(shiyanTime == null) shiyanTime = "";
        List<Shiyan> shiyanList = shiyanService.queryShiyan(shiyanName,shiyanTime,shiyanStateObj,zuzhangObj);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Shiyan信息记录"; 
        String[] headers = { "实验id","实验名称","实验时间","实验状态","组长姓名"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<shiyanList.size();i++) {
        	Shiyan shiyan = shiyanList.get(i); 
        	dataset.add(new String[]{shiyan.getShiyanId() + "",shiyan.getShiyanName(),shiyan.getShiyanTime(),shiyan.getShiyanStateObj().getShiyanStateName(),shiyan.getZuzhangObj().getName()});
        }
        /*
        OutputStream out = null;
		try {
			out = new FileOutputStream("C://output.xls");
			ex.exportExcel(title,headers, dataset, out);
		    out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		*/
		OutputStream out = null;//创建一个输出流对象 
		try { 
			out = response.getOutputStream();//
			response.setHeader("Content-disposition","attachment; filename="+"Shiyan.xls");//filename是下载的xls的名，建议最好用英文 
			response.setContentType("application/msexcel;charset=UTF-8");//设置类型 
			response.setHeader("Pragma","No-cache");//设置头 
			response.setHeader("Cache-Control","no-cache");//设置头 
			response.setDateHeader("Expires", 0);//设置日期头  
			String rootPath = request.getSession().getServletContext().getRealPath("/");
			ex.exportExcel(rootPath,_title,headers, dataset, out);
			out.flush();
		} catch (IOException e) { 
			e.printStackTrace(); 
		}finally{
			try{
				if(out!=null){ 
					out.close(); 
				}
			}catch(IOException e){ 
				e.printStackTrace(); 
			} 
		}
    }
}
