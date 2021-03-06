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
	<script language="javascript" src="${ctx}/_script/casic304_ajax.js"></script>
<script>
<!--
$(document).ready(function(){
	prepareBizApproval("${process.step_dept}","${process.step_role}","${process.step_dept_name}","${process.step_role_name}","${ctx}");
});
function viewEventDetail(event_code){
	go("${ctx}/basic/vieweventdetail.action?jobType_code=${job.jobType.jobTypeCode}&event_code="+escape(event_code));
}
function chkCancel(event_code){
	if(confirm("确定要撤销该打印文件申请？")){
		var url = "${ctx}/print/cancelprintevent.action?event_code="+escape(event_code);
		callServer(url);
	}
}
function updateResult(){
	if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {
		if(xmlHttp.responseText == "ok:0"){
			alert("取消成功");
			go(window.location);
		}else if(xmlHttp.responseText == "ok:1"){
			alert("取消成功,所有申请都已取消,审批单撤销");
			go("${ctx}/print/manageprintjob.action");
		}else{
			alert("取消失败，请重试");
		}
	}
}
//显示每条作业的邦辰关键字检查情况
function ShowRisklist(st_filename,event_code){
	    if("Microsoft Internet Explorer"==navigator.appName){
		var url ="${ctx}/print/showrisklist.action?st_filename="+st_filename+"&event_code="+event_code;
		window.showModalDialog(url,window,'dialogHeight:600px;dialogWidth:700px;center:yes;status:no;scroll:no;help:no;unadorned:no;resizable:no');
		
		//var rValue=window.showModalDialog(urlEnsure,'', 'dialogHeight:600px;dialogWidth:700px;center:yes;status:no;scroll:no;help:no;unadorned:no;resizable:no');
		return false;
		}
}
function showPrintFile(filestorename,pagecount){
	    if("Microsoft Internet Explorer"==navigator.appName){
		var FileStoreNameLen = filestorename.length;
		var unzipdirname = filestorename.substr(0,FileStoreNameLen-4);
		var url ="${ctx}/print/showprintfile.action?unzipdirname="+unzipdirname+"&pagecount="+pagecount;
		window.showModalDialog(url,window,"dialogHeight:"+(screen.availHeight-40)+";dialogWidth:"+(screen.availWidth-5)+";center:yes;resizable:no;status:no;scroll:no;help:no");
		return false;
		}
		else{
			var FileStoreNameLen = filestorename.length;
			var unzipdirname = filestorename.substr(0,FileStoreNameLen-4);
			var url ="${ctx}/print/showprintfilelinux.action?unzipdirname="+unzipdirname;
			window.showModalDialog(url,window);
			//onunload = live();
			return false;
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
    	<td width="10%" align="center">业务类型：</td>
    	<td width="23%"><font color="blue"><b>${job.jobType.jobTypeName}</b></font></td>
	</tr>
	<tr>
		<td align="center">申请状态： </td>
    	<td><font color="blue"><b>${job.job_status_name}</b></font></td> 
    	<td align="center">业务密级： </td>
    	<td><font color="blue"><b>${job.seclv_name}</b></font></td>
    	<td align="center">外发信息： </td>
    	<td>
    		接收单位：<font color="blue"><b>${empty job.output_dept_name?'无':job.output_dept_name}</b></font>
    		接收人：<font color="blue"><b>${empty job.output_user_name?'无':job.output_user_name}</b></font>
    	</td>	
	</tr>
	<tr>
		<td align="center">外发承办人： </td>
    	<td><font color="blue"><b>${job.output_undertaker}</b></font></td> 
    	<td align="center">外发方式： </td>
    	<td><font color="blue"><b>${job.send_way == '0'?'专人携带':'机要'}</b></font></td>
    	<td align="center">携带人： </td>	
    	<td><font color="blue"><b>${job.carryout_user_names}</b></font></td>	
	</tr>
	<tr height="50">
  		<td align="center">委托打印人：</td>
  		<td colspan="5"><font color="blue"><b>&nbsp;${empty proxyoutput_user_name?'无':proxyoutput_user_name}</b></font></td>
  	</tr>
  	<tr>
		<c:choose>
			<c:when test="${viewflag eq 'Y'}">
				<td align="center"><font color="red"><b>&nbsp;知悉范围:</b></font></td>
    			<td><font color="red">&nbsp;${view_file_scope}</font></td>
	    		<td align="center"><font color="red"><b>&nbsp;定密依据:</b></font></td>
				<td><font color="red">&nbsp;${view_seclv_accord}</font></td>	
				<td align="center"><font color="red"><b>&nbsp;保密期限:</b></font></td>
				<td><font color="red">&nbsp;${view_secret_time}</font></td>
			</c:when>
			<c:otherwise>
		        <td align="center"><font color="green"><b>&nbsp;知悉范围:</b></font></td>
    			<td><font color="green">&nbsp;非定密作业</font></td>
	    		<td align="center"><font color="green"><b>&nbsp;定密依据:</b></font></td>
				<td><font color="green">&nbsp;非定密作业</font></td>	
				<td align="center"><font color="green"><b>&nbsp;保密期限:</b></font></td>
				<td><font color="green">&nbsp;非定密作业</font></td>
		    </c:otherwise>
		</c:choose>	
	</tr>
	<tr>
		<td align="center">具体说明： </td>
	   	<td colspan="5"><textarea name="comment" rows="3" cols="60" readonly="readonly">${job.comment}</textarea></td>
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
  	<tr>
    <td colspan="6" align="center"> 
		<input class="button_2003" type="button" value="返回" onClick="javascript:history.go(-1);">&nbsp;
    </td>
  </tr>
</table>
</br></br>
<table align="center" width="95%">
	<tr>
	    <td class="title_box">批量提交的作业列表</td>
	</tr>
	<tr>
		<td>
			<table class="displaytable-outter" cellspacing=0 cellpadding=0 border=0 width="100%">
	 			<tr>
	   				<td>
					<display:table uid="item" class="displaytable" name="eventList" sort="list">
						<display:column title="序号">
							<c:out value="${item_rowNum}"/>
						</display:column>
						<display:column title="文件名" property="file_title" maxLength="40"/>
						<display:column title="页数" property="page_count"/>
						<display:column title="份数" property="print_count"/>
						<display:column title="文件密级" property="seclv_name"/>
						<display:column title="业务类型" property="jobType.jobTypeName"/>
						<display:column title="留用期限" property="period_name"/>
						<display:column title="用途" property="usage_name"/>
						<display:column title="打印状态" property="print_status_name"/>
						<display:column title="申请时间" property="apply_time_str"/>
						<display:column title="关键字检查结果" >
						    <u><label style="color: red;cursor: pointer;" onclick="ShowRisklist('${item.st_filename}','${item.event_code}');">${item.policy_name}&nbsp;</label></u>
						</display:column>
						<%-- <display:column title="关键字" >
							<font color="red">${item.keyword_content}&nbsp;</font>
						</display:column> --%>
						<display:column title="操作" style="width:150px">
							<input type="button" class="button_2003" value="预览" onclick="showPrintFile('${item.st_filename}','${item.page_count}');"/>&nbsp;
							<input type="button" class="button_2003" value="查看" onclick="viewEventDetail('${item.event_code}');"/>&nbsp;
							<c:if test="${is_prop == 'Y'}">
								<c:choose>
									<c:when test="${item.print_status == 0}">
										<input type="button" class="button_2003" value="撤销" onclick="chkCancel('${item.event_code}')"/>
									</c:when>
									<c:otherwise>
										<input type="button" class="button_2003" value="撤销" disabled="disabled"/>
									</c:otherwise>
								</c:choose>
							</c:if>
						</display:column>
					</display:table>
					</td>
				</tr>
			</table>
         </td>
	</tr>
</table>
</body>
</html>
