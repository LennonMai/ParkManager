<%--<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
	<head>
		<title></title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
		<script type="text/javascript">
			if("${result}"=="SUCCESS")
				alert("���ĳɹ�");
				if("${result}"=="FAIL")
				alert("���д˿���");
				   String.prototype.trim = function() 
                   { 
                           // ��������ʽ��ǰ��ո��ÿ��ַ�������� 
                        return this.replace(/(^\s*)|(\s*$)/g, ""); 
                   } 
		      		
				   function Len(str)
			        {
			        var i,sum;
			        sum=0;
			        for(i=0;i<str.length;i++)
			          {   
			             if ((str.charCodeAt(i)>=0) && (str.charCodeAt(i)<=255)){
			                 if(str.charCodeAt(i)==183)
			                 {
			                     sum=sum+2;
			                 }else{
			                	 sum=sum+1;
			                 }
			               
			                } else{
			                	 sum=sum+2;
			                }
			               
			           }
			        return sum;
			        }
			function check(){
				if(document.getElementsByName("account.cardNo")[0].value==""){
					alert("���Ų���Ϊ�գ����������룡");
					document.getElementsByName("account.cardNo").focus();
					return false;
				}
				if((document.getElementsByName("account.cardNo")[0].value).trim()!=""){
				var partten=/^[0-9]\d*$/;
				//var partten=/^d*$/;
				//var partten=/^[0]*$/;
				if(partten.test((document.getElementsByName("account.cardNo")[0].value).trim())){
				  
				}
				else{
				  alert("����ֻ�������֣�����������.");
					document.getElementsByName("account.cardNo")[0].focus();
					return false;
					}
				}		
				if((document.getElementsByName("account.cardNo")[0].value).trim()!=""){
				//var partten=/^[1-9]\d*$/;
				var partten=/^[0]*$/;
				if(partten.test((document.getElementsByName("account.cardNo")[0].value).trim())){
				   alert("���ŵ����е�λ������ȫΪ0������������.");
					document.getElementsByName("account.cardNo")[0].focus();
					return false;
				}
				}		
				var cardNoLegth = document.getElementsByName("param_accountCardNoLength.pvalue")[0].value;
				if(cardNoLegth == 10){
					if((document.getElementsByName("account.cardNo")[0].value).trim()!="" && Len((document.getElementsByName("account.cardNo")[0].value).trim())>cardNoLegth){
						   alert("���ų��Ȳ��ܳ���"+cardNoLegth+"���ַ�,����������."); 
						   document.getElementsByName("account.cardNo")[0].focus();
						   return false;
						}	
				} 
				if(cardNoLegth != 10) {
					if(Len((document.getElementsByName("account.cardNo")[0].value).trim())!=cardNoLegth){
						 alert("���ų���Ҫ����"+cardNoLegth+"���ַ�,����������."); 
						 document.getElementsByName("account.cardNo")[0].focus();
						 return false;
					}
					
				}		
				if((document.getElementsByName("cost")[0].value).trim()==""){
					alert("�����Ѳ���Ϊ�գ����������룡");
					document.getElementsByName("cost")[0].focus();
					return false;
				}	
				if((document.getElementsByName("cost")[0].value).trim()!=""){
				//var partten = /^\+?[0-9][0-9]*$/;
				//var partten=/^d+(.d+)?$/;
				var partten=/^(\d{1,10}\.\d{1,10}|\d{1,10})$/;
				//var partten=/^[1-9]\d*|[1-9]\d*\.\d*|0\.\d*[1-9]\d*$/; 
				if(partten.test((document.getElementsByName("cost")[0].value).trim())){
				   if(document.getElementsByName("cost")[0].value>=100000){
                    alert("�����ѹ��󣨲��ܳ���100000�������������룡");
                    document.getElementsByName("cost")[0].focus();
					return false;
					}
                 }else{
                   alert("������Ϊ��ʵ������0������0����50.5�������������룡");
                   document.getElementsByName("cost")[0].focus();
					return false;
                 }
                 }	
              
               }	
				
		</script>
	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			 <form method="post" action="account_updateAccountOrSavaLog.do?cardNo1=${account.cardNo}" onsubmit="return check();">  
				   <!--  <form method="post" action="car_save.do" onsubmit="return check();">-->
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0" >			
					<tr>
					 
					  <td colspan="4" class="pn-fcontent"><input type="text"  value="�������¿���Ϣ��" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					   
					</tr>
					<tr>
					 
					   <td  class="pn-flabel pn-flabel-h">�����ͣ�</td>
					    <c:if test="${account.cardType==0}"><td  class="pn-fcontent"><input type="text" value="��ͨ��" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					    <c:if test="${account.cardType==5}"><td  class="pn-fcontent"><input type="text" value="�ɷѿ�" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					     <c:if test="${account.cardType!=5&&account.cardType!=0}"><td  class="pn-fcontent"><input type="text" value="" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
						<td colspan="2" class="pn-fcontent"><input type="hidden" name="account.sys_id"  value="${account.sys_id}"/></td>
						</tr>
						<tr>
					  <td class="pn-flabel pn-flabel-h">���ţ�</td>
					  <td class="pn-fcontent"><input type="text" name="account.cardNo" value="${account.cardNo}" /></td>
					    <td class="pn-flabel pn-flabel-h">������(Ԫ����</td>
					  <td class="pn-fcontent"><input type="text" name="cost" value="<fmt:formatNumber value="${account.cost/100}" pattern="#.##" type="number"/>"/></td>
					</tr>
					
					<tr>
						<td colspan="4" class="pn-fbutton">
							<input type="submit" value=" �޸� "/> &nbsp;
							<input type="button" value=" �� �� " onclick="history.back();"/>
							<input type="hidden" name="param_accountCardNoLength.pvalue" value="${param_accountCardNoLength.pvalue}"/>
						</td>
						    
					</tr>
					
					 </table>
					
			</form>
		</div>
	</body>
</html>

--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
	<head>
		<title></title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script type="text/javascript" src="${basePath}/js/jquery.js"></script>
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
		<script type="text/javascript">
			if("${result}"=="SUCCESS")
				alert("���ĳɹ�");
				if("${result}"=="FAIL")
				alert("���д˿���");
			String.prototype.trim = function() { 
               	// ��������ʽ��ǰ��ո��ÿ��ַ�������� 
                return this.replace(/(^\s*)|(\s*$)/g, ""); 
    		} 		      		
			function Len(str) {
				var i,sum;
			 	sum=0;
			   	for(i=0;i<str.length;i++) {   
					if ((str.charCodeAt(i)>=0) && (str.charCodeAt(i)<=255)){
			     		if(str.charCodeAt(i)==183){
			      			sum=sum+2;
						}else{
			           		sum=sum+1;
			    		}			               
			  		} else{
			      		sum=sum+2;
			       	}			               
				}
				return sum;
			}
			<%--window.onload = function() {
				if("${account.balance/100}"!=0){
					document.getElementById("buttonTwo").disabled = true;
				}else{
					document.getElementById("buttonOne").disabled = true;
				}
			}--%>
			function updateCardNo(){
			   	if(check() == false){
					return false;
				}
	      	 	var cardNo= document.getElementsByName("account.cardNo")[0].value;
	         	var cost= document.getElementsByName("cost")[0].value;
	           	var sys_id= document.getElementsByName("account.sys_id")[0].value;
	           	var oldCardNo= document.getElementsByName("oldCardNo")[0].value;                	    	
			  	window.location.href ="account_updateAccountOrSavaLog.do?cardNo1="+oldCardNo+"&account.sys_id="+sys_id+"&cost="+cost+"&account.cardNo="+cardNo;			    	
			    }
			function Run(strPath){ 
		   		try{   
			    	var objShell = new ActiveXObject("wscript.shell");   
			   		// objShell.Run(strPath); 
			   		objShell.Run('\"' + strPath + '\"');   
			    	objShell = null; 
		      	} catch(e) {
		      		alert('�Ҳ����ļ�"'+strPath+'"(���������֮һ)�������ҳ��������˵��')
		   		}   
			}      
			function check(){
			    	if(document.getElementsByName("account.cardNo")[0].value==""){
						  alert("���Ų���Ϊ�գ����������룡");
						  document.getElementsByName("account.cardNo")[0].focus();
						  return false;
					    }
					   if((document.getElementsByName("account.cardNo")[0].value).trim()!=""){
					      var partten=/^[0-9]\d*$/;
					      if(partten.test((document.getElementsByName("account.cardNo")[0].value).trim())){			  
					      }else{
					          alert("����ֻ�������֣�����������.");
						      document.getElementsByName("account.cardNo")[0].focus();
						      return false;
						   }
					    }		
					  if((document.getElementsByName("account.cardNo")[0].value).trim()!=""){
					     var partten=/^[0]*$/;
					     if(partten.test((document.getElementsByName("account.cardNo")[0].value).trim())){
					        alert("���ŵ����е�λ������ȫΪ0������������.");
						    document.getElementsByName("account.cardNo")[0].focus();
						    return false;
					      }
					  }		
					  var cardNoLegth = document.getElementsByName("param_accountCardNoLength.pvalue")[0].value;
					  if(cardNoLegth == 10){
						if((document.getElementsByName("account.cardNo")[0].value).trim()!="" && Len((document.getElementsByName("account.cardNo")[0].value).trim())>cardNoLegth){
							   alert("���ų��Ȳ��ܳ���"+cardNoLegth+"���ַ�,����������."); 
							   document.getElementsByName("account.cardNo")[0].focus();
							   return false;
							}	
					  } 
					  if(cardNoLegth != 10) {
						if(Len((document.getElementsByName("account.cardNo")[0].value).trim())!=cardNoLegth){
							 alert("���ų���Ҫ����"+cardNoLegth+"���ַ�,����������."); 
							 document.getElementsByName("account.cardNo")[0].focus();
							 return false;
						}
						
					  }		
					  if((document.getElementsByName("cost")[0].value).trim()==""){
						alert("�����Ѳ���Ϊ�գ����������룡");
						document.getElementsByName("cost")[0].focus();
						return false;
					   }	
					  if((document.getElementsByName("cost")[0].value).trim()!=""){
					    var partten=/^(\d{1,10}\.\d{1,10}|\d{1,10})$/;
					     if(partten.test((document.getElementsByName("cost")[0].value).trim())){
					        if(document.getElementsByName("cost")[0].value>=100000){
	                            alert("�����ѹ��󣨲��ܳ���100000�������������룡");
	                            document.getElementsByName("cost")[0].focus();
						        return false;
						    }
	                     }else{
	                        alert("������Ϊ��ʵ������0������0����50.5�������������룡");
	                        document.getElementsByName("cost")[0].focus();
						    return false;
	                     }
	                  }	
					  if((document.getElementsByName("account.cardNo")[0].value).trim()!=""){
	     				     var v1="succuss";				   
	     		        	 var val3=(document.getElementsByName("account.cardNo")[0].value).trim();	    			       
	     			         jQuery.ajax({type:"post",url:"userCarAccount_getAccountByCardNo.do?account.cardNo=" +val3,async:false, success:function(data1,textStatus){			           
	          			        if(data1=="fail1"){v1="fail1";alert("�˿����ѱ������˺�����"); }			   
	     				     }
	     				     });
	     				    		 					 
	     				   if(v1=="fail1"){document.getElementsByName("account.cardNo")[0].focus();return false;}				 	     		          	
	                 }	
			    }	
		</script>
	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			 <!-- <form method="post" action="account_updateAccountOrSavaLog.do?cardNo1=${account.cardNo}" onsubmit="return check();">  
				    <form method="post" action="car_save.do" onsubmit="return check();">-->
			<form method="post" action=""> 
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0" >			
					<%--<tr>					 
					  <td colspan="4" class="pn-fcontent"><input type="text"  value="�������¿���Ϣ��" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>					   
					</tr>
					--%><tr>
					  <td  class="pn-flabel pn-flabel-h">�û��˻���</td>
					  <td class="pn-fcontent"><input type="text"  name="account.sys_id" value="${account.sys_id}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					  <td  class="pn-flabel pn-flabel-h">��&nbsp;&nbsp;��&nbsp;&nbsp;�ţ�</td>
					  <td class="pn-fcontent"><input type="text"  name="oldCardNo" value="${account.cardNo}" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					</tr>
					<tr>				 
					   <td  class="pn-flabel pn-flabel-h">��&nbsp;��&nbsp;�ͣ�</td>
					    <c:if test="${account.cardType==0}"><td  class="pn-fcontent"><input type="text" value="��ͨ��" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					    <c:if test="${account.cardType==5}"><td  class="pn-fcontent"><input type="text" value="�ɷѿ�" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					    <c:if test="${account.cardType!=5&&account.cardType!=0}"><td  class="pn-fcontent"><input type="text" value="" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td></c:if>
					   <td  class="pn-flabel pn-flabel-h">��&nbsp;&nbsp;��(Ԫ)��</td>
					   <td class="pn-fcontent"><input type="text" name="balance" value="<fmt:formatNumber value="${account.balance/100}" pattern="#.##" type="number"/>" readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					</tr>
					<c:if test="${param_card_type.pvalue==1}">
					<c:if test="${account.balance/100==0}">
					<tr>
					  <td class="pn-flabel pn-flabel-h">��&nbsp;��&nbsp;�ţ�</td>
					  <td class="pn-fcontent"><input type="text" name="account.cardNo"  />&nbsp;<font style="color:red">*</font></td>
					  <td class="pn-flabel pn-flabel-h">������(Ԫ)��</td>
					  <td class="pn-fcontent"><input type="text" name="cost" value="<fmt:formatNumber value="${account.cost/100}" pattern="#.##" type="number"/>"/></td>
					</tr>
					</c:if>
					</c:if>
					<c:if test="${param_card_type.pvalue!=1}">
					<tr>
					  <td class="pn-flabel pn-flabel-h">��&nbsp;��&nbsp;�ţ�</td>
					  <td class="pn-fcontent"><input type="text" name="account.cardNo"  />&nbsp;<font style="color:red">*</font></td>
					  <td class="pn-flabel pn-flabel-h">������(Ԫ)��</td>
					  <td class="pn-fcontent"><input type="text" name="cost" value="<fmt:formatNumber value="${account.cost/100}" pattern="#.##" type="number"/>"/></td>
					</tr>
					</c:if>
					
					<tr>
						<td colspan="4" class="pn-fbutton">
					 	  <c:if test="${param_card_type.pvalue==1}">
					 	  <c:if test="${account.balance/100!=0}">
						    <input  type="button" value=" �� �� " onclick="Run('${param_cardRechargeSystem_path.pvalue}');"/> &nbsp;
						  </c:if>
						  <c:if test="${account.balance/100==0}">
						    <input  type="button" value=" �� �� "  onclick="updateCardNo();"/> &nbsp;
						  </c:if>
						  </c:if>
						  <c:if test="${param_card_type.pvalue!=1}">
							<input  type="button" value=" �� �� "  onclick="updateCardNo();"/> &nbsp;
						  </c:if>
							<input type="button" value=" ��  �� " onclick="history.back();"/>
							<input type="hidden" name="param_accountCardNoLength.pvalue" value="${param_accountCardNoLength.pvalue}"/>
						</td>						    
					</tr>					
					 </table>
					 <c:if test="${param_card_type.pvalue==1}">
					 <c:if test="${account.balance/100!=0}">
					       	 ����޷���ҳ������ⲿ�������򣬿�������IE������������й�,�볢�����²��裬�����ܷ������⣺<br>һ.ȷ�ϻ��������Ѿ���װ�ڱ������Ҷ����������ӵ�������<br><br>��.�����ⲿ��ֵ����·��<br>ͨ���������¼С���������Ĺ���Ӧ�ú�<br>����߲˵�ѡ��"��������"-"������������"
	            			<br>�޸Ĳ���"CardRechargeSystem_path"��ֵΪ��������װ·�����ɣ�����"E:\�û�����ֵ\CardRechargeSystem.exe"<br><br>��.���������Ļ���<br>���������Ļ�����ܻ������������⡣�� Internet Explorer 6.0 ����߰汾���������ķ������£�<br>1. �� IE �����"����"��<br>2. ѡ��"Internet ѡ��"��<br>3. ���"����"��ǩ��δѡ�У������˱�ǩ��
	             			<br>4. ��"Internet ��ʱ�ļ�"�����·������"ɾ���ļ�"��<br>5. ���"ȷ��"�˳���<br><br>��.ȷ�� JavaScript��ActiveX �Լ�"��������Ϊ"������<br>�� IE ������������������ã�<br>1. ���"����" > "Internet ѡ��"��<br>2. ���"��ȫ"��ǩ��<br>3. ���"�Զ��弶��"��ť��<br>4. ȷ��"���� ActiveX �ؼ��Ͳ��"�Աߵ�"����"��ť�ѱ�ѡ�С�<br>5. ȷ��"�����ƺͽű���Ϊ"�Աߵ�"����"��ť�ѱ�ѡ�С�'
	             			<br>6. ȷ��"��ű�"�µ�"����"��ť�ѱ�ѡ�С�<br>7. ���"ȷ��"��Ȼ���ٴε��"ȷ��"������ġ�<br>��һ�ְ취�ǣ���Ӧ�÷������ַ���� Internet Explorer ��������վ���б����巽�����£�<br>1. ���"����" > "Internet ѡ��"��<br>2. ���"��ȫ"��ǩ��<br>3. ѡ��"�����ε�վ��"ͼ�꣬Ȼ����"վ��"��ť��<br>4. ȡ��ѡ��"�Ը������е�����վ��Ҫ���������֤ ( https:)"��'
	             			<br>5. ��"������վ��ӵ�������:"�ı����ڣ�����Ӧ�÷������ַ��Ȼ����"���"��<br>6. ���"ȷ��"��Ȼ���ٴε��"ȷ��"������ġ�<br>7. ������վ��İ�ȫ�����Ϊ"��"�����"ȷ��"������ġ�<br><br>��.Ϊ��֤����������Ч����Ҫ���������������					 
					</c:if>	
					</c:if>	
			</form>
		</div>
	</body>
</html>

