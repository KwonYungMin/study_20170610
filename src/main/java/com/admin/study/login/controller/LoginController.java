package com.admin.study.login.controller;

import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;


import org.apache.commons.lang.StringUtils;

import com.admin.common.constant.Constant;
import com.admin.common.exception.BadRquestException;
import com.admin.common.listener.SessionDupListener;
import com.admin.study.login.service.LoginService;



@Controller
@RequestMapping(value = "/admin")
public class LoginController {
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private LoginService loginService;
	/**
     * Simply selects the home view to render by returning its name.
     */
	
	@RequestMapping(value = "/login" , method = {RequestMethod.GET,RequestMethod.POST})
    public String login(@RequestParam Map<String,Object> param , HttpSession session , Locale locale, ModelMap map) throws Exception{
        logger.info("Welcome login! {} , {} , {}", session.getId() , locale.getLanguage(), param.toString());
        
    	return "login";
    }
	@RequestMapping(value = "/logout", method = {RequestMethod.GET,RequestMethod.POST})
    public void logout(HttpSession session, HttpServletRequest req, HttpServletResponse rep) throws Exception{

		session.invalidate();
		
		rep.sendRedirect("/admin/login");
    }
	  
    @RequestMapping(value = "/loginProcess", method =RequestMethod.POST)
    public void loginProcess(@RequestParam Map<String,Object> param, HttpSession session,  ModelMap map) throws Exception{
    	String id = StringUtils.defaultString((String)param.get("userId"), "");
    	String pass = StringUtils.defaultString((String)param.get("password"), "");
    	String redirectUrl = StringUtils.defaultString((String)param.get("redirectUrl"), "");
    	
    	Map<String, Object> adminInfo = this.loginService.getAdminInfo(id, pass);

    	String msg = SessionDupListener.getIdChk(session.getId(), id);
    	if(adminInfo == null) { throw new BadRquestException(Constant.propertyMap.get("key_3"), 100); }
    	
    	
    	logger.info("id   ======================  "+id);
    	logger.info("pass   ======================  "+pass);
    	
    	logger.info("msg   ======================  "+msg);
    	logger.info("session.getId()   ======================  "+session.getId());
    	
    	if(msg != null){
    		map.addAttribute("resultCode", 100);
    		map.addAttribute("message", msg);
    	}else{
    		session.setAttribute("adminInfo", adminInfo);
    		session.setAttribute("listener", new SessionDupListener());
    		map.addAttribute("resultCode", 1);
    		map.addAttribute("redirectUrl", redirectUrl);
    	}
    }
}
