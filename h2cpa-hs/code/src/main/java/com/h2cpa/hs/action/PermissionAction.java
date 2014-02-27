package com.h2cpa.hs.action;

import java.util.Map;

import net.sf.json.JSONObject;

import com.h2cpa.hs.common.CommonBaseAction;

public class PermissionAction extends CommonBaseAction {
	private static final long serialVersionUID = -5673642669135123090L;
	private JSONObject result;
	private Map<String, Object> request;
	private Map<String, Object> session;
	
	//参数
	
	private String securityCode;

	// action
	
	/**
	 * 验证码
	 * @return
	 * @throws Exception
	 */
	public String verify() throws Exception {
		String serverCode = (String) session.get("SESSION_SECURITY_CODE");
		if (!serverCode.equals(securityCode)) {
			jsonData.put("message", "验证码输入错误");
		}
		
		result = JSONObject.fromObject(jsonData);
		
		return SUCCESS;
	}

	// getter setter

	public Map<String, Object> getRequest() {
		return request;
	}

	public void setRequest(Map<String, Object> request) {
		this.request = request;
	}

	public Map<String, Object> getSession() {
		return session;
	}

	public void setSession(Map<String, Object> session) {
		this.session = session;
	}

	public JSONObject getResult() {
		return result;
	}

	public void setResult(JSONObject result) {
		this.result = result;
	}

	public String getSecurityCode() {
		return securityCode;
	}

	public void setSecurityCode(String securityCode) {
		this.securityCode = securityCode;
	}
}
