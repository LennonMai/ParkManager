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
			alert("删除成功"); 
		  String.prototype.trim = function() 
          { 
                  // 用正则表达式将前后空格，用空字符串替代。 
               return this.replace(/(^\s*)|(\s*$)/g, ""); 
          } 
		function deleteCardGroup(recNO) {
			var val=(document.getElementsByName("cardGroupInfo.groupNo")[0].value).trim();
			if(confirm("确定要删除吗？")){											
			window.location = "parkCard_deleteCardGroup.do?userCardInfo.recNO=" + recNO+"&cardGroupInfo.groupNo="+val;	
			}
	    }
				
		</script>
		
	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">当前位置： ${currentPosition}</div>
				<form class="ropt" method="post">
					<input type="button" value=" 返 回 " onclick="history.back();"/>
				</form>
				<div class="clear"></div>
			</div>
			<form name="tableForm" method="post" action="">	
			<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
				    
					<tr>
					    <td  class="pn-flabel pn-flabel-h">组编号：</td>
						<td  class="pn-fcontent"> <input type="text" name="cardGroupInfo.groupNo" value="${cardGroupInfo.groupNo}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
						<td  class="pn-flabel pn-flabel-h">组名：</td>
						<td  class="pn-fcontent"> <input type="text" name="cardGroupInfo.groupName" value="${cardGroupInfo.groupName}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>						
					</tr>					 					
					<tr>
						<td  class="pn-flabel pn-flabel-h">车位数：</td>
						<td  class="pn-fcontent"> <input type="text" name="cardGroupInfo.parkSum" value="${cardGroupInfo.parkSum}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
						<td  class="pn-flabel pn-flabel-h">剩余车位数：</td>
						<td  class="pn-fcontent"> <input type="text" name="cardGroupInfo.parkRemant" value="${cardGroupInfo.parkRemant}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					</tr>
				</table>			
				<table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th>卡表面号</th>
						<th>车牌号</th>						
						<th>用户姓名</th>
						<th>停车位</th>						
						<th>房号</th>
						<th>操作</th>
						
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
                            <td><a href="javascript:deleteCardGroup(${item[0].recNO})" class="pn-loperator">删除</a></td>                                        
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<jsp:include page="../../include/pager.jsp"/>
			</form> 
		</div>
	</body>
</html>