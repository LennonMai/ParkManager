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
                // 用正则表达式将前后空格，用空字符串替代。 
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
				<div class="rpos">当前位置： ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form name="tableForm" method="post" action="parkCard_queryCGInfo.do">
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
				    
					<tr>
					    <td  class="pn-flabel pn-flabel-h">组编号：</td>
						<td  class="pn-fcontent"> <input type="text" name="cardGroupInfo.groupNo" value="${cardGroupInfo.groupNo}" /></td>
						<td  class="pn-flabel pn-flabel-h">组名：</td>
						<td  class="pn-fcontent"> <input type="text" name="cardGroupInfo.groupName" value="${cardGroupInfo.groupName}" /></td>						
					</tr>					 					
					<tr>
						<td colspan="4" class="pn-fbutton">
						<input type="submit"   value=" 查 询 " />&nbsp;
						<input type="reset" value=" 重 置 "/>&nbsp;
						<input type="button" value=" 返 回 " onclick="history.back();"/>
						<input type="hidden" name="userCardInfo.recNO"  value="${userCardInfo.recNO}" />
						
						</td>
					</tr>
				</table>
					<table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th>组编号</th>
						<th>组名</th>						
						<th>车位数</th>
						<th>剩余车位数</th>						
						<th>操作</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center">
							<td>${item.groupNo}</td>
							<td>${item.groupName}</td>								
							<td>${item.parkSum}</td>							
							<td>${item.parkRemant}</td>						
                            <td><a href="javascript:group(${item.groupNo})" class="pn-loperator">编号${userCardInfo.recNO}的用户添加至这个组</a></td>                                         
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<jsp:include page="../../include/pager.jsp"/>
			</form> 
		</div>
	</body>
</html>