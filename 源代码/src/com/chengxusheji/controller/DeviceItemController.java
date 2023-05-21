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
import com.chengxusheji.po.DeviceItem;
import com.chengxusheji.service.DeviceService;
import com.chengxusheji.po.Device;
import com.chengxusheji.service.ShiyanService;
import com.chengxusheji.po.Shiyan;

//DeviceItem管理控制层
@Controller
@RequestMapping("/DeviceItem")
public class DeviceItemController extends BaseController {

    /*业务层对象*/
    @Resource DeviceItemService deviceItemService;

    @Resource DeviceService deviceService;
    @Resource ShiyanService shiyanService;
	@InitBinder("shiyanObj")
	public void initBindershiyanObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("shiyanObj.");
	}
	@InitBinder("deviceObj")
	public void initBinderdeviceObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("deviceObj.");
	}
	@InitBinder("deviceItem")
	public void initBinderDeviceItem(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("deviceItem.");
	}
	/*跳转到添加DeviceItem视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new DeviceItem());
		/*查询所有的Device信息*/
		List<Device> deviceList = deviceService.queryAllDevice();
		request.setAttribute("deviceList", deviceList);
		/*查询所有的Shiyan信息*/
		List<Shiyan> shiyanList = shiyanService.queryAllShiyan();
		request.setAttribute("shiyanList", shiyanList);
		return "DeviceItem_add";
	}

	/*客户端ajax方式提交添加实验设备条目信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated DeviceItem deviceItem, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
		
		if(deviceItemService.queryDeviceItem(deviceItem.getShiyanObj(),deviceItem.getDeviceObj()).size() > 0) {
			message = "该实验已经登记了该设备 ！";
			writeJsonResponse(response, success, message);
			return ;
		}
		
        deviceItemService.addDeviceItem(deviceItem);
        message = "实验设备条目添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询实验设备条目信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("shiyanObj") Shiyan shiyanObj,@ModelAttribute("deviceObj") Device deviceObj,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if(rows != 0)deviceItemService.setRows(rows);
		List<DeviceItem> deviceItemList = deviceItemService.queryDeviceItem(shiyanObj, deviceObj, page);
	    /*计算总的页数和总的记录数*/
	    deviceItemService.queryTotalPageAndRecordNumber(shiyanObj, deviceObj);
	    /*获取到总的页码数目*/
	    int totalPage = deviceItemService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = deviceItemService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(DeviceItem deviceItem:deviceItemList) {
			JSONObject jsonDeviceItem = deviceItem.getJsonObject();
			jsonArray.put(jsonDeviceItem);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}
	
	
	/*ajax方式按照查询条件分页查询实验设备条目信息*/
	@RequestMapping(value = { "/zzList" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void zzList(@ModelAttribute("shiyanObj") Shiyan shiyanObj,@ModelAttribute("deviceObj") Device deviceObj,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response,HttpSession session) throws Exception {
		if (page==null || page == 0) page = 1;
		if(rows != 0)deviceItemService.setRows(rows);
		String zuzhang = (String)session.getAttribute("zuzhang");
		List<DeviceItem> deviceItemList = deviceItemService.zzQueryDeviceItem(zuzhang,shiyanObj, deviceObj, page);
	    /*计算总的页数和总的记录数*/
	    deviceItemService.zzQueryTotalPageAndRecordNumber(zuzhang,shiyanObj, deviceObj);
	    /*获取到总的页码数目*/
	    int totalPage = deviceItemService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = deviceItemService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(DeviceItem deviceItem:deviceItemList) {
			JSONObject jsonDeviceItem = deviceItem.getJsonObject();
			jsonArray.put(jsonDeviceItem);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}
	

	/*ajax方式按照查询条件分页查询实验设备条目信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<DeviceItem> deviceItemList = deviceItemService.queryAllDeviceItem();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(DeviceItem deviceItem:deviceItemList) {
			JSONObject jsonDeviceItem = new JSONObject();
			jsonDeviceItem.accumulate("deviceItemId", deviceItem.getDeviceItemId());
			jsonArray.put(jsonDeviceItem);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询实验设备条目信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("shiyanObj") Shiyan shiyanObj,@ModelAttribute("deviceObj") Device deviceObj,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		List<DeviceItem> deviceItemList = deviceItemService.queryDeviceItem(shiyanObj, deviceObj, currentPage);
	    /*计算总的页数和总的记录数*/
	    deviceItemService.queryTotalPageAndRecordNumber(shiyanObj, deviceObj);
	    /*获取到总的页码数目*/
	    int totalPage = deviceItemService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = deviceItemService.getRecordNumber();
	    request.setAttribute("deviceItemList",  deviceItemList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("shiyanObj", shiyanObj);
	    request.setAttribute("deviceObj", deviceObj);
	    List<Device> deviceList = deviceService.queryAllDevice();
	    request.setAttribute("deviceList", deviceList);
	    List<Shiyan> shiyanList = shiyanService.queryAllShiyan();
	    request.setAttribute("shiyanList", shiyanList);
		return "DeviceItem/deviceItem_frontquery_result"; 
	}

     /*前台查询DeviceItem信息*/
	@RequestMapping(value="/{deviceItemId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer deviceItemId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键deviceItemId获取DeviceItem对象*/
        DeviceItem deviceItem = deviceItemService.getDeviceItem(deviceItemId);

        List<Device> deviceList = deviceService.queryAllDevice();
        request.setAttribute("deviceList", deviceList);
        List<Shiyan> shiyanList = shiyanService.queryAllShiyan();
        request.setAttribute("shiyanList", shiyanList);
        request.setAttribute("deviceItem",  deviceItem);
        return "DeviceItem/deviceItem_frontshow";
	}

	/*ajax方式显示实验设备条目修改jsp视图页*/
	@RequestMapping(value="/{deviceItemId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer deviceItemId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键deviceItemId获取DeviceItem对象*/
        DeviceItem deviceItem = deviceItemService.getDeviceItem(deviceItemId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonDeviceItem = deviceItem.getJsonObject();
		out.println(jsonDeviceItem.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新实验设备条目信息*/
	@RequestMapping(value = "/{deviceItemId}/update", method = RequestMethod.POST)
	public void update(@Validated DeviceItem deviceItem, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			deviceItemService.updateDeviceItem(deviceItem);
			message = "实验设备条目更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "实验设备条目更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除实验设备条目信息*/
	@RequestMapping(value="/{deviceItemId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer deviceItemId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  deviceItemService.deleteDeviceItem(deviceItemId);
	            request.setAttribute("message", "实验设备条目删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "实验设备条目删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条实验设备条目记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String deviceItemIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = deviceItemService.deleteDeviceItems(deviceItemIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出实验设备条目信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("shiyanObj") Shiyan shiyanObj,@ModelAttribute("deviceObj") Device deviceObj, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        List<DeviceItem> deviceItemList = deviceItemService.queryDeviceItem(shiyanObj,deviceObj);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "DeviceItem信息记录"; 
        String[] headers = { "记录id","实验名称","所需设备","所需数量"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<deviceItemList.size();i++) {
        	DeviceItem deviceItem = deviceItemList.get(i); 
        	dataset.add(new String[]{deviceItem.getDeviceItemId() + "",deviceItem.getShiyanObj().getShiyanName(),deviceItem.getDeviceObj().getDeviceName(),deviceItem.getDeviceCount() + ""});
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
			response.setHeader("Content-disposition","attachment; filename="+"DeviceItem.xls");//filename是下载的xls的名，建议最好用英文 
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
