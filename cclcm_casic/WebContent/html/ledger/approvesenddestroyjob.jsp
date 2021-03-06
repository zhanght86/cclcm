<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<link rel="stylesheet" type="text/css" href="${ctx}/_css/displaytag.css" media="screen"/>
    <link rel="stylesheet" type="text/css" href="${ctx}/_css/css200603.css"  media="screen"/>
    <script language="javascript" src="${ctx}/_script/jquery/jquery.min.js"></script>
	<script language="JavaScript" src="${ctx}/_script/function.js"></script>
	<script language="javascript" src="${ctx}/_script/casic304_common.js"></script>
<script>
<!--
$(document).ready(function(){
	prepareBizApproval("${process.step_dept}","${process.step_role}","${process.step_dept_name}","${process.step_role_name}","${ctx}");
	if($("#next_approver_all").children().size() == 0){
		$("#selApprover1").hide();
		$("#selApprover2").hide();
	}
	$("#submit_btn").attr("disabled",false);
});
function chk(){
	if($("#opinion").val().trim() == ""){
		alert("审批意见不能为空");
		$("#opinion").focus();
		return false;
	}
	if($("#next_approver_all option").size() > 0 && $("#next_approver_sel option").size() == 0 && $("#approved")[0].checked){
		alert("请选择审批人员");
		$("#next_approver_all").focus();
		return false;
	}
	var next_approver = "";
	$("#next_approver_sel option").each(function(){
		next_approver += this.value+",";
	});
	var len = next_approver.length;
	if (next_approver.lastIndexOf(",") == len - 1){
		next_approver = next_approver.substring(0, len - 1);
	}
	$("#next_approver").val(next_approver);
	return true;
}
function changeApproved(value){
	if(value == "true"){
		$("#opinion").val("同意");
	}else if(value == "false"){
		$("#opinion").val("不同意");
	}
}
//-->
</script>
</head>
<body oncontextmenu="self.event.returnValue=false">
<table width="95%" border="1" cellspacing="0" cellpadding="0" align="center" class="table_box">
	<tr>
	    <td colspan="6" class="title_box">查看任务详情</td>
	</tr>
	<tr> 
    	<td width="10%" align="center">申请用户： </td>
    	<td width="23%"><font color="blue"><b>${job.user_name}</b></font></td>
    	<td width="10%" align="center">用户部门： </td>
    	<td width="23%"><font color="blue"><b>${job.dept_name}</b></font></td>
    	<td width="10%" align="center">业务密级：</td>
    	<td width="23%"><font color="blue"><b>${job.seclv_name}</b></font></td>
	</tr>
  	<tr height="50">
  		<td align="center">审批人：</td>
  		<td colspan="5"><font color="blue"><b>&nbsp;${job.next_approver_name}</b></font></td>
  	</tr>
  	<tr>
  		<td align="center">流程记录：</td>
  		<td colspan="5">
  			<table width="90%" border="0" cellspacing="0" cellpadding="0" align="left" >
				<tr>
					<td align="center" width="100">操作</td>
					<td align="center" width="100">操作人</td>
					<td align="center" width="100">部门</td>
					<td align="center" width="150">时间</td>
					<td align="center">意见</td>
				</tr>		
	  			<s:iterator value="#request.recordList" var="item">
	  				<tr>
	  					<td align="center">&nbsp;${item.operation}</td>
	  					<td align="center">&nbsp;${item.user_name}</td>
	  					<td align="center">&nbsp;${item.dept_name}</td>
	  					<td align="center">&nbsp;${item.op_time_str}</td>
	  					<td align="center">&nbsp;${item.opinion}</td>
	  				</tr>
				</s:iterator>
  			</table>
  		</td>
  	</tr>
  	<tr valign="middle" height="80"> 
    	<td align="center">流程信息： </td>
    	<td class="table_box_border_empty" colspan="5">
			<table class="table_box_border_empty"><tr>
				<td>
					<table>
						<tr><td align="center">
							<img alt="流程开始" border="0" src="${ctx}/_image/ico/process/prc_start.jpg" />
						</td></tr>
						<tr><td align="center">
							流程开始
						</td></tr>
					</table>
				</td>
				<td>
					<table>
						<tr><td align="center">
							<img border="0" src="${ctx}/_image/ico/process/to.gif"/>
						</td></tr>
					</table>
				</td>
				<td>
					<table>
						<tr><td align="center">
							<img alt="用户提交申请" border="0" src="${ctx}/_image/ico/process/prc_step.jpg" />
						</td></tr>
						<tr><td align="center">
							用户提交申请
						</td></tr>
					</table>
				</td>
				<td>
					<table>
						<tr><td align="center">
							<img border="0" src="${ctx}/_image/ico/process/to.gif"/>
						</td></tr>
					</table>
				</td>
				<td>
					<table>
						<tr><td align="center">
							<img border="0" src="${ctx}/_image/ico/process/prc_end.jpg" id="prc_end"/>
						</td></tr>
						<tr><td align="center">
							流程结束
						</td></tr>
					</table>
				</td>
			</tr></table>
		</td>
	</tr>
	<form action="${ctx}/ledger/approvesenddestroyjob.action" method="post" >
	<input type="hidden" name="next_approver" id="next_approver"/>
	<input type="hidden" name="job_code" value="${job.job_code}"/>
	<tr>
		<td align="center"><font color="red">*</font>&nbsp;审批：</td>
  		<td class="table_box_border_empty" colspan="2">
  			<table width="90%" border="0" cellspacing="0" cellpadding="0" align="left" >
				<tr>
					<td><!-- checked="checked"  -->
						&nbsp;&nbsp;<input type="radio" name="approved" value="true" id="approved" onclick="changeApproved(this.value);"/>同意
						&nbsp;&nbsp;<input type="radio" name="approved" value="false" onclick="changeApproved(this.value);"/>不同意
					</td>
				</tr>		
	  			<tr>
	  				<td>
	  					<textarea rows="3" cols="50" name="opinion" id="opinion"></textarea>
	  				</td>
	  			</tr>
  			</table>
  		</td>
  		<td align="center" id="selApprover1">选择审批人：</td>
  		<td id="selApprover2" colspan="2">
  			<table width="300" border="0" cellspacing="0" cellpadding="0" align="left" class="table_box_border_empty">
				<tr>
					<td id="allApprovers">
						<SELECT ondblclick="add_True('next_approver_all','next_approver_sel');" style="WIDTH: 100px" multiple="true" size="8" id="next_approver_all">
							<c:forEach var="item" items="${userList}" varStatus="status">
								<option value="${item.user_iidd}">${item.user_name}</option>
							</c:forEach>
						</SELECT>
					</td>
					<td aling="center" valign="middle">
						<INPUT class="button_2003" onclick="add_MoreTrue('next_approver_all','next_approver_sel');" type="button" value="增加-->" /><br/>
						<br/>
						<INPUT class="button_2003" onclick="del_MoreTrue('next_approver_sel');" type="button" value="删除<--"><br/>
					</td>
					<td>
						<SELECT size="8" multiple="true" style="WIDTH: 100px" ondblclick="del_True('next_approver_sel');" id="next_approver_sel">
						</SELECT>
					</td>
				</tr>
			</table>
		</td>
  	</tr>
  	<tr>
	    <td colspan="6" align="center">
	     	<input class="button_2003" type="submit" value="提交" onclick="return chk();" id="submit_btn" disabled="disabled">&nbsp;
			<input class="button_2003" type="button" value="返回" onClick="javascript:history.go(-1);">&nbsp;
	    </td>
  	</tr>
  	</form>
</table>
</br></br>
<table align="center" width="95%">
	<tr>
	    <td class="title_box">送销列表</td>
	</tr>
	<tr>
		<td>
			<table class="displaytable-outter" cellspacing=0 cellpadding=0 border=0 width="100%">
	 			<tr>
	   				<td>
	   				    <c:if test="${type eq 'cd'}">
	   						<display:table uid="item" class="displaytable" name="cdList" sort="list">
								<display:column title="序号">
									<c:out value="${item_rowNum}"/>
								</display:column>
								<display:column property="file_list" title="光盘列表" maxLength="40"/>												
								<display:column property="cd_barcode" title="光盘条码"/>
								<display:column property="seclv_name" title="密级"/>
								<display:column property="create_type_name" title="制作方式"/>
								<display:column property="cd_state_name" title="状态"/>														
								<display:column title="操作" style="width:50px">
									<input type="button" class="button_2003" value="查看" onclick="go('${ctx}/ledger/viewpersonalledgerinfo.action?op=hasprc&cd_id=${item.cd_id}');"/>
								</display:column>
							</display:table>
						</c:if>
						<c:if test="${type eq 'paper'}">
							<display:table uid="item" class="displaytable" name="paperList" sort="list">
								<display:column title="序号">
									<c:out value="${item_rowNum}"/>
								</display:column>
								<display:column property="file_title" title="文件名" maxLength="40"/>												
								<display:column property="paper_barcode" title="文件条码"/>
								<display:column property="seclv_name" title="密级"/>
								<display:column property="create_type_name" title="制作方式"/>
								<display:column property="paper_state_name" title="状态"/>														
								<display:column title="操作" style="width:50px">
									<input type="button" class="button_2003" value="查看" onclick="go('${ctx}/ledger/viewpersonalpaperledgerinfo.action?op=hasprc&paper_id=${item.paper_id}');"/>
								</display:column>
							</display:table>
						</c:if>
					</td>
				</tr>
			</table>
         </td>
	</tr>
</table>
</body>
</html>
