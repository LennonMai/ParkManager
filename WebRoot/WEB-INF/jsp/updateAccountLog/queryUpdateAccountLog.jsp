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
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
		<script type="text/javascript">
	if ("${result}" == "FAIL")
		alert("没有其账户更改信息");

	function check() {
		if (get("updateAccountLog.accountNo").value != "") {
			var partten = /^\+?[0-9][0-9]*$/;
			if (partten.test(get("updateAccountLog.accountNo").value)) {
			} else {
				alert("用户账号为数字，请重新输入！");
				get("updateAccountLog.accountNo").focus();
				return false;
			}
		}
		if (get("startTime1").value != "" && get("endTime1").value != "") {
			if (get("startTime1").value > get("endTime1").value) {
				alert("开始时间必须早于或等于结束时间");
				return false;
			}
		}

	}
</script>

	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">当前位置： ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form name="tableForm" method="post" action="updateAccountLog_query.do" onsubmit="return check();">
				<table width="100%" class="pn-ftable" cellpadding="2"
					cellspacing="1" border="0">

					<tr>
						<td class="pn-flabel pn-flabel-h">
							用户账号：
						</td>
						<td class="pn-fcontent">
							<input type="text" name="updateAccountLog.accountNo"
								value="${updateAccountLog.accountNo}" />
						</td>
						<td class="pn-flabel pn-flabel-h">
							卡&nbsp;&nbsp;&nbsp;&nbsp;号：
						</td>
						<td class="pn-fcontent">
							<input type="text" name="updateAccountLog.cardNo"
								value="${updateAccountLog.cardNo}" />
						</td>
					</tr>

					<tr>

						<td class="pn-flabel pn-flabel-h">
							用&nbsp;户&nbsp;名：
						</td>
						<td class="pn-fcontent">
							<input type="text" name="updateAccountLog.userName"
								value="${updateAccountLog.userName}" />
						</td>
						<td class="pn-flabel pn-flabel-h">
							车&nbsp;牌&nbsp;号：
						</td>
						<td class="pn-fcontent">
							<input type="text" name="updateAccountLog.vehPlate"
								value="${updateAccountLog.vehPlate}" />
						</td>
					</tr>
					<tr>	<td class="pn-flabel pn-flabel-h">
							账号状态：
						</td>
						<td  class="pn-fcontent">
							<select name="updateAccountLog.status" style="width: 150px">
								<option value=""
									<c:if test="${updateAccountLog.status==null}">selected</c:if>>
									请选择
								</option>
								<option value="0"
									<c:if test="${updateAccountLog.status==0}">selected</c:if>>
									有效
								</option>
								<option value="1"
									<c:if test="${updateAccountLog.status==1}">selected</c:if>>
									挂失
								</option>
								<option value="2"
									<c:if test="${updateAccountLog.status==2}">selected</c:if>>
									预销户
								</option>
								<option value="5"
									<c:if test="${updateAccountLog.status==5}">selected</c:if>>
									已销户
								</option>
								<option value="7"
									<c:if test="${updateAccountLog.status==7}">selected</c:if>>
									黑名单
								</option>
								<option value="4"
									<c:if test="${updateAccountLog.status==4}">selected</c:if>>
									其他
								</option>
							</select>
						</td>					
							<td class="pn-flabel pn-flabel-h">
								证件号码：
							</td>
							<td class="pn-fcontent">
								<input type="text" name="updateAccountLog.credentialsNo"
									value="${updateAccountLog.credentialsNo}" />
							</td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">
							更改时间：
						</td>
						<td colspan="3" class="pn-fcontent">
							<input type="text" name="startTime"
								value="<fmt:formatDate value="${startTime}" pattern="yyyy-MM-dd HH:mm:ss" />"
								class="Wdate"
								onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"">
								- <input type="text" name="endTime"
									value="<fmt:formatDate value="${endTime}" pattern="yyyy-MM-dd HH:mm:ss" />"
									class="Wdate"
									onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"">
						</td>
					</tr>
					<tr>
						<td colspan="4" class="pn-fbutton">
							<input type="submit" value=" 查 询 " />
							&nbsp;
							<input type="reset" value=" 重 置 " />

						</td>
					</tr>
				</table>
				<table class="pn-ltable" width="100%" cellspacing="1"
					cellpadding="0" border="0">
					<thead class="pn-lthead">
						<tr>
							<th>
								用户帐号
							</th>
							<th>
								卡&nbsp;&nbsp;号
							</th>
							<th>
								用户名&nbsp;&nbsp;
							</th>
							<th>
								证件类型
							</th>
							<th>
								证件号码
							</th>
							<th>
								车牌号&nbsp;&nbsp;
							</th>
							<th>
								更改时间
							</th>
							<th>
								账号状态
							</th>
							<th>
								操&nbsp;&nbsp;作
							</th>

						</tr>
					</thead>
					<tbody class="pn-ltbody">
						<c:forEach items="${list}" var="item">
							<tr onmouseover="this.className='pn-lhover'"
								onmouseout="this.className=''" align="center">
								<td>
									${item.accountNo}
								</td>
								<td>
									${item.cardNo}
								</td>

								<td>
									${item.userName}
								</td>
								<td>
									<c:if test="${item.credentialsType==0}">身份证</c:if>
									<c:if test="${item.credentialsType==1}">其&nbsp;&nbsp;他</c:if>
								</td>
								<td>
									${item.credentialsNo}
								</td>

								<td>
									${item.vehPlate}
								</td>
								<td>
									${item.updateTime}
								</td>
								<td>
									<c:if test="${item.status==0}">有效</c:if>
									<c:if test="${item.status==1}">挂失</c:if>
									<c:if test="${item.status==2}">预销户</c:if>
									<c:if test="${item.status==4}">其他</c:if>
									<c:if test="${item.status==5}">已销户</c:if>
									<c:if test="${item.status==7}">黑名单</c:if>
								</td>
								<td>
									<a
										href="updateAccountLog_detail.do?updateAccountLog.accountNo=${item.accountNo}&updateAccountLog.seqNo=${item.seqNo}"
										class="pn-loperator">详细信息</a>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<jsp:include page="../include/pager.jsp"/>
			</form> 
		</div>
	</body>
</html>