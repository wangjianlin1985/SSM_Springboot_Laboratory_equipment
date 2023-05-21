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
import com.chengxusheji.service.ZuzhangService;
import com.chengxusheji.po.Zuzhang;

//Zuzhang管理控制层
@Controller
@RequestMapping("/Zuzhang")
public class ZuzhangController extends BaseController {

    /*业务层对象*/
    @Resource ZuzhangService zuzhangService;

	@InitBinder("zuzhang")
	public void initBinderZuzhang(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("zuzhang.");
	}
	/*跳转到添加Zuzhang视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Zuzhang());
		return "Zuzhang_add";
	}

	/*客户端ajax方式提交添加组长信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(Zuzhang zuzhang, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		
		if(zuzhangService.getZuzhang(zuzhang.getAccount()) != null) {
			message = "账号已经存在！";
			writeJsonResponse(response, success, message);
			return ;
		}
		try {
			zuzhang.setZuzhangPhoto(this.handlePhotoUpload(request, "zuzhangPhotoFile"));
		} catch(UserException ex) {
			message = "图片格式不正确！";
			writeJsonResponse(response, success, message);
			return ;
		}
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		zuzhang.setRegTime(sdf.format(new java.util.Date()));
		
        zuzhangService.addZuzhang(zuzhang);
        message = "组长添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询组长信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(String account,String name,String birthDate,String telephone,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (account == null) account = "";
		if (name == null) name = "";
		if (birthDate == null) birthDate = "";
		if (telephone == null) telephone = "";
		if(rows != 0)zuzhangService.setRows(rows);
		List<Zuzhang> zuzhangList = zuzhangService.queryZuzhang(account, name, birthDate, telephone, page);
	    /*计算总的页数和总的记录数*/
	    zuzhangService.queryTotalPageAndRecordNumber(account, name, birthDate, telephone);
	    /*获取到总的页码数目*/
	    int totalPage = zuzhangService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = zuzhangService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Zuzhang zuzhang:zuzhangList) {
			JSONObject jsonZuzhang = zuzhang.getJsonObject();
			jsonArray.put(jsonZuzhang);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询组长信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Zuzhang> zuzhangList = zuzhangService.queryAllZuzhang();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Zuzhang zuzhang:zuzhangList) {
			JSONObject jsonZuzhang = new JSONObject();
			jsonZuzhang.accumulate("account", zuzhang.getAccount());
			jsonZuzhang.accumulate("name", zuzhang.getName());
			jsonArray.put(jsonZuzhang);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询组长信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(String account,String name,String birthDate,String telephone,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (account == null) account = "";
		if (name == null) name = "";
		if (birthDate == null) birthDate = "";
		if (telephone == null) telephone = "";
		List<Zuzhang> zuzhangList = zuzhangService.queryZuzhang(account, name, birthDate, telephone, currentPage);
	    /*计算总的页数和总的记录数*/
	    zuzhangService.queryTotalPageAndRecordNumber(account, name, birthDate, telephone);
	    /*获取到总的页码数目*/
	    int totalPage = zuzhangService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = zuzhangService.getRecordNumber();
	    request.setAttribute("zuzhangList",  zuzhangList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("account", account);
	    request.setAttribute("name", name);
	    request.setAttribute("birthDate", birthDate);
	    request.setAttribute("telephone", telephone);
		return "Zuzhang/zuzhang_frontquery_result"; 
	}

     /*前台查询Zuzhang信息*/
	@RequestMapping(value="/{account}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable String account,Model model,HttpServletRequest request) throws Exception {
		/*根据主键account获取Zuzhang对象*/
        Zuzhang zuzhang = zuzhangService.getZuzhang(account);

        request.setAttribute("zuzhang",  zuzhang);
        return "Zuzhang/zuzhang_frontshow";
	}

	/*ajax方式显示组长修改jsp视图页*/
	@RequestMapping(value="/{account}/update",method=RequestMethod.GET)
	public void update(@PathVariable String account,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键account获取Zuzhang对象*/
        Zuzhang zuzhang = zuzhangService.getZuzhang(account);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonZuzhang = zuzhang.getJsonObject();
		out.println(jsonZuzhang.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新组长信息*/
	@RequestMapping(value = "/{account}/update", method = RequestMethod.POST)
	public void update(@Validated Zuzhang zuzhang, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		String zuzhangPhotoFileName = this.handlePhotoUpload(request, "zuzhangPhotoFile");
		if(!zuzhangPhotoFileName.equals("upload/NoImage.jpg"))zuzhang.setZuzhangPhoto(zuzhangPhotoFileName); 


		try {
			zuzhangService.updateZuzhang(zuzhang);
			message = "组长更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "组长更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除组长信息*/
	@RequestMapping(value="/{account}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable String account,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  zuzhangService.deleteZuzhang(account);
	            request.setAttribute("message", "组长删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "组长删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条组长记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String accounts,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = zuzhangService.deleteZuzhangs(accounts);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出组长信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(String account,String name,String birthDate,String telephone, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(account == null) account = "";
        if(name == null) name = "";
        if(birthDate == null) birthDate = "";
        if(telephone == null) telephone = "";
        List<Zuzhang> zuzhangList = zuzhangService.queryZuzhang(account,name,birthDate,telephone);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Zuzhang信息记录"; 
        String[] headers = { "账号","姓名","性别","出生日期","组长照片","联系电话","邮箱","注册时间"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<zuzhangList.size();i++) {
        	Zuzhang zuzhang = zuzhangList.get(i); 
        	dataset.add(new String[]{zuzhang.getAccount(),zuzhang.getName(),zuzhang.getGender(),zuzhang.getBirthDate(),zuzhang.getZuzhangPhoto(),zuzhang.getTelephone(),zuzhang.getEmail(),zuzhang.getRegTime()});
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
			response.setHeader("Content-disposition","attachment; filename="+"Zuzhang.xls");//filename是下载的xls的名，建议最好用英文 
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
