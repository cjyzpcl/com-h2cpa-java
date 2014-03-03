<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<base href="<%=basePath%>" />
		<jsp:include page="/h2cpa/resources.jsp" />
		<script type="text/javascript">
			function add() {
				$("#dlg_manager").dialog("open");
				$("#fm_manager").form("clear");
			}
			
			function edit() {
				var row = $("#dg_list").datagrid("getSelected");
				if (row == null) {
					funtl_easyui_dialog.info("请选择一条记录");
				} else {
					$("#dlg_manager").dialog("open");
					$("#menu_menuId").val(row.menuId);
					$("#menu_menuName").val(row.menuName);
					$("#menu_menuBack").val(row.menuBack);
				}
			}
			
			function del() {
				var row = $("#dg_list").datagrid("getSelected");
				if (row == null) {
					funtl_easyui_dialog.info("请选择一条记录");
				} else {
					funtl_easyui_dialog.confirm("确定要删除这条记录吗？", function() {
						var data = {
							"menu.menuId" : row.menuId
						};
						funtl_easyui_ajax.post("permission/menu/action/delete", data, function(data) {
							if (data.message == null || data.message.length == 0) {
								$("#dg_list").datagrid("reload");
								funtl_easyui_dialog.info("数据删除成功");
							} else {
								funtl_easyui_dialog.info(data.message);
							}
						});
					});
				}
			}
			
			var dlgManagerBtn = [{
			    text:"保存",
			    iconCls:"icon-ok",
			    handler:function() {
			    	if ($("#menu_menuId").val() == "") {
			    		$("#fm_manager").attr("action", "permission/menu/action/insert");
			    	} else {
			    		$("#fm_manager").attr("action", "permission/menu/action/update");
			    	}
			    	
			    	funtl_easyui_form.submit("fm_manager", function(data) {
						if (data.message == null || data.message.length == 0) {
							$("#fm_manager").form("clear");
							$("#dlg_manager").dialog("close");
							$("#dg_list").datagrid("reload");
							funtl_easyui_dialog.info("数据保存成功");
						} else {
							funtl_easyui_dialog.info(data.message);
						}
					});
			    }
			},{
			    text:"取消",
			    iconCls:"icon-cancel",
			    handler:function() {
			    	$("#dlg_manager").dialog("close");
			    }
			}];
		</script>
		<title>h2cpa</title>
	</head>
	
	<body>
		<table id="dg_list" class="easyui-datagrid" data-options="rownumbers:true,singleSelect:true,pagination:true,pageSize:50,url:'permission/menu/action/query',toolbar:'#dg_list_toolbar',onLoadError:funtl_easyui_ajax.onLoadError">
			<thead>
	  			<tr>
	  				<th data-options="field:'menuName'">分栏名称</th>
	  				<th data-options="field:'menuCreatename'">分栏创建者</th>
	  				<th data-options="field:'menuDate', formatter:funtl_easyui_formatter.datetime">分栏创建时间</th>
	  				<th data-options="field:'menuBack'">分栏备注</th>
	  			</tr>
  			</thead>
		</table>
		<div id="dg_list_toolbar" style="padding:5px;height:auto">
	   		<div style="margin-bottom:5px">
		  		<a class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true" onclick="add();">新增</a>
		  		<a class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="del();">删除</a>
				<a class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true" onclick="edit();">编辑</a>
			</div>
	   	</div>
		<script>
	   		$("#dg_list").height($(document).height() * 0.98);
	   	</script>
	   	
	   	<div id="dlg_manager" class="easyui-dialog" style="width:600px;height:auto;padding:10px" data-options="title:'管理',buttons:dlgManagerBtn,modal:true,closed:true">
	   		<form id="fm_manager" method="post" action="">
	   			<input id="menu_menuId" type="hidden" name="menu.menuId" />
	   			<table align="center">
	   				<tr>
		    			<td align="right">组名称</td>
		    			<td><input id="menu_menuName" class="easyui-validatebox" type="text" name="menu.menuName" data-options="required:true"></input></td>
		    		</tr>
		    		<tr>
		    			<td align="right">组备注</td>
		    			<td colspan="3"><input id="menu_menuBack" class="easyui-validatebox" type="text" name="menu.menuBack" style="width:100%;"></input></td>
		    		</tr>
	   			</table>
	   		</form>
	   	</div>
	</body>
</html>