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
		<title>��ӳ�������Ա��Ϣ</title>
		<%@include file="../../include/common.jsp" %>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>	
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<!-- ����jsonrpc.js -->
		<script type="text/javascript" src="${basePath}/js/jsonrpc.js"></script>	
		<script type="text/javascript">
		
		if("${message}"=="exitLaneOperator"){
			alert("����Ա�����Ѵ��ڣ�");
			}
        //������ҳ
		function back(){
			window.location.href = "laneOperator_list.do";
			}
		//��ȡС��
		function getPark(){
		  (function($) { 
			   $(function() {
			$.ajax({
				type:"post",
				url:"lostCard_ajaxPark.do?areaNo="+document.getElementById('laneOperator_areaNo').value,
				success:function(res){
					$("#laneOperator_parkNo").empty();
					var op = $("<option value=''>- ��ѡ�� -</option>");		
					$("#laneOperator_parkNo").append(op);
					$(res).find("parks > park").each(function(){								
					var op = $("<option value=" + $(this).attr("id") + ">" 
							+ $(this).attr("name") + "</option>");
					$("#laneOperator_parkNo").append(op);	
				});
				}
			});
		   });
		  })(jQuery);
		}
		
		 //���������ɫ������
	    var roles=new Array();
	    var checkCount=0;

	  //�����±�ɾ��ĳ������Ԫ��	
		  Array.prototype.remove=function(dx) 
		  { 
		      if(isNaN(dx)||dx>this.length){return false;} 
		      for(var i=0,n=0;i<this.length;i++) 
		      { 
		          if(this[i]!=this[dx]) 
		          { 
		              this[n++]=this[i] 
		          } 
		      } 
		      this.length-=1 
		  }
		  Array.prototype.baoremove = function(dx) 
		  { 
		      if(isNaN(dx)||dx>this.length){return false;} 
		      this.splice(dx,1); 
		  } 
		  
		function setRole(obj){
			if(obj.checked){
				roles[checkCount]=obj.value;
				checkCount++;
				}else{
					//����һ��ѡ��checkbox����ȡ�������������ȥ����ֵ
					var del=obj.value;
					for(var i=0;i<roles.length;i++){
						  if(del==roles[i]){
							  roles.baoremove(i);
							  checkCount--;}
						}
					}
			}
		function setRoles(){
			get("roles").value=roles;
			}
		</script>

	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form id="dataform" method="post" action="laneOperator_save.do" onsubmit="setRoles()"/>
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
					<input type="hidden" name="roles" ></input>
					<tr>
						<td class="pn-flabel pn-flabel-h">���ý�ɫ��</td>
						<td colspan="3" class="pn-fcontent">
						<c:forEach items="${list}" var="item">
							<input type="checkbox" id="${item.roleNo}" value="${item.roleNo}" onclick="setRole(this);"></input>${item.roleName}
						</c:forEach>
						</td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">�������ƣ�</td>
						<td class="pn-fcontent">
						<select id="laneOperator_areaNo" class="required" name="laneOperator.areaNo" style="width: 178px;height: 22px;" onchange="getPark();">
						</select><span style="color: red">&nbsp;*</span></td>
						<td class="pn-flabel pn-flabel-h">С�����ƣ�</td>
						<td class="pn-fcontent">
						<select id="laneOperator_parkNo" class="required" name="laneOperator.parkNo" style="width: 178px;height: 22px;">
							<option value="">- ��ѡ�� -</option>
						</select><span style="color: red">&nbsp;*</span></td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">����Ա���룺</td>
						<td class="pn-fcontent"><input type="text" class="required isNo_NotOverValueInt" name="laneOperator.operatorNo" value="${laneOperator.operatorNo}" size="24"/><span style="color: red">&nbsp;*</span></td>
					  	<td class="pn-flabel pn-flabel-h">��¼���룺</td>
						<td class="pn-fcontent"><input type="text" class="required maxlength6" name="laneOperator.password" value="${laneOperator.password}" size="24"/><span style="color: red">&nbsp;*</span></td>
						</tr>
					
					<tr>
						<td class="pn-flabel pn-flabel-h">����Ա���ƣ�</td>
						<td class="pn-fcontent"><input type="text" class=" maxlength8" name="laneOperator.operatorName" value="${laneOperator.operatorName}" size="24"/></td>
							<td  class="pn-flabel pn-flabel-h">״&nbsp;&nbsp;&nbsp;&nbsp;̬��</td>
						<td  class="pn-fcontent">
						<c:if test="${laneOperator.status==null}">
						<select class="required"  name="laneOperator.status" style="width: 178px;height: 24px;">
						   <option value="" selected="selected"> - ��ѡ�� -</option>
						   <option value="0" > ��Ч</option>
						   <option value="1" > ����</option>
						</select>
						</c:if>			
						<c:if test="${laneOperator.status=='0'}">
						<select class="required" name="laneOperator.status"  style="width: 178px;height: 24px;">
						   <option value="0" selected="selected"> ��Ч</option>
						   <option value="1" > ����</option>
						</select>
						</c:if>
						<c:if test="${laneOperator.status=='1'}">
						<select class="required" name="laneOperator.status" style="width: 178px;height: 24px;">
						   <option value="0" > ��Ч</option>
						   <option value="1" selected="selected"> ����</option>
						</select>
						</c:if>
						</td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">��ݿ��ţ�</td>
						<td class="pn-fcontent"><input type="text" class=" maxlength16" name="laneOperator.opCardId" value="${laneOperator.opCardId}" size="24"/></td>
						<td class="pn-flabel pn-flabel-h">��ݿ����Ա�ţ�</td>
						<td class="pn-fcontent"><input type="text" class=" isNo_NotOverValueInt" name="laneOperator.opCardNo" value="${laneOperator.opCardNo}" size="24"/></td>
					</tr>
					<tr>
						<td colspan="4" class="pn-fbutton">
							<input type="submit" value=" �� �� " />&nbsp;
						    <input type="reset" value=" �� �� "/>&nbsp;
						    <input type="button" value=" �� �� " onclick="return back()"/>
						</td>
						    
					</tr>
				</table>
			</form>
		</div>
	<script language="javascript">
	//����������������б�
	jsonrpc = new JSONRpcClient("JSON-RPC");//JSON-RPC ��Ӧweb.xml�����URL
	var result1 = jsonrpc.ajax.getAreaNo_AreaName();
	for (var i=0;i<result1.length;i++){
		option =document.createElement("OPTION");
		option.value = result1[i][0];
		option.text = result1[i][1];
		document.getElementById("laneOperator_areaNo").options.add(option);
	}
	
</script>	
	</body>
</html>