package com.h2cpa.hs.action;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

import com.funtl.permission.entity.PerGroupMenu;
import com.funtl.permission.entity.PerMenuResource;
import com.funtl.permission.entity.PerUser;
import com.funtl.permission.entity.PerUserGroup;
import com.h2cpa.hs.common.CommonBaseAction;
import com.h2cpa.hs.dto.MenuDTO;

/**
 * 界面跳转
 * 
 * @author lusifer
 * 
 */
public class DistributionAction extends CommonBaseAction {
	private static final long serialVersionUID = -1436965970465071555L;
	private JSONObject result;
	private Map<String, Object> request;
	private Map<String, Object> session;

	// page
	
	/**
	 * 主页
	 * @return
	 */
	public String main() throws Exception {
		PerUser admin = (PerUser) session.get("admin");
		
		MenuDTO dto = null;
		List<MenuDTO> dtos = new ArrayList<MenuDTO>();
		
		List<PerUserGroup> groups = admin.getPerUserGroups();
		for (PerUserGroup group : groups) {
			List<PerGroupMenu> menus = group.getPerGroup().getPerGroupMenus();
			for (PerGroupMenu menu : menus) {
				dto = new MenuDTO();
				dto.setMenuName(menu.getPerMenu().getMenuName());
				dto.setResources(new ArrayList<String[]>());
				
				List<PerMenuResource> resources = menu.getPerMenu().getPerMenuResources();
				for (PerMenuResource resource : resources) {
					dto.getResources().add(new String[] {resource.getPerResource().getResourceName(), resource.getPerResource().getResourceUrl()});
				}
				
				dtos.add(dto);
			}
		}
		
		request.put("menus", dtos);
		
		return SUCCESS;
	}
	
	public String loginOut() throws Exception {
		session.clear();
		return SUCCESS;
	}
	
	/*----------权限管理开始----------*/
	
	/**
	 * 用户管理
	 * @return
	 */
	public String permission_manage_user() throws Exception {
		return SUCCESS;
	}
	
	/**
	 * 分组管理
	 * @return
	 * @throws Exception
	 */
	public String permission_manage_group() throws Exception {
		return SUCCESS;
	}
	
	/**
	 * 分栏管理
	 * @return
	 * @throws Exception
	 */
	public String permission_manage_menu() throws Exception {
		return SUCCESS;
	}
	
	/*----------权限管理结束----------*/

	// getter setter

	public JSONObject getResult() {
		return result;
	}

	public void setResult(JSONObject result) {
		this.result = result;
	}

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
}
