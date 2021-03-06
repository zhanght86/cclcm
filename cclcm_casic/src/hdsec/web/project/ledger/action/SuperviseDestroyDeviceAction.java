package hdsec.web.project.ledger.action;

import hdsec.web.project.device.model.EntityDevice;
import hdsec.web.project.user.model.SecLevel;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.displaytag.tags.TableTagParameters;
import org.displaytag.util.ParamEncoder;
import org.springframework.util.StringUtils;

public class SuperviseDestroyDeviceAction extends LedgerBaseAction {

	private static final long serialVersionUID = 1L;
	private String barcode = "";
	private String seclv_code = "";
	private Date start_time = null;
	private Date end_time = null;
	private List<EntityDevice> deviceLedgerList = null;

	public List<EntityDevice> getDeviceLedgerList() {
		return deviceLedgerList;
	}

	public void setDeviceLedgerList(List<EntityDevice> deviceLedgerList) {
		this.deviceLedgerList = deviceLedgerList;
	}

	public String getBarcode() {
		return barcode;
	}

	public void setBarcode(String barcode) {
		this.barcode = barcode.trim();
	}

	public String getSeclv_code() {
		return seclv_code;
	}

	public void setSeclv_code(String seclv_code) {
		this.seclv_code = seclv_code;
	}

	public Date getStart_time() {
		return start_time;
	}

	public void setStart_time(Date start_time) {
		this.start_time = start_time;
	}

	public Date getEnd_time() {
		return end_time;
	}

	public void setEnd_time(Date end_time) {
		this.end_time = end_time;
	}

	public List<SecLevel> getSeclvList() {
		return userService.getSecLevel();
	}

	@Override
	public String executeFunction() throws Exception {
		String temp = getCurUser().getUser_iidd();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("user_iidd", getCurUser().getUser_iidd());
		map.put("device_barcode", barcode);
		map.put("seclv_code", seclv_code);
		map.put("start_time", start_time);
		map.put("end_time", end_time);
		map.put("job_status", "true");
		map.put("device_status", 8);// 类型为监销
		map.put("supervise_user_iidd", getCurUser().getUser_iidd());

		String pageIndexName = new ParamEncoder("item").encodeParameterName(TableTagParameters.PARAMETER_PAGE);
		if (StringUtils.hasLength(getRequest().getParameter(pageIndexName))) {
			page = Integer.parseInt(getRequest().getParameter(pageIndexName)) - 1;
		}
		beginIndex = page * pageSize;
		RowBounds rbs = new RowBounds(beginIndex, pageSize);
		totalSize = ledgerService.getSelfDestroyDeviceSize(map);
		setDeviceLedgerList(ledgerService.getSelfDestroyDevcieList(map, rbs));

		return SUCCESS;
	}
}
