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
		<script type="text/javascript" src="${basePath}/datePicker/WdatePicker.js"></script>
		
		<script type="text/javascript">
			if("${result}"=="SUCCESS")
				alert("���ĳɹ�");
				if("${result}"=="FAIL")
				alert("�����Ϳ����д˿���");
				String.prototype.trim = function() { 
                		// ��������ʽ��ǰ��ո��ÿ��ַ�������� 
                        return this.replace(/(^\s*)|(\s*$)/g, ""); 
              	} 		      		
			function check(){				
				if(document.getElementsByName("fee")[0].value==""){
					alert("��ֵ����Ϊ�գ�����������.");
					document.getElementsByName("fee")[0].focus();
					return false;
				}				
				if(document.getElementsByName("fee")[0].value!=""){				
					var partten=/^(\d{1,10}\.\d{1,10}|\d{1,10})$/;
					if(partten.test(document.getElementsByName("fee")[0].value)){
						if(document.getElementsByName("fee")[0].value>90000){				     
					    	alert("��ֵ���ܴ���90000������������.");
					     	document.getElementsByName("fee")[0].focus();
						  	return false;
					    }
					    var partten1=/^[0]$/;
					    if(partten1.test(document.getElementsByName("fee")[0].value)){
					       alert("��ֵ���Ϊ��ʵ��������50.5��������������.");
					       document.getElementsByName("fee")[0].focus();
						   return false;
					    }              
					}
					else{
	                    alert("��ֵ���Ϊ��ʵ��������50.5��������������.");
	                    document.getElementsByName("fee")[0].focus();
						return false;
	                }
            	}			
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
		</script>
	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			 <form method="post" action="account_paymentEdit.do" onsubmit="return check();">  
				   <!--  <form method="post" action="car_save.do" onsubmit="return check();">-->
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">				
			
					<tr>
					  <td class="pn-flabel pn-flabel-h"> ��&nbsp;&nbsp;&nbsp;&nbsp;�ţ�</td>
					  <td class="pn-fcontent"><input type="text" name="account.sys_id" value="${account.sys_id}"  readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					  <td class="pn-flabel pn-flabel-h"> ��&nbsp;&nbsp;&nbsp;&nbsp;�ţ�</td>
					  <td class="pn-fcontent"><input type="text" name="account.cardNo" value="${account.cardNo}"  readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					    
					</tr>
					<tr>
					 
					 <td class="pn-flabel pn-flabel-h">�˺�״̬��</td>
					  <c:if test="${account.status==0}"><td class="pn-fcontent"><input type="text" name="account.status" value="��Ч"  readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					  </c:if>
					  <c:if test="${account.status==1}"><td class="pn-fcontent"><input type="text" name="account.status" value="��ʧ"  readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					  </c:if>
					  <c:if test="${account.status==2}"><td class="pn-fcontent"><input type="text" name="account.status" value="Ԥ����"  readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					  </c:if>
					  <c:if test="${account.status==3}"><td class="pn-fcontent"><input type="text" name="account.status" value="����"  readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					  </c:if>
					  <c:if test="${account.status==4}"><td class="pn-fcontent"><input type="text" name="account.status" value="����"  readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					  </c:if>
					  <c:if test="${account.status==5}"><td class="pn-fcontent"><input type="text" name="account.status" value="������"  readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					  </c:if>
					  <c:if test="${account.status==6}"><td class="pn-fcontent"><input type="text" name="account.status" value="������"  readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					  </c:if>
					  <c:if test="${account.status==7}"><td class="pn-fcontent"><input type="text" name="account.status" value="������"  readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					  </c:if>
					 <td class="pn-flabel pn-flabel-h">�������ͣ�</td>
					 <td class="pn-fcontent"> <input type="text" name="accountTrade.tradeType" value="��ֵ"  readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					</tr>
					<c:if test="${param_card_type.pvalue!=1}">
					<tr>					
					<td class="pn-flabel pn-flabel-h"> ��Ԫ����</td>
					<td class="pn-fcontent"><input type="text" name="account.balance" value="<fmt:formatNumber value="${account.balance/100}" pattern="#.##" type="number"/>"  readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>
					<td class="pn-flabel pn-flabel-h">��ֵ��Ԫ����</td>
					<td  class="pn-fcontent"><input type="text" name="fee" />&nbsp;<font style="color:red">*</font></td>								
					</tr>
					</c:if>
					<c:if test="${param_card_type.pvalue==1}">
					<tr>					
					<td class="pn-flabel pn-flabel-h"> ��Ԫ����</td>
					<td colspan="3" class="pn-fcontent"><input type="text" name="account.balance" value="<fmt:formatNumber value="${account.balance/100}" pattern="#.##" type="number"/>"  readonly="true" style="BORDER-BOTTOM: 0px; BORDER-LEFT: 0px; BACKGROUND: none transparent scroll repeat 0% 0%; BORDER-TOP: 0px; BORDER-RIGHT: 0px"/></td>								
					</tr>
					</c:if>
					
					<tr>
						    <c:if test="${param_card_type.pvalue!=1}"> <td colspan="4" class="pn-fbutton"><input type="submit" value=" �� ֵ "/> &nbsp;<input type="button" value=" �� �� " onclick="history.back();"/></td></c:if>
							<c:if test="${param_card_type.pvalue==1}"><td  colspan="4" class="pn-fbutton"><input type="button"   value=" �� ֵ " onclick="Run('${param_cardRechargeSystem_path.pvalue}');"/>&nbsp;<input type="button" value=" �� �� " onclick="history.back();"/></td></c:if>						   																								    
					</tr>
					
					 </table>
				 <c:if test="${param_card_type.pvalue==1}">
					 ����޷���ҳ������ⲿ��ֵ���򣬿�������IE������������й�,�볢�����²��裬�����ܷ������⣺<br>һ.ȷ�ϳ�ֵ�����Ѿ���װ�ڱ������Ҷ����������ӵ�������<br><br>��.�����ⲿ��ֵ����·��<br>ͨ���������¼С���������Ĺ���Ӧ�ú�<br>����߲˵�ѡ��"��������"-"������������"
	              <br>�޸Ĳ���"CardRechargeSystem_path"��ֵΪ��������װ·�����ɣ�����"E:\�û�����ֵ\CardRechargeSystem.exe"<br><br>��.���������Ļ���<br>���������Ļ�����ܻ������������⡣�� Internet Explorer 6.0 ����߰汾���������ķ������£�<br>1. �� IE �����"����"��<br>2. ѡ��"Internet ѡ��"��<br>3. ���"����"��ǩ��δѡ�У������˱�ǩ��
	             <br>4. ��"Internet ��ʱ�ļ�"�����·������"ɾ���ļ�"��<br>5. ���"ȷ��"�˳���<br><br>��.ȷ�� JavaScript��ActiveX �Լ�"��������Ϊ"������<br>�� IE ������������������ã�<br>1. ���"����" > "Internet ѡ��"��<br>2. ���"��ȫ"��ǩ��<br>3. ���"�Զ��弶��"��ť��<br>4. ȷ��"���� ActiveX �ؼ��Ͳ��"�Աߵ�"����"��ť�ѱ�ѡ�С�<br>5. ȷ��"�����ƺͽű���Ϊ"�Աߵ�"����"��ť�ѱ�ѡ�С�'
	             <br>6. ȷ��"��ű�"�µ�"����"��ť�ѱ�ѡ�С�<br>7. ���"ȷ��"��Ȼ���ٴε��"ȷ��"������ġ�<br>��һ�ְ취�ǣ���Ӧ�÷������ַ���� Internet Explorer ��������վ���б����巽�����£�<br>1. ���"����" > "Internet ѡ��"��<br>2. ���"��ȫ"��ǩ��<br>3. ѡ��"�����ε�վ��"ͼ�꣬Ȼ����"վ��"��ť��<br>4. ȡ��ѡ��"�Ը������е�����վ��Ҫ���������֤ ( https:)"��'
	             <br>5. ��"������վ��ӵ�������:"�ı����ڣ�����Ӧ�÷������ַ��Ȼ����"���"��<br>6. ���"ȷ��"��Ȼ���ٴε��"ȷ��"������ġ�<br>7. ������վ��İ�ȫ�����Ϊ"��"�����"ȷ��"������ġ�<br><br>��.Ϊ��֤����������Ч����Ҫ���������������					 
				</c:if>	
			</form>
		</div>
	</body>
</html>
