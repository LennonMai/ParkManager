package com.hgsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.FeeRuleTypeDefDao;
import com.hgsoft.entity.FeeRuleTypeDef;

/**
 * 收费类型Service
 */
@Service
public class FeeRuleTypeDefService extends BaseService<FeeRuleTypeDef> {

	@Autowired
	public void setDao(@Qualifier("feeRuleTypeDefDao") FeeRuleTypeDefDao dao) {
		super.setDao(dao);
	}

	private FeeRuleTypeDefDao getFeeRuleTypeDefDao() {
		return (FeeRuleTypeDefDao) this.getDao();
	}

	public List<FeeRuleTypeDef> ishasFeeRuleType(Object feeRuleType) {
		return getFeeRuleTypeDefDao().ishasFeeRuleType(feeRuleType);
	}

	public List<FeeRuleTypeDef> ishasName(Object name) {
		return getFeeRuleTypeDefDao().ishasName(name);
	}

	public List<FeeRuleTypeDef> getAllFeeRuleTypeDef() {
		return getFeeRuleTypeDefDao().getAllFeeRuleTypeDef();
	}

	public List<FeeRuleTypeDef> LoadFeeRuleTypeDef(Object feeRuleType) {
		return getFeeRuleTypeDefDao().LoadFeeRuleTypeDef(feeRuleType);
	}

	public boolean deleteByFeeRuleType(Object feeRuleType) {
		return getFeeRuleTypeDefDao().deleteByFeeRuleType(feeRuleType);
	}
}
