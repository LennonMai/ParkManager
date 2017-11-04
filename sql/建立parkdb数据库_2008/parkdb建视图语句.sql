use [parkdb]
--------------------------------------------------------删除视图----------------------------------------------------------
Go
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[V_AOwnerNVeh]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[V_AOwnerNVeh]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[V_LoseCardList]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[V_LoseCardList]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[V_PASSCARDBLACKLIST]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[V_PASSCARDBLACKLIST]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[V_PassCardWL]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[V_PassCardWL]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[V_WHITELIST]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[V_WHITELIST]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[V_WHITELIST_bak]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[V_WHITELIST_bak]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[V_outlist01]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[V_outlist01]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[V_outlist02]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[V_outlist02]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[V_outlist03]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[V_outlist03]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[V_outlist04]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[V_outlist04]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[V_outlist05]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[V_outlist05]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[V_outlist06]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[V_outlist06]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[V_outlist07]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[V_outlist07]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[V_outlist08]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[V_outlist08]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[V_outlist09]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[V_outlist09]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[V_outlist10]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[V_outlist10]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[V_outlist11]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[V_outlist11]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[V_outlist12]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[V_outlist12]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WhiteListPic]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[WhiteListPic]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_AccountCard]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[tb_AccountCard]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_LaneGroup]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[tb_LaneGroup]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_station]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[tb_station]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[v_AccountTrade]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[v_AccountTrade]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[v_AllInList]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[v_AllInList]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[v_AllOutList]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[v_AllOutList]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[v_AllValidUnlockCommand]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[v_AllValidUnlockCommand]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[v_LimitParkInfo]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[v_LimitParkInfo]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[v_ShowInfo]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[v_ShowInfo]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[v_SpVehHandle]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[v_SpVehHandle]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[v_SpecialVeh]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[v_SpecialVeh]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[v_account]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[v_account]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[v_accountCard]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[v_accountCard]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[v_securitycommand]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[v_securitycommand]
GO


if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[V_WHITELISTNOTESTWL]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[V_WHITELISTNOTESTWL] 
GO

---------------------------------------------------------------------------建立视图---------------------------------------------
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

create view [dbo].[V_AOwnerNVeh]
AS
select distinct
       t1.CardNo,
       t1.VehPlate,
       t2.GroupNo,
	   t2.GroupName,
	   t2.ParkSum as VehPlaceCnt
from tb_CardGroup t1, tb_CardGroupInfo t2
where t1.GroupNo = t2.GroupNo

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

--选择所有已确认为丢失状态的临时卡
create view V_LoseCardList
as
select lch.CardNo,lch.OpTime,lch.ParkNo,lch.GateNo,lch.LaneNo,lch.VehPlate,
	lch.OutOpTime,lch.OutParkNo,lch.OutGateNo,lch.OutLaneNo,lch.OutRemark
from tb_CardDynamic cd,tb_LoseCardHis lch
where cd.Status = 13 and cd.CardNo=lch.CardNo and cd.OpTime=lch.Optime

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


---通行卡黑名单视图
--CREATE VIEW dbo.V_PassCardBlackList
--AS
--SELECT t2.CardID, t1.*
--FROM dbo.tb_PassCardBlackList t1 INNER JOIN
--      dbo.tb_CardInfo t2 ON t1.CardNo = t2.CardNO
CREATE VIEW V_PASSCARDBLACKLIST AS 
	SELECT CARDNO, CARDID, OPTIME, STATUS FROM TB_CARDINFO
		WHERE CARDTYPE=1 AND STATUS <> 0
--	UNION ALL 
--	SELECT A.CARDNO, A.CARDID, C.OPTIME, 9 AS STATUS FROM TB_CARDINFO A
--		INNER JOIN TB_USERCARDINFO B ON A.CARDNO=B.CARDNO
--		INNER JOIN (SELECT USERRECNO,MAX(ENDTIME) AS OPTIME FROM TB_USERCARDBILL GROUP BY USERRECNO HAVING MAX(ENDTIME) < GETDATE()) C
--			ON B.RECNO=C.USERRECNO




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



----通行卡登记视图
--CREATE VIEW dbo.V_PassCardWL
--AS
--SELECT CardID, CardNO
--FROM dbo.tb_CardInfo t1
--WHERE (Status = 0) AND (NOT EXISTS
--          (SELECT CardNo
--         FROM tb_UserCardInfo t2
--         WHERE t1.CardNo = T2.CardNo))

--通行卡登记视图
CREATE VIEW dbo.V_PassCardWL
AS
SELECT CardID, CardNO
FROM dbo.tb_CardInfo 
WHERE CardType = 1 or CardType = 13 or CardType = 14
         


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

---白名单视图
CREATE VIEW [dbo].[V_WHITELIST] AS 
SELECT * FROM 
(
	--费用截止时间不计时分秒，所以+1天
	SELECT A.CARDNO, A.VEHPLATE, A.OWNER AS OWNERNAME,A.OBU AS OBUID,
		CASE WHEN B.STARTTIME IS NULL THEN A.REGISTERTIME ELSE B.STARTTIME END AS FIRTIME, 
		CASE WHEN B.ENDTIME IS NULL THEN A.REGISTERTIME ELSE B.ENDTIME+1 END AS INVALIDATETIME,
		A.UserCardType AS CARDTYPE, 
		CASE WHEN A.STATUS=0 AND (B.ENDTIME IS NULL OR B.ENDTIME<CONVERT(CHAR(10),GETDATE(),120)) THEN 9 ELSE A.STATUS END AS STATUS,
		CASE WHEN VehPlateImage IS NULL THEN 0 ELSE 1 END AS HasVehPic,A.FeeRuleType
	FROM TB_USERCARDINFO  A 
	LEFT JOIN 
	(
		--在跨月缴费的情况下，本SQL可能会有错误
		SELECT USERRECNO, MIN(STARTTIME) AS STARTTIME, MAX(ENDTIME) AS ENDTIME FROM TB_USERCARDBILL 
			WHERE convert(char(10),GETDATE(),120) BETWEEN STARTTIME AND ENDTIME OR STARTTIME>convert(char(10),GETDATE(),120)
			GROUP BY USERRECNO
		UNION ALL
		SELECT USERRECNO, MAX(STARTTIME) as STARTTIME, MAX(ENDTIME) AS ENDTIME FROM TB_USERCARDBILL
		GROUP BY USERRECNO HAVING MAX(ENDTIME) < convert(char(10),GETDATE(),120)
	) B ON A.RECNO = B.USERRECNO
	WHERE A.UserCardType=14 --月租卡
	UNION ALL
	SELECT A.CARDNO, A.VEHPLATE, A.OWNER AS OWNERNAME,A.OBU AS OBUID,CASE WHEN A.REGISTERTIME IS NULL THEN GETDATE() - 120 ELSE A.REGISTERTIME END AS FIRTIME,
	 GETDATE()+1000 AS INVALIDATETIME,A.UserCardType AS CARDTYPE, A.STATUS, CASE WHEN A.VehPlateImage IS NULL THEN 0 ELSE 1 END AS HasVehPic,A.FeeRuleType
	FROM TB_USERCARDINFO A
	WHERE A.UserCardType=13	--业主卡
	union all 
	SELECT CARDNO, VEHPLATE, OWNERName , OBUID, GETDATE()-120 AS FIRTIME, GETDATE()+1000 AS INVALIDATETIME,
		13 as Usetype, 0 as Status, CASE WHEN VehPlateImage IS NULL THEN 0 ELSE 1 END AS HasVehPic,0 AS FeeRuleType
	FROM tb_testwl
	
) TMP


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



CREATE   VIEW V_WHITELIST_bak AS 
SELECT * FROM 
(
	--费用截止时间不计时分秒，所以+1天
	SELECT A.CARDNO, A.VEHPLATE, A.OWNER AS OWNERNAME,A.OBU AS OBUID,
		CASE WHEN B.STARTTIME IS NULL THEN A.REGISTERTIME ELSE B.STARTTIME END AS FIRTIME, 
		CASE WHEN B.ENDTIME IS NULL THEN A.REGISTERTIME ELSE B.ENDTIME+1 END AS INVALIDATETIME,
		A.USERCARDTYPE AS CARDTYPE, 
		CASE WHEN A.STATUS=0 AND (B.ENDTIME IS NULL OR B.ENDTIME<convert(char(10),getdate(),120)) THEN 9 ELSE A.STATUS END AS STATUS,
		CASE WHEN VehPlateImage IS NULL THEN 0 ELSE 1 END AS HasVehPic
	FROM TB_USERCARDINFO  A 
	LEFT JOIN 
	(
		--在跨月缴费的情况下，本SQL可能会有错误
		SELECT USERRECNO, MIN(STARTTIME) AS STARTTIME, MAX(ENDTIME) AS ENDTIME FROM TB_USERCARDBILL 
			WHERE convert(char(10),getdate(),120) BETWEEN STARTTIME AND ENDTIME OR STARTTIME>convert(char(10),getdate(),120)
			GROUP BY USERRECNO
		UNION ALL
		SELECT USERRECNO, MAX(STARTTIME) as STARTTIME, MAX(ENDTIME) AS ENDTIME FROM TB_USERCARDBILL
		GROUP BY USERRECNO HAVING MAX(ENDTIME) < convert(char(10),getdate(),120)
	) B ON A.RECNO = B.USERRECNO
	WHERE A.USERCARDTYPE=14 --月租卡
	UNION ALL
	SELECT A.CARDNO, A.VEHPLATE, A.OWNER AS OWNERNAME,A.OBU AS OBUID,GETDATE()-30 AS FIRTIME, GETDATE()+1000 AS INVALIDATETIME,
		A.USERCARDTYPE AS CARDTYPE, A.STATUS, CASE WHEN A.VehPlateImage IS NULL THEN 0 ELSE 1 END AS HasVehPic
	FROM TB_USERCARDINFO A
	WHERE A.USERCARDTYPE=13	--业主卡
	union all 
	SELECT CARDNO, VEHPLATE, OWNERName , OBUID, GETDATE()-30 AS FIRTIME, GETDATE()+1000 AS INVALIDATETIME,
		13 as Usetype, 0 as Status, CASE WHEN VehPlateImage IS NULL THEN 0 ELSE 1 END AS HasVehPic
	FROM tb_testwl
	
) TMP



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

create view V_outlist01
( RecordNo,ListNo,InListNo,InGateNo,InGateName,InLaneNo,InVehType,InVehClass,InVehPlate,
  InOperatorNo,InOpTime,InVehTypeAuto,InVehPlateAuto,
  CityNo,AreaNo,ParkNo,GateNo,GateName,LaneNo,VehType,VehClass,VehCount,VehPlate,SquadNo,SquadDate,	
  OperatorNo,OperatorName,ID,IDNo,OpTime,CardBoxNo,CardTrunkNo,
  TicketType,CardID,CardNo,ObuID,PayCardID,PayCardNo,PayCardType,PayCardBalance,
  SpEvent,InvoiceID,CashMoney,FreeMoney,UnpayMoney,ETCMoney,VehTypeAuto,VehPlateAuto,PriceVerNo,
  ListName,InParkListNo,AddCashMoney,AddEtcMoney,ETCTradeNo,ETCTac,TCTermTradNo,ETCTermCode,
  BackUp1,BackUp2,BackUp3,BackUp4,VerifyCode
) 
as 

SELECT 
      cast(RecordNo as char(6)),
      cast(ListNo AS char(16)), 
      cast(InListNo AS char(16)),
      cast(InGateNo AS char(4)),
      cast(InGateName AS char(8)),
      cast(InLaneNo AS char(4)),
      cast(InVehType AS char(1)),
      cast(InVehClass AS char(1)),
      cast(InVehPlate AS char(10)),
      cast(InOperatorNo AS char(10)),
      dbo.f_DTtoStr(InOpTime,4),
      cast(InVehTypeAuto AS char(1)),
      cast(InVehPlateAuto AS char(10)),
      cast(CityNo AS char(4)),
      cast(AreaNo AS char(4)),
      cast(ParkNo AS char(4)),
      cast(GateNo AS char(4)), 
      cast(GateName AS char(8)), 
      cast(LaneNo AS char(4)),
      cast(VehType AS char(1)), 
      cast(VehClass AS char(1)), 
      cast(VehCount AS char(4)), 
      cast(VehPlate AS char(10)), 
      cast(SquadNo AS char(1)), 
      dbo.f_DTtoStr(SquadDate, 5), 
      cast(OperatorNo AS char(10)), 
      cast(OperatorName AS char(8)), 
      cast(ID AS char(16)), 
      cast(IDNo AS char(12)), 
      dbo.f_DTtoStr(OpTime, 4),
      cast(CardBoxNo AS char(8)), 
      cast(CardTrunkNo AS char(8)), 
      cast(TicketType AS char(1)), 
      cast(CardID AS char(16)), 
      cast(CardNo AS char(12)), 
      cast(ObuID AS char(16)), 
      cast(PayCardID AS char(16)), 
      cast(PayCardNo AS char(12)), 
      cast(PayCardType AS char(1)), 
      cast(PayCardBalance AS char(12)), 
      cast(SpEvent AS char(10)), 
      cast(InvoiceID AS char(10)), 
      cast(CashMoney AS char(4)), 
      cast(FreeMoney AS char(4)), 
      cast(UnpayMoney AS char(4)), 
      cast(ETCMoney AS char(4)), 
      cast(VehTypeAuto AS char(1)), 
      cast(VehPlateAuto AS char(10)),
      cast(PriceVerNo AS char(2)), 
      cast(ListName AS char(10)), 
      cast(InParkListNo AS char(16)), 
      cast(AddCashMoney AS char(4)), 
      cast(AddEtcMoney AS char(4)), 
      ETCTradeNo,
      ETCTac, 
      ETCTermTradNo,
      ETCTermCode, 
      cast(BackUp1 AS char(8)), 
      cast(BackUp2 AS char(8)), 
      cast(BackUp3 AS char(8)), 
      cast(BackUp4 AS char(8)),
      VerifyCode
FROM tb_outlist01 
Where ETCMoney<>0 and vehclass=6 and tickettype in (5,6)    


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

create view V_outlist02
( RecordNo,ListNo,InListNo,InGateNo,InGateName,InLaneNo,InVehType,InVehClass,InVehPlate,
  InOperatorNo,InOpTime,InVehTypeAuto,InVehPlateAuto,
  CityNo,AreaNo,ParkNo,GateNo,GateName,LaneNo,VehType,VehClass,VehCount,VehPlate,SquadNo,SquadDate,	
  OperatorNo,OperatorName,ID,IDNo,OpTime,CardBoxNo,CardTrunkNo,
  TicketType,CardID,CardNo,ObuID,PayCardID,PayCardNo,PayCardType,PayCardBalance,
  SpEvent,InvoiceID,CashMoney,FreeMoney,UnpayMoney,ETCMoney,VehTypeAuto,VehPlateAuto,PriceVerNo,
  ListName,InParkListNo,AddCashMoney,AddEtcMoney,ETCTradeNo,ETCTac,TCTermTradNo,ETCTermCode,
  BackUp1,BackUp2,BackUp3,BackUp4,VerifyCode
) 
as 

SELECT 
      cast(RecordNo as char(6)),
      cast(ListNo AS char(16)), 
      cast(InListNo AS char(16)),
      cast(InGateNo AS char(4)),
      cast(InGateName AS char(8)),
      cast(InLaneNo AS char(4)),
      cast(InVehType AS char(1)),
      cast(InVehClass AS char(1)),
      cast(InVehPlate AS char(10)),
      cast(InOperatorNo AS char(10)),
      dbo.f_DTtoStr(InOpTime,4),
      cast(InVehTypeAuto AS char(1)),
      cast(InVehPlateAuto AS char(10)),
      cast(CityNo AS char(4)),
      cast(AreaNo AS char(4)),
      cast(ParkNo AS char(4)),
      cast(GateNo AS char(4)), 
      cast(GateName AS char(8)), 
      cast(LaneNo AS char(4)),
      cast(VehType AS char(1)), 
      cast(VehClass AS char(1)), 
      cast(VehCount AS char(4)), 
      cast(VehPlate AS char(10)), 
      cast(SquadNo AS char(1)), 
      dbo.f_DTtoStr(SquadDate, 5), 
      cast(OperatorNo AS char(10)), 
      cast(OperatorName AS char(8)), 
      cast(ID AS char(16)), 
      cast(IDNo AS char(12)), 
      dbo.f_DTtoStr(OpTime, 4),
      cast(CardBoxNo AS char(8)), 
      cast(CardTrunkNo AS char(8)), 
      cast(TicketType AS char(1)), 
      cast(CardID AS char(16)), 
      cast(CardNo AS char(12)), 
      cast(ObuID AS char(16)), 
      cast(PayCardID AS char(16)), 
      cast(PayCardNo AS char(12)), 
      cast(PayCardType AS char(1)), 
      cast(PayCardBalance AS char(12)), 
      cast(SpEvent AS char(10)), 
      cast(InvoiceID AS char(10)), 
      cast(CashMoney AS char(4)), 
      cast(FreeMoney AS char(4)), 
      cast(UnpayMoney AS char(4)), 
      cast(ETCMoney AS char(4)), 
      cast(VehTypeAuto AS char(1)), 
      cast(VehPlateAuto AS char(10)),
      cast(PriceVerNo AS char(2)), 
      cast(ListName AS char(10)), 
      cast(InParkListNo AS char(16)), 
      cast(AddCashMoney AS char(4)), 
      cast(AddEtcMoney AS char(4)), 
      ETCTradeNo,
      ETCTac, 
      ETCTermTradNo,
      ETCTermCode, 
      cast(BackUp1 AS char(8)), 
      cast(BackUp2 AS char(8)), 
      cast(BackUp3 AS char(8)), 
      cast(BackUp4 AS char(8)),
      VerifyCode
FROM tb_outlist02 
Where ETCMoney<>0 and vehclass=6 and tickettype in (5,6)     


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

create view V_outlist03
( RecordNo,ListNo,InListNo,InGateNo,InGateName,InLaneNo,InVehType,InVehClass,InVehPlate,
  InOperatorNo,InOpTime,InVehTypeAuto,InVehPlateAuto,
  CityNo,AreaNo,ParkNo,GateNo,GateName,LaneNo,VehType,VehClass,VehCount,VehPlate,SquadNo,SquadDate,	
  OperatorNo,OperatorName,ID,IDNo,OpTime,CardBoxNo,CardTrunkNo,
  TicketType,CardID,CardNo,ObuID,PayCardID,PayCardNo,PayCardType,PayCardBalance,
  SpEvent,InvoiceID,CashMoney,FreeMoney,UnpayMoney,ETCMoney,VehTypeAuto,VehPlateAuto,PriceVerNo,
  ListName,InParkListNo,AddCashMoney,AddEtcMoney,ETCTradeNo,ETCTac,TCTermTradNo,ETCTermCode,
  BackUp1,BackUp2,BackUp3,BackUp4,VerifyCode
) 
as 

SELECT 
      cast(RecordNo as char(6)),
      cast(ListNo AS char(16)), 
      cast(InListNo AS char(16)),
      cast(InGateNo AS char(4)),
      cast(InGateName AS char(8)),
      cast(InLaneNo AS char(4)),
      cast(InVehType AS char(1)),
      cast(InVehClass AS char(1)),
      cast(InVehPlate AS char(10)),
      cast(InOperatorNo AS char(10)),
      dbo.f_DTtoStr(InOpTime,4),
      cast(InVehTypeAuto AS char(1)),
      cast(InVehPlateAuto AS char(10)),
      cast(CityNo AS char(4)),
      cast(AreaNo AS char(4)),
      cast(ParkNo AS char(4)),
      cast(GateNo AS char(4)), 
      cast(GateName AS char(8)), 
      cast(LaneNo AS char(4)),
      cast(VehType AS char(1)), 
      cast(VehClass AS char(1)), 
      cast(VehCount AS char(4)), 
      cast(VehPlate AS char(10)), 
      cast(SquadNo AS char(1)), 
      dbo.f_DTtoStr(SquadDate, 5), 
      cast(OperatorNo AS char(10)), 
      cast(OperatorName AS char(8)), 
      cast(ID AS char(16)), 
      cast(IDNo AS char(12)), 
      dbo.f_DTtoStr(OpTime, 4),
      cast(CardBoxNo AS char(8)), 
      cast(CardTrunkNo AS char(8)), 
      cast(TicketType AS char(1)), 
      cast(CardID AS char(16)), 
      cast(CardNo AS char(12)), 
      cast(ObuID AS char(16)), 
      cast(PayCardID AS char(16)), 
      cast(PayCardNo AS char(12)), 
      cast(PayCardType AS char(1)), 
      cast(PayCardBalance AS char(12)), 
      cast(SpEvent AS char(10)), 
      cast(InvoiceID AS char(10)), 
      cast(CashMoney AS char(4)), 
      cast(FreeMoney AS char(4)), 
      cast(UnpayMoney AS char(4)), 
      cast(ETCMoney AS char(4)), 
      cast(VehTypeAuto AS char(1)), 
      cast(VehPlateAuto AS char(10)),
      cast(PriceVerNo AS char(2)), 
      cast(ListName AS char(10)), 
      cast(InParkListNo AS char(16)), 
      cast(AddCashMoney AS char(4)), 
      cast(AddEtcMoney AS char(4)), 
      ETCTradeNo,
      ETCTac, 
      ETCTermTradNo,
      ETCTermCode, 
      cast(BackUp1 AS char(8)), 
      cast(BackUp2 AS char(8)), 
      cast(BackUp3 AS char(8)), 
      cast(BackUp4 AS char(8)),
      VerifyCode
FROM tb_outlist03 
Where ETCMoney<>0 and vehclass=6 and tickettype in (5,6)     


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

create view V_outlist04
( RecordNo,ListNo,InListNo,InGateNo,InGateName,InLaneNo,InVehType,InVehClass,InVehPlate,
  InOperatorNo,InOpTime,InVehTypeAuto,InVehPlateAuto,
  CityNo,AreaNo,ParkNo,GateNo,GateName,LaneNo,VehType,VehClass,VehCount,VehPlate,SquadNo,SquadDate,	
  OperatorNo,OperatorName,ID,IDNo,OpTime,CardBoxNo,CardTrunkNo,
  TicketType,CardID,CardNo,ObuID,PayCardID,PayCardNo,PayCardType,PayCardBalance,
  SpEvent,InvoiceID,CashMoney,FreeMoney,UnpayMoney,ETCMoney,VehTypeAuto,VehPlateAuto,PriceVerNo,
  ListName,InParkListNo,AddCashMoney,AddEtcMoney,ETCTradeNo,ETCTac,TCTermTradNo,ETCTermCode,
  BackUp1,BackUp2,BackUp3,BackUp4,VerifyCode
) 
as 

SELECT 
      cast(RecordNo as char(6)),
      cast(ListNo AS char(16)), 
      cast(InListNo AS char(16)),
      cast(InGateNo AS char(4)),
      cast(InGateName AS char(8)),
      cast(InLaneNo AS char(4)),
      cast(InVehType AS char(1)),
      cast(InVehClass AS char(1)),
      cast(InVehPlate AS char(10)),
      cast(InOperatorNo AS char(10)),
      dbo.f_DTtoStr(InOpTime,4),
      cast(InVehTypeAuto AS char(1)),
      cast(InVehPlateAuto AS char(10)),
      cast(CityNo AS char(4)),
      cast(AreaNo AS char(4)),
      cast(ParkNo AS char(4)),
      cast(GateNo AS char(4)), 
      cast(GateName AS char(8)), 
      cast(LaneNo AS char(4)),
      cast(VehType AS char(1)), 
      cast(VehClass AS char(1)), 
      cast(VehCount AS char(4)), 
      cast(VehPlate AS char(10)), 
      cast(SquadNo AS char(1)), 
      dbo.f_DTtoStr(SquadDate, 5), 
      cast(OperatorNo AS char(10)), 
      cast(OperatorName AS char(8)), 
      cast(ID AS char(16)), 
      cast(IDNo AS char(12)), 
      dbo.f_DTtoStr(OpTime, 4),
      cast(CardBoxNo AS char(8)), 
      cast(CardTrunkNo AS char(8)), 
      cast(TicketType AS char(1)), 
      cast(CardID AS char(16)), 
      cast(CardNo AS char(12)), 
      cast(ObuID AS char(16)), 
      cast(PayCardID AS char(16)), 
      cast(PayCardNo AS char(12)), 
      cast(PayCardType AS char(1)), 
      cast(PayCardBalance AS char(12)), 
      cast(SpEvent AS char(10)), 
      cast(InvoiceID AS char(10)), 
      cast(CashMoney AS char(4)), 
      cast(FreeMoney AS char(4)), 
      cast(UnpayMoney AS char(4)), 
      cast(ETCMoney AS char(4)), 
      cast(VehTypeAuto AS char(1)), 
      cast(VehPlateAuto AS char(10)),
      cast(PriceVerNo AS char(2)), 
      cast(ListName AS char(10)), 
      cast(InParkListNo AS char(16)), 
      cast(AddCashMoney AS char(4)), 
      cast(AddEtcMoney AS char(4)), 
      ETCTradeNo,
      ETCTac, 
      ETCTermTradNo,
      ETCTermCode, 
      cast(BackUp1 AS char(8)), 
      cast(BackUp2 AS char(8)), 
      cast(BackUp3 AS char(8)), 
      cast(BackUp4 AS char(8)),
      VerifyCode
FROM tb_outlist04 
Where ETCMoney<>0 and vehclass=6 and tickettype in (5,6)     


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

create view V_outlist05
( RecordNo,ListNo,InListNo,InGateNo,InGateName,InLaneNo,InVehType,InVehClass,InVehPlate,
  InOperatorNo,InOpTime,InVehTypeAuto,InVehPlateAuto,
  CityNo,AreaNo,ParkNo,GateNo,GateName,LaneNo,VehType,VehClass,VehCount,VehPlate,SquadNo,SquadDate,	
  OperatorNo,OperatorName,ID,IDNo,OpTime,CardBoxNo,CardTrunkNo,
  TicketType,CardID,CardNo,ObuID,PayCardID,PayCardNo,PayCardType,PayCardBalance,
  SpEvent,InvoiceID,CashMoney,FreeMoney,UnpayMoney,ETCMoney,VehTypeAuto,VehPlateAuto,PriceVerNo,
  ListName,InParkListNo,AddCashMoney,AddEtcMoney,ETCTradeNo,ETCTac,TCTermTradNo,ETCTermCode,
  BackUp1,BackUp2,BackUp3,BackUp4,VerifyCode
) 
as 

SELECT 
      cast(RecordNo as char(6)),
      cast(ListNo AS char(16)), 
      cast(InListNo AS char(16)),
      cast(InGateNo AS char(4)),
      cast(InGateName AS char(8)),
      cast(InLaneNo AS char(4)),
      cast(InVehType AS char(1)),
      cast(InVehClass AS char(1)),
      cast(InVehPlate AS char(10)),
      cast(InOperatorNo AS char(10)),
      dbo.f_DTtoStr(InOpTime,4),
      cast(InVehTypeAuto AS char(1)),
      cast(InVehPlateAuto AS char(10)),
      cast(CityNo AS char(4)),
      cast(AreaNo AS char(4)),
      cast(ParkNo AS char(4)),
      cast(GateNo AS char(4)), 
      cast(GateName AS char(8)), 
      cast(LaneNo AS char(4)),
      cast(VehType AS char(1)), 
      cast(VehClass AS char(1)), 
      cast(VehCount AS char(4)), 
      cast(VehPlate AS char(10)), 
      cast(SquadNo AS char(1)), 
      dbo.f_DTtoStr(SquadDate, 5), 
      cast(OperatorNo AS char(10)), 
      cast(OperatorName AS char(8)), 
      cast(ID AS char(16)), 
      cast(IDNo AS char(12)), 
      dbo.f_DTtoStr(OpTime, 4),
      cast(CardBoxNo AS char(8)), 
      cast(CardTrunkNo AS char(8)), 
      cast(TicketType AS char(1)), 
      cast(CardID AS char(16)), 
      cast(CardNo AS char(12)), 
      cast(ObuID AS char(16)), 
      cast(PayCardID AS char(16)), 
      cast(PayCardNo AS char(12)), 
      cast(PayCardType AS char(1)), 
      cast(PayCardBalance AS char(12)), 
      cast(SpEvent AS char(10)), 
      cast(InvoiceID AS char(10)), 
      cast(CashMoney AS char(4)), 
      cast(FreeMoney AS char(4)), 
      cast(UnpayMoney AS char(4)), 
      cast(ETCMoney AS char(4)), 
      cast(VehTypeAuto AS char(1)), 
      cast(VehPlateAuto AS char(10)),
      cast(PriceVerNo AS char(2)), 
      cast(ListName AS char(10)), 
      cast(InParkListNo AS char(16)), 
      cast(AddCashMoney AS char(4)), 
      cast(AddEtcMoney AS char(4)), 
      ETCTradeNo,
      ETCTac, 
      ETCTermTradNo,
      ETCTermCode, 
      cast(BackUp1 AS char(8)), 
      cast(BackUp2 AS char(8)), 
      cast(BackUp3 AS char(8)), 
      cast(BackUp4 AS char(8)),
      VerifyCode
FROM tb_outlist05 
Where ETCMoney<>0 and vehclass=6 and tickettype in (5,6)     


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

create view V_outlist06
( RecordNo,ListNo,InListNo,InGateNo,InGateName,InLaneNo,InVehType,InVehClass,InVehPlate,
  InOperatorNo,InOpTime,InVehTypeAuto,InVehPlateAuto,
  CityNo,AreaNo,ParkNo,GateNo,GateName,LaneNo,VehType,VehClass,VehCount,VehPlate,SquadNo,SquadDate,	
  OperatorNo,OperatorName,ID,IDNo,OpTime,CardBoxNo,CardTrunkNo,
  TicketType,CardID,CardNo,ObuID,PayCardID,PayCardNo,PayCardType,PayCardBalance,
  SpEvent,InvoiceID,CashMoney,FreeMoney,UnpayMoney,ETCMoney,VehTypeAuto,VehPlateAuto,PriceVerNo,
  ListName,InParkListNo,AddCashMoney,AddEtcMoney,ETCTradeNo,ETCTac,TCTermTradNo,ETCTermCode,
  BackUp1,BackUp2,BackUp3,BackUp4,VerifyCode
) 
as 

SELECT 
      cast(RecordNo as char(6)),
      cast(ListNo AS char(16)), 
      cast(InListNo AS char(16)),
      cast(InGateNo AS char(4)),
      cast(InGateName AS char(8)),
      cast(InLaneNo AS char(4)),
      cast(InVehType AS char(1)),
      cast(InVehClass AS char(1)),
      cast(InVehPlate AS char(10)),
      cast(InOperatorNo AS char(10)),
      dbo.f_DTtoStr(InOpTime,4),
      cast(InVehTypeAuto AS char(1)),
      cast(InVehPlateAuto AS char(10)),
      cast(CityNo AS char(4)),
      cast(AreaNo AS char(4)),
      cast(ParkNo AS char(4)),
      cast(GateNo AS char(4)), 
      cast(GateName AS char(8)), 
      cast(LaneNo AS char(4)),
      cast(VehType AS char(1)), 
      cast(VehClass AS char(1)), 
      cast(VehCount AS char(4)), 
      cast(VehPlate AS char(10)), 
      cast(SquadNo AS char(1)), 
      dbo.f_DTtoStr(SquadDate, 5), 
      cast(OperatorNo AS char(10)), 
      cast(OperatorName AS char(8)), 
      cast(ID AS char(16)), 
      cast(IDNo AS char(12)), 
      dbo.f_DTtoStr(OpTime, 4),
      cast(CardBoxNo AS char(8)), 
      cast(CardTrunkNo AS char(8)), 
      cast(TicketType AS char(1)), 
      cast(CardID AS char(16)), 
      cast(CardNo AS char(12)), 
      cast(ObuID AS char(16)), 
      cast(PayCardID AS char(16)), 
      cast(PayCardNo AS char(12)), 
      cast(PayCardType AS char(1)), 
      cast(PayCardBalance AS char(12)), 
      cast(SpEvent AS char(10)), 
      cast(InvoiceID AS char(10)), 
      cast(CashMoney AS char(4)), 
      cast(FreeMoney AS char(4)), 
      cast(UnpayMoney AS char(4)), 
      cast(ETCMoney AS char(4)), 
      cast(VehTypeAuto AS char(1)), 
      cast(VehPlateAuto AS char(10)),
      cast(PriceVerNo AS char(2)), 
      cast(ListName AS char(10)), 
      cast(InParkListNo AS char(16)), 
      cast(AddCashMoney AS char(4)), 
      cast(AddEtcMoney AS char(4)), 
      ETCTradeNo,
      ETCTac, 
      ETCTermTradNo,
      ETCTermCode, 
      cast(BackUp1 AS char(8)), 
      cast(BackUp2 AS char(8)), 
      cast(BackUp3 AS char(8)), 
      cast(BackUp4 AS char(8)),
      VerifyCode
FROM tb_outlist06 
Where ETCMoney<>0 and vehclass=6 and tickettype in (5,6)     


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

create view V_outlist07
( RecordNo,ListNo,InListNo,InGateNo,InGateName,InLaneNo,InVehType,InVehClass,InVehPlate,
  InOperatorNo,InOpTime,InVehTypeAuto,InVehPlateAuto,
  CityNo,AreaNo,ParkNo,GateNo,GateName,LaneNo,VehType,VehClass,VehCount,VehPlate,SquadNo,SquadDate,	
  OperatorNo,OperatorName,ID,IDNo,OpTime,CardBoxNo,CardTrunkNo,
  TicketType,CardID,CardNo,ObuID,PayCardID,PayCardNo,PayCardType,PayCardBalance,
  SpEvent,InvoiceID,CashMoney,FreeMoney,UnpayMoney,ETCMoney,VehTypeAuto,VehPlateAuto,PriceVerNo,
  ListName,InParkListNo,AddCashMoney,AddEtcMoney,ETCTradeNo,ETCTac,TCTermTradNo,ETCTermCode,
  BackUp1,BackUp2,BackUp3,BackUp4,VerifyCode
) 
as 

SELECT 
      cast(RecordNo as char(6)),
      cast(ListNo AS char(16)), 
      cast(InListNo AS char(16)),
      cast(InGateNo AS char(4)),
      cast(InGateName AS char(8)),
      cast(InLaneNo AS char(4)),
      cast(InVehType AS char(1)),
      cast(InVehClass AS char(1)),
      cast(InVehPlate AS char(10)),
      cast(InOperatorNo AS char(10)),
      dbo.f_DTtoStr(InOpTime,4),
      cast(InVehTypeAuto AS char(1)),
      cast(InVehPlateAuto AS char(10)),
      cast(CityNo AS char(4)),
      cast(AreaNo AS char(4)),
      cast(ParkNo AS char(4)),
      cast(GateNo AS char(4)), 
      cast(GateName AS char(8)), 
      cast(LaneNo AS char(4)),
      cast(VehType AS char(1)), 
      cast(VehClass AS char(1)), 
      cast(VehCount AS char(4)), 
      cast(VehPlate AS char(10)), 
      cast(SquadNo AS char(1)), 
      dbo.f_DTtoStr(SquadDate, 5), 
      cast(OperatorNo AS char(10)), 
      cast(OperatorName AS char(8)), 
      cast(ID AS char(16)), 
      cast(IDNo AS char(12)), 
      dbo.f_DTtoStr(OpTime, 4),
      cast(CardBoxNo AS char(8)), 
      cast(CardTrunkNo AS char(8)), 
      cast(TicketType AS char(1)), 
      cast(CardID AS char(16)), 
      cast(CardNo AS char(12)), 
      cast(ObuID AS char(16)), 
      cast(PayCardID AS char(16)), 
      cast(PayCardNo AS char(12)), 
      cast(PayCardType AS char(1)), 
      cast(PayCardBalance AS char(12)), 
      cast(SpEvent AS char(10)), 
      cast(InvoiceID AS char(10)), 
      cast(CashMoney AS char(4)), 
      cast(FreeMoney AS char(4)), 
      cast(UnpayMoney AS char(4)), 
      cast(ETCMoney AS char(4)), 
      cast(VehTypeAuto AS char(1)), 
      cast(VehPlateAuto AS char(10)),
      cast(PriceVerNo AS char(2)), 
      cast(ListName AS char(10)), 
      cast(InParkListNo AS char(16)), 
      cast(AddCashMoney AS char(4)), 
      cast(AddEtcMoney AS char(4)), 
      ETCTradeNo,
      ETCTac, 
      ETCTermTradNo,
      ETCTermCode, 
      cast(BackUp1 AS char(8)), 
      cast(BackUp2 AS char(8)), 
      cast(BackUp3 AS char(8)), 
      cast(BackUp4 AS char(8)),
      VerifyCode
FROM tb_outlist07 
Where ETCMoney<>0 and vehclass=6 and tickettype in (5,6)     


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

create view V_outlist08
( RecordNo,ListNo,InListNo,InGateNo,InGateName,InLaneNo,InVehType,InVehClass,InVehPlate,
  InOperatorNo,InOpTime,InVehTypeAuto,InVehPlateAuto,
  CityNo,AreaNo,ParkNo,GateNo,GateName,LaneNo,VehType,VehClass,VehCount,VehPlate,SquadNo,SquadDate,	
  OperatorNo,OperatorName,ID,IDNo,OpTime,CardBoxNo,CardTrunkNo,
  TicketType,CardID,CardNo,ObuID,PayCardID,PayCardNo,PayCardType,PayCardBalance,
  SpEvent,InvoiceID,CashMoney,FreeMoney,UnpayMoney,ETCMoney,VehTypeAuto,VehPlateAuto,PriceVerNo,
  ListName,InParkListNo,AddCashMoney,AddEtcMoney,ETCTradeNo,ETCTac,TCTermTradNo,ETCTermCode,
  BackUp1,BackUp2,BackUp3,BackUp4,VerifyCode
) 
as 

SELECT 
      cast(RecordNo as char(6)),
      cast(ListNo AS char(16)), 
      cast(InListNo AS char(16)),
      cast(InGateNo AS char(4)),
      cast(InGateName AS char(8)),
      cast(InLaneNo AS char(4)),
      cast(InVehType AS char(1)),
      cast(InVehClass AS char(1)),
      cast(InVehPlate AS char(10)),
      cast(InOperatorNo AS char(10)),
      dbo.f_DTtoStr(InOpTime,4),
      cast(InVehTypeAuto AS char(1)),
      cast(InVehPlateAuto AS char(10)),
      cast(CityNo AS char(4)),
      cast(AreaNo AS char(4)),
      cast(ParkNo AS char(4)),
      cast(GateNo AS char(4)), 
      cast(GateName AS char(8)), 
      cast(LaneNo AS char(4)),
      cast(VehType AS char(1)), 
      cast(VehClass AS char(1)), 
      cast(VehCount AS char(4)), 
      cast(VehPlate AS char(10)), 
      cast(SquadNo AS char(1)), 
      dbo.f_DTtoStr(SquadDate, 5), 
      cast(OperatorNo AS char(10)), 
      cast(OperatorName AS char(8)), 
      cast(ID AS char(16)), 
      cast(IDNo AS char(12)), 
      dbo.f_DTtoStr(OpTime, 4),
      cast(CardBoxNo AS char(8)), 
      cast(CardTrunkNo AS char(8)), 
      cast(TicketType AS char(1)), 
      cast(CardID AS char(16)), 
      cast(CardNo AS char(12)), 
      cast(ObuID AS char(16)), 
      cast(PayCardID AS char(16)), 
      cast(PayCardNo AS char(12)), 
      cast(PayCardType AS char(1)), 
      cast(PayCardBalance AS char(12)), 
      cast(SpEvent AS char(10)), 
      cast(InvoiceID AS char(10)), 
      cast(CashMoney AS char(4)), 
      cast(FreeMoney AS char(4)), 
      cast(UnpayMoney AS char(4)), 
      cast(ETCMoney AS char(4)), 
      cast(VehTypeAuto AS char(1)), 
      cast(VehPlateAuto AS char(10)),
      cast(PriceVerNo AS char(2)), 
      cast(ListName AS char(10)), 
      cast(InParkListNo AS char(16)), 
      cast(AddCashMoney AS char(4)), 
      cast(AddEtcMoney AS char(4)), 
      ETCTradeNo,
      ETCTac, 
      ETCTermTradNo,
      ETCTermCode, 
      cast(BackUp1 AS char(8)), 
      cast(BackUp2 AS char(8)), 
      cast(BackUp3 AS char(8)), 
      cast(BackUp4 AS char(8)),
      VerifyCode
FROM tb_outlist08 
Where ETCMoney<>0 and vehclass=6 and tickettype in (5,6)     


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


create view V_outlist09
( RecordNo,ListNo,InListNo,InGateNo,InGateName,InLaneNo,InVehType,InVehClass,InVehPlate,
  InOperatorNo,InOpTime,InVehTypeAuto,InVehPlateAuto,
  CityNo,AreaNo,ParkNo,GateNo,GateName,LaneNo,VehType,VehClass,VehCount,VehPlate,SquadNo,SquadDate,	
  OperatorNo,OperatorName,ID,IDNo,OpTime,CardBoxNo,CardTrunkNo,
  TicketType,CardID,CardNo,ObuID,PayCardID,PayCardNo,PayCardType,PayCardBalance,
  SpEvent,InvoiceID,CashMoney,FreeMoney,UnpayMoney,ETCMoney,VehTypeAuto,VehPlateAuto,PriceVerNo,
  ListName,InParkListNo,AddCashMoney,AddEtcMoney,ETCTradeNo,ETCTac,TCTermTradNo,ETCTermCode,
  BackUp1,BackUp2,BackUp3,BackUp4,VerifyCode
) 
as 

SELECT 
      cast(RecordNo as char(6)),
      cast(ListNo AS char(16)), 
      cast(InListNo AS char(16)),
      cast(InGateNo AS char(4)),
      cast(InGateName AS char(8)),
      cast(InLaneNo AS char(4)),
      cast(InVehType AS char(1)),
      cast(InVehClass AS char(1)),
      cast(InVehPlate AS char(10)),
      cast(InOperatorNo AS char(10)),
      dbo.f_DTtoStr(InOpTime,4),
      cast(InVehTypeAuto AS char(1)),
      cast(InVehPlateAuto AS char(10)),
      cast(CityNo AS char(4)),
      cast(AreaNo AS char(4)),
      cast(ParkNo AS char(4)),
      cast(GateNo AS char(4)), 
      cast(GateName AS char(8)), 
      cast(LaneNo AS char(4)),
      cast(VehType AS char(1)), 
      cast(VehClass AS char(1)), 
      cast(VehCount AS char(4)), 
      cast(VehPlate AS char(10)), 
      cast(SquadNo AS char(1)), 
      dbo.f_DTtoStr(SquadDate, 5), 
      cast(OperatorNo AS char(10)), 
      cast(OperatorName AS char(8)), 
      cast(ID AS char(16)), 
      cast(IDNo AS char(12)), 
      dbo.f_DTtoStr(OpTime, 4),
      cast(CardBoxNo AS char(8)), 
      cast(CardTrunkNo AS char(8)), 
      cast(TicketType AS char(1)), 
      cast(CardID AS char(16)), 
      cast(CardNo AS char(12)), 
      cast(ObuID AS char(16)), 
      cast(PayCardID AS char(16)), 
      cast(PayCardNo AS char(12)), 
      cast(PayCardType AS char(1)), 
      cast(PayCardBalance AS char(12)), 
      cast(SpEvent AS char(10)), 
      cast(InvoiceID AS char(10)), 
      cast(CashMoney AS char(4)), 
      cast(FreeMoney AS char(4)), 
      cast(UnpayMoney AS char(4)), 
      cast(ETCMoney AS char(4)), 
      cast(VehTypeAuto AS char(1)), 
      cast(VehPlateAuto AS char(10)),
      cast(PriceVerNo AS char(2)), 
      cast(ListName AS char(10)), 
      cast(InParkListNo AS char(16)), 
      cast(AddCashMoney AS char(4)), 
      cast(AddEtcMoney AS char(4)), 
      ETCTradeNo,
      ETCTac, 
      ETCTermTradNo,
      ETCTermCode, 
      cast(BackUp1 AS char(8)), 
      cast(BackUp2 AS char(8)), 
      cast(BackUp3 AS char(8)), 
      cast(BackUp4 AS char(8)),
      VerifyCode
FROM tb_outlist09 
Where ETCMoney<>0 and vehclass=6 and tickettype in (5,6)     



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

create view V_outlist10
( RecordNo,ListNo,InListNo,InGateNo,InGateName,InLaneNo,InVehType,InVehClass,InVehPlate,
  InOperatorNo,InOpTime,InVehTypeAuto,InVehPlateAuto,
  CityNo,AreaNo,ParkNo,GateNo,GateName,LaneNo,VehType,VehClass,VehCount,VehPlate,SquadNo,SquadDate,	
  OperatorNo,OperatorName,ID,IDNo,OpTime,CardBoxNo,CardTrunkNo,
  TicketType,CardID,CardNo,ObuID,PayCardID,PayCardNo,PayCardType,PayCardBalance,
  SpEvent,InvoiceID,CashMoney,FreeMoney,UnpayMoney,ETCMoney,VehTypeAuto,VehPlateAuto,PriceVerNo,
  ListName,InParkListNo,AddCashMoney,AddEtcMoney,ETCTradeNo,ETCTac,TCTermTradNo,ETCTermCode,
  BackUp1,BackUp2,BackUp3,BackUp4,VerifyCode
) 
as 

SELECT 
      cast(RecordNo as char(6)),
      cast(ListNo AS char(16)), 
      cast(InListNo AS char(16)),
      cast(InGateNo AS char(4)),
      cast(InGateName AS char(8)),
      cast(InLaneNo AS char(4)),
      cast(InVehType AS char(1)),
      cast(InVehClass AS char(1)),
      cast(InVehPlate AS char(10)),
      cast(InOperatorNo AS char(10)),
      dbo.f_DTtoStr(InOpTime,4),
      cast(InVehTypeAuto AS char(1)),
      cast(InVehPlateAuto AS char(10)),
      cast(CityNo AS char(4)),
      cast(AreaNo AS char(4)),
      cast(ParkNo AS char(4)),
      cast(GateNo AS char(4)), 
      cast(GateName AS char(8)), 
      cast(LaneNo AS char(4)),
      cast(VehType AS char(1)), 
      cast(VehClass AS char(1)), 
      cast(VehCount AS char(4)), 
      cast(VehPlate AS char(10)), 
      cast(SquadNo AS char(1)), 
      dbo.f_DTtoStr(SquadDate, 5), 
      cast(OperatorNo AS char(10)), 
      cast(OperatorName AS char(8)), 
      cast(ID AS char(16)), 
      cast(IDNo AS char(12)), 
      dbo.f_DTtoStr(OpTime, 4),
      cast(CardBoxNo AS char(8)), 
      cast(CardTrunkNo AS char(8)), 
      cast(TicketType AS char(1)), 
      cast(CardID AS char(16)), 
      cast(CardNo AS char(12)), 
      cast(ObuID AS char(16)), 
      cast(PayCardID AS char(16)), 
      cast(PayCardNo AS char(12)), 
      cast(PayCardType AS char(1)), 
      cast(PayCardBalance AS char(12)), 
      cast(SpEvent AS char(10)), 
      cast(InvoiceID AS char(10)), 
      cast(CashMoney AS char(4)), 
      cast(FreeMoney AS char(4)), 
      cast(UnpayMoney AS char(4)), 
      cast(ETCMoney AS char(4)), 
      cast(VehTypeAuto AS char(1)), 
      cast(VehPlateAuto AS char(10)),
      cast(PriceVerNo AS char(2)), 
      cast(ListName AS char(10)), 
      cast(InParkListNo AS char(16)), 
      cast(AddCashMoney AS char(4)), 
      cast(AddEtcMoney AS char(4)), 
      ETCTradeNo,
      ETCTac, 
      ETCTermTradNo,
      ETCTermCode, 
      cast(BackUp1 AS char(8)), 
      cast(BackUp2 AS char(8)), 
      cast(BackUp3 AS char(8)), 
      cast(BackUp4 AS char(8)),
      VerifyCode
FROM tb_outlist10 
Where ETCMoney<>0 and vehclass=6 and tickettype in (5,6)     


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

create view V_outlist11
( RecordNo,ListNo,InListNo,InGateNo,InGateName,InLaneNo,InVehType,InVehClass,InVehPlate,
  InOperatorNo,InOpTime,InVehTypeAuto,InVehPlateAuto,
  CityNo,AreaNo,ParkNo,GateNo,GateName,LaneNo,VehType,VehClass,VehCount,VehPlate,SquadNo,SquadDate,	
  OperatorNo,OperatorName,ID,IDNo,OpTime,CardBoxNo,CardTrunkNo,
  TicketType,CardID,CardNo,ObuID,PayCardID,PayCardNo,PayCardType,PayCardBalance,
  SpEvent,InvoiceID,CashMoney,FreeMoney,UnpayMoney,ETCMoney,VehTypeAuto,VehPlateAuto,PriceVerNo,
  ListName,InParkListNo,AddCashMoney,AddEtcMoney,ETCTradeNo,ETCTac,TCTermTradNo,ETCTermCode,
  BackUp1,BackUp2,BackUp3,BackUp4,VerifyCode
) 
as 

SELECT 
      cast(RecordNo as char(6)),
      cast(ListNo AS char(16)), 
      cast(InListNo AS char(16)),
      cast(InGateNo AS char(4)),
      cast(InGateName AS char(8)),
      cast(InLaneNo AS char(4)),
      cast(InVehType AS char(1)),
      cast(InVehClass AS char(1)),
      cast(InVehPlate AS char(10)),
      cast(InOperatorNo AS char(10)),
      dbo.f_DTtoStr(InOpTime,4),
      cast(InVehTypeAuto AS char(1)),
      cast(InVehPlateAuto AS char(10)),
      cast(CityNo AS char(4)),
      cast(AreaNo AS char(4)),
      cast(ParkNo AS char(4)),
      cast(GateNo AS char(4)), 
      cast(GateName AS char(8)), 
      cast(LaneNo AS char(4)),
      cast(VehType AS char(1)), 
      cast(VehClass AS char(1)), 
      cast(VehCount AS char(4)), 
      cast(VehPlate AS char(10)), 
      cast(SquadNo AS char(1)), 
      dbo.f_DTtoStr(SquadDate, 5), 
      cast(OperatorNo AS char(10)), 
      cast(OperatorName AS char(8)), 
      cast(ID AS char(16)), 
      cast(IDNo AS char(12)), 
      dbo.f_DTtoStr(OpTime, 4),
      cast(CardBoxNo AS char(8)), 
      cast(CardTrunkNo AS char(8)), 
      cast(TicketType AS char(1)), 
      cast(CardID AS char(16)), 
      cast(CardNo AS char(12)), 
      cast(ObuID AS char(16)), 
      cast(PayCardID AS char(16)), 
      cast(PayCardNo AS char(12)), 
      cast(PayCardType AS char(1)), 
      cast(PayCardBalance AS char(12)), 
      cast(SpEvent AS char(10)), 
      cast(InvoiceID AS char(10)), 
      cast(CashMoney AS char(4)), 
      cast(FreeMoney AS char(4)), 
      cast(UnpayMoney AS char(4)), 
      cast(ETCMoney AS char(4)), 
      cast(VehTypeAuto AS char(1)), 
      cast(VehPlateAuto AS char(10)),
      cast(PriceVerNo AS char(2)), 
      cast(ListName AS char(10)), 
      cast(InParkListNo AS char(16)), 
      cast(AddCashMoney AS char(4)), 
      cast(AddEtcMoney AS char(4)), 
      ETCTradeNo,
      ETCTac, 
      ETCTermTradNo,
      ETCTermCode, 
      cast(BackUp1 AS char(8)), 
      cast(BackUp2 AS char(8)), 
      cast(BackUp3 AS char(8)), 
      cast(BackUp4 AS char(8)),
      VerifyCode
FROM tb_outlist11 
Where ETCMoney<>0 and vehclass=6 and tickettype in (5,6)     


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

create view V_outlist12
( RecordNo,ListNo,InListNo,InGateNo,InGateName,InLaneNo,InVehType,InVehClass,InVehPlate,
  InOperatorNo,InOpTime,InVehTypeAuto,InVehPlateAuto,
  CityNo,AreaNo,ParkNo,GateNo,GateName,LaneNo,VehType,VehClass,VehCount,VehPlate,SquadNo,SquadDate,	
  OperatorNo,OperatorName,ID,IDNo,OpTime,CardBoxNo,CardTrunkNo,
  TicketType,CardID,CardNo,ObuID,PayCardID,PayCardNo,PayCardType,PayCardBalance,
  SpEvent,InvoiceID,CashMoney,FreeMoney,UnpayMoney,ETCMoney,VehTypeAuto,VehPlateAuto,PriceVerNo,
  ListName,InParkListNo,AddCashMoney,AddEtcMoney,ETCTradeNo,ETCTac,TCTermTradNo,ETCTermCode,
  BackUp1,BackUp2,BackUp3,BackUp4,VerifyCode
) 
as 

SELECT 
      cast(RecordNo as char(6)),
      cast(ListNo AS char(16)), 
      cast(InListNo AS char(16)),
      cast(InGateNo AS char(4)),
      cast(InGateName AS char(8)),
      cast(InLaneNo AS char(4)),
      cast(InVehType AS char(1)),
      cast(InVehClass AS char(1)),
      cast(InVehPlate AS char(10)),
      cast(InOperatorNo AS char(10)),
      dbo.f_DTtoStr(InOpTime,4),
      cast(InVehTypeAuto AS char(1)),
      cast(InVehPlateAuto AS char(10)),
      cast(CityNo AS char(4)),
      cast(AreaNo AS char(4)),
      cast(ParkNo AS char(4)),
      cast(GateNo AS char(4)), 
      cast(GateName AS char(8)), 
      cast(LaneNo AS char(4)),
      cast(VehType AS char(1)), 
      cast(VehClass AS char(1)), 
      cast(VehCount AS char(4)), 
      cast(VehPlate AS char(10)), 
      cast(SquadNo AS char(1)), 
      dbo.f_DTtoStr(SquadDate, 5), 
      cast(OperatorNo AS char(10)), 
      cast(OperatorName AS char(8)), 
      cast(ID AS char(16)), 
      cast(IDNo AS char(12)), 
      dbo.f_DTtoStr(OpTime, 4),
      cast(CardBoxNo AS char(8)), 
      cast(CardTrunkNo AS char(8)), 
      cast(TicketType AS char(1)), 
      cast(CardID AS char(16)), 
      cast(CardNo AS char(12)), 
      cast(ObuID AS char(16)), 
      cast(PayCardID AS char(16)), 
      cast(PayCardNo AS char(12)), 
      cast(PayCardType AS char(1)), 
      cast(PayCardBalance AS char(12)), 
      cast(SpEvent AS char(10)), 
      cast(InvoiceID AS char(10)), 
      cast(CashMoney AS char(4)), 
      cast(FreeMoney AS char(4)), 
      cast(UnpayMoney AS char(4)), 
      cast(ETCMoney AS char(4)), 
      cast(VehTypeAuto AS char(1)), 
      cast(VehPlateAuto AS char(10)),
      cast(PriceVerNo AS char(2)), 
      cast(ListName AS char(10)), 
      cast(InParkListNo AS char(16)), 
      cast(AddCashMoney AS char(4)), 
      cast(AddEtcMoney AS char(4)), 
      ETCTradeNo,
      ETCTac, 
      ETCTermTradNo,
      ETCTermCode, 
      cast(BackUp1 AS char(8)), 
      cast(BackUp2 AS char(8)), 
      cast(BackUp3 AS char(8)), 
      cast(BackUp4 AS char(8)),
      VerifyCode
FROM tb_outlist12 
Where ETCMoney<>0 and vehclass=6 and tickettype in (5,6)     


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE   view WhiteListPic 
as 
select
VehPlate,vehPlateImage
from tb_Usercardinfo where vehplateimage is not null
union all
select vehplate,vehplateimage
from tb_testwl where vehplateimage is not null



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

create view tb_AccountCard
as
select a.sys_id as accountNo,u.userName,u.credentialsType,u.credentialsNo,u.address,u.phone,a.lowestBalanceAfterConsume,a.tollyLowestBalanceAC,
a.noEntryBalance,a.lowBalanceNotice,a.status,a.remark,a.cardNo,a.CardType,c.VehPlate,a.status as CardStatus,a.balance as Balance
from t_park_account a,t_park_user u,t_park_car c 
where a.user_id=u.sys_id and a.car_id=c.sys_id and a.statusUpdateTime=(select max(statusUpdateTime) from t_park_account a1 where a1.sys_id=a.sys_id)

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO


create view tb_LaneGroup
as
	Select 1 as LaneGroupNo,LaneNo,LaneTypeNo
	From tb_Lane


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


create view tb_station as select * from tb_park


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

create view v_AccountTrade
as
select *
from tb_AccountTrade01
union all

select *
from tb_AccountTrade02
union all

select *
from tb_AccountTrade03
union all

select *
from tb_AccountTrade04
union all

select *
from tb_AccountTrade05
union all

select *
from tb_AccountTrade06
union all

select *
from tb_AccountTrade07
union all

select *
from tb_AccountTrade08
union all

select *
from tb_AccountTrade09
union all

select *
from tb_AccountTrade10
union all

select *
from tb_AccountTrade11
union all

select *
from tb_AccountTrade12
------------------------------------给缴费卡（储值卡，在卡上写钱的卡）cs充值程序中的卡片转移调用-------------------------------------------------------

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


--十二个月的入口流水记录合集
create view v_AllInList
as
select * from tb_Inlist01
union all
select * from tb_Inlist02
union all
select * from tb_Inlist03
union all
select * from tb_Inlist04
union all
select * from tb_Inlist05
union all
select * from tb_Inlist06
union all
select * from tb_Inlist07
union all
select * from tb_Inlist08
union all
select * from tb_Inlist09
union all
select * from tb_Inlist10
union all
select * from tb_Inlist11
union all
select * from tb_Inlist12

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


--十二个月的出口流水记录合集
create view v_AllOutList
as
select * from tb_outlist01
union all
select * from tb_outlist02
union all
select * from tb_outlist03
union all
select * from tb_outlist04
union all
select * from tb_outlist05
union all
select * from tb_outlist06
union all
select * from tb_outlist07
union all
select * from tb_outlist08
union all
select * from tb_outlist09
union all
select * from tb_outlist10
union all
select * from tb_outlist11
union all
select * from tb_outlist12

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

---所有有效的当次有效的解锁指令视图
create view v_AllValidUnlockCommand as
select u.vehplate,s.cardno,s.starttime,s.endtime,s.optime,s.validtype
from tb_usercardinfo u,tb_securitycommand s
where u.cardno = s.cardno and s.type = 2 and s.attribute = 0

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

CREATE   view [dbo].[v_LimitParkInfo]
as
select 1 as gateno , 1 as laneno, cardno, 'A4' as remark from 
(select Substring(parkingspace, 1, patindex('%-%', parkingspace)-1) as parkingspace, cardno
from (select parkingspace, cardno from tb_usercardinfo where parkingspace is not null and parkingspace <> '0') t1
) t2 where parkingspace in('B1', 'B5', 'B11', 'B8', 'A4')

union all

select 5 as gateno , 5 as laneno, cardno, 'A5' as remark from 
(select Substring(parkingspace, 1, patindex('%-%', parkingspace)-1) as parkingspace, cardno
from (select parkingspace, cardno from tb_usercardinfo where parkingspace is not null and parkingspace <> '0') t1
) t2 where parkingspace in('A5', 'C9', 'C1', 'D1')

union all


select 34 as gateno , 34 as laneno, cardno, 'D4' as remark from 
(select Substring(parkingspace, 1, patindex('%-%', parkingspace)-1) as parkingspace, cardno
from (select parkingspace, cardno from tb_usercardinfo where parkingspace is not null and parkingspace <> '0') t1
) t2 where parkingspace in('A5', 'C9', 'C1', 'D1')

union all

select 59 as gateno , 59 as laneno, cardno, 'E9' as remark from 
(select Substring(parkingspace, 1, patindex('%-%', parkingspace)-1) as parkingspace, cardno
from (select parkingspace, cardno from tb_usercardinfo where parkingspace is not null and parkingspace <> '0') t1
) t2 where parkingspace in('E1', 'F1', 'G1')


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

create view [dbo].[v_ShowInfo]
as
	select g.ParkNo,g.GateNo,g.LaneNo,g.InitShow,g.IsShowPosition,c.CarCount as UseCnt, c.MaxSpace as TotalCnt 
	from tb_CarSpaceShowMessage g,tb_CarSpace c 
	where g.ParkNo=c.ParkNo and  c.GateNo!='all' and g.GateNo=c.GateNo
	union all
	select g.ParkNo,g.GateNo,g.LaneNo,g.InitShow,g.IsShowPosition,c.CarCount as UseCnt, c.MaxSpace as TotalCnt 
	from tb_CarSpaceShowMessage g,tb_CarSpace c 
	where g.ParkNo=c.ParkNo and  g.GateNo not in(select GateNo from tb_CarSpace where GateNo!='all') and c.GateNo='all'

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE VIEW v_SpVehHandle
AS
SELECT tb_SpVehHandle.TableName, tb_SpVehHandle.Status as SpecialType,
tb_SpecialType.TypeName as Status, tb_SpVehHandle.HandleType,
tb_HandleType.TypeName as Handle, tb_SpVehHandle.Hint
FROM tb_SpVehHandle, tb_SpecialType, tb_HandleType
WHERE tb_SpVehHandle.HandleType = tb_HandleType.TypeCode
AND tb_SpVehHandle.Status = tb_SpecialType.TypeCode

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE VIEW v_SpecialVeh
AS
SELECT tb_SpecialVeh.VehPlate, tb_SpecialVeh.CardNo,
tb_SpecialVeh.SpecialType, tb_SpecialType.TypeName as Special
FROM tb_SpecialVeh, tb_SpecialType
WHERE tb_SpecialVeh.SpecialType = tb_SpecialType.TypeCode

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


--账户信息视图v_account

CREATE VIEW [dbo].[v_account]
AS
SELECT         a.sys_id AS accountNo, u.userName, u.credentialsType, u.credentialsNo, 
                          u.address, u.phone, a.lowestBalanceAfterConsume, a.tollyLowestBalanceAC, 
                          a.noEntryBalance, a.lowBalanceNotice, a.status, a.remark
FROM             dbo.t_park_account a INNER JOIN
                          dbo.t_park_user u ON a.user_id = u.sys_id

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


--车卡账户绑定视图v_accountCard

CREATE VIEW [dbo].[v_accountCard]
AS
SELECT         a.sys_id AS accountNo, a.cardNo, a.cardType, c.vehPlate, a.status, 
                          a.remark
FROM             dbo.t_park_account a INNER JOIN
                          dbo.t_park_car c ON a.car_id = c.sys_id

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE view v_securitycommand AS
select Owner,CallNum,OwnerVehPlate.VehPlate,OwnerVehPlate.CardNo,Type,ValidType,UseType,StartTime,EndTime,OpTime,Attribute,Status
from
    (select uc.Owner,uc.CardNo,uc.VehPlate 
	from tb_UserCardInfo uc
		where uc.VehPlate in (select distinct uc2.VehPlate 
			from tb_UserCardInfo uc2,tb_SecurityUserInfo su2,tb_SecurityCommand sc2
			where sc2.Attribute=0 and sc2.Status=0 and su2.IsValid=1 and sc2.CardNo=su2.CardNo and su2.CardNo=uc2.CardNo))as OwnerVehPlate
    left join
    (select uc.VehPlate,su.CallNum,sc.*
	from tb_UserCardInfo uc,tb_SecurityUserInfo su,tb_SecurityCommand sc
	where sc.Attribute=0 and sc.Status=0 and su.IsValid=1 and sc.CardNo=su.CardNo and su.CardNo=uc.CardNO) as VehPlateSecurity
	on OwnerVehPlate.VehPlate=VehPlateSecurity.VehPlate
GO
--无测试视图的白名单视图
CREATE VIEW [dbo].[V_WHITELISTNOTESTWL] AS 
SELECT * FROM 
(
	--费用截止时间不计时分秒，所以+1天
	SELECT A.CARDNO, A.VEHPLATE, A.OWNER AS OWNERNAME,A.OBU AS OBUID,
		CASE WHEN B.STARTTIME IS NULL THEN A.REGISTERTIME ELSE B.STARTTIME END AS FIRTIME, 
		CASE WHEN B.ENDTIME IS NULL THEN A.REGISTERTIME ELSE B.ENDTIME+1 END AS INVALIDATETIME,
		A.UserCardType AS CARDTYPE, 
		CASE WHEN A.STATUS=0 AND (B.ENDTIME IS NULL OR B.ENDTIME<CONVERT(CHAR(10),GETDATE(),120)) THEN 9 ELSE A.STATUS END AS STATUS,
		CASE WHEN VehPlateImage IS NULL THEN 0 ELSE 1 END AS HasVehPic,A.FeeRuleType
	FROM TB_USERCARDINFO  A 
	LEFT JOIN 
	(
		--在跨月缴费的情况下，本SQL可能会有错误
		SELECT USERRECNO, MIN(STARTTIME) AS STARTTIME, MAX(ENDTIME) AS ENDTIME FROM TB_USERCARDBILL 
			WHERE convert(char(10),GETDATE(),120) BETWEEN STARTTIME AND ENDTIME OR STARTTIME>convert(char(10),GETDATE(),120)
			GROUP BY USERRECNO
		UNION ALL
		SELECT USERRECNO, MAX(STARTTIME) as STARTTIME, MAX(ENDTIME) AS ENDTIME FROM TB_USERCARDBILL
		GROUP BY USERRECNO HAVING MAX(ENDTIME) < convert(char(10),GETDATE(),120)
	) B ON A.RECNO = B.USERRECNO
	WHERE A.UserCardType=14 --月租卡
	UNION ALL
	SELECT A.CARDNO, A.VEHPLATE, A.OWNER AS OWNERNAME,A.OBU AS OBUID,GETDATE()-30 AS FIRTIME, GETDATE()+1000 AS INVALIDATETIME,
		A.UserCardType AS CARDTYPE, A.STATUS, CASE WHEN A.VehPlateImage IS NULL THEN 0 ELSE 1 END AS HasVehPic,A.FeeRuleType
	FROM TB_USERCARDINFO A
	WHERE A.UserCardType=13	--业主卡
	union all 
	SELECT CARDNO, VEHPLATE, OWNERName , OBUID, GETDATE()-30 AS FIRTIME, GETDATE()+1000 AS INVALIDATETIME,
		13 as Usetype, 0 as Status, CASE WHEN VehPlateImage IS NULL THEN 0 ELSE 1 END AS HasVehPic,0 AS FeeRuleType
	FROM tb_testwl
	
) TMP


GO

