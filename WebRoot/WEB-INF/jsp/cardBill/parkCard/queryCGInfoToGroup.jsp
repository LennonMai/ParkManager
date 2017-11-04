 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
	<head>
		<title></title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/dtree.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script type="text/javascript" src="${basePath}/js/dtree.js"></script>
		<script type="text/javascript">	
	    String.prototype.trim = function() 
        { 
                // ��������ʽ��ǰ��ո��ÿ��ַ�������� 
             return this.replace(/(^\s*)|(\s*$)/g, ""); 
        } 			  
		function group(groupNo) {		
			    var val=(document.getElementsByName("userCardInfo.recNO")[0].value).trim();												
				window.location = "parkCard_group.do?cardGroupInfo.groupNo=" + groupNo+"&userCardInfo.recNO="+val;	
		}
			
			
				
		</script>
		
	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form name="tableForm" method="post" action="parkCard_queryCGInfo.do">
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
				    
					<tr>
					    <td  class="pn-flabel pn-flabel-h">���ţ�</td>
						<td  class="pn-fcontent"> <input type="text" name="cardGroupInfo.groupNo" value="${cardGroupInfo.groupNo}" /></td>
						<td  class="pn-flabel pn-flabel-h">������</td>
						<td  class="pn-fcontent"> <input type="text" name="cardGroupInfo.groupName" value="${cardGroupInfo.groupName}" /></td>						
					</tr>					 					
					<tr>
						<td colspan="4" class="pn-fbutton">
						<input type="submit"   value=" �� ѯ " />&nbsp;
						<input type="reset" value=" �� �� "/>&nbsp;
						<input type="button" value=" �� �� " onclick="history.back();"/>
						<input type="hidden" name="userCardInfo.recNO"  value="${userCardInfo.recNO}" />
						
						</td>
					</tr>
				</table>
					<table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th>����</th>
						<th>����</th>						
						<th>��λ��</th>
						<th>ʣ�೵λ��</th>						
						<th>����</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center">
							<td>${item.groupNo}</td>
							<td>${item.groupName}</td>								
							<td>${item.parkSum}</td>							
							<td>${item.parkRemant}</td>						
                            <td><a href="javascript:group(${item.groupNo})" class="pn-loperator">���${userCardInfo.recNO}���û�����������</a></td>                                         
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<jsp:include page="../../include/pager.jsp"/>
			</form> 
		</div>
	</body>
</html>