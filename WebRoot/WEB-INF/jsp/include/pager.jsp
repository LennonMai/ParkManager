<%@ page contentType="text/html; charset=GBK" language="java" pageEncoding="gbk"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<script language="javascript">
function gotoPage(pageNo) {
	if(pageNo>0)
		get("pager.currentPage").value = pageNo;
	document.tableForm.submit();
}
</script>
	
<div class="pn-sp">
	<div class="pn-sp-left">共 ${pager.totalSize} 条 &nbsp;每页
	<input type="text" name="pager.pageSize" value="${pager.pageSize}" size="2" onfocus="this.select();"/> 条</div>
	<div class="pn-sp-right">
		<input type="button" value=" 首 页 " onclick="gotoPage('1');" <s:if test="pager.hasFirst==false">disabled</s:if>/>&nbsp;
		<input type="button" value=" 上一页 " onclick="gotoPage('${pager.currentPage-1}');"
		<s:if test="pager.hasPrevious==false">disabled</s:if> />&nbsp;
		<input type="button" value=" 下一页 " onclick="gotoPage('${pager.currentPage+1}');"
	  <s:if test="pager.hasNext==false">disabled</s:if> />&nbsp;
		<input type="button" value=" 尾 页 " onclick="gotoPage('${pager.totalPage}');"
		<s:if test="pager.hasLast==false">disabled</s:if> />&nbsp;
		当前 ${pager.currentPage}/${pager.totalPage} 页 &nbsp;转到第 
			<input type="text" name="pager.currentPage" size="2" value="${pager.currentPage}" onfocus="this.select();"/> 页
		<input type="button" value=" 转 " onclick="gotoPage(-1);"/>
		<input type="hidden" name="pager.rowIndex" size="2" value="${pager.rowIndex}"/>
	</div>
	<div class="clear"></div>
</div>