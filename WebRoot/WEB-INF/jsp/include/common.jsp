<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	<link href="css/style.css" rel="stylesheet" media="screen" />
	<link type="text/css" rel="stylesheet" media="screen" href="css/validate-css/showmgs.css"/>		
    <script type="text/javascript" src="js/util.js"></script>
    <script type="text/javascript" src="js/validate/jquery.js" charset="UTF-8"></script> 
	<script type="text/javascript" src="js/validate/jquery.validate.js" charset="UTF-8"></script> 
	<script type="text/javascript" src="js/validate/messages_cn.js" charset="UTF-8"></script> 	
		<script type="text/javascript">	
		String.prototype.trim = function() 
        { 
             // 用正则表达式将前后空格，用空字符串替代。 
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
        //判断是否为数字和是否含有空格
        function numAndKong(value){
        	var reg=/^\s+|\s+/g;   
  			if(reg.test(value)){
   				return false; 
  			}
  			if(isNaN(value)){
  				return false;
  			} 
  			return true;
        }

        //判断IP地址格式是否正确
         function isIP(str){   
  			var ip= /^([1-9]|[1-9]\d|1\d{2}|2[0-1]\d|22[0-3])(\.(\d|[1-9]\d|1\d{2}|2[0-4]\d|25[0-5])){3}$/;
  			if(Len(str)<=15&&ip.test(str.trim())) return true;
  			else return false;   
 		 }
		//判断参数名是否合法，标识符规范以 字母 或 _ 开头
		function isValidIdentifier(str){   
		    try{   
		        eval("var "+str+"=0;");
		        if(str.charCodeAt(0)==36)
			        return false;
		        else  return true;      	       
		    }catch(e){   
		        return false;   
		    }   
		} 
		//判断是否是整数 
		function isInt(str){
			if(str.search("^-?\\d+$")==0)return true;
			else return false;
			}	
		/**
		 * 这里的dataform是form的id
		 */		 
		$(document).ready(function() {
					$("#dataform").validate({			
						success: function(label) {					
							label.html("&nbsp;").addClass("checked");
						}
					});	
				jQuery.validator.addMethod("positiveInteger", function(value, element) {					     
						    var decimal = /^[1-9]\d*$/;
						    return this.optional(element) || (decimal.test(value));
					       }, $.validator.format("请输入正整数."));	

				 jQuery.validator.addMethod("numberDeleteNull", function(value, element) {					     
						    var decimal = /^\d*$/;
						    return this.optional(element) || (decimal.test(value.trim()));
					       }, $.validator.format("请输入数字."));
				 jQuery.validator.addMethod("digitForOne", function(value, element) {
				     //var decimal = /^[\u0391-\uFFE5]{1}[A-Za-z]{1}[A-Za-z0-9]{5}$/;
					    var decimal = /^\d{1}$/;
					    return this.optional(element) || (decimal.test(value.trim()));
				       }, $.validator.format("卡号为1位数字."));		
				 jQuery.validator.addMethod("digitForTwo", function(value, element) {
				     //var decimal = /^[\u0391-\uFFE5]{1}[A-Za-z]{1}[A-Za-z0-9]{5}$/;
					    var decimal = /^\d{2}$/;
					    return this.optional(element) || (decimal.test(value.trim()));
				       }, $.validator.format("卡号为2位数字."));			
				 jQuery.validator.addMethod("digitForThree", function(value, element) {
				     //var decimal = /^[\u0391-\uFFE5]{1}[A-Za-z]{1}[A-Za-z0-9]{5}$/;
					    var decimal = /^\d{3}$/;
					    return this.optional(element) || (decimal.test(value.trim()));
				       }, $.validator.format("卡号为3位数字."));		
				 jQuery.validator.addMethod("digitForFour", function(value, element) {
				     //var decimal = /^[\u0391-\uFFE5]{1}[A-Za-z]{1}[A-Za-z0-9]{5}$/;
					    var decimal = /^\d{4}$/;
					    return this.optional(element) || (decimal.test(value.trim()));
				       }, $.validator.format("卡号为4位数字."));		
				 jQuery.validator.addMethod("digitForFive", function(value, element) {
				     //var decimal = /^[\u0391-\uFFE5]{1}[A-Za-z]{1}[A-Za-z0-9]{5}$/;
					    var decimal = /^\d{5}$/;
					    return this.optional(element) || (decimal.test(value.trim()));
				       }, $.validator.format("卡号为5位数字."));		
				 jQuery.validator.addMethod("digitForSix", function(value, element) {
				     //var decimal = /^[\u0391-\uFFE5]{1}[A-Za-z]{1}[A-Za-z0-9]{5}$/;
					    var decimal = /^\d{6}$/;
					    return this.optional(element) || (decimal.test(value.trim()));
				       }, $.validator.format("卡号为6位数字."));													
				 jQuery.validator.addMethod("digitForSeven", function(value, element) {
				     //var decimal = /^[\u0391-\uFFE5]{1}[A-Za-z]{1}[A-Za-z0-9]{5}$/;
					    var decimal = /^\d{7}$/;
					    return this.optional(element) || (decimal.test(value.trim()));
				       }, $.validator.format("卡号为7位数字."));
				 jQuery.validator.addMethod("digitForEight", function(value, element) {
				     //var decimal = /^[\u0391-\uFFE5]{1}[A-Za-z]{1}[A-Za-z0-9]{5}$/;
					    var decimal = /^\d{8}$/;
					    return this.optional(element) || (decimal.test(value.trim()));
				       }, $.validator.format("卡号为8位数字."));
		          jQuery.validator.addMethod("digitForNine", function(value, element) {
			     //var decimal = /^[\u0391-\uFFE5]{1}[A-Za-z]{1}[A-Za-z0-9]{5}$/;
				    var decimal = /^\d{9}$/;
				    return this.optional(element) || (decimal.test(value.trim()));
			       }, $.validator.format("卡号为9位数字."));
			       
	            jQuery.validator.addMethod("cardNomaxlengthTem", function(value, element) {
				      return this.optional(element) || ((Len(value.trim()) <= 10));
			         }, $.validator.format("卡号长度不能大于10位"));
	            
	            jQuery.validator.addMethod("cardNomaxlength20", function(value, element) {
				      return this.optional(element) || ((Len(value.trim()) <= 20));
			         }, $.validator.format("卡号长度不能大于20位"));   
	            
                jQuery.validator.addMethod("maxlengthNine", function(value, element) {
			      return this.optional(element) || ((Len(value.trim()) <= 9));
		         }, $.validator.format("长度不能大于9"));
		         
		        jQuery.validator.addMethod("maxlengthTen", function(value, element) {
			      return this.optional(element) || ((Len(value.trim()) <= 10));
		         }, $.validator.format("长度不能大于10（汉字算两个)"));

		        jQuery.validator.addMethod("maxlengthSixteen", function(value, element) {
				      return this.optional(element) || ((Len(value.trim()) <= 16));
			         }, $.validator.format("长度不能大于16（汉字算两个)"));
		         
		         jQuery.validator.addMethod("maxlengthTwenty", function(value, element) {
			      return this.optional(element) || ((Len(value.trim()) <= 20));
		         }, $.validator.format("长度不能大于20（汉字算两个)"));
		         
		         jQuery.validator.addMethod("maxlengthThirtyTwo", function(value, element) {
				      return this.optional(element) || ((Len(value.trim()) <= 32));
			         }, $.validator.format("长度不能大于32（汉字算两个)"));
		         
		         jQuery.validator.addMethod("maxlengthForty", function(value, element) {
			      return this.optional(element) || ((Len(value.trim()) <= 40));
		         }, $.validator.format("长度不能大于40（汉字算两个)"));

		         jQuery.validator.addMethod("maxlengthFifty", function(value, element) {
				      return this.optional(element) || ((Len(value.trim()) <= 50));
			         }, $.validator.format("长度不能大于50（汉字算两个)"));
			         
			     jQuery.validator.addMethod("maxlength255", function(value, element) {
					      return this.optional(element) || ((Len(value.trim()) <= 255));
				     }, $.validator.format("长度不能大于255（汉字算两个)"));
			         
		         jQuery.validator.addMethod("jpg", function(value, element) {
		                var temp=new Array();
			    	    var temp=value.split(".");
			      return this.optional(element) || (temp[1]=="jpg");
		         }, $.validator.format("请输入.jpg格式图片"));

		         jQuery.validator.addMethod("max100", function(value, element) {
				      return this.optional(element) || (value <= 100);
			         }, $.validator.format("不能大于100"));
		         jQuery.validator.addMethod("min-100", function(value, element) {
				      return this.optional(element) || (value >= -100);
			         }, $.validator.format("不能小于-100"));
		         
		         jQuery.validator.addMethod("max2147483647", function(value, element) {
				      return this.optional(element) || (value <= 2147483647);
			         }, $.validator.format("不能大于2147483647"));		
			         
			     /**
			     *参数管理 验证 startisInt
			     */ 
			     jQuery.validator.addMethod("isInt", function(value, element) {
				      return this.optional(element) || ((isInt(value.trim())));
			         }, $.validator.format("请输入整数"));
			     jQuery.validator.addMethod("maxlength1", function(value, element) {
				      return this.optional(element) || ((Len(value.trim())<=1&&isInt(value.trim())));
			         }, $.validator.format("请输入整数,长度不能超过1个字符"));
			     jQuery.validator.addMethod("maxlength6", function(value, element) {
				      return this.optional(element) || ((Len(value.trim()) <= 6));
			         }, $.validator.format("长度不能超过6个字符（中文占2个字符）"));
			     jQuery.validator.addMethod("maxlength8", function(value, element) {
				      return this.optional(element) || ((Len(value.trim()) <= 8));
			         }, $.validator.format("长度不能超过8个字符（中文占2个字符）"));
			     jQuery.validator.addMethod("maxlength10", function(value, element) {
				      return this.optional(element) || ((Len(value.trim()) <= 10));
			         }, $.validator.format("长度不能超过10个字符（中文占2个字符）"));
			     jQuery.validator.addMethod("maxlength15", function(value, element) {
				      return this.optional(element) || ((Len(value.trim()) <= 15));
			         }, $.validator.format("长度不能超过15个字符（中文占2个字符）"));
			     jQuery.validator.addMethod("maxlength16", function(value, element) {
				      return this.optional(element) || ((Len(value.trim()) <= 16));
			         }, $.validator.format("长度不能超过16个字符（中文占2个字符）"));
			     jQuery.validator.addMethod("maxlength20", function(value, element) {
				      return this.optional(element) || ((Len(value.trim()) <= 20));
			         }, $.validator.format("长度不能超过20个字符（中文占2个字符）"));

			     jQuery.validator.addMethod("maxlength24", function(value, element) {
				      return this.optional(element) || ((Len(value.trim()) <= 24));
			         }, $.validator.format("长度不能超过24个字符（中文占2个字符）"));
		         
			     jQuery.validator.addMethod("maxlength30", function(value, element) {
				      return this.optional(element) || ((Len(value.trim()) <= 30));
			         }, $.validator.format("长度不能超过30个字符（中文占2个字符）"));
			    
			     jQuery.validator.addMethod("maxlength32", function(value, element) {
				      return this.optional(element) || ((Len(value.trim()) <= 32));
			         }, $.validator.format("长度不能超过32个字符（中文占2个字符）"));
			     jQuery.validator.addMethod("maxlength40", function(value, element) {
				      return this.optional(element) || ((Len(value.trim()) <= 50));
			         }, $.validator.format("长度不能超过40个字符（中文占2个字符）"));
			     jQuery.validator.addMethod("maxlength50", function(value, element) {
				      return this.optional(element) || ((Len(value.trim()) <= 50));
			         }, $.validator.format("长度不能超过50个字符（中文占2个字符）"));
			     jQuery.validator.addMethod("maxlength60", function(value, element) {
				      return this.optional(element) || ((Len(value.trim()) <= 60));
			         }, $.validator.format("长度不能超过60个字符（中文占2个字符）"));
			     jQuery.validator.addMethod("maxlength150", function(value, element) {
				      return this.optional(element) || ((Len(value.trim()) <= 150));
			         }, $.validator.format("长度不能超过150个字符（中文占2个字符）"));

			     jQuery.validator.addMethod("maxlength100", function(value, element) {
				      return this.optional(element) || ((Len(value.trim()) <= 100));
			         }, $.validator.format("长度不能超过100个字符（中文占2个字符）"));
		         
			     jQuery.validator.addMethod("maxlength200", function(value, element) {
				      return this.optional(element) || ((Len(value.trim()) <= 200));
			         }, $.validator.format("长度不能超过200个字符（中文占2个字符）"));

			     jQuery.validator.addMethod("isRightName", 
					     function(value, element) {
				      		return this.optional(element) || ((isValidIdentifier(value.trim())==true));
			         }, $.validator.format("命名不符合标识符规范，请以字母 或  _ 开头"));
			     jQuery.validator.addMethod("isNo", 
					     function(value, element) {
				      		return this.optional(element) || ((!isNaN(value.trim())));
			         }, $.validator.format("请输入数字"));
			     jQuery.validator.addMethod("isNo_Tinyint", 
					     function(value, element) {
				      		return this.optional(element) || ((numAndKong(value)&&0<=value&&value<=255)&&isInt(value.trim()));
			         }, $.validator.format("请输入整数，范围在0~255之间"));
			     jQuery.validator.addMethod("isNo_smallint", 
					     function(value, element) {
				      		return this.optional(element) || ((numAndKong(value)&&0<=value&&value<=32767)&&isInt(value.trim()));
			         }, $.validator.format("请输入整数，范围在0~32767之间"));
			     jQuery.validator.addMethod("isNo_NotOverValue", 
					     function(value, element) {
				      		return this.optional(element) || ((numAndKong(value)&&0<=value&&value<=32767)&&isInt(value.trim()));
			         }, $.validator.format("请输入整数，范围在0~32767之间"));
		         
			     jQuery.validator.addMethod("isNo_NotOverValueInt", 
					     function(value, element) {
				      		return this.optional(element) || ((numAndKong(value)&&0<=value&&value<=2147483647)&&isInt(value.trim()));
			         }, $.validator.format("请输入整数，范围在0~2147483647之间"));
			     jQuery.validator.addMethod("isNo_NotOverValueIntOne", 
					     function(value, element) {
				      		return this.optional(element) || ((numAndKong(value)&&1<=value&&value<=2147483647)&&isInt(value.trim()));
			         }, $.validator.format("请输入整数，范围在1~2147483647之间"));
			     jQuery.validator.addMethod("isIP", 
					     function(value, element) {
				      		return this.optional(element) || ((isIP(value.trim())));
			         }, $.validator.format("请输入正确的IP地址（不超过15个字符），如：192.168.1.1"));
			     jQuery.validator.addMethod("versonNoFormat", 
					     function(value, element) {
			    	        var reg = /^(-|\+)?\d+$/ ;		     
				      		return this.optional(element) || ((reg.test(value)&&value>=0));
			         }, $.validator.format("版本号必须是正整型数"));
			      /**
			     *参数管理 验证 end
			     */
			     
			     /**
			     *报表管理 验证 start
			     */  
			     jQuery.validator.addMethod("isNo_NotOverDecimal", 
					     function(value, element) {
				      		return this.optional(element) || ((!isNaN(value.trim())&&0<=value&&value<=90000000));
			         }, $.validator.format("请输入数字，且范围在0~90000000之间"));
			     jQuery.validator.addMethod("zeroAndInteger", function(value, element) {					     
						    var decimal = /^[0-9]\d*$/;
						    return this.optional(element) || (decimal.test(value));
					       }, $.validator.format("请输入0或者正整数."));
			     /**
			     *报表管理 验证 end
			     */             
	  });

	/**
	 * 这里自定义方法 校验整数或小数
	 */
</script>
