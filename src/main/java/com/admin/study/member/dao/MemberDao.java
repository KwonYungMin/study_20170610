package com.admin.study.member.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.admin.common.mybatis.QueryMapper;

@Repository
public class MemberDao extends QueryMapper {
	public int countAllMember(){
		return (Integer)super.selectOne("member.countAllMember");
	}
	
	public int countMemberAll(Map<String, Object> param){
		return (Integer)super.selectOne("member.countMemberAll", param);
	}
	
	public int countMember(Map<String, Object> param){
		return (Integer)super.selectOne("member.countMember", param);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectAllMember(Map<String, Object> param){
		return (List<Map<String, Object>>)super.selectList("member.selectAllMember", param);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectMemberAll(Map<String, Object> param){
		return (List<Map<String, Object>>)super.selectList("member.selectMemberAll", param);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectMember(Map<String, Object> param){
		return (List<Map<String, Object>>)super.selectList("member.selectMember", param);
	}
	
	public int deleteMemeber(Map<String, Object> param){
		return super.delete("member.deleteMember", param);
	}
	
	public int insertMemeber(Map<String, Object> param){
		return super.insert("member.insertMember", param);
	}
}
