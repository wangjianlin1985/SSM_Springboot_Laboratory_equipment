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
import com.chengxusheji.service.ScrapService;
import com.chengxusheji.po.Scrap;
import com.chengxusheji.service.DeviceService;
import com.chengxusheji.po.Device;

//Scrap管理控制层
@Controller
@RequestMapping("/Scrap")
public class ScrapController extends BaseController {

    /*业务层对象*/
    @Resource ScrapService scrapService;

    @Resource DeviceService deviceService;
	@InitBinder("deviceObj")
	public void initBinderdeviceObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("deviceObj.");
	}
	@InitBinder("scrap")
	public void initBinderScrap(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("scrap.");
	}
	/*跳转到添加Scrap视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Scrap());
		/*查询所有的Device信息*/
		List<Device> deviceList = deviceService.queryAllDevice();
		request.setAttribute("deviceList", deviceList);
		return "Scrap_add";
	}

	/*客户端ajax方式提交添加设备报废信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Scrap scrap, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        scrapService.addScrap(scrap);
        message = "设备报废添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询设备报废信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("deviceObj") Device deviceObj,String reason,String scrapDate,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (reason == null) reason = "";
		if (scrapDate == null) scrapDate = "";
		if(rows != 0)scrapService.setRows(rows);
		List<Scrap> scrapList = scrapService.queryScrap(deviceObj, reason, scrapDate, page);
	    /*计算总的页数和总的记录数*/
	    scrapService.queryTotalPageAndRecordNumber(deviceObj, reason, scrapDate);
	    /*获取到总的页码数目*/
	    int totalPage = scrapService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = scrapService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Scrap scrap:scrapList) {
			JSONObject jsonScrap = scrap.getJsonObject();
			jsonArray.put(jsonScrap);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询设备报废信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Scrap> scrapList = scrapService.queryAllScrap();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Scrap scrap:scrapList) {
			JSONObject jsonScrap = new JSONObject();
			jsonScrap.accumulate("scrapId", scrap.getScrapId());
			jsonArray.put(jsonScrap);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询设备报废信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("deviceObj") Device deviceObj,String reason,String scrapDate,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (reason == null) reason = "";
		if (scrapDate == null) scrapDate = "";
		List<Scrap> scrapList = scrapService.queryScrap(deviceObj, reason, scrapDate, currentPage);
	    /*计算总的页数和总的记录数*/
	    scrapService.queryTotalPageAndRecordNumber(deviceObj, reason, scrapDate);
	    /*获取到总的页码数目*/
	    int totalPage = scrapService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = scrapService.getRecordNumber();
	    request.setAttribute("scrapList",  scrapList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("deviceObj", deviceObj);
	    request.setAttribute("reason", reason);
	    request.setAttribute("scrapDate", scrapDate);
	    List<Device> deviceList = deviceService.queryAllDevice();
	    request.setAttribute("deviceList", deviceList);
		return "Scrap/scrap_frontquery_result"; 
	}

     /*前台查询Scrap信息*/
	@RequestMapping(value="/{scrapId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer scrapId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键scrapId获取Scrap对象*/
        Scrap scrap = scrapService.getScrap(scrapId);

        List<Device> deviceList = deviceService.queryAllDevice();
        request.setAttribute("deviceList", deviceList);
        request.setAttribute("scrap",  scrap);
        return "Scrap/scrap_frontshow";
	}

	/*ajax方式显示设备报废修改jsp视图页*/
	@RequestMapping(value="/{scrapId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer scrapId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键scrapId获取Scrap对象*/
        Scrap scrap = scrapService.getScrap(scrapId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonScrap = scrap.getJsonObject();
		out.println(jsonScrap.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新设备报废信息*/
	@RequestMapping(value = "/{scrapId}/update", method = RequestMethod.POST)
	public void update(@Validated Scrap scrap, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			scrapService.updateScrap(scrap);
			message = "设备报废更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "设备报废更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除设备报废信息*/
	@RequestMapping(value="/{scrapId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer scrapId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  scrapService.deleteScrap(scrapId);
	            request.setAttribute("message", "设备报废删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "设备报废删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条设备报废记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String scrapIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = scrapService.deleteScraps(scrapIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出设备报废信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("deviceObj") Device deviceObj,String reason,String scrapDate, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(reason == null) reason = "";
        if(scrapDate == null) scrapDate = "";
        List<Scrap> scrapList = scrapService.queryScrap(deviceObj,reason,scrapDate);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Scrap信息记录"; 
        String[] headers = { "报废id","报废的设备","报废数量","报废原因","报废日期"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<scrapList.size();i++) {
        	Scrap scrap = scrapList.get(i); 
        	dataset.add(new String[]{scrap.getScrapId() + "",scrap.getDeviceObj().getDeviceName(),scrap.getScrapCount() + "",scrap.getReason(),scrap.getScrapDate()});
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
			response.setHeader("Content-disposition","attachment; filename="+"Scrap.xls");//filename是下载的xls的名，建议最好用英文 
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
