--��ʦ���ݿⴴ�����ӷ��������ݿ�
exec   sp_addlinkedserver     'yuehai', ' ', 'SQLOLEDB ', '10.173.235.231' 
exec   sp_addlinkedsrvlogin   'yuehai', 'false ',null, 'sa', 'hgrica1@' 
--exec   sp_dropserver   'yuehai ', 'droplogins ' 


--��������ʱ��˫��ͬ����/��ʦ����������Ҫ���˱�
CREATE TABLE [dbo].[tb_WhiteListTmp](
	[CardNo] [char](16) NOT NULL,
	[VehPlate] [char](10) NOT NULL,
	[OwnerName] [char](32) NULL,
	[ObuId] [char](16) NULL,
	[FirstTime] [datetime] NULL,
	[InvalidateTime] [datetime] NULL,
	[CardType] [smallint] NULL,
	[Status] [smallint] NULL,
	[HASVEHPIC] [smallint] NOT NULL,
	[FeeRuleType] [smallint] NOT NULL,
 CONSTRAINT [PK_WhiteListTmp] PRIMARY KEY CLUSTERED 
(
	[CardNo] ASC,
	[VehPlate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO




--�˵�������Ա����ͬ���洢���̣�����ͬ��������ͬ������ʦ��
--ֻ���ڻ�ʦ���ݿⴴ���˴洢����
--ʵʩʱ�����ݿ�ȫ����Ϊ�ֳ����ݿ��� (��ȥ�������������ݿ�ǰ׺����hpg_parkdb�ĳ�parkdb)
create proc proc_synLaneOperator as
 --��ͬ��������Ա��ɫ��
 insert into parkdb.dbo.tb_OperatorRole
 select * from yuehai.parkdb.dbo.tb_OperatorRole OperatorRole
 where OperatorRole.OperatorNo in(
  select t1.OperatorNo from  yuehai.parkdb.dbo.tb_operator t1
 where not exists(
 select * from parkdb.dbo.tb_Operator t2 
 where t2.OperatorNo = t1.OperatorNo))
 --ͬ������������Ա��
 insert into parkdb.dbo.tb_Operator
 select * from yuehai.parkdb.dbo.tb_operator t1
 where not exists(
 select * from parkdb.dbo.tb_Operator t2 
 where t2.OperatorNo = t1.OperatorNo)
 go

 
 --�������洢����
 --ֻ���ڻ�ʦ���ݿⴴ���˴洢����
create proc proc_synWhiteList as
 --ɾ����ʦ��������ʱ��
begin
declare @count int
set @count = (select COUNT(*) from yuehai.parkdb.dbo.v_whiteList t1
where not exists (select * from parkdb.dbo.V_WHITELIST t2 where t1.CARDNO =t2.CardNo))
if @count>0
begin
delete from parkdb.dbo.tb_WhiteListTmp
--�������İ��������뻪ʦ�İ�������ʱ������շѰ�����(��feeRuleType ��Ϊ2������������feeRuleType�� 0 Ϊ��ҹ�� ��1������ҹ����>1��ͨУ�ڳ���
insert into parkdb.dbo.tb_WhiteListTmp (cardNO,VehPlate,ownerName,ObuId,FirstTime,InvalidateTime,CardType,Status,HasVehPic,FeeRuleType)
select t1.CARDNO,t1.VEHPLATE,t1.OWNERNAME,t1.OBUID,t1.FIRTIME,t1.INVALIDATETIME,t1.CARDTYPE,t1.STATUS,t1.HasVehPic,2 from yuehai.parkdb.dbo.v_whiteList t1
where not exists (select * from parkdb.dbo.V_WHITELIST t2 where t1.CARDNO =t2.CardNo)
--��ʦ�·�������
insert into parkdb.dbo.tb_SendPara select 1,0,0,laneno,laneComputerIP,'V_WhiteList','V_WhiteList' from tb_LaneUse
end
set @count = (select COUNT(*) from parkdb.dbo.V_WHITELIST t3
where not exists (select * from yuehai.parkdb.dbo.v_whiteList t4 where t4.CARDNO = t3.CARDNO))
if(@count>0)
begin
--ɾ�������İ�������ʱ��
delete from yuehai.parkdb.dbo.tb_WhiteListTmp
--����ʦ�İ��������������İ�������ʱ������շѰ�����
insert into yuehai.parkdb.dbo.tb_WhiteListTmp(cardNO,VehPlate,ownerName,ObuId,FirstTime,InvalidateTime,CardType,Status,HasVehPic,FeeRuleType)
select t3.CARDNO,t3.VEHPLATE,t3.OWNERNAME,t3.OBUID,t3.FIRTIME,t3.INVALIDATETIME,t3.CARDTYPE,t3.STATUS,t3.HasVehPic,2 from parkdb.dbo.V_WHITELIST t3
where not exists (select * from yuehai.parkdb.dbo.v_whiteList t4 where t4.CARDNO = t3.CARDNO)
--�����·�������
insert into yuehai.parkdb.dbo.tb_SendPara select 1,0,0,laneno,laneComputerIP,'V_WhiteList','V_WhiteList' from yuehai.parkdb.dbo.tb_LaneUse
end
end 

 --�������洢����(�޸İ棩
 --ֻ���ڻ�ʦ���ݿⴴ���˴洢����
create proc proc_synWhiteList as
 --ɾ����ʦ��������ʱ��
begin
declare @count1 int,@count2 int,@num1 int,@num2 int
set @count1 = (select COUNT(*) from yuehai.parkdb.dbo.v_whiteList t1
where not exists (select * from parkdb.dbo.V_WHITELIST t2 where t1.CARDNO =t2.CardNo and t1.status = t2.status))
set @count2 = (select COUNT(*) from parkdb.dbo.V_WHITELIST t3
where not exists (select * from yuehai.parkdb.dbo.v_whiteList t4 where t4.CARDNO = t3.CARDNO and t3.status = t4.status))
set @num1 = (select COUNT(*) from yuehai.parkdb.dbo.v_whiteList)
set @num2 = (select COUNT(*) from v_whiteList)
if ((@count1+@count2<>0) OR (@num1-@num2<>0))
begin
delete from parkdb.dbo.tb_WhiteListTmp
--�������İ��������뻪ʦ�İ�������ʱ������շѰ�����(��feeRuleType ��Ϊ2������������feeRuleType�� 0 Ϊ��ҹ�� ��1������ҹ����>1��ͨУ�ڳ���
insert into parkdb.dbo.tb_WhiteListTmp (cardNO,VehPlate,ownerName,ObuId,FirstTime,InvalidateTime,CardType,Status,HasVehPic,FeeRuleType)
select t1.CARDNO,t1.VEHPLATE,t1.OWNERNAME,t1.OBUID,t1.FIRTIME,t1.INVALIDATETIME,t1.CARDTYPE,t1.STATUS,t1.HasVehPic,2 from yuehai.parkdb.dbo.v_whiteList t1
where t1.CARDNO not in(select t2.CardNO  from yuehai.parkdb.dbo.tb_WhiteListTmp t2 )
--��ʦ�·�������
delete from tb_sendPara where tableName ='V_WhiteList'
insert into parkdb.dbo.tb_SendPara select 1,0,0,laneno,laneComputerIP,'V_WhiteList','V_WhiteList' from tb_LaneUse
--ɾ�������İ�������ʱ��
delete from yuehai.parkdb.dbo.tb_WhiteListTmp
--����ʦ�İ��������������İ�������ʱ������շѰ�����
insert into yuehai.parkdb.dbo.tb_WhiteListTmp(cardNO,VehPlate,ownerName,ObuId,FirstTime,InvalidateTime,CardType,Status,HasVehPic,FeeRuleType)
select t3.CARDNO,t3.VEHPLATE,t3.OWNERNAME,t3.OBUID,t3.FIRTIME,t3.INVALIDATETIME,t3.CARDTYPE,t3.STATUS,t3.HasVehPic,2 from parkdb.dbo.V_WHITELIST t3
where t3.cardNo not in (select t4.CardNO  from parkdb.dbo.tb_WhiteListTmp t4)
--�����·�������
delete from yuehai.parkdb.dbo.tb_sendPara where tableName ='V_WhiteList'
insert into yuehai.parkdb.dbo.tb_SendPara select 1,0,0,laneno,laneComputerIP,'V_WhiteList','V_WhiteList' from yuehai.parkdb.dbo.tb_LaneUse
end
end 

--ͬ����ʱ���洢����
create proc proc_synCardInfo 
as
begin 
	insert into yuehai.parkdb.dbo.tb_CardInfo 
	select * from parkdb.dbo.tb_CardInfo A where not exists (select * from yuehai.parkdb.dbo.tb_cardInfo B where A.CardNO = B.CardNo)
end



--�޸İ�������ͼ
--��������ʦ�������½�������ͼ
create VIEW [dbo].[V_WHITELIST] AS 
SELECT * FROM 
(
	--���ý�ֹʱ�䲻��ʱ���룬����+1��
	SELECT A.CARDNO, A.VEHPLATE, A.OWNER AS OWNERNAME,A.OBU AS OBUID,
		CASE WHEN B.STARTTIME IS NULL THEN A.REGISTERTIME ELSE B.STARTTIME END AS FIRTIME, 
		CASE WHEN B.ENDTIME IS NULL THEN A.REGISTERTIME ELSE B.ENDTIME+1 END AS INVALIDATETIME,
		A.UserCardType AS CARDTYPE, 
		CASE WHEN A.STATUS=0 AND (B.ENDTIME IS NULL OR B.ENDTIME<CONVERT(CHAR(10),GETDATE(),120)) THEN 9 ELSE A.STATUS END AS STATUS,
		CASE WHEN VehPlateImage IS NULL THEN 0 ELSE 1 END AS HasVehPic,A.FeeRuleType
	FROM TB_USERCARDINFO  A 
	LEFT JOIN 
	(
		--�ڿ��½ɷѵ�����£���SQL���ܻ��д���
		SELECT USERRECNO, MIN(STARTTIME) AS STARTTIME, MAX(ENDTIME) AS ENDTIME FROM TB_USERCARDBILL 
			WHERE convert(char(10),GETDATE(),120) BETWEEN STARTTIME AND ENDTIME OR STARTTIME>convert(char(10),GETDATE(),120)
			GROUP BY USERRECNO
		UNION ALL
		SELECT USERRECNO, MAX(STARTTIME) as STARTTIME, MAX(ENDTIME) AS ENDTIME FROM TB_USERCARDBILL
		GROUP BY USERRECNO HAVING MAX(ENDTIME) < convert(char(10),GETDATE(),120)
	) B ON A.RECNO = B.USERRECNO
	WHERE A.UserCardType=14 --���⿨
	UNION ALL
	SELECT A.CARDNO, A.VEHPLATE, A.OWNER AS OWNERNAME,A.OBU AS OBUID,CASE WHEN A.REGISTERTIME IS NULL THEN GETDATE() - 120 ELSE A.REGISTERTIME END AS FIRTIME,
	 GETDATE()+1000 AS INVALIDATETIME,A.UserCardType AS CARDTYPE, A.STATUS, CASE WHEN A.VehPlateImage IS NULL THEN 0 ELSE 1 END AS HasVehPic,A.FeeRuleType
	FROM TB_USERCARDINFO A
	WHERE A.UserCardType=13	--ҵ����
	union all 
	SELECT CARDNO, VEHPLATE, OWNERName , OBUID, GETDATE()-120 AS FIRTIME, GETDATE()+1000 AS INVALIDATETIME,
		13 as Usetype, 0 as Status, CASE WHEN VehPlateImage IS NULL THEN 0 ELSE 1 END AS HasVehPic,0 AS FeeRuleType
	FROM tb_testwl
	union all 
	select * from tb_WhiteListTmp
	
) TMP





