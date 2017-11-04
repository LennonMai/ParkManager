<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
	<head>
		<title></title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/dtree.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script type="text/javascript" src="${basePath}/js/jquery.js"></script>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
		<script type="text/javascript">
			function check() {
				if(get("startTime").value > get("endTime").value) {
					alert("��ʼʱ��������ڻ���ڽ���ʱ��");
					return false;
				}
			}
			function eExcel(a,b,c)
			{
				 var url='unitollInterface_ExportExecl.do?';
				 var arg=new Array();
				 var argName=new Array();
				 for(var i=0;i<arguments.length;i++)
					 {
					 argName.push(arguments[i]);
					 var node=document.getElementsByName(arguments[i]);
					 arg.push(node[0].value);
					 url+=argName[i]+'='+arg[i]+'&';
					 }
				return window.location.href=url;
				
				
			}
		</script>
	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
                <button onclick="eExcel('startTime','endTime','PackNo')" class="ropt" >����Excel</button>  
                
                
				<div class="clear"></div>
			</div>
			<form name="tableForm" method="post" action="unitollInterface_listAccountAgentExportLog.do" onsubmit="return check();">
				<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
					<tr>
                    <td style="padding-top: 5px;padding-bottom: 5px;" width="10%" class="pn-flabel pn-flabel-h">
                            ���ݰ���ţ�
                        </td>
                        <td style="padding-top: 5px;padding-bottom: 5px;" width="20%" class="pn-fcontent">
                            <select style="width:100px" name="PackNo">
                          <option value="all">ȫ��</option>
                         <c:forEach items="${packNoList}" var="item">
                          <option value="${item.PackNo}" <c:if test="${item.PackNo==PackNo}">selected</c:if>>${item.PackNo}</option>
                         </c:forEach>
                          </select>
                        </td>
                         
						<td style="padding-top: 5px;padding-bottom: 5px;" width="20%" class="pn-flabel pn-flabel-h">
							�������ڷ�Χ��
						</td>
						<td style="padding-top: 5px;padding-bottom: 5px;" width="50%" class="pn-fcontent">
						  	<input type="text" name="startTime" value="${startTime }" class="Wdate" onClick="WdatePicker()">
						  	 - <input type="text" name="endTime" value="${endTime }" class="Wdate" onClick="WdatePicker()">
						  	&nbsp;<font style="color:red">*</font>
						</td>
					</tr>
					<tr>
						<td colspan="4" class="pn-fbutton">
						<input type="submit" value=" �� ѯ " />&nbsp;
						<input type="reset" value=" �� �� "/>	
						</td>
					</tr>
				</table>
			<table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th>��������</th>
						<th>���ݰ����</th>
						<th>����ʱ��</th>
						<th>�ļ���</th>
						<th>���ݼ�¼��</th>
						<th>�շѽ����</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${accountAgentExportLogList}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center">
							<td><fmt:formatDate value="${item.squadDate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
							<td>${item.packNo }</td>
							<td><fmt:formatDate value="${item.opTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
							<td>${item.fileName }</td>
							<td>${item.recCount }</td>
							<td>${item.totalMoney }</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			
			<jsp:include page="../include/pager.jsp"/>
			</form>
		</div>
	</body>
</html>