package com.h2cpa.hs.api.dto;

import java.io.Serializable;

public class ArticleCategoryDTO implements Serializable {
	private static final long serialVersionUID = -4076181570670716291L;
	private String categoryId;
	private String categoryPid;
	private Integer categoryType;
	private String categoryTitle;
	private String categorySubtitle;
	private String categorySimg;
	private String categoryBimg;
	private Integer categoryLorder;
	private Integer categoryVerify;
	private String categoryCreatename;
	private String categoryCreatedate;

	public String getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(String categoryId) {
		this.categoryId = categoryId;
	}

	public String getCategoryPid() {
		return categoryPid;
	}

	public void setCategoryPid(String categoryPid) {
		this.categoryPid = categoryPid;
	}

	public Integer getCategoryType() {
		return categoryType;
	}

	public void setCategoryType(Integer categoryType) {
		this.categoryType = categoryType;
	}

	public String getCategoryTitle() {
		return categoryTitle;
	}

	public void setCategoryTitle(String categoryTitle) {
		this.categoryTitle = categoryTitle;
	}

	public String getCategorySubtitle() {
		return categorySubtitle;
	}

	public void setCategorySubtitle(String categorySubtitle) {
		this.categorySubtitle = categorySubtitle;
	}

	public String getCategorySimg() {
		return categorySimg;
	}

	public void setCategorySimg(String categorySimg) {
		this.categorySimg = categorySimg;
	}

	public String getCategoryBimg() {
		return categoryBimg;
	}

	public void setCategoryBimg(String categoryBimg) {
		this.categoryBimg = categoryBimg;
	}

	public Integer getCategoryLorder() {
		return categoryLorder;
	}

	public void setCategoryLorder(Integer categoryLorder) {
		this.categoryLorder = categoryLorder;
	}

	public Integer getCategoryVerify() {
		return categoryVerify;
	}

	public void setCategoryVerify(Integer categoryVerify) {
		this.categoryVerify = categoryVerify;
	}

	public String getCategoryCreatename() {
		return categoryCreatename;
	}

	public void setCategoryCreatename(String categoryCreatename) {
		this.categoryCreatename = categoryCreatename;
	}

	public String getCategoryCreatedate() {
		return categoryCreatedate;
	}

	public void setCategoryCreatedate(String categoryCreatedate) {
		this.categoryCreatedate = categoryCreatedate;
	}
}
