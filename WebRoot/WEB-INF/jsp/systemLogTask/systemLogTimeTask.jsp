<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- ʹ��JavaBean ����jsonrpc.jar -->
<jsp:useBean id="JSONRPCBridge" scope="session" class="com.metaparadigm.jsonrpc.JSONRPCBridge"/>
<jsp:useBean id="ajax" class="com.hgsoft.util.AjaxBean"></jsp:useBean>
<%
	JSONRPCBridge.registerObject("ajax",ajax);
%>
<html>
	<head>
		<title>ϵͳ��־��ʱ����</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<%@include file="../include/common.jsp" %>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
		<!-- ����jsonrpc.js -->
		<script type="text/javascript" src="${basePath}/js/jsonrpc.js"></script>
		<script language="javascript">
		 
		if("${message}"=="SUCCESS"){
			alert("������־���ݶ�ʱ�������óɹ���");
			}

		function deleteTask(){
			jsonrpc = new JSONRpcClient("JSON-RPC");//JSON-RPC ��Ӧweb.xml�����URL
			var result = jsonrpc.ajax.deleteTask();
			if(result=="deleteTaskSuccess"){
				window.location.href = "systemLogTask_timeTask.do";
				alert("ɾ������ɹ��� ");
				}	     
			else{
				alert("�������ɾ���� ");
				}
			}
		//��֤������̷��Ƿ����
	    function ishasPosition() {
	    	var position = $("#position").val();
	    	//ͬ��
	    	jQuery.ajax({type:"post",url:"systemLogTask_ishasPosition.do?position="+position,async:false, success:function(data,textStatus){
	    	//�첽��תjQuery.post("systemLogTask_ishasPosition.do?position="+position, function(data){
	    		if(data == "noPosition") {
	    			$("#position").val(" D");
	    			alert("��������̷������ڣ�ϵͳ����������Ϊ D�̣�");
	    			//$("#position").focus();
	    		}	
	    	}});
	    }

		//�ж��Ƿ���0-59������
		function MvalTime(obj){
			 var re = /^[0-9]+[0-9]*]*$/; //�ж�������   
			 if(re.test(obj)&&obj<60){return true}
			 else {
				 alert("������0-59֮��ķ�����");
				 $("#minute").val("00");
				 }
			}
		//�ж��Ƿ���0-59������
		function SvalTime(obj){
			 var re = /^[0-9]+[0-9]*]*$/; //�ж�������   
			 if(re.test(obj)&&obj<60){return true}
			 else {
				 alert("������0-59֮�������");
				 $("#second").val("00");
				 }
			}
		</script>
<style type=text/css>
<!--
.page{padding-top:5px;width:100%;clear:both;}
.left{float:left;width:60%;}
.right{float:right;width:40%;}
.clear{clear:both;}
.line{width:100%;font-size:10px;border-top-color:#556b2f;bordor-top-style:dotted}
-->
</style>
	</head> 
	<body>
		<div class="body-box">
            <div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}
				</div>
				<div class="clear"></div>
			</div>
			<div class="left">
			<form id="dataform" name="tableForm"  method="post" action="systemLogTask_updateTask.do" onsubmit="ishasPosition();">
			<table align="center" id="controltb" class="pn-ltable" width="100%" cellspacing="1" cellpadding="0" border="0" style="height: 172px;">
				<thead class="pn-lthead">
					<tr>
						<th style="white-space:nowrap;padding-left:5px;padding-right:5px;"></th>
						<th align="left" style="white-space:nowrap;padding-left:140px;">��������</th>
					</tr>
				</thead>
				<tbody class="pn-ltbody">

				<tr> 
				
            	<td align="right" > ���뱸��λ�ã�</td> 
             	<td  style="font-weight:bold;padding-left: 20px;" > 
 					 <input style="border:1px solid #78a3d3;height: 15px;" size="3" type="text" id ="position" name ="position"  value =" D" />&nbsp;��
 					 <input class=" required" style="border:1px solid #78a3d3;height: 15px;" size="17" type="text" id ="backupDir" name ="backupDir"  value =" systemLogBackup"/>&nbsp;Ŀ¼
           		</td >  
   				</tr >
   				<tr> 
            	<td align="right" > ѡ����ʱ�䣺</td > 
             	<td style ="font-weight:bold;padding-left: 20px;" >
             	ÿ�� 
            	<select style="border:1px solid #78a3d3;width: 65px;" name ="intervalTime" > 
              		<option  value ="1" > һ </option > 
             		<option  value ="2" > �� </option > 
              		<option  value ="3" > �� </option > 
              		<option  value ="4" > �� </option > 
              		<option  value ="5" > �� </option > 
             		<option  value ="6" > �� </option > 
              		<option  value ="7" > �� </option > 
              		<option  value ="8" > �� </option > 
              		<option  value ="9" > �� </option > 
              		<option  value ="10" > ʮ </option > 
             		<option  value ="11" > ʮһ </option > 
              		<option  value ="12" > ʮ��</option > 
            	</select >&nbsp;���±���һ�� 
          		</td >  
   				</tr >  
   				<tr > 
            	<td align="right" > ���ÿ�ʼ���ڣ�</td > 
             	<td style ="font-weight:bold;padding-left: 20px;" > 
            		<input class=" required" style="border:1px solid #78a3d3;" size="24" type="text" id="startDate" name="startDate" value="<fmt:formatDate value="${startDate}" pattern="yyyy-MM-dd" />" class="Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
          		</td >  
   				</tr >  
   				<tr > 
           		<td align="right" > ������ʼʱ�䣺</td> 
            	<td style ="font-weight:bold;padding-left: 20px;" >
             	 <select style="border:1px solid #78a3d3;width: 45px;" name ="hour"  id ="hour" > 
             		<option  value ="01" <c:if test="${hour=='01'}">selected="selected"</c:if>> 01 </option > 
              		<option  value ="02" <c:if test="${hour=='02'}">selected="selected"</c:if>> 02 </option > 
             		<option  value ="03" <c:if test="${hour=='03'}">selected="selected"</c:if>> 03 </option > 
             		<option  value ="04" <c:if test="${hour=='04'}">selected="selected"</c:if>> 04 </option > 
             		<option  value ="05" <c:if test="${hour=='05'}">selected="selected"</c:if>> 05 </option > 
             		<option  value ="06" <c:if test="${hour=='06'}">selected="selected"</c:if>> 06 </option > 
             		<option  value ="07" <c:if test="${hour=='07'}">selected="selected"</c:if>> 07 </option > 
             		<option  value ="08" <c:if test="${hour=='08'}">selected="selected"</c:if>> 08 </option > 
             		<option  value ="09" <c:if test="${hour=='09'}">selected="selected"</c:if>> 09 </option > 
            		<option  value ="10" <c:if test="${hour=='10'}">selected="selected"</c:if>> 10 </option > 
             		<option  value ="11" <c:if test="${hour=='11'}">selected="selected"</c:if>> 11 </option > 
              		<option  value ="12" <c:if test="${hour=='12'}">selected="selected"</c:if>> 12 </option > 
             		<option  value ="13" <c:if test="${hour=='13'}">selected="selected"</c:if>> 13 </option > 
             		<option  value ="14" <c:if test="${hour=='14'}">selected="selected"</c:if>> 14 </option > 
             		<option  value ="15" <c:if test="${hour=='15'}">selected="selected"</c:if>> 15 </option > 
             		<option  value ="16" <c:if test="${hour=='16'}">selected="selected"</c:if>> 16 </option > 
              		<option  value ="17" <c:if test="${hour=='17'}">selected="selected"</c:if>> 17 </option > 
            		<option  value ="18" <c:if test="${hour=='18'}">selected="selected"</c:if>> 18 </option > 
             		<option  value ="19" <c:if test="${hour=='19'}">selected="selected"</c:if>> 19 </option > 
             		<option  value ="20" <c:if test="${hour=='20'}">selected="selected"</c:if>> 20 </option > 
             		<option  value ="21" <c:if test="${hour=='21'}">selected="selected"</c:if>> 21 </option > 
             		<option  value ="22" <c:if test="${hour=='22'}">selected="selected"</c:if>> 22 </option > 
              		<option  value ="23" <c:if test="${hour=='23'}">selected="selected"</c:if>> 23 </option > 
              		<option  value ="00" <c:if test="${hour=='00'}">selected="selected"</c:if>> 00 </option > 
             	</select >
            	  ��&nbsp;<input style="border:1px solid #78a3d3;height: 15px;" size="3" type="text" id ="minute" name ="minute"   value ="${minute}"  onchange ="MvalTime(this.value)"   />  ��
        	      <input style="border:1px solid #78a3d3;height: 15px;" size="3" type="text" id ="second" name ="second"   value ="${second }"  onchange ="SvalTime(this.value)"   />  ��
        		</td >  
  				</tr >
  				<tr>
				<td colspan="2" class="pn-fbutton" style="padding-top: 15px;padding-bottom: 11px;">
					<input type="submit" value=" ���� "/>&nbsp;
					<input type="reset"" value=" ���� "/>&nbsp;
					<input type="button" value=" ɾ������ " onclick="deleteTask();"/>&nbsp;
				</td>	    
				</tr> 
				
				</tbody>
			</table>	
			</form>
			</div>
			<div class="right">
			<table align="left" class="pn-ltable"  width="100%" cellspacing="1" cellpadding="0" border="0" style="height: 178px;">
				<thead class="pn-lthead">
					<tr><th style="white-space:nowrap;padding-left:5px;padding-right:5px;">��ǰ����</th></tr>
				</thead>
				<tbody class="pn-ltbody">
            	<tr style="padding-top: 5px;"> 
				<td style="padding: 5px;">
				<br />
				<span style="font-weight:normal;font-size:13px;padding-left: 20px;">����Ŀ¼:</span><span id="taskPath" style="font-weight:normal;font-size:13px;padding-left: 5px;"></span><br /><br />
				<span style="font-weight:normal;font-size:13px;padding-left: 20px;">���ݲ���:</span><span id="taskTimeParameter" style="font-weight:normal;font-size:13px;padding-left: 5px;"></span><br /><br />
				<span style="font-weight:normal;font-size:13px;padding-left: 20px;">����˵��:</span><br /><span id="taskTimeRemark" style="font-weight:normal;font-size:13px;padding-left: 85px;"></span><br /><br /><br />
				<script language="javascript">			    
	                  jsonrpc = new JSONRpcClient("JSON-RPC");//JSON-RPC ��Ӧweb.xml�����URL
	                  var _path = jsonrpc.ajax.findSysLogBackupTask_PATH();	             	 
	                  for (var i=0;i<_path.length;i++){	                    	 
		                   var path=_path[i][0];    
		                   document.getElementById("taskPath").innerHTML=path;
	                  }	    
	                  var _time = jsonrpc.ajax.findSysLogBackupTask_TIME();	                        	 
	                  for (var i=0;i<_time.length;i++){	                    	 
		                   var timeParameter=_time[i][0];
		                   var timeRemark=_time[i][1];
		                   document.getElementById("taskTimeParameter").innerHTML=timeParameter;
		                   document.getElementById("taskTimeRemark").innerHTML=timeRemark;	
	                  }	                         	
                </script>
				</td>
            	</tr>
            	</tbody>
			</table>
			</div>
		</div>
	</body>
</html>