<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- ʹ��JavaBean ����jsonrpc.jar -->
<!--<jsp:useBean id="JSONRPCBridge" scope="session" class="com.metaparadigm.jsonrpc.JSONRPCBridge"/>
<jsp:useBean id="ajax" class="com.hgsoft.util.AjaxBean"></jsp:useBean>
<--%
	JSONRPCBridge.registerObject("ajax",ajax);
%>
--><html>
	<head>
		<title>���������б�</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<!-- ����jsonrpc.js -->
		<!--<script type="text/javascript" src="${basePath}/js/jsonrpc.js"></script>
		--><script language="javascript">

		if("${result}"=="SUCCESS"){
			alert("����������ӳɹ���");
			}
		if("${message}"=="updateSuccess"){
			alert("�޸ĳɹ���");
			}
		if("${message}"=="deleteSuccess"){
			alert("ɾ���ɹ���");
			}
			function del(parkNo,feeTypeNo,vehTypeNo,startRange,pageSize,currentPage){
				if(confirm("ȷ��Ҫɾ����")){
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
				<div class="rpos">��ǰλ�ã� ${currentPosition}
				</div>
				<div class="clear"></div>
			</div>
			<form  name="tableForm"  method="post" action="priceRule_query.do">
			<table width="100%" class="pn-ftable" cellpadding="0" cellspacing="1" border="0">
				    <tr>
						<td  class="pn-flabel pn-flabel-h">�汾�ţ�</td>
						<td  class="pn-fcontent"> <input type="text" name="priceRule.verNo" value="${priceRule.verNo}" size="24"/></td>
					    <td  class="pn-flabel pn-flabel-h">�շ����ͣ�</td>
						<td  class="pn-fcontent">
						<select name="priceRule.feeTypeNo" style="width: 178px;height: 24px;">
						  <option value="" <c:if test="${priceRule.feeTypeNo==null}">selected="selected"</c:if> >- ��ѡ�� -</option>
						   <%-- <option value="1" <c:if test="${priceRule.feeTypeNo==1}">selected="selected"</c:if> >�����շ�</option>
						   <option value="2" <c:if test="${priceRule.feeTypeNo==2}">selected="selected"</c:if> >�޿��շ�</option>
						   <option value="3" <c:if test="${priceRule.feeTypeNo==3}">selected="selected"</c:if> >�����շ�</option>
						   <option value="4" <c:if test="${priceRule.feeTypeNo==4}">selected="selected"</c:if> >�Ż��շ�</option>
						    --%>
						    <option value="2" <c:if test="${priceRule.feeTypeNo==2}">selected="selected"</c:if> >ͬ���շ�</option>
						    <option value="3" <c:if test="${priceRule.feeTypeNo==3}">selected="selected"</c:if> >�����շ�</option>
						    <option value="4" <c:if test="${priceRule.feeTypeNo==4}">selected="selected"</c:if> >�Ż��շ�</option>
						
						</select>
						</td>
						</tr>
					<tr>
					    <td  class="pn-flabel pn-flabel-h">��&nbsp;&nbsp;�ͣ�</td>
						<td  colspan="3" class="pn-fcontent"> 
						<select style="width: 178px;height: 22px;"  class="required " name="priceRule.vehTypeNo">
						<option value="" <c:if test="${priceRule.vehTypeNo==null}">selected="selected"</c:if> >- ��ѡ�� -</option>
						<option value="1" <c:if test="${priceRule.vehTypeNo==1}">selected="selected"</c:if> >Ħ�г�</option>
						<option value="2" <c:if test="${priceRule.vehTypeNo==2}">selected="selected"</c:if> >С��</option>
						<option value="3" <c:if test="${priceRule.vehTypeNo==3}">selected="selected"</c:if> >���ͳ�</option>
						<option value="4" <c:if test="${priceRule.vehTypeNo==4}">selected="selected"</c:if> >�����ͳ�</option>
						</select>
						</td>
					</tr>
					<tr>
						<td colspan="4" class="pn-fbutton">
						<input style="padding-left: 5px;padding-right: 5px;" type="submit"   value=" �� ѯ " />&nbsp;
						<input style="padding-left: 5px;padding-right: 5px;" type="button"  value=" �� �� "  onclick="add();"/> &nbsp;
						<input style="padding-left: 5px;padding-right: 5px;" type="reset" value=" �� �� " />	
						</td>
					</tr>
			
			</table>				
			<table id="tb" class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">�汾��</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">С������</th>
						<!--<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">С������</th>
						--><th style="white-space:nowrap;padding-left:5px;padding-right:5px;">�շ�����</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��&nbsp;&nbsp;��</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��Сʱ��</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">���ʱ��</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">ʱ�����(����)</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">�շѻ���(��)</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">ʱ����</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">�շ�����</th>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">������</th>
						
				    	<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">����ʱ��</th>
				    	<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��&nbsp;&nbsp;��</th>
				    	<th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��&nbsp;&nbsp;��</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center" onclick="getRowIndex(this)">
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;">${item.verNo}</td>
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;" >${item.parkNo}</td>
                            <%--<td style="word-break:break-all;padding-left:5px;padding-right:5px;" id="${item.parkNo}+${item.feeTypeNo}+${item.vehTypeNo}+${item.startRange}"></td>
						    <script language="javascript">			    
	                             //�����У�����С�����ȡ��С������д������
	                             var parkNo=${item.parkNo};
	                             jsonrpc = new JSONRpcClient("JSON-RPC");//JSON-RPC ��Ӧweb.xml�����URL
	                             var parkName = jsonrpc.ajax.getParkNameByParkNo(parkNo);	                           	 
	                           	 //document.write("<td style='word-break:break-all;padding-left:5px;padding-right:5px;' id='${item.parkNo}+${item.feeTypeNo}+${item.vehTypeNo}+${item.startRange}'></td>");                         		                        
		                         document.getElementById("${item.parkNo}+${item.feeTypeNo}+${item.vehTypeNo}+${item.startRange}").innerHTML=parkName;
                            </script>
							--%>
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;">
							<%--<c:if test="${item.feeTypeNo==1}">�����շ�</c:if>
							<c:if test="${item.feeTypeNo==2}">�޿��շ�</c:if>
							<c:if test="${item.feeTypeNo==3}">�����շ�</c:if>
							<c:if test="${item.feeTypeNo==4}">�Ż��շ�</c:if>
							--%>
							<c:if test="${item.feeTypeNo==2}">ͬ���շ�</c:if>
							<c:if test="${item.feeTypeNo==3}">�����շ�</c:if>
							<c:if test="${item.feeTypeNo==4}">�Ż��շ�</c:if>
							<c:if test="${item.feeTypeNo!=1&&item.feeTypeNo!=2&&item.feeTypeNo!=3&&item.feeTypeNo!=4}">${item.feeTypeNo}</c:if>
							</td>
							<td style="word-break:break-all;padding-left:5px;padding-right:5px;">
							<c:if test="${item.vehTypeNo==1}">Ħ�г�</c:if>
							<c:if test="${item.vehTypeNo==2}">С��</c:if>
							<c:if test="${item.vehTypeNo==3}">���ͳ�</c:if>
							<c:if test="${item.vehTypeNo==4}">�����ͳ�</c:if></td>
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
							<!--<a href="priceRule_edit.do?priceRule.parkNo=${item.parkNo}&priceRule.feeTypeNo=${item.feeTypeNo}&priceRule.vehTypeNo=${item.vehTypeNo}&priceRule.startRange=${item.startRange}" class="pn-loperator">�޸�</a>-->
							<a href="javascript:edit(${item.parkNo},${item.feeTypeNo},${item.vehTypeNo},${item.startRange},${pager.pageSize},${pager.currentPage})" class="pn-loperator">�޸�</a>
							�� <a href="javascript:del(${item.parkNo},${item.feeTypeNo},${item.vehTypeNo},${item.startRange},${pager.pageSize},${pager.currentPage});" class="pn-loperator">ɾ��</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<jsp:include page="../include/pager.jsp"/>
			</form>

		</div>

	</body>
</html>