<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
	<head>
		<title>���ó�����ɫȨ��</title>
		<%@include file="../../include/common.jsp" %>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>	
		<script type="text/javascript" src="${basePath}/js/CJL.0.1.min.js"></script>  
		<script type="text/javascript" src="${basePath}/js/MSGalert.js"></script>  
		<script type="text/javascript">	
		
		if("${message}"=="updateSuccess"){
			alert("���½�ɫȨ�޳ɹ���");
			}
		if("${message}"=="updateFail"){
			alert("���½�ɫȨ��ʧ�ܣ�");
			}
		if("${message}"=="clearSuccess"){
			alert("��ս�ɫȨ�޳ɹ���");
			}
		
		//��ȡ��ɫ�Ѿ����õ�Ȩ��	
		var initroleModule=new Array();
		var init=new Array();
		var _initroleModule="${rmPrivilege}";
		init=_initroleModule.split(",");
		for(var i=0;i<init.length;i++){
			if(init[i]!=""){
				initroleModule[i]=init[i];
				}
			}
		//alert(initroleModule);
        //������ҳ
		function back(){
			window.location.href = "laneRole_list.do";
			}

		//���������ɫ������
	    var modulePrivilege=new Array();
	    var checkCount=0,initcheckCount=0;
	    String.prototype.trim = function() 
        { 
             // ��������ʽ��ǰ��ո��ÿ��ַ�������� 
             return this.replace(/(^\s*)|(\s*$)/g, ""); 
        } 
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
		//��ȫѡ����  
		function setPrivilege(obj){
			//�������
			if(obj.checked){
				//�ǿɶ���
				if(obj.value!=1){
					//�õ�5��check�Ķ���
					var mp_1=document.getElementsByName(obj.id);
					//ѭ��mp_1.length�Σ���5��
					for(var i=0;i<5;i++){
						//�ɶ�Ϊ���Ȩ�ޣ�������ǿɶ�ʱӦ�ø��ɶ���ֵ
						if(mp_1[i].value==1&&mp_1[i].checked==false){
							mp_1[i].checked=true;
							modulePrivilege[checkCount]=mp_1[i].id.trim()+"_"+mp_1[i].value;
							checkCount++; 
							}
						}
					modulePrivilege[checkCount]=obj.id.trim()+"_"+obj.value;
					checkCount++;
					}
				//Ϊ�ɶ���
				else{
					modulePrivilege[checkCount]=obj.id.trim()+"_"+obj.value;
					checkCount++;
					}
				}
			
			//ȡ���������
			else{
				
				//����һ��ѡ��checkbox����ȡ�������������ȥ����ֵ
				var del=obj.id.trim()+"_"+obj.value;
				for(var i=0;i<modulePrivilege.length;i++){
					  if(del==modulePrivilege[i]){
						  modulePrivilege.baoremove(i);
						  checkCount--;}
					}
				//�����ȫѡ���ٵ��ȡ��������ȫѡ�����Ҫȡ��ȫѡ��
				var mp=document.getElementsByName(obj.id);
				var del_allmp=null;
				for(var n=0;n<mp.length;n++){
					if(mp[n].value==15&&mp[n].checked==true){
						mp[n].checked=false;
						del_allmp=mp[n].id.trim()+"_"+mp[n].value;
						for(var i=0;i<modulePrivilege.length;i++){
							if(del_allmp!=null){ 
								  if(del_allmp==modulePrivilege[i]){
									  modulePrivilege.baoremove(i);
									  checkCount--;}
								  }
							}
						}
					}

				}
			}
		//��ȫѡ����ѡ��ȫѡʱֻȡ15�����಻����
		function setAllPrivilege(obj){
			if(obj.checked){
				var mp=document.getElementsByName(obj.id); 
				for(var i=0;i<mp.length;i++){
					if(mp[i].value!=15){
						mp[i].checked=true;
						var val=mp[i].id.trim()+"_"+mp[i].value;
						//�����в�������ֵͬʱ��������
						//alert(isSame(modulePrivilege,val));
						if(!isSame(modulePrivilege,val)){
							modulePrivilege[checkCount]=val;
							checkCount++;
							}	
						}	 
					}
				modulePrivilege[checkCount]=obj.id.trim()+"_"+obj.value;
				checkCount++;
				}else{
					//����һ��ѡ��checkbox����ȡ�������������ȥ����ֵ
					var mp=document.getElementsByName(obj.id);
					for(var i=0;i<mp.length;i++){
						mp[i].checked=false;
						var del=mp[i].id.trim()+"_"+mp[i].value;
						//alert(del);
						for(var j=0;j<modulePrivilege.length;j++){
							  if(del==modulePrivilege[j]){
								  modulePrivilege.baoremove(j);
								  checkCount--;}
							}
						}
					}
			}
		//ȫ��ģ���ȫѡ����ѡ����
		function setAll(_obj){
			var inputs = document.getElementsByTagName("input");
			for(var i=0;i<inputs.length;i++){
			  var obj = inputs[i];
			  if(obj.type=='checkbox'){
				  //ȫѡ
				  if(_obj.checked){
					  obj.checked=true;
					  if(obj.value!="AllPrivilege"){
						  modulePrivilege[checkCount]=obj.id.trim()+"_"+obj.value;
						  checkCount++;
					 	}
					  }
				   //��ѡ
				   else{
					  modulePrivilege.length=0;
					  modulePrivilege=[];
					  modulePrivilege.splice(0)
					  checkCount=0;
					  obj.checked=false;
					  }
			  }
			}

			}
		
		 //�ж������Ƿ������ͬ����
		  function isSame(obj,value){
			for(var i=0;i<obj.length;i++){
              if(obj[i]==value)return true;
				}
			 return false;
			  } 
		function setModulePrivilege(){
			showMSGalert(); 
			//alert(modulePrivilege);
			get("modulePrivilege").value=modulePrivilege;
			//return  false;
			}
		//1-6��¼��
		var count=1;
        function insert(){
        	var text="��ɫȨ��ֵ���ڸ����У����Ժ�";
        	if(count<=6&&count>0){
        		if(count==1)text=text+".";
        		if(count==2)text=text+"..";
        		if(count==3)text=text+"...";
        		if(count==4)text=text+"....";
        		if(count==5)text=text+".....";
        		if(count==6)text=text+"......";
        		count++;
            	}else {
            		count=1;
                }
            $$("MSGtext").innerHTML ='<b>'+text+'</b>';
            } 
		function showMSGalert(){
			var ab = new MSGalert("idMSG");
			var lock = true;
			
			//��������
			function lockup(e){ e.preventDefault(); }
			//�����㲻����
			function lockout(e){ e.stopPropagation(); }

			ab.onShow = function(){
				if (lock) {
					$$E.addEvent( document, "keydown", lockup );
					$$E.addEvent( this.box, "keydown", lockout );
					OverLay.show();
				}
			}
			ab.onClose = function(){
				$$E.removeEvent( document, "keydown", lockup );
				$$E.removeEvent( this.box, "keydown", lockout );
				OverLay.close();
			}
			ab.center = true;
			$$("MSGtext").innerHTML ='<b>��ɫȨ��ֵ���ڸ����У����Ժ�</b>';
			ab.show();
			//��ʱ���µ�����ʾ����
            setInterval("insert()",500);
            $$("idMSGClose").onclick = function(){if(confirm("\nȷ��Ҫȡ����ʾ��ȡ����Ӱ��Ȩ�޸��£������ĵȴ�������ϣ� ")){ ab.close();}}
			//$$("importExcle").onclick = function(){}
			}		
		</script>
<style>
.MSGalert {
	width: 360px;
	background: #FFFFFF;
	border:1px solid #9DBCEA;
	line-height: 30px;
	display: none;
	margin: 0;
}

.MSGalert dt {
	/**PADDING-RIGHT: 2px;  PADDING-LEFT: 2px; FONT-SIZE: 12px; FILTER: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr=#FFFFFF, EndColorStr=#9DBCEA);  CURSOR: hand; PADDING-TOP: 2px; */
	PADDING-LEFT: 5px;
	PADDING-TOP: 2px;
	padding-bottom: 5px; 
	FONT-SIZE: 12px; 
	font-weight:bold; 
	background-image:url(image/MSGalert.png);
	height: 24px;
}

.MSGalert dd {
	padding: 20px;
	margin: 0;
}

.btn {
	PADDING-RIGHT: 2px;  PADDING-LEFT: 2px; FONT-SIZE: 12px; FILTER: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr=#FFFFFF, EndColorStr=#9DBCEA);   PADDING-TOP: 2px;
}
</style>		
	</head>
	<body>
		<div class="body-box">
			<div class="rhead">
				<div class="rpos">��ǰλ�ã� ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form id="dataform" method="post" action="laneRole_setModulePrivilege.do" onsubmit="return setModulePrivilege();">
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
					<tr>
						<td class="pn-flabel pn-flabel-h">��ɫ���룺</td>
						<td colspan="4" class="pn-fcontent"><input type="hidden" name="laneRole.roleNo" value="${laneRole.roleNo}" size="24"/>${laneRole.roleNo}</td>
					  	</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">��ɫ���ƣ�</td>
						<td colspan="4" class="pn-fcontent"><input type="hidden" name="laneRole.roleName" value="${laneRole.roleName}" size="24"/>${laneRole.roleName}</td>
					</tr>
    				<tr>
	     			<input type="hidden" name="modulePrivilege" ></input>
	     			<td class="pn-flabel pn-flabel-h">����Ȩ�ޣ�</td>
	     			<td colspan="4" class="pn-fcontent">
	     			<table style="background-color:#E2EBEF;" width="660px;" cellspacing="1" cellpadding="0" border="0">
					<tbody class="pn-ltbody">
						<tr>
							<td  onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center" style="padding-left: 5px;width: 180px;" ><strong>ģ������</strong></td>
              				<td align="right" style="padding-left: 10px;padding-right: 10px;"><input type="checkbox" id="AllPrivilege" name="AllPrivilege" value="AllPrivilege" onclick="setAll(this)">&nbsp;ȫѡ </input></td>
						</tr>
					</tbody>
					</table>
	     			<div style="overflow: scroll; width: 100%; height: 320px;" >
              		<c:forEach items="${list}" var="item">
	     			<table style="background-color:#E2EBEF;" width="660px;" cellspacing="1" cellpadding="0" border="0">
					<tbody class="pn-ltbody">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''">
							<td onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" bgcolor="#BAC2DA" style="padding-left: 5px;width: 180px;" ><strong>${item.moduleName} </strong></td>
              	   			<td style="background-color:#FFFFFF;padding-left:5px;" align="center" ><input type="checkbox" id="${item.moduleNo}" name="${item.moduleNo}" value="1" onclick="setPrivilege(this);"/>&nbsp;ֻ��</td><!--ֻ��0001-->
              				<td style="background-color:#FFFFFF;padding-left:5px;" align="center" ><input type="checkbox" id="${item.moduleNo}" name="${item.moduleNo}" value="2" onclick="setPrivilege(this);"/>&nbsp;��д</td><!--��д0010-->
              				<td style="background-color:#FFFFFF;padding-left:5px;" align="center" ><input type="checkbox" id="${item.moduleNo}" name="${item.moduleNo}" value="4" onclick="setPrivilege(this);"/>&nbsp;�޸�</td><!--�޸�0100-->
              				<td style="background-color:#FFFFFF;padding-left:5px;" align="center" ><input type="checkbox" id="${item.moduleNo}" name="${item.moduleNo}" value="8" onclick="setPrivilege(this);"/>&nbsp;ɾ��</td><!--ɾ��1000-->
              				<td style="background-color:#FFFFFF;padding-left:5px;" align="center" ><input type="checkbox" id="${item.moduleNo}" name="${item.moduleNo}" value="15" onclick="setAllPrivilege(this);"/>&nbsp;ȫѡ</td><!--ȫѡ1111-->
						</tr>
					</tbody>
					</table>
					</c:forEach>
            		</div>
   					</td>
    				</tr>
					<tr>
						<td colspan="5" class="pn-fbutton">
							<input type="submit" value=" �� �� "/>&nbsp;
						    <input type="reset" value=" �� �� "/>&nbsp;
						    <input type="button" value=" �� �� " onclick="return back()"/>
						</td>
						    
					</tr>
				</table>
			<dl id="idMSG" class="MSGalert" style="top:10%;left:5%;">
			<dt>��ʾ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<img id="idMSGClose" src="image/MSGalert_C1.png" onmouseout="this.src='image/MSGalert_C1.png'" onmousemove="this.src='image/MSGalert_C2.png'" />
			</dt>
			<dd id="MSGtext">
			</dd>
		</dl> 	
			</form>
		</div>
<script language="javascript">
	
	//��ʼ����ɫ��Ȩ��
	var inputs =document.getElementsByTagName("input");
	
	for(var i=0;i < inputs.length;i++){
        var ele = inputs[i];
        //�ж�type�ǡ�checkbox�������һ�ȡcheckbox��id 
        if(ele.type == "checkbox"){
            //��������ȫѡ�İ�ťʱ�������봦��
            if(ele.id.trim()!="AllPrivilege"){
            	
            	var _id,_value;
            	//������̨�����ĸý�ɫȨ��
            	for(var j=0;j<initroleModule.length;j++){
                	//��ֵΪ��8_CARD000_3���ַ����ָ��ȡid -CARD000��Ȩ��-3
       				_id=initroleModule[j].split("_")[1].trim();
       				_value=initroleModule[j].split("_")[2].trim();

       				if(ele.id.trim()==_id){
       				 	if(matchBinaryIndex(parseInt(_value),parseInt(ele.value.trim()))){
       				 		//alert(parseInt(_value),parseInt(ele.value.trim()));
 				    		ele.checked=true;
              				modulePrivilege[initcheckCount]=ele.id.trim()+"_"+ele.value;;
              				//��ʼ�������
              				initcheckCount++;
         				}
                      	 
       				}
       				
       			}	
             }
        }
	}
	//��ʼ��ҳ��ȫѡ
	if(parseInt(initcheckCount)==390)get("AllPrivilege").checked=true;

	//����ʼ����������������¼��
	checkCount=initcheckCount;

	//��ʮ����תΪ������
	function toBinary(obj){
		var _binary;
		if(obj.toString(2).split("").length==1)_binary="000"+obj.toString(2);
		else if(obj.toString(2).split("").length==2)_binary="00"+obj.toString(2);
			 else if(obj.toString(2).split("").length==3)_binary="0"+obj.toString(2);
			      else _binary=obj.toString(2);	
		 return _binary;
		}
	//������λ�Ƿ��Ӧ	
	function matchBinaryIndex(obj,value){
		if(toBinary(obj)==1111)return true;
		else if(toBinary(obj)==toBinary(value)){
			return true;
		}
		else if(toBinary(value)!=1111){
			var inBvalue=new Array();
			inBvalue=toBinary(obj).split("");
			var thisBvalue=new Array();
			thisBvalue=toBinary(value).split("");
			for(var i=0;i<4;i++){
				if(inBvalue[i]==1&&inBvalue[i]==thisBvalue[i]){
					return true;
					}
			}
		}
		return false;
	}
	
</script>	
	</body>
</html>