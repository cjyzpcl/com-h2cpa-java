package com.h2cpa.hs.api;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.apache.struts2.ServletActionContext;

import com.funtl.article.entity.ArtCategory;
import com.funtl.orm.hibernate.HibernateDao;
import com.funtl.util.bean.BeanUtil;
import com.h2cpa.hs.api.dto.ArticleCategoryDTO;
import com.h2cpa.hs.common.CommonBaseAction;

public class ArticleCategory extends CommonBaseAction {
	private static final long serialVersionUID = -5736126536591043211L;
	private JSONArray result;
	private Map<String, Object> request;
	private Map<String, Object> session;
	private String jsoncallback;

	@Resource
	private HibernateDao hibernateDao;

	// hql

	private static final String CATEGORY_PID = "FROM ArtCategory t WHERE t.categoryPid = :categoryPid";

	// parameter

	// action

	/**
	 * 获取根目录 http://localhost:8080/h2cpa-hs/api/category/roots
	 * 
	 * @return
	 * @throws Exception
	 */
	public String roots() throws Exception {
		// 根目录

		ArtCategory rootCategory = (ArtCategory) hibernateDao.getListByHql(
				CATEGORY_PID,
				new String[][] { new String[] { "categoryPid", "0" } }).get(0);

		// 直属根目录的子目录

		List<ArtCategory> list = hibernateDao.getListByHql(
				CATEGORY_PID,
				new String[][] { new String[] { "categoryPid",
						rootCategory.getCategoryId() } });

		ArticleCategoryDTO dto = null;
		List<ArticleCategoryDTO> dtos = new ArrayList<ArticleCategoryDTO>();
		if (list != null && list.size() > 0) {
			for (ArtCategory obj : list) {
				dto = new ArticleCategoryDTO();
				BeanUtil.beanToBean(dto, obj);
				dtos.add(dto);
			}
		}

		result = JSONArray.fromObject(dtos);

		// 返回跨域请求的数据

		if (jsoncallback != null) {
			String callback = jsoncallback + "(" + result + ")";
			HttpServletResponse response = ServletActionContext.getResponse();
			response.getWriter().print(callback);
			return null;
		}

		return SUCCESS;
	}

	// getter setter

	public JSONArray getResult() {
		return result;
	}

	public void setResult(JSONArray result) {
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

	public String getJsoncallback() {
		return jsoncallback;
	}

	public void setJsoncallback(String jsoncallback) {
		this.jsoncallback = jsoncallback;
	}
}
