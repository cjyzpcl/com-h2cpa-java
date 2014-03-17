package com.h2cpa.hs.action;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import net.sf.json.JSONObject;

import com.funtl.permission.entity.PerGroup;
import com.funtl.permission.entity.PerGroupMenu;
import com.funtl.permission.entity.PerMenu;
import com.funtl.permission.entity.PerMenuResource;
import com.funtl.permission.entity.PerResource;
import com.funtl.permission.entity.PerUser;
import com.funtl.permission.entity.PerUserGroup;
import com.funtl.permission.service.PerGroupService;
import com.funtl.permission.service.PerMenuService;
import com.funtl.permission.service.PerResourceService;
import com.funtl.permission.service.PerUserService;
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
	
	@Resource
	private PerUserService perUserService;
	@Resource
	private PerMenuService perMenuService;
	@Resource
	private PerGroupService perGroupService;
	@Resource
	private PerResourceService perResourceService;

	// page
	
	/**
	 * 主页
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public String main() throws Exception {
		PerUser admin = (PerUser) session.get("admin");
		session.put("adminName", admin.getUserName());
		
		MenuDTO dto = null;
		List<MenuDTO> dtos = new ArrayList<MenuDTO>();
		
		List<PerUserGroup> groups = admin.getPerUserGroups();
		for (PerUserGroup group : groups) {
			List<PerGroupMenu> menus = group.getPerGroup().getPerGroupMenus();
			
			//分栏排序
			
			Collections.sort(menus, new Comparator() {
				public int compare(Object o1, Object o2) {
					PerGroupMenu t1 = (PerGroupMenu) o1;
					PerGroupMenu t2 = (PerGroupMenu) o2;
					if (t1.getPerMenu().getMenuSort() > t2.getPerMenu().getMenuSort()) {
						return 1;
					} else if (t1.getPerMenu().getMenuSort() == t2.getPerMenu().getMenuSort()) {
						return 0;
					} else {
						return -1;
					}
				}
			});

			for (PerGroupMenu menu : menus) {
				dto = new MenuDTO();
				dto.setMenuName(menu.getPerMenu().getMenuName());
				dto.setResources(new ArrayList<String[]>());
				
				List<PerMenuResource> resources = menu.getPerMenu().getPerMenuResources();
				
				//资源排序
				
				Collections.sort(resources, new Comparator() {
					public int compare(Object o1, Object o2) {
						PerMenuResource t1 = (PerMenuResource) o1;
						PerMenuResource t2 = (PerMenuResource) o2;
						if (t1.getPerResource().getResourceSort() > t2.getPerResource().getResourceSort()) {
							return 1;
						} else if (t1.getPerResource().getResourceSort() == t2.getPerResource().getResourceSort()) {
							return 0;
						} else {
							return -1;
						}
					}
				});
				
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
	
	/**
	 * 资源管理
	 * @return
	 * @throws Exception
	 */
	public String permission_manage_resource() throws Exception {
		return SUCCESS;
	}
	
	/**
	 * 权限管理
	 * @return
	 * @throws Exception
	 */
	public String permission_manage_manage() throws Exception {
		//分组
		
		List<PerGroup> groupList = perGroupService.queryList();
		List<String[]> groups = new ArrayList<String[]>();
		if (groupList != null && groupList.size() > 0) {
			for (PerGroup group : groupList) {
				String[] str = new String[] {group.getGroupId(), group.getGroupName()};
				groups.add(str);
			}
		}
		
		//用户
		
		List<PerUser> userList = perUserService.queryList();
		List<String[]> users = new ArrayList<String[]>();
		if (userList != null && userList.size() > 0) {
			for (PerUser user : userList) {
				String[] str = new String[] {user.getUserId(), user.getUserName()};
				users.add(str);
			}
		}
		
		//分栏
		
		List<PerMenu> menuList = perMenuService.queryList();
		List<String[]> menus = new ArrayList<String[]>();
		if (userList != null && userList.size() > 0) {
			for (PerMenu menu : menuList) {
				String[] str = new String[] {menu.getMenuId(), menu.getMenuName()};
				menus.add(str);
			}
		}
		
		//资源
		
		List<PerResource> resourceList = perResourceService.queryList();
		List<String[]> resources = new ArrayList<String[]>();
		if (resourceList != null && resourceList.size() > 0) {
			for (PerResource resource : resourceList) {
				String[] str = new String[] {resource.getResourceId(), resource.getResourceName()};
				resources.add(str);
			}
		}
		
		request.put("groups", groups);
		request.put("users", users);
		request.put("menus", menus);
		request.put("resources", resources);
		
		return SUCCESS;
	}
	
	/*----------权限管理结束----------*/
	
	/*----------文章管理开始----------*/
	
	/**
	 * 分类管理
	 * @return
	 * @throws Exception
	 */
	public String article_manage_category() throws Exception {
		return SUCCESS;
	}
	
	/**
	 * 文章管理
	 * @return
	 * @throws Exception
	 */
	public String article_manage_info() throws Exception {
		return SUCCESS;
	}
	
	/*----------文章管理结束----------*/

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
