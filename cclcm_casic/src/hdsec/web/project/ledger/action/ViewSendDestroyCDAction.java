package hdsec.web.project.ledger.action;

import hdsec.web.project.activiti.model.JobTypeEnum;
import hdsec.web.project.activiti.model.ProcessJob;
import hdsec.web.project.ledger.model.EntityCD;
import hdsec.web.project.ledger.model.SendDestroyEvent;
import hdsec.web.project.user.model.SecLevel;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 查看光盘送销申请记录
 * 
 * @author lixiang
 * 
 */
public class ViewSendDestroyCDAction extends LedgerBaseAction {

	private static final long serialVersionUID = 1L;
	private String seclv_code = "";
	private Date startTime = null;
	private Date endTime = null;
	private String job_status = "";
	private List<SendDestroyEvent> eventList = null;
	private JobTypeEnum jobType = JobTypeEnum.SENDES_CD;
	private List<ProcessJob> jobList = null;

	public String getActionContext() {
		return "/ledger/viewsenddestroycd.action";
	}

	public JobTypeEnum getJobType() {
		return jobType;
	}

	public String getSeclv_code() {
		return seclv_code;
	}

	public void setSeclv_code(String seclv_code) {
		this.seclv_code = seclv_code;
	}

	public String getStartTime_str() {
		return startTime == null ? "" : sdf.format(startTime);
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}

	public String getEndTime_str() {
		return endTime == null ? "" : sdf.format(endTime);
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}

	public String getJob_status() {
		return job_status;
	}

	public void setJob_status(String job_status) {
		this.job_status = job_status;
	}

	public List<SendDestroyEvent> getEventList() {
		return eventList;
	}

	public List<SecLevel> getSeclvList() {
		return userService.getSecLevel();
	}

	public List<ProcessJob> getJobList() {
		return jobList;
	}

	@Override
	public String executeFunction() throws Exception {

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("user_iidd", getCurUser().getUser_iidd());
		map.put("startTime", startTime);
		map.put("endTime", endTime);
		map.put("seclv_code", seclv_code);
		map.put("job_status", job_status);
		map.put("jobType_code", JobTypeEnum.SENDES_CD);
		jobList = ledgerService.getSendDestroyCDJobList(map);
		for (ProcessJob job : jobList) {
			String event_names = "";
			List<SendDestroyEvent> events = ledgerService.getSendDestroyEventListByJobCode(job.getJob_code());
			for (SendDestroyEvent event : events) {
				EntityCD cd = ledgerService.getCDByBarcode(event.getBarcode());
				if (cd != null) {
					event_names += cd.getFile_list() + "  ";
				}
			}
			job.setEvent_names(event_names);
		}
		basicService.setClientMsgRead(getCurUser().getUser_iidd(), "SENDES_CD", 2);
		basicService.setClientMsgRead(getCurUser().getUser_iidd(), "SENDES_CD", 3);
		return SUCCESS;
	}

}
