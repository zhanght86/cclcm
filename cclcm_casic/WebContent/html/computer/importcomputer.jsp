<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<html>
<head>
	<title>批量录入磁介质</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" type="text/css" href="${ctx}/_css/displaytag.css" media="screen"/>
    <link rel="stylesheet" type="text/css" href="${ctx}/_css/css200603.css"  media="screen"/>
    <script language="javascript" src="${ctx}/_script/casic304_common.js"></script>
    <script language="javascript" src="${ctx}/_script/jquery/jquery.min.js"></script>
</head>
<script>
$(document).ready(function(){
		if('${done}'=='Y'){
			text = "导入成功：${successNum}个信息设备<p>";
			text = text + "必填信息缺失的行号为${lackList}<p>";
			text = text + "计算机名称错误的行数为${computerWrongList}<p>";
			text = text + "计算机型号错误的行数为${modelWrongList}<p>";
			text = text + "编号（设备编号与保密编号）错误的行数为${codeWrongList}<p>";
			text = text + "密级错误行数为${seclvWrongList}<p>";
			text = text + "责任人错误的行数为${userWrongList}<p>";
			text = text + "部门错误的行数为${deptWrongList}<p>";
			text = text + "网络连接设置错误的行数为${internettypeWrongList}<p>";
			text = text + "硬盘序列号错误的行数为${hdisknoWrongList}<p>";
			text = text + "使用情况错误的行数为${statusWrongList}<p>";
			text = text + "未知原因导致失败的行号为${failList}";
			$("#td_result").html(text);
		}
	});
</script>
<body oncontextmenu="self.event.returnValue=false" onload="onHover();" style="padding-top: 120px">
<center>
	<table width="60%" border="0" cellspacing="0" cellpadding="0" align="center" class="table_only_border">
		<tr>
			<td class="title_box">批量录入计算机</td>
		</tr>
		<tr style="padding-top: 20px;">
			<td align="center">
			<form id="TemplateQueryCondForm" method="POST" action="${ctx}/computer/importcomputer.action" enctype="multipart/form-data">
				<input type="hidden" name="done" value="Y"/>
	 			导入文件<input type="file" name="upload" class="button_2003"/>&nbsp;&nbsp;
	 				<input type="submit" class="button_2003" value="提交">&nbsp;&nbsp;
	 				<a href="${ctx}/html/computer/computer.xls">下载模板</a>
	 		</form>
			</td>
		</tr>
		<tr>
			<td id="td_result" style="border-top: 2px">
			</td>
		</tr>
		<tr>
	        <td align="center" class="bottom_box">
	          	<input type="button" value="返回" class="button_2003" onclick="javascript:history.go(-1);">
	        </td>
		</tr>
	</table>
</center>
</body>

</html>