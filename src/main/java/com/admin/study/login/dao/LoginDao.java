package com.admin.study.login.dao;

import java.util.Map;
import org.springframework.stereotype.Repository;
import com.admin.common.mybatis.QueryMapper;

@Repository
public class LoginDao extends QueryMapper{
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectAdminInfo(Map<String, Object> param){
		return (Map<String, Object>)super.selectOne("login.selectAdminInfo", param);
	}
}
