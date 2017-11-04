<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<html>
	<head>
		<title>list</title>
		<link href="${basePath}/css/admin.css" rel="stylesheet" type="text/css"/>
		<link href="${basePath}/css/theme.css" rel="stylesheet" type="text/css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script type="text/javascript" src="${basePath}/js/jquery.js"></script>
		<script type="text/javascript" src="${basePath}/js/jquery.form.js"></script>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
		<script language="javascript">
		//��ȡС��
		function getGate(){
		(function($) { 
				$(function() {
			$.ajax({
				type:"post",
				url:"lostCard_ajaxGate.do?parkNo="+$(document.tableForm.parkNo).val(),
				success:function(res){
					$("#gateNo").empty();
					$("#laneNo").empty();
					var op = $("<option value=''>-��ѡ��-</option>");		
					$("#gateNo").append(op);
					var op1 = $("<option value=''>-��ѡ��-</option>");
					$("#laneNo").append(op1);
					$(res).find("gates > gate").each(function(){								
					var op = $("<option value=" + $(this).attr("id") + ">" 
							+ $(this).attr("name") + "</option>");
					$("#gateNo").append(op);	
				});
				}
			});
			 });
			})(jQuery);
		}
		
		//��ȡ������Ϣ
		function getLane(){
			//��ֵ ��ӡ����
		  var temp =  get("gateNo");
		  get("td0").innerHTML = temp.options[temp.selectedIndex].text;
			
		  (function($) { 
			   $(function() {
			$.ajax({
				type:"post",
				url:"lostCard_ajaxLane.do?parkNo="+$(document.tableForm.parkNo).val()
				+ "&gateNo="+$(document.tableForm.gateNo).val(),
				success:function(res){
					$("#laneNo").empty();
					var op = $("<option value=''>-��ѡ��-</option>");		
					$("#laneNo").append(op);
					$(res).find("lanes > lane").each(function(){								
					var op = $("<option value=" + $(this).attr("id") + ">" 
							+ $(this).attr("name") + "</option>");
					$("#laneNo").append(op);	
				});
				}
			});
		   });
		  })(jQuery);
		}


		function setName(selectId,tdId){
			//��ֵ ��ӡ����
			
			  var temp =  get(selectId);

			  try{
			  get(tdId).innerHTML = temp.options[temp.selectedIndex].text;
			  }catch(e){
				  get(tdId).innerHTML = temp.value;
				  }
			}
			function query(){
					if(get("laneNo").value==""){
						alert("��ѡ��һ���������ٲ�ѯ��");
						return;
						}
					if(get("dltime").value==""||get("dhtime").value==""){
						alert("��ѡ����ĩʱ��!");
						return;
						}
					if((get("dltime").value.substring(5,7)!=get("dhtime").value.substring(5,7))
							||(get("dltime").value.substring(0,4)!=get("dhtime").value.substring(0,4))){
						alert("ʱ�䷶Χ��Ҫѡ��ͬһ���·ݣ�");
						return ;
						}
					
					get("tableForm").submit();
					get("btn").value="��ѯ��...";
					get("btn").disabled="disabled";
					
				}


			function printX(){
				if((get("waterQuery.cashType").value=="1"||get("waterQuery.cashType").value=="0")&&!(get("waterQuery.totalMoney").value==$("#td10").text().replace(/(^\s*)|(\s*$)/g,""))){
				    if(confirm("��ˮ�Ƿ��ϴ�������"))	{
				    	window.open("waterQuery_print.do","_blank","width=1000,height=500,scrollbars=yes");
				     }
				  }
				else
					window.open("waterQuery_print.do","_blank","width=1000,height=500,scrollbars=yes");
					   //window.showModelessDialog("waterQuery_print.do",window,"dialogWidth:1000px;dialogHeight:400px");
			}

			function operatorNoChange(){
					get("td6").innerHTML = get("waterQuery.operatorNo").value;
				}
			function totalMoneyNoChange()
			{
				   get("td11").innerHTML = get("waterQuery.totalMoney").value; 
				}
		</script>
	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				
				<div class="clear"></div>
			</div>
			<form  name="tableForm" action="waterQuery_printList.do" method="post">
			<table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<thead class="pn-lthead">
					<tr>
						<th align="left" colspan="4">&nbsp;��ѯ</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
				<tr align="center">
						<td class="pn-flabel pn-flabel-h" width="20%">
						<input name ="waterQuery.spEventState" type="radio" value="0"  <c:if test="${waterQuery.spEventState==0}">checked="checked"</c:if> >���</input>
						<input  <c:if test="${waterQuery.spEventState==1}">checked="checked"</c:if> name ="waterQuery.spEventState" type="radio" value="1">����</input>&nbsp;&nbsp;�����¼���</td>
						<td class="pn-fcontent" width="30%" align="left">
							<select name="waterQuery.spEvent" style="width:150px">
									<option value="">��ѡ��</option>
							 	<c:forEach items="${spEventList}" var="spItem">
							 		<option value="${spItem.spEventNo}" <c:if test="${waterQuery.spEvent==spItem.spEventNo}">selected</c:if>>${spItem.spEventName}</option>							 			
							 	</c:forEach>
							</select>
						</td>
							<td class="pn-flabel pn-flabel-h" width="20%"><input name ="waterQuery.timeState" type="radio" value="0" 
							<c:if test="${waterQuery.timeState==0}">checked="checked"</c:if>>���</input>
							<input name ="waterQuery.timeState" type="radio" value="1" <c:if test="${waterQuery.timeState==1}">checked="checked"</c:if>>����</input>&nbsp;&nbsp;
							��ˮʱ��Σ�</td>
							<td width="30%" class="pn-fcontent" align="left" >
							<input id="dltime" type="text" name="waterQuery.dltime" onchange="setName('dltime','td3');"
							<c:if test="${waterQuery.dltime!=null }">
								value='<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${waterQuery.dltime}" ></fmt:formatDate>'
							</c:if>
							class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" /> -
							<input id="dhtime" type="text" name="waterQuery.dhtime" onchange="setName('dhtime','td4');"
							<c:if test="${waterQuery.dhtime!=null }">
								value='<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${waterQuery.dhtime}" ></fmt:formatDate>'
							</c:if>
							class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"/>
							</td>
				</tr>
				<tr align="center">
							<td class="pn-flabel pn-flabel-h" width="20%">
							�����أ�</td>
							<td class="pn-fcontent" width="30%"  align="left">
								<select name="waterQuery.cashType" id="cashTypeId" style="width:150px" onchange="setName('cashTypeId','td7');">
								<option value="" >��ѡ��</option>
								<option value="0" <c:if test="${waterQuery.cashType==0}">selected</c:if>>�ֽ𳵽��</option>
								<option value="1" <c:if test="${waterQuery.cashType==1}">selected</c:if>>�ֽ��йص���ˮ</option>
								<option value="2" <c:if test="${waterQuery.cashType==2}">selected</c:if>>�ֹ������</option>
								</select>
							</td>
							<td class="pn-flabel pn-flabel-h" width="20%">
							����ţ�</td>
							<td class="pn-fcontent" width="30%"  align="left">
								<select name="waterQuery.squadNo" id="squadId" style="width:150px" onchange="setName('squadId','td2');">
								<option value="">-��ѡ��-</option>
							 	<c:forEach items="${squadList}" var="squadItem">
							 		<option value="${squadItem.squadNo}" <c:if test="${waterQuery.squadNo==squadItem.squadNo}">selected</c:if>>${squadItem.squadName}</option>							 			
							 	</c:forEach>
							</select>
							</td>
				</tr>
				<tr align="center">
							<td class="pn-flabel pn-flabel-h" width="20%">
							���ţ�</td>
							<td class="pn-fcontent" align="left" colspan="3">
								<input type="text" name="waterQuery.operatorNo" value="${waterQuery.operatorNo}" onchange="operatorNoChange();" ></input>
							</td>
				</tr>
				<tr align="center">
						<td class="pn-flabel pn-flabel-h"><input name ="waterQuery.laneNoState" type="radio" value="0"
						 <c:if test="${waterQuery.laneNoState==0}">checked="checked"</c:if>>���</input>
						 <input name ="waterQuery.laneNoState" type="radio" value="1"
						 <c:if test="${waterQuery.laneNoState==1}">checked="checked"</c:if>>����</input>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;λ    �ã�</td>
						<td class="pn-fcontent" colspan="3" align="left">
							С����<select name="parkNo" id ="parkNo" onchange="getGate();" >
									<option value="">-��ѡ��-</option>
									<c:forEach items="${parkList}" var="item">
										<option value="${item.parkNo }"<c:if test="${item.parkNo==parkNo }"> selected="selected" </c:if>>${item.parkName }</option>
									</c:forEach>
								</select>&nbsp;
							���ţ�<select name="gateNo" id="gateNo" onchange="getLane();">
									<option value="">-��ѡ��-</option>
									<c:forEach items="${gateList}" var="item">
										<option value="${item.gateNo }"<c:if test="${item.gateNo==gateNo }"> selected="selected" </c:if>>${item.gateName }</option>
									</c:forEach>
								</select>&nbsp;
							������<select name="waterQuery.laneNo" id="laneNo" onchange="setName('laneNo','td1');">
									<option value="">-��ѡ��-</option>
									<c:forEach items="${laneList}" var="item">
										<option value="${item.laneNo }"<c:if test="${item.laneNo==waterQuery.laneNo}"> selected="selected" </c:if>>${item.laneNo }</option>
									</c:forEach>
								</select>
<!--								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-->
<!--								<input type="checkbox" name="fuzzySearch" value="1" <c:if test="${fuzzySearch==1 }"> checked="checked" </c:if>/>�Ƿ�ģ����ѯ-->
<!--								&nbsp;&nbsp;&nbsp;&nbsp;-->
								<!-- <input type="checkbox" name="autoImag" value="1" <c:if test="${autoImag==1 }"> checked="checked" </c:if>/>�Ƿ��Զ�ȡͼ -->
						</td>

				</tr>
				<tr align="center">
				   <td align="right"  width="10%">Ӧ���ֽ�</td>
					<td id="td10" width="10%" >
						${waterQuery.totalMoney}
					</td>
							
							<td class="pn-flabel pn-flabel-h" width="20%">
							����Ӧ���ֽ�</td>
							<td class="pn-fcontent" align="left" colspan="3">
								<input type="text" name="waterQuery.totalMoney" onchange="totalMoneyNoChange();"></input>
							</td>
				</tr>
<!--				<tr align="center">-->
<!--							<td class="pn-flabel pn-flabel-h" width="20%">-->
<!--							���ô�ӡ������</td>-->
<!--							<td class="pn-fcontent" width="30%"  align="left" colspan="3">-->
<!--								<input type="text" name = "pager.pageSize" value="${pager.pageSize}" onchange="change();"/>-->
<!--							</td>-->
<!--				</tr>-->
				<tr><td align="center" colspan="4"><input id="btn" type="button" value="�� ѯ" onclick="query();"></input>&nbsp;
				<input type="button" value="�� ӡ" onclick="printX();"></input></td></tr>
				</tbody>
			</table>
			<div id="div0">
			<table class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0">
				<tbody class="pn-ltbody">
					<tr>
					<td align="right"  width="10%">����:</td>
					<td  width="10%" id="td0">
						<c:forEach items="${gateList}" var="item">
							<c:if test="${item.gateNo==gateNo }"> ${item.gateName }</c:if>
						</c:forEach>
					</td>
					<td align="right"  width="10%">������:</td>
					<td width="10%" id="td1">${waterQuery.laneNo}</td>
					<td align="right"  width="10%">����:</td>
					<td id="td6" width="10%">
						${waterQuery.operatorNo}
					</td>
					<td align="right"  width="10%">�շ�Ա:</td>
					<td id="td5" width="10%">
						${waterQuery.operatorName}
					</td>
					<td align="right"  width="10%">�����:</td>
					<td id="td2" width="10%" class="border-r">
						<c:forEach items="${squadList}" var="squadItem">
					 		<c:if test="${waterQuery.squadNo==squadItem.squadNo}">${squadItem.squadName}</c:if>						 			
					 	</c:forEach>
					</td>
					</tr>
					<tr>
					<td align="right"  width="10%">����:</td>
					<td id="td7" width="10%">
						<c:if test="${waterQuery.cashType==0}">�ֽ𳵽��</c:if>	
						<c:if test="${waterQuery.cashType==1}">�ֽ��йص���ˮ</c:if>	
						<c:if test="${waterQuery.cashType==2}">�ֹ������</c:if>	
					</td>								
					<td align="right"  width="10%">������:</td>
					<td id="td8" width="10%">
						${pager.totalSize}
					</td>
					<td align="right"  width="10%">Ӧ���ֽ�:</td>
					<td id="td9" width="10%">
						${waterQuery.totalMoney}
					</td>
					<td align="right"  width="12%" >����Ӧ���ֽ�:</td>
					<td id="td11" width="10%">
						
					</td>
					<td></td><td class="border-r"></td>
					</tr>
					<tr><td align="right" >�ϰ�ʱ��:</td>
					<td colspan="4" id="td3" ><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${waterQuery.dltime}" ></fmt:formatDate></td>
					<td  align="right" >�°�ʱ��:</td>
					<td colspan="4" id="td4" class="border-r"><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${waterQuery.dhtime}" ></fmt:formatDate></td>
					</tr>
					</tbody>
				</table>
			<table  class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0" >
				<thead class="pn-lthead">
					<tr>
<!--						<th>��     ��</th>-->
						<th>���ʱ��</th>
						<th>����ʱ��</th>
						<th>��     ��</th>	
						<th>��ڳ���</th>
						<th>��     ��</th>
						<th>��     ��</th>
						<th>�𡡶�(Ԫ)</th>
						<th>���ƺ�</th>
						<th>��     ��</th>
						<th class="border-r">�����¼�</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">
					<c:forEach items="${list}" var="item" varStatus="status">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center">
<!--							<td>${status.index+1}</td>-->
							<td class="td1"><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${item.inTime}" ></fmt:formatDate></td>
							<td class="td2"><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${item.outTime}" ></fmt:formatDate></td>
							<td class="td3">${item.entrance}</td>
							<td class="td4">${item.inLaneNo}</td>
							<td class="td5">${item.vehClass}</td>
							<td class="td6">${item.vehType}</td>
							<td class="td7">${item.cashMoney}</td>
							<td class="td8">${item.vehPlate}</td>
							<td class="td9">${item.cardNo}</td>
							<td class="td10">${item.spEvent}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			</div>
			<jsp:include page="../include/pager.jsp"/>
			</form>
		</div>
	</body>
</html>