<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
	<head>
		<title></title>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>
		<script type="text/javascript" src="${basePath}/js/util.js"></script>
		<script type="text/javascript" src="${basePath}/js/jquery.js"></script>
		<script type="text/javascript" src="${basePath}/js/jquery.form.js"></script>
		<script type="text/javascript">
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
				if(document.getElementsByName('identifyResult.vehPlate')[0].value==""){
					$("#tishi").empty();
					$("#tishi").append("���ƺŲ���Ϊ��");
					document.getElementsByName('identifyResult.vehPlate')[0].focus();
					return false;
				}else{
					$("#tishi").empty();
				}
				if(Len(document.getElementsByName('identifyResult.vehPlate')[0].value)>10){	
					$("#tishi").empty();
					$("#tishi").append("���Ƴ��Ȳ��ܴ���10λ");
					document.getElementsByName('identifyResult.vehPlate')[0].focus();
					return false;
				}else{
					$("#tishi").empty();
				}
				return true;
			}
			function back(id,count){
				window.location.href = "lostCard_queryIndentify.do?pager.currentPage="+id+"&pager.pageSize="+count;
			}
		</script>
	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<form class="ropt" method="post">
					<input type="button" value=" �� �� " onclick="history.back();"/>
					<!-- <input type="button" value=" �� �� " onclick="back(${pager.currentPage },${pager.pageSize });"/> -->
				</form>
				<div class="clear"></div>
			</div>
			<form name="tableForm" action="lostCard_updateIdentify.do" method="post" onsubmit="return updateVehPlate();">
			<table width="550" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
				<tr>
					<td width="30%" class="pn-flabel pn-flabel-h">�� ˮ �ţ�</td>
					<td width="60%" class="pn-fcontent">
						<input type="text" name="identifyResult.listNo" value="${identifyResult.listNo}" readonly="readonly"/>
					</td>
				</tr>
				<tr>
					<td width="30%" class="pn-flabel pn-flabel-h">�� �� �ţ�</td>
					<td width="60%" class="pn-fcontent">
						<input type="text" name="identifyResult.vehPlate" value="${identifyResult.vehPlate }" maxlength="10"/> &nbsp; <font color="red">*</font>
						<font color="red"><label id ="tishi"></label></font>
						
						<input type="hidden" name="sign" value="${sign }" />
						<input type="hidden" name="pager.currentPage" value="${pager.currentPage }" />
						<input type="hidden" name="pager.pageSize" value="${pager.pageSize }" />
					</td>
				</tr>
				<tr>
					<td class="pn-fcontent" colspan="2">
						&nbsp;&nbsp;<b>ץ��ͼƬ��</b><br/><br/>
						<img src="lostCard_readImg.do?imagSrc=${imagSrc }" alt="��ͼƬ"/>
					</td>
				</tr>
				<tr>
					<td class="pn-fcontent" colspan="2" align="center">
						<input type="submit" value="�� ��" />
					</td>
				</tr>
			</table>
			
			</form>
		</div>
	</body>
</html>