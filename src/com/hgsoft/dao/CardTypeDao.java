package com.hgsoft.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.hgsoft.entity.CardType;

@Repository
public class CardTypeDao extends BaseDao<CardType> {
	@SuppressWarnings("unchecked")
	public List<CardType> getAllCardType() {
		String hql = "from CardType cardType ";
		List list = executeQuery(hql);
		if (list.isEmpty()) {
			return null;
		} else {
			return list;
		}
	}
	@SuppressWarnings("unchecked")
	public CardType getCardTypeByCardType(Short cardType ) {
		String hql = "from CardType cardTypeTemp where cardTypeTemp.cardType=? ";
		List list = executeQuery(hql,cardType);
		if (list.isEmpty()) {
			return null;
		} else {
			return (CardType)list.get(0);
		}
	}
	@SuppressWarnings("unchecked")
	public List<CardType> getCardTypeByThreeCardType(Short cardType,Short cardType1,Short cardType2) {
		String hql = "from CardType cardTypeTemp where cardTypeTemp.cardType=? or cardTypeTemp.cardType=? or cardTypeTemp.cardType=?";
		List list = executeQuery(hql,cardType,cardType1,cardType2);
		if (list.isEmpty()) {
			return null;
		} else {
			return list;
		}
	}

}
