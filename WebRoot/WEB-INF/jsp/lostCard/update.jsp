<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
	<head>
		<title></title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script type="text/javascript" src="${basePath}/js/jquery.js"></script>
		<script type="text/javascript" src="${basePath}/js/jquery.form.js"></script>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
		<script type="text/javascript"><!--
			var arr = new Array;//�������
			var imgArr = new Array;//���ͼƬ����
			var i = 0;
			var queryStatus = "";
			function Len(str) {	//���������ַ�����
                var i,sum;
                sum=0;
                for(i=0;i<str.length;i++) {
                	if ((str.charCodeAt(i)>=0) && (str.charCodeAt(i)<=255)) {
                		sum=sum+1;
                	} else {
                		sum=sum+2;
                	}
                }
                return sum;
            }
			//�޸ĳ��ƺ�
			function updateVehPlate(){
				if($(document.getElementById('vehPlate')).val()==""){
					alert("���ƺŲ���Ϊ��");
					return false;
				}
				if(Len($(document.getElementById('vehPlate')).val())>10){
					alert("���Ƴ��Ȳ��ܴ���10λ");
					return false;
				}
				$.ajax({
					type:"post",
					url:"lostCard_updateVehPlate.do?cardNo="+$(document.getElementById('cardNo1')).val()
					+ "&vehPlate="+encodeURI(encodeURI($(document.getElementById('vehPlate')).val())),
					success:function(res){
						$(res).find("massages > massage").each(function(){
							var op = $(this).attr("content");
							alert("   "+op);
								
						});
					}
				});
			}
			//�޸�״̬
			function updateStatus(){
				var temp = $(document.getElementById('status')).val();
				if(temp ==""){
					alert("��ѡ��״̬");
					return false;
				}
				if(temp==13 || temp ==16){
					if(queryStatus==""){
						alert("��Ҫ�ó��ĳ�����Ϣ");
						return false;
					}
				}
				$.ajax({
					type:"post",
					url:"lostCard_updateStatus.do?cardNo="+$(document.getElementById('cardNo1')).val()+"&cardOpTime="+$(document.getElementById('qOpTime')).val()
					+ "&status="+$(document.getElementById('status')).val()+"&outListNo="+$('#outListNo').text(),
					success:function(res){			
						$(res).find("massages > massage").each(function(){
							var op = $(this).attr("content");
							alert("   "+op);
							if(op=="��״̬�޸ĳɹ�"){
								$("#ListStatus").empty();
								var tempStatus = $("#status");
								var tempSelect = document.getElementById('status');
								$("#ListStatus").append(tempSelect.options[tempSelect.selectedIndex].text);
							}
						});
					}
				});
			}
			//ѡ��״̬ʱ��������ʾ�Ƿ���ʾ
			function toChange(obj){
				if(obj.value==13 || obj.value==16){
					alert("��Ҫ�Աȳ�����Ϣ");
				}
			}
			//��ѯ������Ϣ
			function search(){
				if(document.getElementById('qOpTime').value==""){
					alert("ʱ���ʽ����");
					return;
				}
				if(document.getElementById('days').value==""){
					alert("�����������Ϊ�գ�");
					return;
				} else {
					if(document.getElementById('days').value>365){
						alert("�������������365��");
					    return;
					}
					var partten=/^[0-9]*$/;
					if(!partten.test((document.getElementById('days').value))){
						alert("���������ʽ�����ţ����������루���磺30����300��");
					    return;
					}
					
				}
				document.getElementById('waiting').style.display='inline';
				$.ajax({
					type:"post",
					url:"lostCard_queryByOpTimeAndVehPlate.do?days="+$(document.getElementById('days')).val()
						+ "&backNums="+$(document.getElementById('backNums')).val()
						+ "&vehPlate="+encodeURI(encodeURI($(document.getElementById('qVehPlate')).val()))
						+ "&opTime="+$(document.getElementById('qOpTime')).val(),
					success:function(res, status){
						document.getElementById('waiting').style.display='none';
						$("#dataId").empty();
						i = 0;
						arr = arr.splice(0);//���������
						imgArr = imgArr.splice(0);//��ͼƬ�����������
						$(res).find("allOutLists > allOutList").each(function(){
							var op = $("<table cellspacing='1' class='pn-ftable' bodercolor='#ffaa00'><tr><td width='10%' class='pn-flabel pn-flabel-h'>�� ˮ �ţ�</td><td width='15%' class='pn-fcontent' id='outListNo'>"+$(this).attr("listNo")+"</td><td width='10%' class='pn-flabel pn-flabel-h'>С �� ����</td><td width='15%' class='pn-fcontent'>"+$(this).attr("parkName")+"</td></tr><tr><td width='10%' class='pn-flabel pn-flabel-h'>�û����ţ�</td><td width='15%' class='pn-fcontent'>"
								+$(this).attr("cardNo")+"</td><td width='10%' class='pn-flabel pn-flabel-h'>�� �� ����</td><td width='15%' class='pn-fcontent'>"+$(this).attr("gateName")+"</td></tr><tr><td width='10%' class='pn-flabel pn-flabel-h'>�� �� �ţ�</td><td width='15%' class='pn-fcontent'>"
								+$(this).attr("vehplate")+"</td><td width='10%' class='pn-flabel pn-flabel-h'>�� �� �ţ�</td><td width='15%' class='pn-fcontent'>"+$(this).attr("laneNo")+"</td></tr><tr><td width='10%' class='pn-flabel pn-flabel-h'>ʱ    �䣺</td><td width='15%' class='pn-fcontent'>"
								+$(this).attr("opTime")+"</td><td width='10%' class='pn-flabel pn-flabel-h'>�� �� Ա��</td><td width='15%' class='pn-fcontent'>"+$(this).attr("operatorName")+"</td></tr><tr><td width='10%' class='pn-flabel pn-flabel-h'>��   ע��</td><td colspan='3'class='pn-fcontent'>"
								+$(this).attr("outRemark")+"</td></tr><tr><td colspan='4'class='pn-fcontent'>&nbsp;&nbsp;<br/><b>����ͼ��</b><br/><br/><img id='imgSrc'/></td></tr></table>");
							arr[i] = op;
							imgArr[i] = $(this).attr("pic");
							i = i+1;
						});
						if(arr.length > 0){
							$("#dataId").append(arr[0]);
							document.getElementById('imgSrc').src="lostCard_readImg.do?imagSrc="+imgArr[0];
							document.getElementById('nowRecord').value=1;
						}else{
							document.getElementById('nowRecord').value=0;
						}
						i=0;
						queryStatus = "0";
						if(arr.length ==1 || arr.length == 0){
							document.getElementById('currRecord').style.display='none';
							document.getElementById('nextRecord').style.display='none';
						}else{
							document.getElementById('currRecord').style.display='none';
							document.getElementById('nextRecord').style.display='inline';
						}	
						document.getElementById('totalRecord').value=arr.length;
						document.getElementById('countsId').style.display='inline';
					}
				});
			}
			//��ȡ��һ������
			function getNextRecord(){
				for(n=0;n<arr.length;n++){
					if(i==n){
						document.getElementById('imgSrc').src="";
						$("#dataId").empty();
						$("#dataId").append(arr[i+1]);
						document.getElementById('imgSrc').src="lostCard_readImg.do?imagSrc="+imgArr[i+1];
						break;
					}
				}
				document.getElementById('nowRecord').value=i+2;
				if((i+2)==arr.length){
					document.getElementById('currRecord').style.display='inline';
					document.getElementById('nextRecord').style.display='none';
				}else{
					document.getElementById('currRecord').style.display='inline';
					document.getElementById('nextRecord').style.display='inline';
				}
				i=i+1;
			}
			//�����һ������
			function getCurrRecord(){
				for(n=0;n<arr.length;n++){
					if(i==n){
						document.getElementById('imgSrc').src="";
						$("#dataId").empty();
						$("#dataId").append(arr[i-1]);
						document.getElementById('imgSrc').src="lostCard_readImg.do?imagSrc="+imgArr[i-1];
						break;
					}
				}
				document.getElementById('nowRecord').value=i;
				if((i-1)==0){
					document.getElementById('currRecord').style.display='none';
					document.getElementById('nextRecord').style.display='inline';
				}else{
					document.getElementById('currRecord').style.display='inline';
					document.getElementById('nextRecord').style.display='inline';
				}
				i=i-1;
			}
			function back(id,count,startTime,endTime,cardNo,status,vehPlate){
				window.location.href = "lostCard_queryCardDynamic.do?pager.currentPage="+id+"&pager.pageSize="+count+"&startTime="+startTime+"&endTime="+endTime+"&cardNo="+cardNo+"&status="+status+"&vehPlate="+vehPlate;
			}
		--></script>
	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<form class="ropt" method="post">
					<input type="button" value=" �� �� " onclick="back(${pager.currentPage },${pager.pageSize },'${startTime}','${endTime}','${cardNo}','${status}','${vehPlate}');"/>
				</form>
				<div class="clear"></div>
			</div>
			<table width="850" cellspacing="1" class="pn-ftable" bodercolor="#ffaa00">
				<tr>
					<!-- �������Ϣ -->
					<td class="pn-fcontent" width="50%">
						<table cellspacing="1" class="pn-ftable" bodercolor="#ffaa00" width="100%">
							<tr>
								<td class="pn-fcontent">
									<table cellspacing="1" class="pn-ftable" bodercolor="#ffaa00" width="100%">
										<tr>									
											<td width="13%" class="pn-flabel pn-flabel-h">���ƺţ�</td>
											<td class="pn-fcontent">
												<input type="text" name="vehPlate" id="vehPlate" value="${cardDynamic.vehPlate }" style="width: 60px"/>&nbsp;
												<input type="button" value="�� ��" onclick="updateVehPlate();"/>
											</td>		
											<td width="13%" class="pn-flabel pn-flabel-h">��״̬��</td>
											<td class="pn-fcontent">
												<select name="status" id="status" onchange="toChange(this);">
													<option value="">-��ѡ��-</option>
													<option value="13">&nbsp;�� ��</option>
													<option value="14">&nbsp;δ ֪</option>
													<option value="15">&nbsp;�� ��</option>
													<option value="16">&nbsp;�ѷ���</option>
													<option value="12">&nbsp;�ѻ���</option>
												</select>
												<input type="button" value="ȷ ��" onclick="updateStatus();"/>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td class="pn-fcontent">
									<table width="100%" cellspacing="1" class="pn-ftable" bodercolor="#ffaa00">
										<tr>
											<td colspan="4" class="pn-fcontent">
											<br/>�����Ϣ��<br/>
											</td>
										</tr>
										<tr>
											<td width="10%" class="pn-flabel pn-flabel-h">�� ˮ �ţ�</td>
											<td width="15%" class="pn-fcontent">${cardDynamic.inListNo }</td>
											<td width="10%" class="pn-flabel pn-flabel-h">С �� ����</td>
											<td width="15%" class="pn-fcontent">
												<c:forEach items="${parkList}" var="temp">
													<c:if test="${temp.parkNo == cardDynamic.parkNo}">${temp.parkName}</c:if>
												</c:forEach>
											</td>
										</tr>
										<tr>
											<td width="10%" class="pn-flabel pn-flabel-h">������ţ�</td>
											<td width="15%" class="pn-fcontent">${cardDynamic.cardNo }</td>
											<td width="10%" class="pn-flabel pn-flabel-h">�� �� ����</td>
											<td width="15%" class="pn-fcontent">
												<c:forEach items="${gateList}" var="temp">
													<c:if test="${temp.gateNo == cardDynamic.gateNo}">${temp.gateName}</c:if>
												</c:forEach>
											</td>
										</tr>
										<tr>
											<td width="10%" class="pn-flabel pn-flabel-h">�� �� �ţ�</td>
											<td width="15%" class="pn-fcontent">${cardDynamic.vehPlate }</td>
											<td width="10%" class="pn-flabel pn-flabel-h">�� �� �ţ�</td>
											<td width="15%" class="pn-fcontent">${cardDynamic.laneNo }</td>
										</tr>
										<tr>
											<td width="10%" class="pn-flabel pn-flabel-h">ʱ    �䣺</td>
											<td width="15%" class="pn-fcontent"><fmt:formatDate value="${cardDynamic.opTime }" pattern="yyyy-MM-dd HH:mm:ss" /></td>
											<td width="10%" class="pn-flabel pn-flabel-h">�� �� Ա��</td>
											<td width="15%" class="pn-fcontent">${cardDynamic.operatorName }</td>
										</tr>
										<tr>
											<td width="10%" class="pn-flabel pn-flabel-h">�� ״ ̬��</td>
											<td width="15%" class="pn-fcontent" id="ListStatus">
												<c:if test="${cardDynamic.status == 11}">��ڷ���</c:if>
												<c:if test="${cardDynamic.status == 12}">���ڻ���</c:if>
												<c:if test="${cardDynamic.status == 13}">����(��ʧ���ݲ��㣬�޷�׷��)</c:if>
												<c:if test="${cardDynamic.status == 14}">δ֪</c:if>
												<c:if test="${cardDynamic.status == 15}">����</c:if>
												<c:if test="${cardDynamic.status == 16}">�ѷ���</c:if>
											</td>
											<td width="10%" class="pn-flabel pn-flabel-h">�� �� ����</td>
											<td width="15%" class="pn-fcontent">${cardDynamic.owner}</td>
										</tr>
										<tr>
											<td class="pn-fcontent" colspan="4">
												&nbsp;&nbsp;<br/><b>���ͼ��</b><br/><br/>
												<img src="lostCard_readImg.do?imagSrc=${imagSrc }" alt="��ͼƬ"/>
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
					<!-- �ų�����Ϣ -->
					<td class="pn-fcontent" valign="top">
						<table  cellspacing="1" class="pn-ftable" bodercolor="#ffaa00" width="100%">
							<tr>
								<td class="pn-fcontent">
									<table cellspacing="1" class="pn-ftable" bodercolor="#ffaa00" width="100%">
										<tr>									
											<td class="pn-fcontent" align="left">
												&nbsp;&nbsp;������
												<input type="text" name="days" id="days" value="${days }" style="width: 20px;height: 13px"/>&nbsp;�죬����������
												<select name="backNums" id="backNums" style="width: 40px">
													<option value="10"<c:if test="${backNums==10 }"> selected </c:if>>10</option>
													<option value="20"<c:if test="${backNums==20 }"> selected </c:if>>20</option>
													<option value="30"<c:if test="${backNums==30 }"> selected </c:if>>30</option>
													<option value="40"<c:if test="${backNums==40 }"> selected </c:if>>40</option>
													<option value="50"<c:if test="${backNums==50 }"> selected </c:if>>50</option>
												</select>&nbsp;��&nbsp;&nbsp;
												<input type="button" value="��ѯ" onclick="search();"/> &nbsp; <span id="waiting" style="display: none"><font color="red">��ѯ��...</font></span>
												<input type="hidden" name="qOpTime" id="qOpTime" value="${cardDynamic.opTime }"/><!-- ����ʱ�� -->
												<input type="hidden" name="qVehPlate" id="qVehPlate" value="${cardDynamic.vehPlate }" /><!-- ���ƺ� -->
												<input type="hidden" name="cardNo1" id="cardNo1" value="${cardDynamic.cardNo }"><!-- ������� -->
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td class="pn-fcontent">
									<table cellspacing="1" class="pn-ftable" bodercolor="#ffaa00" width="100%">
										<tr>
											<td class="pn-fcontent">
												<br/>������Ϣ��						
												<div id="dataId">
												
												</div>
											</td>
										</tr>
										<tr>
											<td class="pn-fcontent">
												<div id="countsId" style="display: none;">
													��ǰ��<input type="text" id="nowRecord" size="1" style="border-left:0px;border-top:0px;border-right:0px;border-bottom:0px"/>��
													/����<input type="text" id="totalRecord" size="1" style="border-left:0px;border-top:0px;border-right:0px;border-bottom:0px"/>��
													&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
													<input type="button" value="��һ��" onclick="getCurrRecord();" style="display: none;" id="currRecord"/>
													&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" value="��һ��" onclick="getNextRecord();" style="display: none;" id="nextRecord"/>
												</div>
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</div>
	</body>
</html>