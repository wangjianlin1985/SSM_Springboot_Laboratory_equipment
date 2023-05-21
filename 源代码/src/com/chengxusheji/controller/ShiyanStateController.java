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
import com.chengxusheji.service.ShiyanStateService;
import com.chengxusheji.po.ShiyanState;

//ShiyanState管理控制层
@Controller
@RequestMapping("/ShiyanState")
public class ShiyanStateController extends BaseController {

    /*业务层对象*/
    @Resource ShiyanStateService shiyanStateService;

	@InitBinder("shiyanState")
	public void initBinderShiyanState(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("shiyanState.");
	}
	/*跳转到添加ShiyanState视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new ShiyanState());
		return "ShiyanState_add";
	}

	/*客户端ajax方式提交添加实验状态信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated ShiyanState shiyanState, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        shiyanStateService.addShiyanState(shiyanState);
        message = "实验状态添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询实验状态信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if(rows != 0)shiyanStateService.setRows(rows);
		List<ShiyanState> shiyanStateList = shiyanStateService.queryShiyanState(page);
	    /*计算总的页数和总的记录数*/
	    shiyanStateService.queryTotalPageAndRecordNumber();
	    /*获取到总的页码数目*/
	    int totalPage = shiyanStateService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = shiyanStateService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(ShiyanState shiyanState:shiyanStateList) {
			JSONObject jsonShiyanState = shiyanState.getJsonObject();
			jsonArray.put(jsonShiyanState);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询实验状态信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<ShiyanState> shiyanStateList = shiyanStateService.queryAllShiyanState();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(ShiyanState shiyanState:shiyanStateList) {
			JSONObject jsonShiyanState = new JSONObject();
			jsonShiyanState.accumulate("shiyanStateId", shiyanState.getShiyanStateId());
			jsonShiyanState.accumulate("shiyanStateName", shiyanState.getShiyanStateName());
			jsonArray.put(jsonShiyanState);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询实验状态信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		List<ShiyanState> shiyanStateList = shiyanStateService.queryShiyanState(currentPage);
	    /*计算总的页数和总的记录数*/
	    shiyanStateService.queryTotalPageAndRecordNumber();
	    /*获取到总的页码数目*/
	    int totalPage = shiyanStateService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = shiyanStateService.getRecordNumber();
	    request.setAttribute("shiyanStateList",  shiyanStateList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
		return "ShiyanState/shiyanState_frontquery_result"; 
	}

     /*前台查询ShiyanState信息*/
	@RequestMapping(value="/{shiyanStateId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer shiyanStateId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键shiyanStateId获取ShiyanState对象*/
        ShiyanState shiyanState = shiyanStateService.getShiyanState(shiyanStateId);

        request.setAttribute("shiyanState",  shiyanState);
        return "ShiyanState/shiyanState_frontshow";
	}

	/*ajax方式显示实验状态修改jsp视图页*/
	@RequestMapping(value="/{shiyanStateId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer shiyanStateId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键shiyanStateId获取ShiyanState对象*/
        ShiyanState shiyanState = shiyanStateService.getShiyanState(shiyanStateId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonShiyanState = shiyanState.getJsonObject();
		out.println(jsonShiyanState.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新实验状态信息*/
	@RequestMapping(value = "/{shiyanStateId}/update", method = RequestMethod.POST)
	public void update(@Validated ShiyanState shiyanState, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			shiyanStateService.updateShiyanState(shiyanState);
			message = "实验状态更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "实验状态更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除实验状态信息*/
	@RequestMapping(value="/{shiyanStateId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer shiyanStateId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  shiyanStateService.deleteShiyanState(shiyanStateId);
	            request.setAttribute("message", "实验状态删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "实验状态删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条实验状态记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String shiyanStateIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = shiyanStateService.deleteShiyanStates(shiyanStateIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出实验状态信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel( Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        List<ShiyanState> shiyanStateList = shiyanStateService.queryShiyanState();
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "ShiyanState信息记录"; 
        String[] headers = { "实验状态id","实验状态名称"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<shiyanStateList.size();i++) {
        	ShiyanState shiyanState = shiyanStateList.get(i); 
        	dataset.add(new String[]{shiyanState.getShiyanStateId() + "",shiyanState.getShiyanStateName()});
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
			response.setHeader("Content-disposition","attachment; filename="+"ShiyanState.xls");//filename是下载的xls的名，建议最好用英文 
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
