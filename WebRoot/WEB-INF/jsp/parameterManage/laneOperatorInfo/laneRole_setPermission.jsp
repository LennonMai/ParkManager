<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
	<head>
		<title>设置车道角色权限</title>
		<%@include file="../../include/common.jsp" %>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/admin.css"/>
		<link type="text/css" rel="stylesheet" href="${basePath}/css/theme.css"/>	
		<script type="text/javascript" src="${basePath}/js/CJL.0.1.min.js"></script>  
		<script type="text/javascript" src="${basePath}/js/MSGalert.js"></script>  
		<script type="text/javascript">	
		
		if("${message}"=="updateSuccess"){
			alert("更新角色权限成功！");
			}
		if("${message}"=="updateFail"){
			alert("更新角色权限失败！");
			}
		if("${message}"=="clearSuccess"){
			alert("清空角色权限成功！");
			}
		
		//获取角色已经设置的权限	
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
        //返回首页
		function back(){
			window.location.href = "laneRole_list.do";
			}

		//创建保存角色的数组
	    var modulePrivilege=new Array();
	    var checkCount=0,initcheckCount=0;
	    String.prototype.trim = function() 
        { 
             // 用正则表达式将前后空格，用空字符串替代。 
             return this.replace(/(^\s*)|(\s*$)/g, ""); 
        } 
	  //根据下标删除某个数组元素	
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
		//非全选项点击  
		function setPrivilege(obj){
			//点击处理
			if(obj.checked){
				//非可读项
				if(obj.value!=1){
					//得到5项check的对象
					var mp_1=document.getElementsByName(obj.id);
					//循环mp_1.length次，即5次
					for(var i=0;i<5;i++){
						//可读为最低权限，当点击非可读时应该给可读赋值
						if(mp_1[i].value==1&&mp_1[i].checked==false){
							mp_1[i].checked=true;
							modulePrivilege[checkCount]=mp_1[i].id.trim()+"_"+mp_1[i].value;
							checkCount++; 
							}
						}
					modulePrivilege[checkCount]=obj.id.trim()+"_"+obj.value;
					checkCount++;
					}
				//为可读项
				else{
					modulePrivilege[checkCount]=obj.id.trim()+"_"+obj.value;
					checkCount++;
					}
				}
			
			//取消点击处理
			else{
				
				//当第一次选择checkbox后，再取消，则出数组中去掉该值
				var del=obj.id.trim()+"_"+obj.value;
				for(var i=0;i<modulePrivilege.length;i++){
					  if(del==modulePrivilege[i]){
						  modulePrivilege.baoremove(i);
						  checkCount--;}
					}
				//当点击全选后，再点击取消其它非全选项，则需要取消全选项
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
		//行全选、反选，全选时只取15，其余不处理
		function setAllPrivilege(obj){
			if(obj.checked){
				var mp=document.getElementsByName(obj.id); 
				for(var i=0;i<mp.length;i++){
					if(mp[i].value!=15){
						mp[i].checked=true;
						var val=mp[i].id.trim()+"_"+mp[i].value;
						//数组中不存在相同值时插入数组
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
					//当第一次选择checkbox后，再取消，则出数组中去掉该值
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
		//全部模块的全选、反选处理
		function setAll(_obj){
			var inputs = document.getElementsByTagName("input");
			for(var i=0;i<inputs.length;i++){
			  var obj = inputs[i];
			  if(obj.type=='checkbox'){
				  //全选
				  if(_obj.checked){
					  obj.checked=true;
					  if(obj.value!="AllPrivilege"){
						  modulePrivilege[checkCount]=obj.id.trim()+"_"+obj.value;
						  checkCount++;
					 	}
					  }
				   //反选
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
		
		 //判断数组是否存在相同的项
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
		//1-6记录数
		var count=1;
        function insert(){
        	var text="角色权限值正在更新中，请稍候";
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
			
			//锁定键盘
			function lockup(e){ e.preventDefault(); }
			//高亮层不锁定
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
			$$("MSGtext").innerHTML ='<b>角色权限值正在更新中，请稍候</b>';
			ab.show();
			//定时更新导入提示内容
            setInterval("insert()",500);
            $$("idMSGClose").onclick = function(){if(confirm("\n确认要取消提示吗？取消后不影响权限更新，请耐心等待更新完毕！ ")){ ab.close();}}
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
				<div class="rpos">当前位置： ${currentPosition}</div>
				<div class="clear"></div>
			</div>
			<form id="dataform" method="post" action="laneRole_setModulePrivilege.do" onsubmit="return setModulePrivilege();">
				<table width="100%" class="pn-ftable" cellpadding="2" cellspacing="1" border="0">
					<tr>
						<td class="pn-flabel pn-flabel-h">角色编码：</td>
						<td colspan="4" class="pn-fcontent"><input type="hidden" name="laneRole.roleNo" value="${laneRole.roleNo}" size="24"/>${laneRole.roleNo}</td>
					  	</tr>
					<tr>
						<td class="pn-flabel pn-flabel-h">角色名称：</td>
						<td colspan="4" class="pn-fcontent"><input type="hidden" name="laneRole.roleName" value="${laneRole.roleName}" size="24"/>${laneRole.roleName}</td>
					</tr>
    				<tr>
	     			<input type="hidden" name="modulePrivilege" ></input>
	     			<td class="pn-flabel pn-flabel-h">设置权限：</td>
	     			<td colspan="4" class="pn-fcontent">
	     			<table style="background-color:#E2EBEF;" width="660px;" cellspacing="1" cellpadding="0" border="0">
					<tbody class="pn-ltbody">
						<tr>
							<td  onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" align="center" style="padding-left: 5px;width: 180px;" ><strong>模块名称</strong></td>
              				<td align="right" style="padding-left: 10px;padding-right: 10px;"><input type="checkbox" id="AllPrivilege" name="AllPrivilege" value="AllPrivilege" onclick="setAll(this)">&nbsp;全选 </input></td>
						</tr>
					</tbody>
					</table>
	     			<div style="overflow: scroll; width: 100%; height: 320px;" >
              		<c:forEach items="${list}" var="item">
	     			<table style="background-color:#E2EBEF;" width="660px;" cellspacing="1" cellpadding="0" border="0">
					<tbody class="pn-ltbody">
						<tr onmouseover="this.className='pn-lhover'" onmouseout="this.className=''">
							<td onmouseover="this.className='pn-lhover'" onmouseout="this.className=''" bgcolor="#BAC2DA" style="padding-left: 5px;width: 180px;" ><strong>${item.moduleName} </strong></td>
              	   			<td style="background-color:#FFFFFF;padding-left:5px;" align="center" ><input type="checkbox" id="${item.moduleNo}" name="${item.moduleNo}" value="1" onclick="setPrivilege(this);"/>&nbsp;只读</td><!--只读0001-->
              				<td style="background-color:#FFFFFF;padding-left:5px;" align="center" ><input type="checkbox" id="${item.moduleNo}" name="${item.moduleNo}" value="2" onclick="setPrivilege(this);"/>&nbsp;可写</td><!--可写0010-->
              				<td style="background-color:#FFFFFF;padding-left:5px;" align="center" ><input type="checkbox" id="${item.moduleNo}" name="${item.moduleNo}" value="4" onclick="setPrivilege(this);"/>&nbsp;修改</td><!--修改0100-->
              				<td style="background-color:#FFFFFF;padding-left:5px;" align="center" ><input type="checkbox" id="${item.moduleNo}" name="${item.moduleNo}" value="8" onclick="setPrivilege(this);"/>&nbsp;删除</td><!--删除1000-->
              				<td style="background-color:#FFFFFF;padding-left:5px;" align="center" ><input type="checkbox" id="${item.moduleNo}" name="${item.moduleNo}" value="15" onclick="setAllPrivilege(this);"/>&nbsp;全选</td><!--全选1111-->
						</tr>
					</tbody>
					</table>
					</c:forEach>
            		</div>
   					</td>
    				</tr>
					<tr>
						<td colspan="5" class="pn-fbutton">
							<input type="submit" value=" 保 存 "/>&nbsp;
						    <input type="reset" value=" 重 置 "/>&nbsp;
						    <input type="button" value=" 返 回 " onclick="return back()"/>
						</td>
						    
					</tr>
				</table>
			<dl id="idMSG" class="MSGalert" style="top:10%;left:5%;">
			<dt>提示&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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
	
	//初始化角色的权限
	var inputs =document.getElementsByTagName("input");
	
	for(var i=0;i < inputs.length;i++){
        var ele = inputs[i];
        //判断type是“checkbox”，并且获取checkbox的id 
        if(ele.type == "checkbox"){
            //如是所有全选的按钮时，不进入处理
            if(ele.id.trim()!="AllPrivilege"){
            	
            	var _id,_value;
            	//遍历后台传来的该角色权限
            	for(var j=0;j<initroleModule.length;j++){
                	//将值为如8_CARD000_3的字符串分割，获取id -CARD000和权限-3
       				_id=initroleModule[j].split("_")[1].trim();
       				_value=initroleModule[j].split("_")[2].trim();

       				if(ele.id.trim()==_id){
       				 	if(matchBinaryIndex(parseInt(_value),parseInt(ele.value.trim()))){
       				 		//alert(parseInt(_value),parseInt(ele.value.trim()));
 				    		ele.checked=true;
              				modulePrivilege[initcheckCount]=ele.id.trim()+"_"+ele.value;;
              				//初始化点击数
              				initcheckCount++;
         				}
                      	 
       				}
       				
       			}	
             }
        }
	}
	//初始化页面全选
	if(parseInt(initcheckCount)==390)get("AllPrivilege").checked=true;

	//将初始化点击数赋给点击记录数
	checkCount=initcheckCount;

	//将十进制转为二进制
	function toBinary(obj){
		var _binary;
		if(obj.toString(2).split("").length==1)_binary="000"+obj.toString(2);
		else if(obj.toString(2).split("").length==2)_binary="00"+obj.toString(2);
			 else if(obj.toString(2).split("").length==3)_binary="0"+obj.toString(2);
			      else _binary=obj.toString(2);	
		 return _binary;
		}
	//二进制位是否对应	
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