<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
	<head>
		<title>�޸ĳ�������Ա��Ϣ</title>
		<%@include file="../../include/common.jsp" %>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>	
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script type="text/javascript">
		//��ȡ������Ա�Ľ�ɫ	
		var operatorRoles=new Array();
		var _operatorRoles="${operatorRoles}";
		operatorRoles=_operatorRoles.split("_");

        //������ҳ
		function back(){
			window.location.href = "laneOperator_list.do";
			}
		//���������ɫ������
	    var roles=new Array();
	    var checkCount=operatorRoles.length;
        var initcheckCount=0;
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
			//alert(roles);
			get("roles").value=roles;
			//return false;
			}
		
		</script>

	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form id="dataform" method="post" action="laneOperator_update.do" onsubmit="return setRoles();">
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
					<input type="hidden" name="roles" ></input>
					<tr>
						<td class="pn-flabel pn-flabel-h">���ý�ɫ��</td>
						<td colspan="3" class="pn-fcontent">
						<c:forEach items="${list}" var="item">
							<input type="checkbox" id="${item.roleNo}" name="${item.roleNo}" value="${item.roleNo}" onclick="setRole(this)"></input>${item.roleName}
						</c:forEach>
						</td>
					</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">������룺</td>
						<td style="width: 446px;" class="pn-fcontent"><input type="hidden"  name="laneOperator.areaNo" value="${laneOperator.areaNo}" size="24"/>${laneOperator.areaNo}</td>
					  	<td class="pn-flabel pn-flabel-h">С�����룺</td>
						<td style="width: 446px;" class="pn-fcontent"><input type="hidden"  name="laneOperator.parkNo" value="${laneOperator.parkNo}" size="24"/>${laneOperator.parkNo}</td>
					  </tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">����Ա���룺</td>
						<td class="pn-fcontent"><input type="hidden" name="laneOperator.operatorNo" value="${laneOperator.operatorNo}" size="24"/>${laneOperator.operatorNo}</td>
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
						<td class="pn-flabel pn-flabel-h">��ݿ��Ա�ţ�</td>
						<td class="pn-fcontent"><input type="text" class=" isNo_NotOverValueInt" name="laneOperator.opCardNo" value="${laneOperator.opCardNo}" size="24"/></td>
					</tr>
					<tr>
						<td colspan="4" class="pn-fbutton">
							<input type="submit" value=" �� �� "/>&nbsp;
						    <input type="reset" value=" �� �� "/>&nbsp;
						    <input type="button" value=" �� �� " onclick="return back()"/>
						</td>
						    
					</tr>
				</table>
			</form>
		</div>
	<script language="javascript">
	
	//��ʼ����ɫ
	var inputs =document.getElementsByTagName("input");
	for(var i=0;i < inputs.length;i++){ 
        var ele = inputs[i];
        //�ж�type�ǡ�checkbox�������һ�ȡcheckbox��id 
        if(ele.type == "checkbox"){
        	if(isValue(ele.value)){
        		ele.checked=true;
        		roles[initcheckCount]=ele.value;
        		initcheckCount++;
            	}
            }
	}
	function isValue(obj){
		for(var j=0;j<operatorRoles.length;j++){
			if(operatorRoles[j]==obj)
    		  return true;
            }
		}
</script>	
	</body>
</html>