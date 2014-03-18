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
		<script type="text/javascript">
			$(function () {  
			    //点击图片更换验证码
			    $("#verify").click(function(){
			        $(this).attr("src","security/securityCodeImageAction?timestamp=" + new Date().getTime());
			    });
			});
			
			function submitForm(){
				var param = {
					 "securityCode" : $("#securityCode").val()
				};
				funtl_easyui_ajax.post("security/manage/action/verify", param, function(data) {
					if (data.message == null || data.message.length == 0) {
						funtl_easyui_form.submit("form_index", function(data) {
							if (data.message == null || data.message.length == 0) {
								window.parent.location.href = "<%=request.getContextPath()%>/distribution/main";
							} else {
								funtl_easyui_dialog.info(data.message);
							}
						});
					} else {
						funtl_easyui_dialog.info(data.message);
					}
				});
			}
			
			function clearForm() {
				$("#form_index").form('clear');
			}
		</script>
		<title><%=System.getProperty("WEB_NAME") %></title>
	</head>
	
	<body>
		<div style="position:absolute;top:50%;left:50%;margin:-150px 0 0 -200px;">
			<div class="easyui-panel" title="管理员登录" style="width:350px;">
				<div style="padding:10px 0 10px 60px">
					<form id="form_index" method="post" action="permission/user/action/login">
						<table>
				    		<tr>
				    			<td align="right">用户名：</td>
				    			<td colspan="2"><input class="easyui-validatebox" type="text" name="user.userNm" data-options="required:true"></input></td>
				    		</tr>
				    		<tr>
				    			<td align="right">密&nbsp;&nbsp;码：</td>
				    			<td colspan="2"><input class="easyui-validatebox" type="password" name="user.userPass" data-options="required:true"></input></td>
				    		</tr>
				    		<tr>
				    			<td align="right">验证码：</td>
				    			<td><input class="easyui-validatebox" type="text" id="securityCode" data-options="required:true" style="width:70px;"></input></td>
				    			<td><img src="security/securityCodeImageAction" id="verify" style="cursor:pointer;" title="看不清，换一张"/></td>
				    		</tr>
				    	</table>
					</form>
				</div>
				<div style="text-align:center;padding:5px">
			    	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm();">登录</a>
			    	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm();">清空</a>
			    </div>
			</div>
		</div>
	</body>
</html>