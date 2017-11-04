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
		if("${result}"=="SUCCESS")
			alert("ɾ���ɹ�"); 
		  String.prototype.trim = function() 
          { 
                  // ��������ʽ��ǰ��ո��ÿ��ַ�������� 
               return this.replace(/(^\s*)|(\s*$)/g, ""); 
          } 
		function deleteCardGroup(recNO) {
			var val=(document.getElementsByName("cardGroupInfo.groupNo")[0].value).trim();
			if(confirm("ȷ��Ҫɾ����")){											
			window.location = "parkCard_deleteCardGroup.do?userCardInfo.recNO=" + recNO+"&cardGroupInfo.groupNo="+val;	
			}
	    }
				
		</script>
		
	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<form class="ropt" method="post">
					<input type="button" value=" �� �� " onclick="history.back();"/>
				</form>
				<div class="clear"></div>
			</div>
			<form name="tableForm" method="post" action="">	
			<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
				    
					<tr>
					    <td  class="pn-flabel pn-flabel-h">���ţ�</td>
						<td  class="pn-fcontent"> <input type="text" name="cardGroupInfo.groupNo" value="${cardGroupInfo.groupNo}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
						<td  class="pn-flabel pn-flabel-h">������</td>
						<td  class="pn-fcontent"> <input type="text" name="cardGroupInfo.groupName" value="${cardGroupInfo.groupName}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>						
					</tr>					 					
					<tr>
						<td  class="pn-flabel pn-flabel-h">��λ����</td>
						<td  class="pn-fcontent"> <input type="text" name="cardGroupInfo.parkSum" value="${cardGroupInfo.parkSum}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
						<td  class="pn-flabel pn-flabel-h">ʣ�೵λ����</td>
						<td  class="pn-fcontent"> <input type="text" name="cardGroupInfo.parkRemant" value="${cardGroupInfo.parkRemant}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					</tr>
				</table>			
				<table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th>�������</th>
						<th>���ƺ�</th>						
						<th>�û�����</th>
						<th>ͣ��λ</th>						
						<th>����</th>
						<th>����</th>
						
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center">
							<td>${item[0].recNO}</td>
							<td>${item[0].vehPlate}</td>								
							<td>${item[0].owner}</td>							
							<td>${item[0].parkingSpace}</td>						
                            <td>${item[0].roomNo}</td>
                            <td><a href="javascript:deleteCardGroup(${item[0].recNO})" class="pn-loperator">ɾ��</a></td>                                        
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<jsp:include page="../../include/pager.jsp"/>
			</form> 
		</div>
	</body>
</html>