package com.hgsoft.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.hgsoft.dao.CardTypeDao;
import com.hgsoft.entity.CardType;

@Service
public class CardTypeService extends BaseService<CardType> {

	@Autowired
	public void setDao(@Qualifier("cardTypeDao") CardTypeDao dao) {
		super.setDao(dao);
	}

	private CardTypeDao getCardTypeDao() {
		return (CardTypeDao) this.getDao();
	}

	public List<CardType> getAllCardType() {
		return getCardTypeDao().getAllCardType();
	}

	public CardType getCardTypeByCardType(Short cardType) {
		return getCardTypeDao().getCardTypeByCardType(cardType);
	}

	public List<CardType> getCardTypeByThreeCardType(Short cardType, Short cardType1, Short cardType2) {
		return getCardTypeDao().getCardTypeByThreeCardType(cardType, cardType1, cardType2);
	}

}
