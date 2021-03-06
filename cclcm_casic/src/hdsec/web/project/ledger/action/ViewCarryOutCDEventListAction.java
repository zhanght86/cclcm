package hdsec.web.project.ledger.action;

import hdsec.web.project.activiti.model.JobTypeEnum;
import hdsec.web.project.ledger.model.EventOut;
import hdsec.web.project.user.model.SecLevel;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 载体外带
 * 
 * @author fyp
 * 
 */
public class ViewCarryOutCDEventListAction extends LedgerBaseAction {
	private static final long serialVersionUID = 1L;
	private Date startTime = null;
	private Date endTime = null;
	private String job_status = "";// 审批状态
	private String entity_type = "";
	private String seclv_code = "";
	private List<EventOut> eventList = null;

	private final JobTypeEnum jobType = JobTypeEnum.CHANGE;

	public String getEntity_type() {
		return entity_type;
	}

	public void setEntity_type(String entity_type) {
		this.entity_type = entity_type;
	}

	public JobTypeEnum getJobType() {
		return jobType;
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

	public String getSeclv_code() {
		return seclv_code;
	}

	public void setSeclv_code(String seclv_code) {
		this.seclv_code = seclv_code;
	}

	public List<EventOut> getEventList() {
		return eventList;
	}

	public void setEventList(List<EventOut> eventList) {
		this.eventList = eventList;
	}

	public List<SecLevel> getSeclvList() {
		return userService.getSecLevel();
	}

	public String getStartTime() {
		return sdf.format(startTime);
	}

	public String getEndTime() {
		return sdf.format(endTime);
	}

	@Override
	public String executeFunction() throws Exception {
		String web_url = getModuleName().toLowerCase() + "/" + getTitleName().toLowerCase() + ".action";
		List<String> dept_ids = basicService.getAdminDeptIdList(getCurUser().getUser_iidd(), web_url);
		if (dept_ids == null || dept_ids.size() == 0) {
			throw new Exception("没有配置管理部门,请联系系统管理员进行配置");
		}
		Map<String, Object> map = new HashMap<String, Object>();

		map.put("seclv_code", seclv_code);

		map.put("jobType_code", JobTypeEnum.CARRYOUT_CD.getJobTypeCode());

		map.put("job_status", "true");
		map.put("startTime", startTime);
		map.put("endTime", endTime);
		eventList = ledgerService.getCarryOutConfirmEventList(map);

		return SUCCESS;

	}

}
