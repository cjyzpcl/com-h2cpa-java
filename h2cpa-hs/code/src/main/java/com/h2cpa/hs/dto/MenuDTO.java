package com.h2cpa.hs.dto;

import java.io.Serializable;
import java.util.List;

public class MenuDTO implements Serializable {
	private static final long serialVersionUID = -1322429630658279826L;
	private String menuName;
	private List<String[]> resources;

	public String getMenuName() {
		return menuName;
	}

	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}

	public List<String[]> getResources() {
		return resources;
	}

	public void setResources(List<String[]> resources) {
		this.resources = resources;
	}

}
