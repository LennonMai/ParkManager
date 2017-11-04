<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 使用JavaBean 引入jsonrpc.jar -->
<!--<jsp:useBean id="JSONRPCBridge" scope="session" class="com.metaparadigm.jsonrpc.JSONRPCBridge"/>
<jsp:useBean id="ajax" class="com.hgsoft.util.AjaxBean"></jsp:useBean>
<--%
	JSONRPCBridge.registerObject("ajax",ajax);
%>
--><html>
	<head>
		<title>车道费率列表</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<!-- 引入jsonrpc.js -->
		<!--<script type="text/javascript" src="${basePath}/js/jsonrpc.js"></script>
		--><script language="javascript">

		if("${result}"=="SUCCESS"){
			alert("车道费率添加成功！");
			}
		if("${message}"=="updateSuccess"){
			alert("修改成功！");
			}
		if("${message}"=="deleteSuccess"){
			alert("删除成功！");
			}
			function del(parkNo,feeTypeNo,vehTypeNo,startRange,pageSize,currentPage){
				if(confirm("确认要删除吗？")){
					//alert(parkNo+"-"+feeTypeNo+"-"+vehTypeNo+"-"+startRange);
					window.location.href = "priceRule_delete.do?priceRule.parkNo="+parkNo+"&priceRule.feeTypeNo="+feeTypeNo+"&priceRule.vehTypeNo="+vehTypeNo+"&priceRule.startRange="+startRange+"&pager.pageSize="+pageSize+"&pager.currentPage="+currentPage;
				}
			}			
			function add(){
				window.location.href = "priceRule_add.do";
				}
			function getRowIndex(obj){
				get("pager.rowIndex").value=obj.rowIndex;
				}
			function edit(parkNo,feeTypeNo,vehTypeNo,startRange,pageSize,currentPage){
				window.location.href ="priceRule_edit.do?priceRule.parkNo="+parkNo+"&priceRule.feeTypeNo="+feeTypeNo+"&priceRule.vehTypeNo="+vehTypeNo+"&priceRule.startRange="+startRange+"&pager.pageSize="+pageSize+"&pager.currentPage="+currentPage+"&pager.rowIndex="+get("pager.rowIndex").value;
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
				<div class="rpos">当前位置： ${currentPosition}
				</div>
				<div class="clear"></div>
			</div>
			<form  name="tableForm"  method="post" action="priceRule_query.do">
			<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
				    <tr>
						<td  class="pn-flabel pn-flabel-h">版本号：</td>
						<td  class="pn-fcontent"> <input type="text" name="priceRule.verNo" value="${priceRule.verNo}" size="24"/></td>
					    <td  class="pn-flabel pn-flabel-h">收费类型：</td>
						<td  class="pn-fcontent">
						<select name="priceRule.feeTypeNo" style="width: 178px;height: 24px;">
						  <option value="" <c:if test="${priceRule.feeTypeNo==null}">selected="selected"</c:if> >- 请选择 -</option>
						   <%-- <option value="1" <c:if test="${priceRule.feeTypeNo==1}">selected="selected"</c:if> >正常收费</option>
						   <option value="2" <c:if test="${priceRule.feeTypeNo==2}">selected="selected"</c:if> >无卡收费</option>
						   <option value="3" <c:if test="${priceRule.feeTypeNo==3}">selected="selected"</c:if> >异门收费</option>
						   <option value="4" <c:if test="${priceRule.feeTypeNo==4}">selected="selected"</c:if> >优惠收费</option>
						    --%>
						    <option value="2" <c:if test="${priceRule.feeTypeNo==2}">selected="selected"</c:if> >同门收费</option>
						    <option value="3" <c:if test="${priceRule.feeTypeNo==3}">selected="selected"</c:if> >异门收费</option>
						    <option value="4" <c:if test="${priceRule.feeTypeNo==4}">selected="selected"</c:if> >优惠收费</option>
						
						</select>
						</td>
						</tr>
					<tr>
					    <td  class="pn-flabel pn-flabel-h">车&nbsp;&nbsp;型：</td>
						<td  colspan="3" class="pn-fcontent"> 
						<select style="width: 178px;height: 22px;"  class="required " name="priceRule.vehTypeNo">
						<option value="" <c:if test="${priceRule.vehTypeNo==null}">selected="selected"</c:if> >- 请选择 -</option>
						<option value="1" <c:if test="${priceRule.vehTypeNo==1}">selected="selected"</c:if> >摩托车</option>
						<option value="2" <c:if test="${priceRule.vehTypeNo==2}">selected="selected"</c:if> >小车</option>
						<option value="3" <c:if test="${priceRule.vehTypeNo==3}">selected="selected"</c:if> >大型车</option>
						<option value="4" <c:if test="${priceRule.vehTypeNo==4}">selected="selected"</c:if> >超大型车</option>
						</select>
						</td>
					</tr>
					<tr>
						<td colspan="4" class="pn-fbutton">
						<input style="padding-left: 5px;padding-right: 5px;" type="submit"   value=" 查 询 " />&nbsp;
						<input style="padding-left: 5px;padding-right: 5px;" type="button"  value=" 添 加 "  onclick="add();"/> &nbsp;
						<input style="padding-left: 5px;padding-right: 5px;" type="reset" value=" 重 置 " />	
						</td>
					</tr>
			
			</table>				
			<table id="tb" class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">版本号</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">小区编码</th>
						<!--<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">小区名称</th>
						--><th style="white-space:nowrap;padding-left:5px;padding-right:5px;">收费类型</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">车&nbsp;&nbsp;型</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">最小时间</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">最大时间</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">时间基数(分钟)</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">收费基数(分)</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">时间间隔</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">收费增量</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">最大费率</th>
						
				    	<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">启用时间</th>
				    	<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">备&nbsp;&nbsp;用</th>
				    	<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">操&nbsp;&nbsp;作</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center" onclick="getRowIndex(this)">
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;">${item.verNo}</td>
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;" >${item.parkNo}</td>
                            <%--<td style="word-break:break-all;padding-left:5px;padding-right:5px;" id="${item.parkNo}+${item.feeTypeNo}+${item.vehTypeNo}+${item.startRange}"></td>
						    <script language="javascript">			    
	                             //构造列，根据小区编号取得小区名称写进列中
	                             var parkNo=${item.parkNo};
	                             jsonrpc = new JSONRpcClient("JSON-RPC");//JSON-RPC 对应web.xml里面的URL
	                             var parkName = jsonrpc.ajax.getParkNameByParkNo(parkNo);	                           	 
	                           	 //document.write("<td style='word-break:break-all;padding-left:5px;padding-right:5px;' id='${item.parkNo}+${item.feeTypeNo}+${item.vehTypeNo}+${item.startRange}'></td>");                         		                        
		                         document.getElementById("${item.parkNo}+${item.feeTypeNo}+${item.vehTypeNo}+${item.startRange}").innerHTML=parkName;
                            </script>
							--%>
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;">
							<%--<c:if test="${item.feeTypeNo==1}">正常收费</c:if>
							<c:if test="${item.feeTypeNo==2}">无卡收费</c:if>
							<c:if test="${item.feeTypeNo==3}">异门收费</c:if>
							<c:if test="${item.feeTypeNo==4}">优惠收费</c:if>
							--%>
							<c:if test="${item.feeTypeNo==2}">同门收费</c:if>
							<c:if test="${item.feeTypeNo==3}">异门收费</c:if>
							<c:if test="${item.feeTypeNo==4}">优惠收费</c:if>
							<c:if test="${item.feeTypeNo!=1&&item.feeTypeNo!=2&&item.feeTypeNo!=3&&item.feeTypeNo!=4}">${item.feeTypeNo}</c:if>
							</td>
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;">
							<c:if test="${item.vehTypeNo==1}">摩托车</c:if>
							<c:if test="${item.vehTypeNo==2}">小车</c:if>
							<c:if test="${item.vehTypeNo==3}">大型车</c:if>
							<c:if test="${item.vehTypeNo==4}">超大型车</c:if></td>
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;">${item.startRange}</td>
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;">${item.endRange}</td>
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;">${item.allowStay}</td>
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;">${item.baseFee}</td>
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;">${item.stayAdd}</td>
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;">${item.addFee}</td>
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;">${item.maxFee}</td>
							
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;">${item.startTime}</td>
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;">${item.backUp1}</td>
							
							<td class="pn-lopt" style="white-space:nowrap;padding-left:5px;padding-right:5px;">
							<!--<a href="priceRule_edit.do?priceRule.parkNo=${item.parkNo}&priceRule.feeTypeNo=${item.feeTypeNo}&priceRule.vehTypeNo=${item.vehTypeNo}&priceRule.startRange=${item.startRange}" class="pn-loperator">修改</a>-->
							<a href="javascript:edit(${item.parkNo},${item.feeTypeNo},${item.vehTypeNo},${item.startRange},${pager.pageSize},${pager.currentPage})" class="pn-loperator">修改</a>
							┆ <a href="javascript:del(${item.parkNo},${item.feeTypeNo},${item.vehTypeNo},${item.startRange},${pager.pageSize},${pager.currentPage});" class="pn-loperator">删除</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<jsp:include page="../include/pager.jsp"/>
			</form>

		</div>

	</body>
</html>