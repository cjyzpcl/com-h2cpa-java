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
		<jsp:include page="/resources.jsp" />
		<script type="text/javascript" src="ckfinder/ckfinder.js"></script>
		<script type="text/javascript" src="js/ckeditor/ckeditor.js"></script>
		<script type="text/javascript" src="js/ckeditor/adapters/jquery.js"></script>
		<script type="text/javascript">
			$(document).ready(function() {
				$("#info_infoContent").ckeditor(); 
			});
		
			function add() {
				var category = $("#tree_list").datagrid("getSelected");
				if (category == null) {
					funtl_easyui_dialog.info("请选择文章分类");
				} else {
					$("#dlg_manager").dialog("open");
					$("#fm_manager").form("clear");
					$("#info_infoContent").val("");
					$("#info_artCategory_categoryTitle").val(category.categoryTitle);
					$("#info_artCategory_categoryId").val(category.categoryId);
				}
			}
			
			function edit() {
				var row = $("#dg_list").datagrid("getSelected");
				if (row == null) {
					funtl_easyui_dialog.info("请选择一条记录");
				} else {
					$("#dlg_manager").dialog("open");
					
					$("#info_artCategory_categoryTitle").val(row.categoryTitle);
					$("#info_artCategory_categoryId").val(row.categoryId);
					
					$("#info_infoId").val(row.infoId);
					$("#info_infoTitle").val(row.infoTitle);
					$("#info_infoSubtitle").val(row.infoSubtitle);
					$("#info_infoSimg").val(row.infoSimg);
					$("#info_infoContent").val(row.infoContent);
					$("#info_infoVerify").combobox("setValue", row.infoVerify);
				}
			}
			
			function del() {
				var row = $("#dg_list").datagrid("getSelected");
				if (row == null) {
					funtl_easyui_dialog.info("请选择一条记录");
				} else {
					funtl_easyui_dialog.confirm("确定要删除这条记录吗？", function() {
						var data = {
							"info.infoId" : row.infoId
						};
						funtl_easyui_ajax.post("article/info/action/delete", data, function(data) {
							if (data.message == null || data.message.length == 0) {
								$("#dg_list").datagrid("reload");
								funtl_easyui_dialog.info("数据已删除");
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
			    	if ($("#info_infoId").val() == "") {
			    		$("#fm_manager").attr("action", "article/info/action/insert");
			    	} else {
			    		$("#fm_manager").attr("action", "article/info/action/update");
			    	}
			    	
			    	funtl_easyui_form.submit("fm_manager", function(data) {
						if (data.message == null || data.message.length == 0) {
							$("#fm_manager").form("clear");
							$("#dlg_manager").dialog("close");
							$("#dg_list").datagrid("reload");
							funtl_easyui_dialog.info("数据已保存");
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
			
			function BrowseServer() {
				var finder = new CKFinder();
				finder.BasePath = 'ckfinder/';
				finder.selectActionFunction = SetFileField;
				finder.popup();
			}
			
			function SetFileField(fileUrl) {
				$("#info_infoSimg").val(fileUrl);
			}
			
			function showImg() {
				window.open($("#info_infoSimg").val(),"图片预览","height=400,width=950,top=0,left=0,toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no, status=no");
			}
		</script>
		<title><%=System.getProperty("WEB_NAME") %></title>
	</head>
	
	<body class="easyui-layout" data-options="fit:true">
		<div data-options="region:'west',title:'文章分类'" style="width:180px;">
			<table id="tree_list" class="easyui-treegrid" 
				data-options="
					idField:'categoryId',
					treeField:'categoryTitle',
					rownumbers:true,
					singleSelect:true,
					url:'article/category/action/queryArray/treeArray',
					onLoadError:funtl_easyui_ajax.onLoadError,
					onClickRow:function(row) {
						$('#dg_list').datagrid({url:'article/info/action/queryByCategory?categoryId=' + row.categoryId});
						$('#dg_list').datagrid('reload');
					}
				">
				<thead>
		  			<tr>
		  				<th data-options="field:'categoryTitle'"></th>
		  			</tr>
	  			</thead>
			</table>
		</div>
		<div data-options="region:'center',title:'文章列表'">
			<table id="dg_list" class="easyui-datagrid" 
				data-options="
					rownumbers:true,
					singleSelect:true,
					pagination:true,
					pageSize:50,
					url:'article/info/action/query',
					toolbar:'#dg_list_toolbar',
					onLoadError:funtl_easyui_ajax.onLoadError
				">
				<thead>
		  			<tr>
		  				<th data-options="field:'infoTitle'">文章标题</th>
		  				<th data-options="field:'infoSubtitle'">文章简介</th>
		  				<th data-options="field:'infoVerify', formatter:funtl_easyui_formatter.verify">文章审核</th>
		  				<th data-options="field:'infoCreatename'">文章创建者</th>
		  				<th data-options="field:'infoCreatedate', formatter:funtl_easyui_formatter.datetime">文章创建时间</th>
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
		   		$("#dg_list").height($(document).height() * 0.96);
		   	</script>
		   	
		   	<div id="dlg_manager" class="easyui-dialog" style="width:800px;height:auto;padding:10px" data-options="title:'管理',buttons:dlgManagerBtn,modal:true,closed:true">
		   		<form id="fm_manager" method="post" action="">
		   			<input id="info_infoId" type="hidden" name="info.infoId" />
		   			<table align="center">
		   				<tr>
		   					<td align="right">文章分类</td>
		   					<td colspan="5">
		   						<input id="info_artCategory_categoryTitle" class="easyui-validatebox" type="text" name="" data-options="required:true" readonly="readonly" style="width:100%;"></input>
		   						<input id="info_artCategory_categoryId" type="hidden" name="info.artCategory.categoryId" />
		   					</td>
		   				</tr>
		   				<tr>
		   					<td align="right">文章标题</td>
		   					<td colspan="5"><input id="info_infoTitle" class="easyui-validatebox" type="text" name="info.infoTitle" data-options="required:true" style="width:100%;"></input></td>
		   				</tr>
		   				<tr>
		   					<td align="right">文章简介</td>
		   					<td colspan="5"><input id="info_infoSubtitle" class="easyui-validatebox" type="text" name="info.infoSubtitle" data-options="required:true" style="width:100%;"></input></td>
		   				</tr>
		   				<tr>
		   					<td align="right">文章图标</td>
		   					<td colspan="5">
		   						<input id="info_infoSimg" class="easyui-validatebox" type="text" name="info.infoSimg" data-options="required:true" style="width:82%;" readonly="readonly"></input>
		   						<input type="button" value="浏览" onclick="BrowseServer( 'info_infoSimg' );" />
		   						<input type="button" value="预览" onclick="showImg();" />
		   					</td>
		   				</tr>
		   				<tr>
		   					<td align="right">文章审核</td>
		   					<td>
		   						<select class="easyui-combobox" id="info_infoVerify" name="info.infoVerify" data-options="required:true, editable:false" style="width:150px;">
			    					<option value="0">启用</option>
			    					<option value="1">禁用</option>
			    				</select>
		   					</td>
		   				</tr>
		   				<tr>
		   					<td align="right">文章内容</td>
		   					<td colspan="5">
		   						<textarea id="info_infoContent" name="info.infoContent"></textarea>
		   					</td>
		   				</tr>
		   			</table>
		   		</form>
		   	</div>
		</div>
	</body>
</html>