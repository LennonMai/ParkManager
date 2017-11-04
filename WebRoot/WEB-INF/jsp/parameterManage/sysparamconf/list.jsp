<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
	<head>
		<title>�����б�</title>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
	
		<script language="javascript">

		if("${result}"=="SUCCESS"){
			alert("�������óɹ�");
			}
		if("${message}"=="updateSuccess"){
			alert("�޸ĳɹ���");
			}
		if("${message}"=="deleteSuccess"){
			alert("ɾ���ɹ���");
			}
	    
			function del(id,pageSize,currentPage){
				if(confirm("ȷ��Ҫɾ����")){
					window.location.href = "paramconf_delete.do?sysparamconf.sys_id="+id+"&pager.pageSize="+pageSize+"&pager.currentPage="+currentPage;
				}
			}
			function add(){
				window.location.href = "paramconf_add.do";
				}
			function dataToExcel(){
				window.location.href = "paramconf_dataToExcel.do";
				}
			function toImportExcel(){
				window.location.href = "paramconf_toImportExcel.do";
				}
			function GetStringLen(str) { 
				var len=0; 
				for(var i=0;i<str.length;i++) { 
				  char = str.charCodeAt(i); 
				   if(!(char>255)) { 
				     len = len + 1; 
				  } else { 
				     len = len + 2; 
				  } 
				} 
				return len; 
				}
			function getRowIndex(obj){
				get("pager.rowIndex").value=obj.rowIndex;
				}
			function edit(sys_id,pageSize,currentPage){
				window.location.href ="paramconf_edit.do?sysparamconf.sys_id="+sys_id+"&pager.pageSize="+pageSize+"&pager.currentPage="+currentPage+"&pager.rowIndex="+get("pager.rowIndex").value;
			}
			function setRowBGcolor(){
				var rowIndex="${rowIndex}";
				var pageSize="${pageSize}";
				var currentPage="${currentPage}";
				if(rowIndex!=""&&pageSize!=""&&currentPage!=""){
					var trs=document.getElementById("tb").getElementsByTagName("tr");
					for(var i=0;i<trs.length;i++){
						if(i==rowIndex&&get("pager.pageSize").value==pageSize&&get("pager.currentPage").value==currentPage){
							trs[i].style.backgroundColor="#E6E6E6";
						}
					}
				}
			}		 
		</script>
	</head> 
	<body onload="setRowBGcolor();">
		<div class="body-box">
            <div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form id="dataform" name="tableForm"  method="post" action="paramconf_query.do" >
			<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
				    <tr>
						<td  class="pn-flabel pn-flabel-h">��������</td>
						<td  class="pn-fcontent"> <input size="24" type="text" class="maxlength50" name="sysparamconf.pname"  /></td>
						<td  class="pn-flabel pn-flabel-h">��&nbsp;&nbsp;�ͣ�</td>
						<td  class="pn-fcontent">
						<select name="sysparamconf.ptype" style="width: 178px;height: 24px;;">
						   <option value="">- ��ѡ�� -</option>
			               <option value="0">ҵ�����</option>
			               <option value="1">��&nbsp;&nbsp;&nbsp;��</option>			          
		                </select>
						  
						</td>
					</tr>
					<tr>
					    <td  class="pn-flabel pn-flabel-h">����ֵ��</td>
						<td  class="pn-fcontent"> <input size="24" type="text" class="maxlength200" name="sysparamconf.pvalue" /></td>
						<td  class="pn-flabel pn-flabel-h">��&nbsp;&nbsp;ע��</td>
						<td  class="pn-fcontent"><input size="24" type="text" class="maxlength150" name="sysparamconf.remark" /></td>
					</tr>
					<tr>
						<td colspan="4" class="pn-fbutton">
						<input style="padding-left: 5px;padding-right: 5px;" type="submit" value=" �� ѯ " />&nbsp;
						<input style="padding-left: 5px;padding-right: 5px;" type="button" value=" �� �� "  onclick="add();"/> &nbsp;
						<input style="padding-left: 5px;padding-right: 5px;" type="reset"  value=" �� �� " />	
						</td>
					</tr>
			
				</table>		
			<table id="tb" class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��&nbsp;&nbsp;��</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">������</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">����ֵ</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��&nbsp;&nbsp;��</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��&nbsp;&nbsp;ע</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��&nbsp;&nbsp;��</th>
						
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center"  onclick="getRowIndex(this)">
							<td style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.sys_id}</td>
							<td align="left" style="word-break:normal|break-all|keep-all;padding-left:5px;padding-right:5px;">${item.pname}</td>
							<td align="left" style="word-break:break-all;padding-left:5px;padding-right:5px;">${item.pvalue}</td>
							<td style="white-space:nowrap;padding-left:5px;padding-right:5px;"><c:if test="${item.ptype==0}">ҵ�����</c:if><c:if test="${item.ptype==1}">����</c:if></td>
							<td align="left" style="word-break:break-all;padding-left:5px;padding-right:5px;">${item.remark}</td>
							<td class="pn-lopt" style="white-space:nowrap;padding-left:5px;padding-right:5px;">
							<!--<a href="paramconf_edit.do?sysparamconf.sys_id=${item.sys_id}&pager.pageSize=${pager.pageSize}&pager.currentPage=${pager.currentPage}" class="pn-loperator">�޸�</a>
							--><a href="javascript:edit(${item.sys_id},${pager.pageSize},${pager.currentPage})" class="pn-loperator">�޸�</a>
							�� <a href="javascript:del(${item.sys_id},${pager.pageSize},${pager.currentPage});" class="pn-loperator">ɾ��</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<jsp:include page="../../include/pager.jsp"/>
			</form>
		<div class=pn-sp>
		<input type="button" name="" style="padding-left: 5px;padding-right: 5px;padding-bottom: 1px;padding-top: 2px;" value="�����ݵ���Excel" onclick="dataToExcel();"/> 
		<input type="button" name="" style="padding-left: 5px;padding-right: 5px;padding-bottom: 1px;padding-top: 2px;"  value="����Excel����" onclick="toImportExcel();" /> 	
	    <div class="clear"></div>
        </div>
		
		</div>
		
	</body>
</html>