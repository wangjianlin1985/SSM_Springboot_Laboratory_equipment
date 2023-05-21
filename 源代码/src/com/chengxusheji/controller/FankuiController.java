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
import com.chengxusheji.service.FankuiService;
import com.chengxusheji.po.Fankui;
import com.chengxusheji.service.ZuzhangService;
import com.chengxusheji.po.Zuzhang;

//Fankui管理控制层
@Controller
@RequestMapping("/Fankui")
public class FankuiController extends BaseController {

    /*业务层对象*/
    @Resource FankuiService fankuiService;

    @Resource ZuzhangService zuzhangService;
	@InitBinder("zuzhangObj")
	public void initBinderzuzhangObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("zuzhangObj.");
	}
	@InitBinder("fankui")
	public void initBinderFankui(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("fankui.");
	}
	/*跳转到添加Fankui视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Fankui());
		/*查询所有的Zuzhang信息*/
		List<Zuzhang> zuzhangList = zuzhangService.queryAllZuzhang();
		request.setAttribute("zuzhangList", zuzhangList);
		return "Fankui_add";
	}

	/*客户端ajax方式提交添加反馈日志信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Fankui fankui, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        fankuiService.addFankui(fankui);
        message = "反馈日志添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	
	/*客户端ajax方式提交添加反馈日志信息*/
	@RequestMapping(value = "/zzAdd", method = RequestMethod.POST)
	public void zzAdd(Fankui fankui, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response,HttpSession session) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
		String zuzhang = (String) session.getAttribute("zuzhang");
		Zuzhang zuzhangObj = new Zuzhang();
		zuzhangObj.setAccount(zuzhang);
		fankui.setZuzhangObj(zuzhangObj);
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		fankui.setFankuiTime(sdf.format(new java.util.Date()));
		
		fankui.setJjcs("--");
		
		
        fankuiService.addFankui(fankui);
        message = "反馈日志添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	
	
	/*ajax方式按照查询条件分页查询反馈日志信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(String title,@ModelAttribute("zuzhangObj") Zuzhang zuzhangObj,String fankuiTime,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (title == null) title = "";
		if (fankuiTime == null) fankuiTime = "";
		if(rows != 0)fankuiService.setRows(rows);
		List<Fankui> fankuiList = fankuiService.queryFankui(title, zuzhangObj, fankuiTime, page);
	    /*计算总的页数和总的记录数*/
	    fankuiService.queryTotalPageAndRecordNumber(title, zuzhangObj, fankuiTime);
	    /*获取到总的页码数目*/
	    int totalPage = fankuiService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = fankuiService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Fankui fankui:fankuiList) {
			JSONObject jsonFankui = fankui.getJsonObject();
			jsonArray.put(jsonFankui);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}
	
	/*ajax方式按照查询条件分页查询反馈日志信息*/
	@RequestMapping(value = { "/zzList" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void zzList(String title,@ModelAttribute("zuzhangObj") Zuzhang zuzhangObj,String fankuiTime,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response,HttpSession session) throws Exception {
		if (page==null || page == 0) page = 1;
		if (title == null) title = "";
		if (fankuiTime == null) fankuiTime = "";
		if(rows != 0)fankuiService.setRows(rows);
		String zuzhang = (String)session.getAttribute("zuzhang");
		zuzhangObj = new Zuzhang();
		zuzhangObj.setAccount(zuzhang);
		
		List<Fankui> fankuiList = fankuiService.queryFankui(title, zuzhangObj, fankuiTime, page);
	    /*计算总的页数和总的记录数*/
	    fankuiService.queryTotalPageAndRecordNumber(title, zuzhangObj, fankuiTime);
	    /*获取到总的页码数目*/
	    int totalPage = fankuiService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = fankuiService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Fankui fankui:fankuiList) {
			JSONObject jsonFankui = fankui.getJsonObject();
			jsonArray.put(jsonFankui);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}
	

	/*ajax方式按照查询条件分页查询反馈日志信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Fankui> fankuiList = fankuiService.queryAllFankui();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Fankui fankui:fankuiList) {
			JSONObject jsonFankui = new JSONObject();
			jsonFankui.accumulate("fankuiId", fankui.getFankuiId());
			jsonFankui.accumulate("title", fankui.getTitle());
			jsonArray.put(jsonFankui);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询反馈日志信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(String title,@ModelAttribute("zuzhangObj") Zuzhang zuzhangObj,String fankuiTime,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (title == null) title = "";
		if (fankuiTime == null) fankuiTime = "";
		List<Fankui> fankuiList = fankuiService.queryFankui(title, zuzhangObj, fankuiTime, currentPage);
	    /*计算总的页数和总的记录数*/
	    fankuiService.queryTotalPageAndRecordNumber(title, zuzhangObj, fankuiTime);
	    /*获取到总的页码数目*/
	    int totalPage = fankuiService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = fankuiService.getRecordNumber();
	    request.setAttribute("fankuiList",  fankuiList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("title", title);
	    request.setAttribute("zuzhangObj", zuzhangObj);
	    request.setAttribute("fankuiTime", fankuiTime);
	    List<Zuzhang> zuzhangList = zuzhangService.queryAllZuzhang();
	    request.setAttribute("zuzhangList", zuzhangList);
		return "Fankui/fankui_frontquery_result"; 
	}

     /*前台查询Fankui信息*/
	@RequestMapping(value="/{fankuiId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer fankuiId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键fankuiId获取Fankui对象*/
        Fankui fankui = fankuiService.getFankui(fankuiId);

        List<Zuzhang> zuzhangList = zuzhangService.queryAllZuzhang();
        request.setAttribute("zuzhangList", zuzhangList);
        request.setAttribute("fankui",  fankui);
        return "Fankui/fankui_frontshow";
	}

	/*ajax方式显示反馈日志修改jsp视图页*/
	@RequestMapping(value="/{fankuiId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer fankuiId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键fankuiId获取Fankui对象*/
        Fankui fankui = fankuiService.getFankui(fankuiId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonFankui = fankui.getJsonObject();
		out.println(jsonFankui.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新反馈日志信息*/
	@RequestMapping(value = "/{fankuiId}/update", method = RequestMethod.POST)
	public void update(@Validated Fankui fankui, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			fankuiService.updateFankui(fankui);
			message = "反馈日志更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "反馈日志更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除反馈日志信息*/
	@RequestMapping(value="/{fankuiId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer fankuiId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  fankuiService.deleteFankui(fankuiId);
	            request.setAttribute("message", "反馈日志删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "反馈日志删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条反馈日志记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String fankuiIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = fankuiService.deleteFankuis(fankuiIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出反馈日志信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(String title,@ModelAttribute("zuzhangObj") Zuzhang zuzhangObj,String fankuiTime, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(title == null) title = "";
        if(fankuiTime == null) fankuiTime = "";
        List<Fankui> fankuiList = fankuiService.queryFankui(title,zuzhangObj,fankuiTime);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Fankui信息记录"; 
        String[] headers = { "反馈id","反馈标题","反馈组长","反馈时间","解决措施"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<fankuiList.size();i++) {
        	Fankui fankui = fankuiList.get(i); 
        	dataset.add(new String[]{fankui.getFankuiId() + "",fankui.getTitle(),fankui.getZuzhangObj().getName(),fankui.getFankuiTime(),fankui.getJjcs()});
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
			response.setHeader("Content-disposition","attachment; filename="+"Fankui.xls");//filename是下载的xls的名，建议最好用英文 
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
