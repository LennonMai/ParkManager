package com.hgsoft.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.CardInfoDao;
import com.hgsoft.entity.CardInfo;
import com.hgsoft.util.Pager;

@Service
public class CardInfoService extends BaseService<CardInfo> {

	@Autowired
	public void setDao(@Qualifier("cardInfoDao") CardInfoDao dao) {
		super.setDao(dao);
	}

	private CardInfoDao getCardInfoDao() {
		return (CardInfoDao) this.getDao();
	}

	public List<Object[]> getAllCardInfoAndCardType(Pager pager) {
		return getCardInfoDao().getAllCardInfoAndCardType(pager);
	}

	public List<Object[]> findAllItemByHql(Pager pager, String cardNo, Short cardType, Short status,
			Short userCardType) {
		return getCardInfoDao().findAllItemByHql(pager, cardNo, cardType, status, userCardType);
	}

	public CardInfo getCardInfoByCardNo(String cardNo) {
		return getCardInfoDao().getCardInfoByCardNo(cardNo);
	}

	public int getCardAmountByTypeName(String typeName) {
		return getCardInfoDao().getCardAmountByTypeName(typeName);
	}

	// caijunhua IC卡库存统计
	public int getTypeStatistics(int type) {
		return getCardInfoDao().getTypeStatistics(type);
	}

	public int getStatusStatistics(int status) {
		return getCardInfoDao().getStatusStatistics(status);
	}

	// 查询白名单 曾
	public List<Object[]> queryWhite(Pager pager, String cardNo, String vehplate, String obuId, String cardType,
			String status, String ownerName, String isImage, String feeRuleType) {
		return getCardInfoDao().queryWhite(pager, cardNo, vehplate, obuId, cardType, status, ownerName, isImage,
				feeRuleType);
	}

	// 导出白名单 曾
	public List<Object[]> exportWhite(String cardNo, String vehplate, String obuId, String cardType, String status,
			String ownerName, String isImage, String feeRuleType) {
		return getCardInfoDao().exportWhite(cardNo, vehplate, obuId, cardType, status, ownerName, isImage, feeRuleType);
	}

	public List<Object[]> exportWhite(String fileds, Map map) {
		return getCardInfoDao().exportWhite(fileds, map);
	}

	// 导出IC卡 曾 cardInfo.getCardNo().trim(), cardInfo.getCardType(),
	// cardInfo.getStatus(),cardInfo.getUserCardType()
	public List<Object[]> exportICCard(String cardNo, Short cardType, Short status, Short userCardType) {
		return getCardInfoDao().exportICCard(cardNo, cardType, status, userCardType);
	}

	// 打印userCardInfo
	public List<Object[]> printUserCardInfo(String cardNo) {
		return getCardInfoDao().printUserCardInfo(cardNo);
	}
}
