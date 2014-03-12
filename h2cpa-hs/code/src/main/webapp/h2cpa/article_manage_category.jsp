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
				var row = $("#dg_list").datagrid("getSelected");
				if (row == null) {
					funtl_easyui_dialog.info("请选择父类");
				} else {
					$("#dlg_manager").dialog("open");
					$("#fm_manager").form("clear");
					$("#category_categoryPTitle").val(row.categoryTitle);
					$("#category_categoryPid").val(row.categoryId);
				}
			}
			
			function edit() {
				var row = $("#dg_list").datagrid("getSelected");
				if (row == null || row.categoryPid == "0") {
					funtl_easyui_dialog.info("请选择一条记录");
				} else {
					$("#dlg_manager").dialog("open");
					
					var parent = $("#dg_list").treegrid("getParent", row.categoryId);
					$("#category_categoryPTitle").val(parent.categoryTitle);
					$("#category_categoryPid").val(parent.categoryId);
					
					$("#category_categoryId").val(row.categoryId);
					$("#category_categoryTitle").val(row.categoryTitle);
					$("#category_categorySubtitle").val(row.categorySubtitle);
					$("#category_categorySimg").val(row.categorySimg);
					$("#category_categoryLorder").val(row.categoryLorder);
					$("#category_categoryType").combobox("setValue", row.categoryType);
					$("#category_categoryVerify").combobox("setValue", row.categoryVerify);
				}
			}
			
			function del() {
				var row = $("#dg_list").datagrid("getSelected");
				if (row == null || row.categoryPid == "0") {
					funtl_easyui_dialog.info("请选择一条记录");
				} else {
					funtl_easyui_dialog.confirm("确定要删除这条记录吗？", function() {
						var data = {
							"category.categoryId" : row.categoryId
						};
						funtl_easyui_ajax.post("article/category/action/delete", data, function(data) {
							if (data.message == null || data.message.length == 0) {
								$("#dg_list").treegrid("reload");
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
			    	if ($("#category_categoryId").val() == "") {
			    		$("#fm_manager").attr("action", "article/category/action/insert");
			    	} else {
			    		$("#fm_manager").attr("action", "article/category/action/update");
			    	}
			    	
			    	funtl_easyui_form.submit("fm_manager", function(data) {
						if (data.message == null || data.message.length == 0) {
							$("#fm_manager").form("clear");
							$("#dlg_manager").dialog("close");
							$("#dg_list").treegrid("reload");
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
		<table id="dg_list" class="easyui-treegrid" 
			data-options="
				idField:'categoryId',
				treeField:'categoryTitle',
				rownumbers:true,
				singleSelect:true,
				url:'article/category/action/queryArray/treeArray',
				toolbar:'#dg_list_toolbar',
				onLoadError:funtl_easyui_ajax.onLoadError
			">
			<thead>
	  			<tr>
	  				<th data-options="field:'categorySimg'">分类图标</th>
	  				<th data-options="field:'categoryTitle'">分类标题</th>
	  				<th data-options="field:'categorySubtitle'">分类说明</th>
	  				<th data-options="field:'categoryType', formatter:funtl_easyui_formatter.artType">分类类型</th>
	  				<th data-options="field:'categoryVerify', formatter:funtl_easyui_formatter.verify">分类审核</th>
	  				<th data-options="field:'categoryLorder'">分类排序</th>
	  				<th data-options="field:'categoryCreatename'">分类创建者</th>
	  				<th data-options="field:'categoryCreatedate', formatter:funtl_easyui_formatter.datetime">分类创建时间</th>
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
	   	
	   	<div id="dlg_manager" class="easyui-dialog" style="width:800px;height:auto;padding:10px" data-options="title:'管理',buttons:dlgManagerBtn,modal:true,closed:true">
	   		<form id="fm_manager" method="post" action="">
	   			<input id="category_categoryId" type="hidden" name="category.categoryId" />
	   			<table align="center">
	   				<tr>
	   					<td align="right">父类标题</td>
	   					<td colspan="5">
	   						<input id="category_categoryPTitle" class="easyui-validatebox" type="text" name="" data-options="required:true" readonly="readonly" style="width:100%;"></input>
	   						<input id="category_categoryPid" type="hidden" name="category.categoryPid" />
	   					</td>
	   				</tr>
	   				<tr>
	   					<td align="right">分类标题</td>
	   					<td colspan="5"><input id="category_categoryTitle" class="easyui-validatebox" type="text" name="category.categoryTitle" data-options="required:true" style="width:100%;"></input></td>
	   				</tr>
	   				<tr>
	   					<td align="right">分类说明</td>
	   					<td colspan="5"><input id="category_categorySubtitle" class="easyui-validatebox" type="text" name="category.categorySubtitle" data-options="" style="width:100%;"></input></td>
	   				</tr>
	   				<tr>
	   					<td align="right">分类图标</td>
	   					<td colspan="5"><input id="category_categorySimg" class="easyui-validatebox" type="text" name="category.categorySimg" data-options="" style="width:100%;"></input></td>
	   				</tr>
	   				<tr>
	   					<td align="right">分类类型</td>
	   					<td>
	   						<select class="easyui-combobox" id="category_categoryType" name="category.categoryType" data-options="required:true, editable:false" style="width:150px;">
		    					<option value="1">文章</option>
		    				</select>
	   					</td>
	   					<td align="right">分类审核</td>
	   					<td>
	   						<select class="easyui-combobox" id="category_categoryVerify" name="category.categoryVerify" data-options="required:true, editable:false" style="width:150px;">
		    					<option value="0">启用</option>
		    					<option value="1">禁用</option>
		    				</select>
	   					</td>
	   					<td align="right">分类排序</td>
	   					<td><input id="category_categoryLorder" class="easyui-numberbox" name="category.categoryLorder" data-options="required:true"></input></td>
	   				</tr>
	   			</table>
	   		</form>
	   	</div>
	</body>
</html>