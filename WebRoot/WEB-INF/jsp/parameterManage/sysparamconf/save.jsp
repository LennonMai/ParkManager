<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
	<head>
		<title>�������</title>
		<%@include file="../../include/common.jsp" %>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>

		<script type="text/javascript">
			if("${result}"=="SUCCESS"){
				alert("�������óɹ���");
				}
			if("${message}"=="hasPname"){
				alert("�������Ѵ��ڣ�");
			    }
			function back(){
				window.location.href = "paramconf_list.do";
				}
		    //�жϲ������Ƿ�Ϸ�����ʶ���淶�� ��ĸ �� _ ��ͷ
			function isValidIdentifier(str){   
			    try{   
			        eval("var "+str+"=0;");
			        if(str.charCodeAt(0)==36)
				        return false;
			        else  return true;      	       
			    }catch(e){   
			        return false;   
			    }   
			}  
		    
		
			
		</script>

	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form id="dataform" method="post" action="paramconf_save.do" >
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">��������</td>
						<td width="80%" class="pn-fcontent"><input type="text" class="required maxlength50 isRightName" name="sysparamconf.pname" value="${sysparamconf.pname}" size="24"/><span style="color: red">&nbsp;*</span></td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">����ֵ��</td>
						<td width="80%" class="pn-fcontent"><input type="text" class="required maxlength200" name="sysparamconf.pvalue" value="${sysparamconf.pvalue}" size="24"/><span style="color: red">&nbsp;*</span></td>
					</tr>
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">��&nbsp;&nbsp;�ͣ�</td>
						<td width="80%" class="pn-fcontent">
						 <c:if test="${sysparamconf.ptype==null}">
						<select class="required" name="sysparamconf.ptype" style="display;  width: 178px;height: 24px;">
			                <option value="">- ��ѡ�� -</option>
			                <option value="0">ҵ�����</option>
			                <option value="1">��&nbsp;&nbsp;&nbsp;��</option>			          
		                </select></c:if>
						<c:if test="${sysparamconf.ptype==0}">
						<select class="required" name="sysparamconf.ptype" style="display;  width: 178px;height: 24px;">			       
			                <option value="0">ҵ�����</option>			       
			                <option value="">- ��ѡ�� -</option>	
			                <option value="1">��&nbsp;&nbsp;&nbsp;��</option>		          
		                </select></c:if>
						<c:if test="${sysparamconf.ptype==1}">
						<select class="required" name="sysparamconf.ptype" style="display;  width: 178px;height: 24px;">			                			               
			                <option value="1">��&nbsp;&nbsp;&nbsp;��</option>
			                <option value="">- ��ѡ�� -</option>	
			                 <option value="0">ҵ�����</option>		          
		                </select></c:if>
						<span style="color: red">&nbsp;*</span></td>
					</tr>
		
					<tr>
						<td width="20%" class="pn-flabel pn-flabel-h">��&nbsp;&nbsp;ע��</td>
						<td width="80%" class="pn-fcontent">
						<textarea class=" maxlength150" name="sysparamconf.remark" rows="5" cols="50">${sysparamconf.remark}</textarea></td>
					</tr>
					<tr>
						<td colspan="2" class="pn-fbutton">
							<input style="padding-left: 5px;padding-right: 5px;" type="submit" value=" �� �� "/>&nbsp;
						    <input style="padding-left: 5px;padding-right: 5px;" type="reset" value=" �� �� "/>&nbsp;
						    <input style="padding-left: 5px;padding-right: 5px;" type="button" value=" �� �� " onclick="return back()"/>
						</td>
						    
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>