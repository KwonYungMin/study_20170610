package com.admin.study.member.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.admin.study.member.dao.MemberDao;

@Service
public class MemberService {
	private Logger logger = LoggerFactory.getLogger(this.getClass());
//	
	@Autowired
	private MemberDao memberDao;
	
	public int countAllMember(){
		return memberDao.countAllMember(); 
	}
	
	public int countMemberAll(String keyword){
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("KEYWORD", keyword);
		
		return memberDao.countMemberAll(param); 
	}
	
	public int countMember(String selectItem, String keyword){
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("ITEM", selectItem);
		param.put("KEYWORD", keyword);
		
		return memberDao.countMember(param); 
	}
	
//	public int countMemberName(String keyword){
//		Map<String, Object> param = new HashMap<String, Object>();
//		param.put("ITEM", "ADMIN_NM");
//		param.put("KEYWORD", keyword);
//		
//		return memberDao.countMemberName(param); 
//	}
	
	public List<Map<String, Object>> selectAllMember(String limit, String pageNum){
		
		if(StringUtils.isEmpty(limit)){
			return null;
		}
		
		int limit_1 = (Integer.parseInt(pageNum)-1) * Integer.parseInt(limit);
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("LIMIT_NUM_1", limit_1);
		param.put("LIMIT_NUM_2", limit);
		
		return memberDao.selectAllMember(param); 
	}
	
	public List<Map<String, Object>> selectMemberAll(String keyword, 
			String limit, String pageNum){
		
		if(StringUtils.isEmpty(limit)){
			return null;
		}
		
		int limit_1 = (Integer.parseInt(pageNum)-1) * Integer.parseInt(limit);
		
		Map<String, Object> param = new HashMap<String, Object>();
		System.out.println("keyword : "+keyword);
		param.put("KEYWORD", keyword);
		param.put("LIMIT_NUM_1", limit_1);
		param.put("LIMIT_NUM_2", limit);
		
		return memberDao.selectMemberAll(param); 
	}
	
	public List<Map<String, Object>> selectMember(String selectItem, String keyword, 
			String limit, String pageNum){
		
		if(StringUtils.isEmpty(selectItem) || StringUtils.isEmpty(keyword) || StringUtils.isEmpty(limit) 
				|| StringUtils.isEmpty(pageNum)){
			return null;
		}
		
		int limit_1 = (Integer.parseInt(pageNum)-1) * Integer.parseInt(limit);
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("ITEM", selectItem);
		param.put("KEYWORD", keyword);
		param.put("LIMIT_NUM_1", limit_1);
		param.put("LIMIT_NUM_2", limit);
		
		
		return memberDao.selectMember(param); 
	}
	
	public int deleteMember(Map<String, Object> mapMemberId){
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("MEMBER_ID", mapMemberId);
		
		return memberDao.deleteMemeber(param); 
	}
	
	public int insertMember(String id, String pass, String name, String tel_No, String Mobile_No, String email){
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("MEMBER_ID", id);
		param.put("MEMBER_PWD", pass);
		param.put("MEMBER_NM", name);
		param.put("TEL_NO", tel_No);
		param.put("MOBILE_NO", Mobile_No);
		param.put("EMAIL", email);
		
		return memberDao.insertMemeber(param); 
	}
}
