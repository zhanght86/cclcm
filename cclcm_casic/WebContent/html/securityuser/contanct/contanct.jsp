<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<html>
<head>
	<title>联系方式</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="${ctx}/_css/css200603.css" type="text/css" media="screen" />
		<link rel="stylesheet" type="text/css" href="${ctx}/_css/displaytag.css" media="screen"/>
	<link href="${ctx}/_script/calendar2/calendar-blue.css" type="text/css" rel="stylesheet"/>
	<script language="javascript" src="${ctx}/_script/calendar2/calendar.js"></script>
	<script language="javascript" src="${ctx}/_script/jquery/jquery.min.js"></script>
	<script language="javascript" src="${ctx}/_script/casic304_common.js"></script>
	<script language="javascript" src="${ctx}/_script/casic304_ajax.js"></script>
	<script>
	$(document).ready(function(){
		onHoverInfinite();
		addSelectAllCheckbox();
		optionSelect();
	});
	function clearFindForm(){
		$("#ContactQueryCondForm :text").val("");
		$("#ContactQueryCondForm select").val("");
	}	
	function optionSelect(){
		$("#seclv_code").val("${seclv_code}");
		$("#paper_state").val("${paper_state}");
	}
	function deletecompanycontact(obj){
		    var url="${ctx}/securityuser/deletecompanycontanct.action?id="+obj;
		    if(confirm("确定删除联系人吗？")){
		    	xmlHttp.open("GET", url, true);
				xmlHttp.onreadystatechange = updatePage;
				xmlHttp.send(null);
		    }
		}
		function updatePage() {
			if (xmlHttp.readyState == 4) {
				  var response = xmlHttp.responseText;
				  ContactQueryCondForm.submit();
			}
		}
	</script>
</head>
<body oncontextmenu="self.event.returnValue=false">
<table width="95%" border="0" cellspacing="0" cellpadding="0" align="center" class="table_only_border">
	<tr>
		<td class="title_box">首页联系方式</td>
	</tr>
	<form id="ContactQueryCondForm" method="GET" action="${ctx}/securityuser/contanct.action">
	<tr>
		<td align="right">
			<table  table border=0 class="table_box" cellspacing="0" cellpadding="0" width="100%">
				<tr>
					<td width="8%" align="center">姓&nbsp&nbsp名：</td>
					<td width="20%">
						<input type="text" id="name" name="name" value="${name}"/>&nbsp;
					</td>
					<td width="8%" align="center">职&nbsp&nbsp务：</td>
					<td width="17%">
						<input type="text" id="post" name="post" value="${post}"/>&nbsp;
					</td>
					<td width="8%" align="center">手&nbsp&nbsp机:</td>
					<td width="17%">
						<input type="text" id="mobile" name="mobile" value="${mobile}"/>&nbsp;
					</td>
					<td align="center" colspan="2"> 
						&nbsp;<input name="button" type="submit" class="button_2003" value="查询" onclick="return checkTime();">
						&nbsp;<input name="button" type="button" class="button_2003" value="清空" onclick="clearFindForm();">&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="button" class="button_2003" value="新增首页联系人" onclick="go('${ctx}/securityuser/addcompanycontanct.action?name=null');"/>
					</td>	
				</tr>				
			</table>
		</td>
	</tr>
	<tr>
		<td>
			<table class="displaytable-outter" cellspacing=0 cellpadding=0 border=0 width="100%">
	 			<tr>
	   				<td>
	   					<display:table requestURI="${ctx}/securityuser/contanct.action" uid="item" class="displaytable" name="listContact"
	   							pagesize="10"  size="item.size()" form="ContactQueryCondForm" excludedParams="*">		   							   					
		   					<display:column title="选择">							
										<input type="checkbox" name="_chk" value="${item.id}" id="${item.id}"
							</display:column>
							<display:column title="序号">
								<c:out value="${item_rowNum}"/>
							</display:column>
							<display:column property="name" title="姓名" maxLength="15"/>
							<display:column property="post" title="职务" maxLength="15"/>
							<display:column property="mobile" title="手机"/>
							<display:column property="telephone" title="座机"/>
							<display:column property="address" title="办公室"/>
							<display:column property="reark" title="备注"/>
							<display:column property="rank" title="排序值"/>
								<display:column title="操作" style="width:100px">
								<input type="button" class="button_2003" value="修改" onclick="go('${ctx}/securityuser/updatecompanycontanct.action?id=${item.id}');"/>
								<input type="button" class="button_2003" value="删除" onclick="deletecompanycontact('${item.id}')"/>								
							</display:column>
						</display:table>
					</td>
				</tr>
			</table>
         </td>
	</tr>
</table>	
</form>
</body>
</html>
