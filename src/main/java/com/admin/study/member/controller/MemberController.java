package com.admin.study.member.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.admin.study.member.service.MemberService;


@Controller
@RequestMapping(value = "/admin")
public class MemberController {
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private MemberService memberService;
	
//	private int memCnt;
	
	@RequestMapping(value = "/member" , method = {RequestMethod.GET,RequestMethod.POST})
    public String login(@RequestParam Map<String,Object> param , HttpSession session , Locale locale, ModelMap map) throws Exception{
        logger.info("member Page! {} , {} , {}", session.getId() , locale.getLanguage(), param.toString());
        
    	return "member/member_list.tiles";
    }
	
	@RequestMapping(value = "/select" , method = {RequestMethod.GET,RequestMethod.POST})
    public void Search(@RequestParam Map<String,Object> param , HttpSession session , Locale locale, ModelMap map) throws Exception{
        
		String keyword = StringUtils.defaultString((String)param.get("keyword"), "");
		String selectItem = StringUtils.defaultString((String)param.get("select-item"), "");
		String limit = StringUtils.defaultString((String)param.get("limit"), "");
		String pageNum = StringUtils.defaultString((String)param.get("pageNum"), "");
		
		System.out.println("keyword : "+keyword);
		System.out.println("selectItem : "+selectItem);
		
		List<Map<String, Object>> listAdminInfo = getAdminInfo(keyword, selectItem, limit, pageNum);
		int memCnt = getMemberCount(keyword, selectItem);
		
		map.addAttribute("listAdminInfo", listAdminInfo);
		map.addAttribute("memCnt", memCnt);
    }
	
	private List<Map<String, Object>> getAdminInfo(String keyword, String selectItem, String limit, String pageNum){
		List<Map<String, Object>> listAdminInfo = null;
		if(keyword == ""){
			listAdminInfo = this.memberService.selectAllMember(limit, pageNum);
		} else if(selectItem.equals("all")) {
			listAdminInfo = this.memberService.selectMemberAll(keyword, limit, pageNum);
		}
		else if(selectItem.equals("id")){
			selectItem = "ADMIN_ID";
			listAdminInfo = this.memberService.selectMember(selectItem, keyword, limit, pageNum);
		} else if(selectItem.equals("name")){
			selectItem = "ADMIN_NM";
			listAdminInfo = this.memberService.selectMember(selectItem, keyword, limit, pageNum);
		}
		
		return listAdminInfo;
	}
	
	private int getMemberCount(String keyword, String selectItem){
		int memCnt = 0;
		if(keyword == ""){
			memCnt = this.memberService.countAllMember();
		} else if(selectItem.equals("all")) {
			memCnt = this.memberService.countMemberAll(keyword);
		}
		else if(selectItem.equals("id")){
			selectItem = "ADMIN_ID";
			memCnt = this.memberService.countMember(selectItem, keyword);
		} else if(selectItem.equals("name")){
			selectItem = "ADMIN_NM";
			memCnt = this.memberService.countMember(selectItem, keyword);
		}
		
		return memCnt;
	}
	
	@RequestMapping(value = "/delete" , method = {RequestMethod.GET,RequestMethod.POST})
    public void Delete(@RequestParam Map<String,Object> param , HttpSession session , Locale locale, ModelMap map) throws Exception{
        
//		System.out.println();
		Map<String, Object> mapMemberId = new HashMap<String, Object>();
		Iterator<String> keys = param.keySet().iterator();
//		
		boolean isEmpty = true;
//		System.out.println("Delete ~~~~~~~~~~~~~~~~~=================");
		while(keys.hasNext()){
			String key = keys.next();
			mapMemberId.put(key, StringUtils.defaultString((String)param.get(key), ""));
			System.out.println(StringUtils.defaultString((String)param.get(key), ""));
			isEmpty = false;
		}
//		
		System.out.println("Delete  완료");
//		
		if(isEmpty){
			return;
		} else {
			this.memberService.deleteMember(mapMemberId);
		}
    }
	
	@RequestMapping(value = "/insert" , method = {RequestMethod.GET,RequestMethod.POST})
    public void Insert(@RequestParam Map<String,Object> param , HttpSession session , Locale locale, ModelMap map) throws Exception{
        
		String memId = StringUtils.defaultString((String)param.get("memId"), "");
		String memPass = StringUtils.defaultString((String)param.get("memPass"), "");
		String memName = StringUtils.defaultString((String)param.get("memName"), "");
		String memTelNo = StringUtils.defaultString((String)param.get("memTelNo"), "");
		String memMobileNo = StringUtils.defaultString((String)param.get("memMobileNo"), "");
		String memEmail = StringUtils.defaultString((String)param.get("memEmail"), "");
		
		int result = memberService.insertMember(memId, memPass, memName, memTelNo, memMobileNo, memEmail);
		
		System.out.println("result : ====================== "+result);
    }
	
	@RequestMapping(value = "/excel" , method = {RequestMethod.GET,RequestMethod.POST})
    public void DownloadExcel(HttpServletResponse response, @RequestParam Map<String,Object> param , HttpSession session , Locale locale, ModelMap map) throws Exception{
		String keyword = StringUtils.defaultString((String)param.get("keyword"), "");
		String selectItem = StringUtils.defaultString((String)param.get("select-item"), "");
		
		String limit = "99999";
		String pageNum = "1";
		
		ServletContext context = session.getServletContext();
		String filePath = context.getRealPath("/files");
		
		filePath = "C:\\Test";
		String fileName = "data.xls";
		
		
		response.setCharacterEncoding("euc-kr");
		response.setContentType("application/octet-stream charset=\"euc-kr\"");
		response.setHeader("Content-Disposition", "attachment; filename=\""+fileName+"\"");
		
		System.out.println("fileName : "+fileName);
		
		FileOutputStream fileOut = new FileOutputStream(filePath+"\\"+fileName);
		
		List<Map<String, Object>> listAdminInfo = getAdminInfo(keyword, selectItem, limit, pageNum);
		
		HSSFWorkbook workbook = new HSSFWorkbook(); 
		

		int cellCnt = 0;
		
		HSSFSheet worksheet = workbook.createSheet("sheetName");
		HSSFRow row = worksheet.createRow(cellCnt++); 

		row.createCell(0).setCellValue("번호"); 
		row.createCell(1).setCellValue("이름"); 
		row.createCell(2).setCellValue("아이디"); 
		row.createCell(3).setCellValue("전화번호"); 
		row.createCell(4).setCellValue("핸드폰번호"); 
		row.createCell(5).setCellValue("이메일");
		row.createCell(6).setCellValue("사용가능");
//		row.createCell(7).setCellValue("로그인 실패 횟수");
		row.createCell(8).setCellValue("가입일");
		row.createCell(9).setCellValue("수정일");
		 
		for (Map<String, Object> adminInfo : listAdminInfo) {
			row = worksheet.createRow(cellCnt++);
			row.createCell(1).setCellValue((String)adminInfo.get("ADMIN_NM"));
			row.createCell(2).setCellValue((String)adminInfo.get("ADMIN_ID"));
			row.createCell(3).setCellValue((String)adminInfo.get("TEL_NO"));
			row.createCell(4).setCellValue((String)adminInfo.get("MOBILE_NO"));
			row.createCell(5).setCellValue((String)adminInfo.get("EMAIL"));
			row.createCell(6).setCellValue((String)adminInfo.get("USE_YN"));
//			row.createCell(7).setCellValue((Integer)adminInfo.get("LOGIN_FAIL_CNT"));
			row.createCell(8).setCellValue((String)adminInfo.get("CRE_DT"));
			row.createCell(9).setCellValue((String)adminInfo.get("MOD_DT"));
		}
		
		workbook.write(fileOut);
		fileOut.close();
    }
}
