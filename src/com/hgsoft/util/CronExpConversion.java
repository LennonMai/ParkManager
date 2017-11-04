package com.hgsoft.util;

/**
 * ����ʱ����ʱ��ת����UNIX cron expressions
 * 
 * @author qinzuohai
 * 
 */
public class CronExpConversion {
	/**
	 * 
	 * 
	 * @param everyWhat
	 * @param commonNeeds:second minute hour
	 * @param monthlyNeeds: �ڼ������� ���ڼ�
	 * @param weeklyNeeds:  ���ڼ�
	 * @param userDefinedNeeds:����ʱ���
	 * @return cron expression
	 */
	public static String convertDateToCronExp(String everyWhat,
			String[] commonNeeds, String[] monthlyNeeds, String weeklyNeeds,
			String userDefinedNeeds) {
		String cronEx = "";
		String commons = commonNeeds[0] + "   " + commonNeeds[1] + "   "
				+ commonNeeds[2] + "   ";

		String dayOfWeek = "";
		if ("monthly".equals(everyWhat.trim())) {
			// example: 6#3 (day 6 = Friday and "#3" = the 3rd one in the month)
			dayOfWeek = monthlyNeeds[1]
					+ CronExRelated.specialCharacters
							.get(CronExRelated._THENTH) + monthlyNeeds[0];
			cronEx = (commons
					+ CronExRelated.specialCharacters.get(CronExRelated._ANY)
					+ "   "
					+ CronExRelated.specialCharacters.get(CronExRelated._EVERY)
					+ "   " + dayOfWeek + "   ").trim();
		} else if ("weekly".equals(everyWhat.trim())) {

			dayOfWeek = weeklyNeeds; // 1
			cronEx = (commons
					+ CronExRelated.specialCharacters.get(CronExRelated._ANY)
					+ "   "
					+ CronExRelated.specialCharacters.get(CronExRelated._EVERY)
					+ "   " + dayOfWeek + "   ").trim();
		} else if ("userDefined".equals(everyWhat.trim())) {
			
			String dayOfMonth = userDefinedNeeds.split("-")[2];
			
			if (dayOfMonth.startsWith("0")) {
				dayOfMonth = dayOfMonth.replaceFirst("0", "");
			}
			String month = userDefinedNeeds.split("-")[1];
			if (month.startsWith("0")) {
				month = month.replaceFirst("0", "");
			}
			// String year = userDefinedNeeds.split(" - ")[0];
			// ��ʱ������� Quartz����
			/*
			 * cronEx = (commons + dayOfMonth + " " + month + " " +
			 * CronExRelated.specialCharacters.get(CronExRelated._ANY) + " " +
			 * year).trim();
			 */
			cronEx = (commons + dayOfMonth + "   " + month + "   "
					+ CronExRelated.specialCharacters.get(CronExRelated._ANY) + "   ")
					.trim();
		}
		return cronEx;
	}

}
