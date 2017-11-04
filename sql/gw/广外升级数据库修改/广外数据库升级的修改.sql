-->�޸Ĺ�����־��2011-08-09��
GO
alter table tb_SquadLog alter column OperatorName char(8);
GO
alter table tb_SquadLog alter column ID char(16);


--�����������ñ�tb_PriceBase����Ϊ�����ݿ�ͳһ������û�ã�
GO
CREATE TABLE tb_PriceBase(
	VerNo int NOT NULL,
	FeeNo int NOT NULL,
	RebateType int NOT NULL,
	InOutSign int NOT NULL,
	TimesSign int NOT NULL,
	VehTypeNo int NOT NULL,
	AllowStayTime int NULL,
	BaseFeeTime int NULL,
	BaseFee int NULL,
	StayAdd int NULL,
	AddFee int NULL,
	AddStart int NULL,
	MaxFee int NULL,
	MaxTime int NULL,
	MaxFeeTime int NULL,
	SumFeeCtr int NULL,
	backup1 char(16) NULL,
	backup2 char(16) NULL,
	StartTime datetime NULL,
	Remark char(50) NULL,
    CONSTRAINT PK_PriceBase PRIMARY KEY CLUSTERED (VerNo ASC,FeeNo ASC,RebateType ASC,InOutSign ASC,TimesSign ASC,VehTypeNo ASC)
)

-->�������ʹ����[���]��tb_pricerule_zd����Ϊ�����ݿ�ͳһ������û�ã�
GO
CREATE TABLE tb_PriceRule_zd(
	FeeRuleType int NOT NULL,
	VehTypeNo int NOT NULL,
	FeeOfOneCycle int NULL,
	FreeTimes int NULL,
	MaxFreeTimesUsedEveryTimes int NULL,
	ValidateTrim int NULL,
	InvalidateTrim int NULL,
	remark char(50) NULL,
	MaxTotalFee int NULL,
 CONSTRAINT PK_PriceRule_zd PRIMARY KEY CLUSTERED (FeeRuleType ASC,VehTypeNo ASC)
)
-->����������ڱ�tb_FreeDays�����㽭��ѧ���ã�Ϊ�����ݿ�ͳһ������û�ã�
GO
CREATE TABLE tb_FreeDays(
	FeeRuleType int NULL,
	Type int NULL,
	Value char(10) NULL
) 
-->����ڱ�־��tb_InOutSignDef��(�㽭��ѧ���ã�Ϊ�����ݿ�ͳһ������û�ã�
GO
CREATE TABLE tb_InOutSignDef(
	InGateNo int NOT NULL,
	OutGateNo int NOT NULL,
	InOutSign int NULL,
	Remark char(16) NULL,
    CONSTRAINT PK_InOutSignDef PRIMARY KEY CLUSTERED (InGateNo ASC,OutGateNo ASC)
 )
-->ʱ���־��tb_TimesSignDef��(�㽭��ѧ���ã�Ϊ�����ݿ�ͳһ������û�ã�
GO
CREATE TABLE tb_TimesSignDef(
	FeeRuleType int NOT NULL,
	DayType int NOT NULL,
	StartTime char(8) NOT NULL,
	EndTime char(8) NULL,
	TimesSign int NULL,
	Remark char(50) NULL,
    CONSTRAINT PK_TimesSignDef PRIMARY KEY CLUSTERED (FeeRuleType ASC,DayType ASC,StartTime ASC)
)
GO
--�����ʺ���Ϣ��
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[t_park_account]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table t_park_account
GO
create table t_park_account
(
	sys_id int identity(1,1),
	status int not null,
	user_id int,
	car_id int,
	cardNo varchar(20) not null,
	cardType int not null,
	parkNo int null,
	cost int not null,
	balance int null,
	lowestBalanceAfterConsume int not null,
	tollyLowestBalanceAC int not null,
	noEntryBalance int,
	lowBalanceNotice int,
	openAccountTime datetime,
	statusUpdateTime datetime,
	remark varchar(100),
	constraint pk_pams_accountNo primary key(sys_id),
)

GO

--����������Ϣ��
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[t_park_car]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table t_park_car
GO
create table t_park_car
(
	sys_id int identity(1,1),
	vehPlate varchar(10) not null,
	carType int,
	carColour varchar(50),
	constraint pk_pams_car_id primary key(sys_id),
)
GO

--����ϵͳ���ñ�
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[t_park_config]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table t_park_config
GO
create table t_park_config
(
   id               int identity(1,1) primary key,
   siteName         varchar(100),
   propertyName     varchar(50),
   company          varchar(200),
   copyright        varchar(255),
   recordCode       varchar(255),
   email            varchar(100),
   phone            varchar(200),
   mobile           varchar(200)   
)
GO

--��ʼ��ϵͳ���ñ�����
insert into t_park_config values('С��������������ϵͳ','С��','С��','Copyright &copy;2007-2009 www.flc.com, All Rights Reserved','��ICP֤030173��','liu@hgrica.com','02087113968','13632338888')
GO

--ϵͳ�������ñ�
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[t_park_sysparamconf]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table t_park_sysparamconf
GO
create table t_park_sysparamconf
(
	sys_id int  identity(1,1),
	pname varchar (50)  NOT NULL ,
	pvalue varchar (200)  NOT NULL ,
	ptype  int NOT NULL ,
	remark varchar (150) ,
	constraint pk_pams_sysparamconf_id primary key (sys_id)  
) 
create unique index index_pams_pname on t_park_sysparamconf(pname)
GO

--ϵͳ�������ñ����ݳ�ʼ��
insert into t_park_sysparamconf values('AreaNo','4430',0,'������')
insert into t_park_sysparamconf values('ParkNo','103',0,'С�����')
insert into t_park_sysparamconf values('parkReport','gw',0,'��cardInfoReport���Ǹ�У����jsp�ļ������ֵΪhg������cardInfoReprot�ļ����µ�hg�ļ����е�jsp����ʼֵΪhg')
insert into t_park_sysparamconf values('card_type','0',0,'�����Ͳ�����0���Ǽ��˿���1���Ǵ�ֵ��,���ֵ����0����1�ͳ�ʼ��Ϊ0. û���������ϵͳ�Զ���ӣ���ʼ��ֵΪ0)')
insert into t_park_sysparamconf values('endAccount_amongTime','0',0,'����������������ʱ��������ֵҪ�����֣�����ϵͳ��ʼ��Ϊ0�죨û��endAccount_amongTime����ϵͳҲ��ʼ��Ϊ0��)')
insert into t_park_sysparamconf values('addAccount_LowestBalanceAfterConsume','0',0,'�����е��������λ��Ԫ��������ֵҪ����������0�����磺10��С�������Ϊ2λ��������λʱ��ֱ�ӰѺ����С����ȥ�㣩�������ʼ��Ϊ0��')
insert into t_park_sysparamconf values('addAccount_TollyLowestBalanceAC','0',0,'�����еļ����������λ��Ԫ��������ֵҪ����������0�����磺10��С�������Ϊ2λ��������λʱ��ֱ�ӰѺ����С����ȥ�㣩�������ʼ��Ϊ0��')
insert into t_park_sysparamconf values('addAccount_NoEntryBalance','15',0,'�����еĽ�ֹʻ���������λ��Ԫ��������ֵҪ����������0�����磺15��С�������Ϊ2λ��������λʱ��ֱ�ӰѺ����С����ȥ�㣩������ϵͳ��ʼ��Ϊ15��')
insert into t_park_sysparamconf values('addAccount_LowBalanceNotice','50',0,'�����е���ʾ�û�ȥ���ѵ��������λ��Ԫ��������ֵҪ����������0��С�������Ϊ2λ��������λʱ��ֱ�ӰѺ����С����ȥ�㣩������ϵͳ��ʼ��Ϊ50��')
insert into t_park_sysparamconf values('addAccount_Cost','0',0,'���������ѣ���λ��Ԫ��������ֵҪ����������0�����磺10��С�������Ϊ2λ��������λʱ��ֱ�ӰѺ����С����ȥ�㣩�������ʼ��Ϊ0��')
insert into t_park_sysparamconf values('CardRechargeSystem_path','C:\�û�����ֵ\CardRechargeSystem.exe',0,'��ֵ����ֵ�ͳ������·����û�����ǳ�ʼ��ΪC:/��ֵ�ͳ���/CardRechargeSystem.exe')
insert into t_park_sysparamconf values('whtherPayType','0',0,'�Ƿ��нɷ����Ͳ�����0��ʾ�нɷ����ͣ�1��ʾû�нɷ�����,���ֵ����0����1�ͳ�ʼ��Ϊ0. û���������ϵͳ�Զ���ӣ���ʼ��ֵΪ0)')
insert into t_park_sysparamconf values('TIME_updateUserCarInfoStatusTask','2011-04-13_00:00:00',0,'ÿ�춨ʱ���Ĺ���У԰���˻�״̬�ͽɷ����ޡ���2011-04-13_00:00:00,��ʾ��ǰʱ����ڻ��ߵ���2011��4��13��ʱ��00��00��00ִ�У���')
insert into t_park_sysparamconf values('accountCardNoLength','10',0,'�ɷѿ��˻�����ģ�������ƿ��ŵĳ��ȣ�ֵΪ<=0��>=10��ֵ��Ϊ����ʱ���Ȳ��ܳ���10��ֵΪ������ʱ���ų���ֻ�ܵ�����ֵ�����磺ֵΪ9�򿨺ų���ֻ��Ϊ9����')
insert into t_park_sysparamconf values('parkjsp','gw',0,'��parkCard�Ǹ�У����jsp�ļ���ֵΪhg��������parkCard�ļ��µ�hg�ļ����е�jsp����ʼֵΪhg��')
insert into t_park_sysparamconf values('userCardInfoCardNoLength','10',0,'У԰������ģ�������ƿ��ŵĳ��ȣ�ֵΪ<=0��>=10��ֵ��Ϊ����ʱ���Ȳ��ܳ���10��ֵΪ������ʱ���ų���ֻ�ܵ�����ֵ�����磺ֵΪ9�򿨺ų���ֻ��Ϊ9��')
insert into t_park_sysparamconf values('vehPlate','D:\Jpeg\',0,'Ϊ��ѯ����׽��ͼƬ�ṩ·��')
insert into t_park_sysparamconf values('CardInit_path','C:/IC���Ǽǳ���/CardInit.exe',0,'IC���Ǽǳ���·������ʼ������ΪC:/IC���Ǽǳ���/CardInit.exe')
--insert into t_park_sysparamconf values('SWL_KEY','7#26hgrica1@62#7',0,'��������ϵͳ���ù����ܳף������޸ġ�')
--insert into t_park_sysparamconf values('SWL_InputFileName','sysConfig.dll',0,'��������ϵͳ���ù������������ļ����ƣ��������޸ġ�')
GO
delete from tb_FreeDays
insert into tb_FreeDays values(4,0,'6')
insert into tb_FreeDays values(4,0,'7')
GO
--����ϵͳ��־��
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[t_park_systemLog]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table t_park_systemLog
GO
create table t_park_systemLog
(
	sys_id int identity(1,1),
	logTime datetime not null,
	logType int not null,
	operatorID int not null,
	logData	varchar(400) not null,
	coverage varchar(400),
	remark varchar(400),
	constraint pk_pams_systemLog_id primary key(sys_id),
)
GO

--���������ʺ���־��
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[t_park_updateAccountLog]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table t_park_updateAccountLog
GO
create table t_park_updateAccountLog
(
	accountNo int,
	seqNo int,
	status int not null,
	cardNo varchar(20) not null,
	cost int not null,
	lowestBalanceAfterConsume int not null,
	tollyLowestBalanceAC int not null,
	noEntryBalance int,
	lowBalanceNotice int,
	openAccountTime datetime,
	statusUpdateTime datetime,
	remark varchar(100),
	user_id int,
	userName varchar(50),
	credentialsType int,
	credentialsNo varchar(50),
	phone varchar(50),
	mobileNumber varchar(50),
	address varchar(120),
	car_id int,
	vehPlate varchar(10),
	carType int,
	carColour varchar(50),
	updateTime datetime,
	operator_id int,
	operatorName varchar(50),
	printNumber int,
	updateRemark varchar(100),
	constraint pk_pams_updateAccountLog_id primary key(accountNo,seqNo),
)
GO

--�����û���Ϣ��
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[t_park_user]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table t_park_user
GO
create table t_park_user
(
	sys_id int,
	userName varchar(50) not null,
	credentialsType int,
	credentialsNo varchar(50),
	phone varchar(50),
	mobileNumber varchar(50),
	address varchar(120),
	constraint pk_pams_user_id primary key(sys_id),
)
GO
--------------------------------------------------------------------------------------
--�����˻���Ϣ��ͼv_account��ֻ���㽭��ѧ���ã�Ϊ�����ݿ�ͳһ��
--�ж���ͼv_account�Ƿ���ڣ�������ɾ��
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[v_account]') and OBJECTPROPERTY(id,N'IsView') = 1)    
  --   ɾ����ͼ    
  drop view [dbo].[v_account]    
GO
GO

/****** Object:  View [dbo].[v_account]    Script Date: 06/23/2011 09:13:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--�˻���Ϣ��ͼv_account

CREATE VIEW [dbo].[v_account]
AS
SELECT         a.sys_id AS accountNo, u.userName, u.credentialsType, u.credentialsNo, 
                          u.address, u.phone, a.lowestBalanceAfterConsume, a.tollyLowestBalanceAC, 
                          a.noEntryBalance, a.lowBalanceNotice, a.status, a.remark
FROM             dbo.t_park_account a INNER JOIN
                          dbo.t_park_user u ON a.user_id = u.sys_id
GO
--------------------------------------------------------------------------------------
--���������˻�����ͼv_accountCard��ֻ���㽭��ѧ���ã�Ϊ�����ݿ�ͳһ��
--�жϳ����˻�����ͼv_accountCard�Ƿ���ڣ�������ɾ��
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[v_accountCard]') and OBJECTPROPERTY(id,N'IsView') = 1)    
  --   ɾ����ͼ    
  drop view [dbo].[v_accountCard]    
GO
GO

/****** Object:  View [dbo].[v_accountCard]    Script Date: 06/23/2011 09:15:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--�����˻�����ͼv_accountCard

CREATE VIEW [dbo].[v_accountCard]
AS
SELECT         a.sys_id AS accountNo, a.cardNo, a.cardType, c.vehPlate, a.status, 
                          a.remark
FROM             dbo.t_park_account a INNER JOIN
                          dbo.t_park_car c ON a.car_id = c.sys_id
GO

--�˻���Ϣ�·�������ͼ��ֻ�и��������ã�Ϊ�����ݿ�ͳһ��
--�ж���ͼtb_AccountCard�Ƿ���ڣ�������ɾ��
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_AccountCard]') and OBJECTPROPERTY(id,N'IsView') = 1)    
  --   ɾ����ͼ    
  drop view [dbo].[tb_AccountCard]    
GO
create view tb_AccountCard
as
select a.sys_id as accountNo,u.userName,u.credentialsType,u.credentialsNo,u.address,u.phone,a.lowestBalanceAfterConsume,a.tollyLowestBalanceAC,
a.noEntryBalance,a.lowBalanceNotice,a.status,a.remark,a.cardNo,a.CardType,c.VehPlate,a.status as CardStatus,a.balance as Balance
from t_park_account a,t_park_user u,t_park_car c 
where a.user_id=u.sys_id and a.car_id=c.sys_id and a.statusUpdateTime=(select max(statusUpdateTime) from t_park_account a1 where a1.sys_id=a.sys_id)
GO
--------------------------------------------------------------------------------------


--��������ģ��--------------------------------------------------------------------------------------
--exec sp_helpconstraint tb_Squad;--�鿴��Լ��
--GO

--С����Ϣ��
GO
alter table tb_Park alter column ParkName char(20) null
GO

-->������Ϣ��
alter table tb_Gateway alter column GateName char(20) null
GO

-->������Ϣ��
alter table tb_Squad alter column SquadName char(20) null
GO

--���ó�����Ϣ��
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_LaneUse]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table tb_LaneUse
GO
CREATE TABLE tb_LaneUse(
	AreaNo smallint NOT NULL,
	ParkNo smallint NOT NULL,
	GateNo smallint NOT NULL,
	LaneNo smallint NOT NULL,
	LaneComputerIP char(15) NULL,
 	CONSTRAINT PK_LaneUse PRIMARY KEY CLUSTERED (AreaNo ASC,ParkNo ASC,GateNo ASC,LaneNo ASC))
go
insert into tb_LaneUse(AreaNo,ParkNo,GateNo,LaneNo,LaneComputerIP) select AreaNo,ParkNo,GateNo,LaneNo,LaneComputerIP from tb_Lane 

GO

--ϵͳ������
alter table tb_SystemPara alter column ItemValue varchar(100) null
GO
alter table tb_SystemPara  add  SendControl tinyint null
GO
update tb_SystemPara set SendControl=1 where ParaClass=1 

Go
--������Ϣ��ʾ��ͼ��v_ShowInfo)(Ϊ�����ݿ�ͳһ��Ŀǰֻ�и������ã�
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[v_ShowInfo]') and OBJECTPROPERTY(id,N'IsView') = 1)    
  --   ɾ����ͼ    
  drop view [dbo].[v_ShowInfo]    
GO
create view [dbo].[v_ShowInfo]
as
select case when InitShow is null then '' else InitShow end as InitShow, 
	IsShowPosition, UseCnt, TotalCnt
from 
(
	select (select top 1 itemvalue  from tb_systempara where paraclass=0 and item='CarSpaceMsg' ) as InitShow,
		'1' as IsShowPosition, CarCount as UseCnt, MaxSpace as TotalCnt
	from tb_CarSpace 
) tmp
GO

--���ն����ֻ�и���ʹ�ã�
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_HoliDayDef]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table tb_HoliDayDef
GO
CREATE TABLE tb_HoliDayDef(
	Holiday	varchar(20)	NOT NULL,
	DayType	int NULL,
	Remark	varchar(50)	NULL
 	CONSTRAINT PK_HoliDayDef PRIMARY KEY CLUSTERED (Holiday ASC))
 GO
 
--����Ƚ�ʶ���Ƴ�����
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_VehNoCmpPlate]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table tb_VehNoCmpPlate
GO
CREATE TABLE tb_VehNoCmpPlate(
	VehPlate varchar(10) NOT NULL
    CONSTRAINT PK_VehNoCmpPlate PRIMARY KEY CLUSTERED (VehPlate ASC))
GO


--�������ʱ�tb_PriceRule�����⣩
--FeeTypeNo=1000ʱ���� 
    

--ϵͳ���ģ��------------------------------------------------------------------------------------------------
--tb_SpecialVeh
--���� VehPlate	CardNo	SpecialType	lanetype	info
--����VehPlate	CardNo	SpecialType
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_SpecialVeh]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table tb_SpecialVeh
GO
CREATE TABLE tb_SpecialVeh(
	VehPlate	char(12) NOT NULL,
	CardNo		varchar(16) NOT NULL,
	SpecialType int NOT NULL,
	lanetype	smallint NOT NULL,
	info		char(24) NOT NULL,
 	CONSTRAINT PK_tb_SpecialVeh PRIMARY KEY CLUSTERED (VehPlate ASC,CardNo ASC))
GO

--���·������������ֶ�
alter table tb_SendPara  add  FileName varchar(30) NULL
GO

--�·����������
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_SendParaResult]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table tb_SendParaResult
GO
CREATE TABLE tb_SendParaResult(
	SendType       smallint NOT NULL,
	FieldName      varchar(30) NULL,
	FieldValue     varchar(30) NOT NULL,
	LaneNo         smallint NOT NULL,
	LaneComputerIP varchar(15) NOT NULL,
	TableName      varchar(30) NOT NULL,
	FileName	   varchar(30) NULL,
	SendTime	   dateTime  NULL,
	SendResult       smallint null,
 CONSTRAINT PK_SendParaSuccess PRIMARY KEY CLUSTERED 
(FieldValue ASC,LaneNo ASC,LaneComputerIP ASC,TableName ASC))
GO
 -----------------------------------------------------------------------------------
-->������Ѵ�����[���]��tb_VehFreeTimes��(Ŀǰֻ���㽭��ѧ���ã�Ϊ�����ݿ�ͳһ������û�ã�
GO
CREATE TABLE tb_VehFreeTimes(
	VehPlate char(10) NOT NULL,
	Year int NULL,
	LeftFreeTimes int NULL,
    CONSTRAINT PK_VehFreeTimes PRIMARY KEY CLUSTERED (VehPlate ASC)
)
GO
 -----------------------------------------------------------------------------------
--����tb_VehFreeTimes_Update��Ŀǰֻ���㽭��ѧ���ã�Ϊ�����ݿ�ͳһ��
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_VehFreeTimes_Update]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table tb_VehFreeTimes_Update
GO
CREATE TABLE tb_VehFreeTimes_Update(
	VehPlate char(10) NOT NULL,
	Year int NULL,
	LeftFreeTimes int NULL,
 CONSTRAINT PK_VehFreeTimes_Update PRIMARY KEY CLUSTERED(VehPlate ASC)
 )
 
 GO
 -----------------------------------------------------------------------------------
 --���[tb_VehFreeTimes_Update]��Ĵ�����Tr_VehFreeTimesSplit

/****** Object:  Trigger [dbo].[Tr_VehFreeTimesSplit]    Script Date: 07/26/2011 15:56:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

CREATE  trigger [dbo].[Tr_VehFreeTimesSplit]
on [dbo].[tb_VehFreeTimes_Update]
for insert

as

declare @sVehPlate	char(10)
declare @iYear		int
declare @iLeftFreeTimes	int
declare @iFreeTimes     int
declare @iFeeRuleType	int

declare cur_inserted cursor
for
select VehPlate, Year, LeftFreeTimes from inserted
for read only

open cur_inserted

fetch next from cur_inserted into @sVehPlate, @iYear, @iLeftFreeTimes

while @@fetch_status = 0
begin
	--��������иó��Ƶļ�¼����ʣ����Ѵ�����1
	if exists(select VehPlate from tb_VehFreeTimes where VehPlate = @sVehPlate and Year = @iYear)
	begin
		update tb_VehFreeTimes set LeftFreeTimes = LeftFreeTimes - 1 where VehPlate = @sVehPlate and Year = @iYear
	end
	
	--��������޸ó��Ƽ�¼���������в����¼
	else
	begin
		delete from tb_VehFreeTimes where VehPlate = @sVehPlate
		
		--�Ӱ�������÷�������,Ȼ������ķ��ʹ�����л�ø÷������͵���Ѵ���
		select top 1 @iFeeRuleType = FeeRuleType from V_WhiteList where VehPlate = @sVehPlate
		select top 1 @iFreeTimes = FreeTimes from tb_PriceRule_zd where FeeRuleType = @iFeeRuleType
		
		insert into tb_VehFreeTimes Values(@sVehPlate, @iYear, @iFreeTimes -1)
	end
	fetch next from cur_inserted into @sVehPlate, @iYear, @iLeftFreeTimes
end
deallocate cur_inserted 

delete from tb_VehFreeTimes_Update

--�嵽�·�����
delete from tb_SendPara where TableName = 'tb_VehFreeTimes'
insert into tb_SendPara select 1, 0, 0, LaneNo, LaneComputerIP, 'tb_VehFreeTimes','tb_VehFreeTimes' FROM tb_LaneUse 
GO
-----------------------------------------------------------------------------------

--���⳵��������Ϣ��
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_SpVehHandle]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table tb_SpVehHandle
GO
CREATE TABLE tb_SpVehHandle(
	LaneType		smallint 	NOT NULL,
	TableName		varchar(50)	NOT NULL,
	Status			int			NOT NULL,
	HandleType		int			NULL,
	Hint			varchar(100)NULL,
	Remark			varchar(100)NULL,
	CONSTRAINT PK_SpVehHandle PRIMARY KEY CLUSTERED
	(LaneType ASC,TableName ASC,Status ASC)
)
GO

--�����������ñ�
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_PriceBase]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table tb_PriceBase
GO
CREATE TABLE tb_PriceBase(
	VerNo int NOT NULL,
	FeeNo int NOT NULL,
	RebateType int NOT NULL,
	InOutSign int NOT NULL,
	TimesSign int NOT NULL,
	VehTypeNo int NOT NULL,
	AllowStayTime int NULL,
	BaseFeeTime int NULL,
	BaseFee int NULL,
	StayAdd int NULL,
	AddFee int NULL,
	AddStart int NULL,
	MaxFee int NULL,
	MaxTime int NULL,
	MaxFeeTime int NULL,
	SumFeeCtr int NULL,
	backup1 char(16) NULL,
	backup2 char(16) NULL,
	StartTime datetime NULL,
	Remark char(50) NULL,
 CONSTRAINT PK_PriceBase PRIMARY KEY CLUSTERED 
(
	VerNo ASC,
	FeeNo ASC,
	RebateType ASC,
	InOutSign ASC,
	TimesSign ASC,
	VehTypeNo ASC
))
GO

------------------------------------���ɷѿ�����ֵ�����ڿ���дǮ�Ŀ���cs��ֵ�����еĿ�Ƭת�Ƶ���-------------------------------------------------------
GO
/****** ����:  �û�����Ĵ洢���� dbo.SP_ChangeCard  ************/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SP_ChangeCard]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SP_ChangeCard]
GO

/*
 * ���ܣ�����������
 * ������
 *		@iSys_id	--����������˻��������sys_id
 *		@sNewCardNo	--����������¿�����
 *		@iCost		--����������¿��Ĺ�����
 *		@iResult	--���������0���ɹ���������ʧ��
 */
CREATE procedure SP_ChangeCard (@iSys_id int,@sNewCardNo Varchar(20),@iCost int,@iOperatorID int,@iResult int output)
As
Begin
	Declare @sOldCardNo Varchar(20)
	Declare @oldBalance int 

	-- 1.����sys_id��ȡ�ɿ���
	Set @sOldCardNo=''
	Select @sOldCardNo = cardNo,@oldBalance=balance From t_park_account where sys_id=@iSys_id
	Select @oldBalance=@oldBalance/100
	-- 2.���ʻ���Ŀ����޸�Ϊ�¿��ţ��޸Ĺ�����Ϊ 0
	Update t_park_account Set cardNo=@sNewCardNo,cost=@iCost where sys_id=@iSys_id

	-- 3.�û�����Ϣ���еĿ����޸�Ϊ�¿���
	Update tb_UserCardInfo Set cardNo=@sNewCardNo where cardNo=@sOldCardNo
	-- 4.�ɿ���д����ֵ�����������У�����ԭ��Ϊ2��ע����
	if(Exists (Select * from tb_StoreCardBlackList where SCCode=@sOldCardNo))
		Update tb_StoreCardBlackList set GenCau=2,GenTime=GetDate() where SCCode=@sOldCardNo
	else
		Insert Into tb_StoreCardBlackList Values(@sOldCardNo,2,GetDate())

	-- ����IC����Ϣ���д˿���״̬Ϊ1����ʧ��
	update tb_CardInfo Set Status=1 Where CardNo=@sOldCardNo

	-- �Ѳ���д��ϵͳ��־����
	Insert Into t_park_systemLog(logTime,logType,operatorID,logData,coverage,remark)
	Values(GetDate(),1,@iOperatorID,'��������,�ɿ��ţ�'+@sOldCardNo+'�ɿ������Ϊ��'+LTrim(str(@oldBalance))+'Ԫ.�¿��ţ�'+@sNewCardNo,'t_park_account,tb_UserCardInfo,tb_StoreCardBlackList,tb_CardInfo','ִ�� SP_ChangeCard')


	Set @iResult=0

End

Go


/****** ����:  �û�����Ĵ洢���� dbo.SP_ChangeCardCheck  ************/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SP_ChangeCardCheck]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SP_ChangeCardCheck]
GO

/*
 * ���ܣ���֤�¿��ĺϷ���
 * ������
 *      @sOldCardNo --����������ɿ�����
 *		@sNewCardNo	--����������¿�����
 *		@iResult	--���������0���ÿ��Ϸ����������Ƿ���ԭ��
 */
CREATE procedure SP_ChangeCardCheck (@sOldCardNo Varchar(20),@sNewCardNo Varchar(20),@iResult int output)
As
Begin
	Declare @iCnt integer
	Declare @iCntOldCardNo integer

	-- 1.���ÿ��Ƿ��ں�������
	Select @iCnt = count(*) from tb_StoreCardBlackList where SCCode=@sNewCardNo
	if @iCnt>0
	Begin
		Set @iResult=11
		return
	End

	-- 2.�¿����Ƿ��Ѵ������ʻ�����
	Select @iCnt = count(*) from t_park_account where cardNo=@sNewCardNo
	if @iCnt>0
	Begin
		Set @iResult=12
		return
	End

	-- 3.�¿��ź;ɿ����Ƿ񶼴������û�����Ϣ����
	Select @iCnt = count(*) from tb_UserCardInfo where cardNo=@sNewCardNo
	Select @iCntOldCardNo = count(*) from tb_UserCardInfo where cardNo=@sOldCardNo
	if @iCnt>0 and @iCntOldCardNo>0 
	Begin
		Set @iResult=13
		return
	End

	Set @iResult=0
End
Go
-------------------------------------------------------------------------------------------
--�ɷѿ�����ģ��
-------------------------------------------------------------------
-------------------------------------------------------------------
-------------------------------------------------------------------
--�жϱ�tb_AccountTrade�Ƿ���ڣ�������ɾ��
GO
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_AccountTrade]') and OBJECTPROPERTY(id,N'IsUserTable') = 1)    
  --ɾ����    
  drop   table   [dbo].[tb_AccountTrade]    
  GO
    
--����������ˮ��ʱ��
create table tb_AccountTrade
(
	accountNo int,
	seqNo int,
	tradeType int not null,
	listNo varchar(30) not null,
	cardNo varchar(30),
	cardType int,
	tradeTime varchar(20) not null,
	fee int not null,
	balance int not null,
	cardBalance int,
	backoutedListNo varchar(30),
	backoutedMark int,
	parkNo int,
	vehPlate varchar(10),
	inGateNo int,
	inGateName varchar(30),
	inLaneNo int,
	inOpTime varchar(20),
	gateNo int,
	gateName varchar(30),
	laneNo int,
	opTime varchar(20),
	operatorID int,
	operatorPassword char(32),
	verify char(32),
	remark varchar(100),
	constraint pk_pams_accountTrade_id primary key(accountNo,seqNo),
)
--����tb_AccountTradeΨһ����
create unique index index_pams_ListNo on tb_AccountTrade(ListNo)
--����optime����
create index ix_accounttrade_optime on tb_accounttrade (optime desc)

--------------------------------------------------------------------
--�жϱ�tb_AccountTrade1�Ƿ���ڣ�������ɾ��
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_AccountTrade1]') and OBJECTPROPERTY(id,N'IsUserTable') = 1)    
   --   ɾ����   
  drop   table   [dbo].[tb_AccountTrade1]    
  GO
  --�жϱ�tb_AccountTrade01�Ƿ���ڣ�������ɾ��
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_AccountTrade01]') and OBJECTPROPERTY(id,N'IsUserTable') = 1)    
  --   ɾ����    
  drop   table   [dbo].[tb_AccountTrade01]    
  GO
--����12�Ž�����ˮ��
create table tb_AccountTrade01
(
	accountNo int,
	seqNo int,
	tradeType int not null,
	listNo varchar(30) not null,
	cardNo varchar(30),
	cardType int,
	tradeTime varchar(20) not null,
	fee int not null,
	balance int not null,
	cardBalance int,
	backoutedListNo varchar(30),
	backoutedMark int,
	parkNo int,
	vehPlate varchar(10),
	inGateNo int,
	inGateName varchar(30),
	inLaneNo int,
	inOpTime varchar(20),
	gateNo int,
	gateName varchar(30),
	laneNo int,
	opTime varchar(20),
	operatorID int,
	operatorPassword char(32),
	verify char(32),
	remark varchar(100),
	constraint pk_pams_accountTrade01_id primary key(accountNo,seqNo),
)
--����tb_AccountTradeΨһ����
create unique index index_pams_ListNo on tb_AccountTrade01(ListNo)
-------------------------------------------------------------------------------
GO
 --�жϱ�tb_AccountTrade2�Ƿ���ڣ�������ɾ��
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_AccountTrade2]') and OBJECTPROPERTY(id,N'IsUserTable') = 1)    
     --   ɾ���� 
  drop   table   [dbo].[tb_AccountTrade2]    
  GO
  --�жϱ�tb_AccountTrade02�Ƿ���ڣ�������ɾ��
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_AccountTrade02]') and OBJECTPROPERTY(id,N'IsUserTable') = 1)    
    --   ɾ����  
  drop   table   [dbo].[tb_AccountTrade02] 
create table tb_AccountTrade02
(
	accountNo int,
	seqNo int,
	tradeType int not null,
	listNo varchar(30) not null,
	cardNo varchar(30),
	cardType int,
	tradeTime varchar(20) not null,
	fee int not null,
	balance int not null,
	cardBalance int,
	backoutedListNo varchar(30),
	backoutedMark int,
	parkNo int,
	vehPlate varchar(10),
	inGateNo int,
	inGateName varchar(30),
	inLaneNo int,
	inOpTime varchar(20),
	gateNo int,
	gateName varchar(30),
	laneNo int,
	opTime varchar(20),
	operatorID int,
	operatorPassword char(32),
	verify char(32),
	remark varchar(100),
	constraint pk_pams_accountTrade02_id primary key(accountNo,seqNo),
)
--����tb_AccountTradeΨһ����
create unique index index_pams_ListNo on tb_AccountTrade02(ListNo)
-------------------------------------------------------------------------
GO
  --�жϱ�tb_AccountTrade3�Ƿ���ڣ�������ɾ��
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_AccountTrade3]') and OBJECTPROPERTY(id,N'IsUserTable') = 1)    
  --   ɾ����    
  drop   table   [dbo].[tb_AccountTrade3]    
  GO
  --�жϱ�tb_AccountTrade03�Ƿ���ڣ�������ɾ��
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_AccountTrade03]') and OBJECTPROPERTY(id,N'IsUserTable') = 1)    
  --   ɾ����    
  drop   table   [dbo].[tb_AccountTrade03]    
  GO
create table tb_AccountTrade03
(
	accountNo int,
	seqNo int,
	tradeType int not null,
	listNo varchar(30) not null,
	cardNo varchar(30),
	cardType int,
	tradeTime varchar(20) not null,
	fee int not null,
	balance int not null,
	cardBalance int,
	backoutedListNo varchar(30),
	backoutedMark int,
	parkNo int,
	vehPlate varchar(10),
	inGateNo int,
	inGateName varchar(30),
	inLaneNo int,
	inOpTime varchar(20),
	gateNo int,
	gateName varchar(30),
	laneNo int,
	opTime varchar(20),
	operatorID int,
	operatorPassword char(32),
	verify char(32),
	remark varchar(100),
	constraint pk_pams_accountTrade03_id primary key(accountNo,seqNo),
)
--����tb_AccountTradeΨһ����
create unique index index_pams_ListNo on tb_AccountTrade03(ListNo)
-------------------------------------------------------------------------
GO
  --�жϱ�tb_AccountTrade4�Ƿ���ڣ�������ɾ��
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_AccountTrade4]') and OBJECTPROPERTY(id,N'IsUserTable') = 1)    
  --   ɾ����    
  drop   table   [dbo].[tb_AccountTrade4]    
  GO
  --�жϱ�tb_AccountTrade04�Ƿ���ڣ�������ɾ��
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_AccountTrade04]') and OBJECTPROPERTY(id,N'IsUserTable') = 1)    
  --   ɾ����    
  drop   table   [dbo].[tb_AccountTrade04]    
  GO
create table tb_AccountTrade04
(
	accountNo int,
	seqNo int,
	tradeType int not null,
	listNo varchar(30) not null,
	cardNo varchar(30),
	cardType int,
	tradeTime varchar(20) not null,
	fee int not null,
	balance int not null,
	cardBalance int,
	backoutedListNo varchar(30),
	backoutedMark int,
	parkNo int,
	vehPlate varchar(10),
	inGateNo int,
	inGateName varchar(30),
	inLaneNo int,
	inOpTime varchar(20),
	gateNo int,
	gateName varchar(30),
	laneNo int,
	opTime varchar(20),
	operatorID int,
	operatorPassword char(32),
	verify char(32),
	remark varchar(100),
	constraint pk_pams_accountTrade04_id primary key(accountNo,seqNo),
)
--����tb_AccountTradeΨһ����
create unique index index_pams_ListNo on tb_AccountTrade04(ListNo)
-------------------------------------------------------------------------
GO
  --�жϱ�tb_AccountTrade5�Ƿ���ڣ�������ɾ��
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_AccountTrade5]') and OBJECTPROPERTY(id,N'IsUserTable') = 1)    
  --   ɾ����    
  drop   table   [dbo].[tb_AccountTrade5]    
  GO
  --�жϱ�tb_AccountTrade05�Ƿ���ڣ�������ɾ��
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_AccountTrade05]') and OBJECTPROPERTY(id,N'IsUserTable') = 1)    
  --   ɾ����    
  drop   table   [dbo].[tb_AccountTrade05]    
  GO
create table tb_AccountTrade05
(
	accountNo int,
	seqNo int,
	tradeType int not null,
	listNo varchar(30) not null,
	cardNo varchar(30),
	cardType int,
	tradeTime varchar(20) not null,
	fee int not null,
	balance int not null,
	cardBalance int,
	backoutedListNo varchar(30),
	backoutedMark int,
	parkNo int,
	vehPlate varchar(10),
	inGateNo int,
	inGateName varchar(30),
	inLaneNo int,
	inOpTime varchar(20),
	gateNo int,
	gateName varchar(30),
	laneNo int,
	opTime varchar(20),
	operatorID int,
	operatorPassword char(32),
	verify char(32),
	remark varchar(100),
	constraint pk_pams_accountTrade05_id primary key(accountNo,seqNo),
)
--����tb_AccountTradeΨһ����
create unique index index_pams_ListNo on tb_AccountTrade05(ListNo)
-------------------------------------------------------------------------
GO
  --�жϱ�tb_AccountTrade6�Ƿ���ڣ�������ɾ��
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_AccountTrade6]') and OBJECTPROPERTY(id,N'IsUserTable') = 1)    
  --   ɾ����    
  drop   table   [dbo].[tb_AccountTrade6]    
  GO
  --�жϱ�tb_AccountTrade06�Ƿ���ڣ�������ɾ��
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_AccountTrade06]') and OBJECTPROPERTY(id,N'IsUserTable') = 1)    
  --   ɾ����    
  drop   table   [dbo].[tb_AccountTrade06]    
  GO
create table tb_AccountTrade06
(
	accountNo int,
	seqNo int,
	tradeType int not null,
	listNo varchar(30) not null,
	cardNo varchar(30),
	cardType int,
	tradeTime varchar(20) not null,
	fee int not null,
	balance int not null,
	cardBalance int,
	backoutedListNo varchar(30),
	backoutedMark int,
	parkNo int,
	vehPlate varchar(10),
	inGateNo int,
	inGateName varchar(30),
	inLaneNo int,
	inOpTime varchar(20),
	gateNo int,
	gateName varchar(30),
	laneNo int,
	opTime varchar(20),
	operatorID int,
	operatorPassword char(32),
	verify char(32),
	remark varchar(100),
	constraint pk_pams_accountTrade06_id primary key(accountNo,seqNo),
)
--����tb_AccountTradeΨһ����
create unique index index_pams_ListNo on tb_AccountTrade06(ListNo)
-------------------------------------------------------------------------
GO
  --�жϱ�tb_AccountTrade7�Ƿ���ڣ�������ɾ��
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_AccountTrade7]') and OBJECTPROPERTY(id,N'IsUserTable') = 1)    
  --   ɾ����    
  drop   table   [dbo].[tb_AccountTrade7]    
  GO
  --�жϱ�tb_AccountTrade07�Ƿ���ڣ�������ɾ��
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_AccountTrade07]') and OBJECTPROPERTY(id,N'IsUserTable') = 1)    
  --   ɾ����    
  drop   table   [dbo].[tb_AccountTrade07]    
  GO
create table tb_AccountTrade07
(
	accountNo int,
	seqNo int,
	tradeType int not null,
	listNo varchar(30) not null,
	cardNo varchar(30),
	cardType int,
	tradeTime varchar(20) not null,
	fee int not null,
	balance int not null,
	cardBalance int,
	backoutedListNo varchar(30),
	backoutedMark int,
	parkNo int,
	vehPlate varchar(10),
	inGateNo int,
	inGateName varchar(30),
	inLaneNo int,
	inOpTime varchar(20),
	gateNo int,
	gateName varchar(30),
	laneNo int,
	opTime varchar(20),
	operatorID int,
	operatorPassword char(32),
	verify char(32),
	remark varchar(100),
	constraint pk_pams_accountTrade07_id primary key(accountNo,seqNo),
)
--����tb_AccountTradeΨһ����
create unique index index_pams_ListNo on tb_AccountTrade07(ListNo)
-------------------------------------------------------------------------
GO
  --�жϱ�tb_AccountTrade8�Ƿ���ڣ�������ɾ��
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_AccountTrade8]') and OBJECTPROPERTY(id,N'IsUserTable') = 1)    
  --   ɾ����    
  drop   table   [dbo].[tb_AccountTrade8]    
  GO
  --�жϱ�tb_AccountTrade08�Ƿ���ڣ�������ɾ��
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_AccountTrade08]') and OBJECTPROPERTY(id,N'IsUserTable') = 1)    
  --   ɾ����    
  drop   table   [dbo].[tb_AccountTrade08]    
  GO
create table tb_AccountTrade08
(
	accountNo int,
	seqNo int,
	tradeType int not null,
	listNo varchar(30) not null,
	cardNo varchar(30),
	cardType int,
	tradeTime varchar(20) not null,
	fee int not null,
	balance int not null,
	cardBalance int,
	backoutedListNo varchar(30),
	backoutedMark int,
	parkNo int,
	vehPlate varchar(10),
	inGateNo int,
	inGateName varchar(30),
	inLaneNo int,
	inOpTime varchar(20),
	gateNo int,
	gateName varchar(30),
	laneNo int,
	opTime varchar(20),
	operatorID int,
	operatorPassword char(32),
	verify char(32),
	remark varchar(100),
	constraint pk_pams_accountTrade08_id primary key(accountNo,seqNo),
)
--����tb_AccountTradeΨһ����
create unique index index_pams_ListNo on tb_AccountTrade08(ListNo)
-------------------------------------------------------------------------
GO
  --�жϱ�tb_AccountTrade9�Ƿ���ڣ�������ɾ��
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_AccountTrade9]') and OBJECTPROPERTY(id,N'IsUserTable') = 1)    
  --   ɾ����    
  drop   table   [dbo].[tb_AccountTrade9]    
  GO
  --�жϱ�tb_AccountTrade09�Ƿ���ڣ�������ɾ��
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_AccountTrade09]') and OBJECTPROPERTY(id,N'IsUserTable') = 1)    
  --   ɾ����    
  drop   table   [dbo].[tb_AccountTrade09]    
  GO
create table tb_AccountTrade09
(
	accountNo int,
	seqNo int,
	tradeType int not null,
	listNo varchar(30) not null,
	cardNo varchar(30),
	cardType int,
	tradeTime varchar(20) not null,
	fee int not null,
	balance int not null,
	cardBalance int,
	backoutedListNo varchar(30),
	backoutedMark int,
	parkNo int,
	vehPlate varchar(10),
	inGateNo int,
	inGateName varchar(30),
	inLaneNo int,
	inOpTime varchar(20),
	gateNo int,
	gateName varchar(30),
	laneNo int,
	opTime varchar(20),
	operatorID int,
	operatorPassword char(32),
	verify char(32),
	remark varchar(100),
	constraint pk_pams_accountTrade09_id primary key(accountNo,seqNo),
)
--����tb_AccountTradeΨһ����
create unique index index_pams_ListNo on tb_AccountTrade09(ListNo)
-------------------------------------------------------------------------
GO
  --�жϱ�tb_AccountTrade10�Ƿ���ڣ�������ɾ��
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_AccountTrade10]') and OBJECTPROPERTY(id,N'IsUserTable') = 1)    
  --   ɾ����    
  drop   table   [dbo].[tb_AccountTrade10]    
  GO
  
create table tb_AccountTrade10
(
	accountNo int,
	seqNo int,
	tradeType int not null,
	listNo varchar(30) not null,
	cardNo varchar(30),
	cardType int,
	tradeTime varchar(20) not null,
	fee int not null,
	balance int not null,
	cardBalance int,
	backoutedListNo varchar(30),
	backoutedMark int,
	parkNo int,
	vehPlate varchar(10),
	inGateNo int,
	inGateName varchar(30),
	inLaneNo int,
	inOpTime varchar(20),
	gateNo int,
	gateName varchar(30),
	laneNo int,
	opTime varchar(20),
	operatorID int,
	operatorPassword char(32),
	verify char(32),
	remark varchar(100),
	constraint pk_pams_accountTrade10_id primary key(accountNo,seqNo),
)
--����tb_AccountTradeΨһ����
create unique index index_pams_ListNo on tb_AccountTrade10(ListNo)
GO
  --�жϱ�tb_AccountTrade11�Ƿ���ڣ�������ɾ��
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_AccountTrade11]') and OBJECTPROPERTY(id,N'IsUserTable') = 1)    
  --   ɾ����    
  drop   table   [dbo].[tb_AccountTrade11]    
  GO
create table tb_AccountTrade11
(
	accountNo int,
	seqNo int,
	tradeType int not null,
	listNo varchar(30) not null,
	cardNo varchar(30),
	cardType int,
	tradeTime varchar(20) not null,
	fee int not null,
	balance int not null,
	cardBalance int,
	backoutedListNo varchar(30),
	backoutedMark int,
	parkNo int,
	vehPlate varchar(10),
	inGateNo int,
	inGateName varchar(30),
	inLaneNo int,
	inOpTime varchar(20),
	gateNo int,
	gateName varchar(30),
	laneNo int,
	opTime varchar(20),
	operatorID int,
	operatorPassword char(32),
	verify char(32),
	remark varchar(100),
	constraint pk_pams_accountTrade11_id primary key(accountNo,seqNo),
)
--����tb_AccountTradeΨһ����
create unique index index_pams_ListNo on tb_AccountTrade11(ListNo)
GO
  --�жϱ�tb_AccountTrade12�Ƿ���ڣ�������ɾ��
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_AccountTrade12]') and OBJECTPROPERTY(id,N'IsUserTable') = 1)    
  --   ɾ����    
  drop   table   [dbo].[tb_AccountTrade12]    
  GO
create table tb_AccountTrade12
(
	accountNo int,
	seqNo int,
	tradeType int not null,
	listNo varchar(30) not null,
	cardNo varchar(30),
	cardType int,
	tradeTime varchar(20) not null,
	fee int not null,
	balance int not null,
	cardBalance int,
	backoutedListNo varchar(30),
	backoutedMark int,
	parkNo int,
	vehPlate varchar(10),
	inGateNo int,
	inGateName varchar(30),
	inLaneNo int,
	inOpTime varchar(20),
	gateNo int,
	gateName varchar(30),
	laneNo int,
	opTime varchar(20),
	operatorID int,
	operatorPassword char(32),
	verify char(32),
	remark varchar(100),
	constraint pk_pams_accountTrade12_id primary key(accountNo,seqNo),
)
--����tb_AccountTradeΨһ����
create unique index index_pams_ListNo on tb_AccountTrade12(ListNo)
------------------------------------------------------------------------------------
--�����쳣������ˮ��
create table tb_UnusualAccountTrade
(
	accountNo int,
	seqNo int,
	tradeType int not null,
	listNo varchar(30) not null,
	cardNo varchar(30),
	cardType int,
	tradeTime varchar(20) not null,
	fee int not null,
	balance int not null,
	cardBalance int,
	backoutedListNo varchar(30),
	backoutedMark int,
	parkNo int,
	vehPlate varchar(10),
	inGateNo int,
	inGateName varchar(30),
	inLaneNo int,
	inOpTime varchar(20),
	gateNo int,
	gateName varchar(30),
	laneNo int,
	opTime varchar(20),
	operatorID int,
	operatorPassword char(32),
	verify char(32),
	remark varchar(100),
	constraint pk_pams_UnusualAccountTrade_id primary key(accountNo,seqNo),
)
------------------------------------------------------------------------------------
--����tb_AccountTrade��Ĵ�����Tr_AccountTrade
GO
/****** Object:  Trigger [dbo].[Tr_AccountTrade]    Script Date: 05/10/2011 13:57:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
   create TRIGGER [dbo].[Tr_AccountTrade] 
    ON  [dbo].[tb_AccountTrade] 
    AFTER  INSERT
   
AS 

   declare @Months                  tinyint
     
   declare @TradeType                        int
   
   declare @BackoutedListNo                  varchar(30) 
    

 
select  @Months=DATEPART(month,convert(datetime,OpTime)),@TradeType=tradeType,@BackoutedListNo=backoutedListNo from inserted
if @Months=1
    insert into tb_AccountTrade01
    select * from inserted
    
else if @Months=2
    insert into tb_AccountTrade02
    select * from inserted

else if @Months=3
    insert into tb_AccountTrade03
    select * from inserted
    
else if @Months=4
    insert into tb_AccountTrade04
    select * from inserted

else if @Months=5
    insert into tb_AccountTrade05
    select * from inserted

else if @Months=6
    insert into tb_AccountTrade06
    select * from inserted
    
else if @Months=7
    insert into tb_AccountTrade07
    select * from inserted
    
else if @Months=8
    insert into tb_AccountTrade08
    select * from inserted
    
else if @Months=9
    insert into tb_AccountTrade09
    select * from inserted
    
else if @Months=10
    insert into tb_AccountTrade10
    select * from inserted
    
else if @Months=11
    insert into tb_AccountTrade11
    select * from inserted
    
else if @Months=12
    insert into tb_AccountTrade12
    select * from inserted
   
    
begin  
 
    declare @AccountNo               int  
 
    declare @Fee                     int

    select @AccountNo=accountNo,@Fee=fee from inserted 
 
    update t_park_account set balance=balance+@Fee where sys_id=@AccountNo

end
 delete from tb_AccountTrade
Go
-----------------------------------------------------------------------------
 --�жϱ�v_AccountTrade�Ƿ���ڣ�������ɾ��
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[v_AccountTrade]') and OBJECTPROPERTY(id,N'IsView') = 1)    
  --   ɾ����    
  drop view [dbo].[v_AccountTrade]    
  GO
--����12����ˮ�������ͼ
go
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
-------------------------------------------------------------------------------------------
--У԰������ģ��
-------------------------------------------------------------------
-------------------------------------------------------------------
-------------------------------------------------------------------
GO
  --�жϱ�tb_FeeRuleTypeDef�Ƿ���ڣ�������ɾ��
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_FeeRuleTypeDef]') and OBJECTPROPERTY(id,N'IsUserTable') = 1)    
  --   ɾ����    
  drop table [dbo].[tb_FeeRuleTypeDef]    
GO
--��С��������ģ�����й����ݱ���޸ĺͳ�ʼֵ
go
create table tb_FeeRuleTypeDef
(
	FeeRuleType	   int,
	Name		char(20),
	Constraint PK_FeeRuleTypeDef Primary Key(FeeRuleType)
)
Delete from tb_FeeRuleTypeDef;
Insert into tb_FeeRuleTypeDef values(0,'��ҹ��');
Insert into tb_FeeRuleTypeDef values(1,'����ҹ��');
Insert into tb_FeeRuleTypeDef values(4,'MBAѧԱ��');
delete from t_park_sysparamconf where pname='whtherPayType';
insert into t_park_sysparamconf values('whtherPayType','0',0,'�Ƿ��нɷ����Ͳ�����0��ʾ�нɷ����ͣ�1��ʾû�нɷ�����,���ֵ����0����1�ͳ�ʼ��Ϊ0. û���������ϵͳ�Զ���ӣ���ʼ��ֵΪ0)');
------------------------------------------------------
--�û������ͱ�
GO
create table tb_UserCardType
(
   UserCardType     smallint primary key,
   TypeName     	char(10) not null,
   Remark     		varchar(255),
)
------------------------------------------------------
--�û����շ����ͱ�
Go
create table tb_UserCardFeeRuleType
(
   UserCardType     smallint primary key,
   FeeRuleType     	int not null,
)
--��ʼ��ֵ
GO
  insert into tb_UserCardType values(0,'��ʱ��',null)
  insert into tb_UserCardType values(1,'��ݿ�',null)
  insert into tb_UserCardType values(2,'�ɷѿ�',null)
   insert into tb_UserCardType values(12,'MBAѧԱ��',null)
  insert into tb_UserCardType values(13,'����',null)
  insert into tb_UserCardType values(14,'������',null)
  insert into tb_UserCardFeeRuleType values(12,4)
  insert into tb_UserCardFeeRuleType values(13,0)
  insert into tb_UserCardFeeRuleType values(14,1)
  GO
------------------------------------------------------------------------------------------
--��С��������ģ�����й����ݱ���޸ĺͳ�ʼֵ
go
delete from tb_CardType where CardType=12 or CardType=13 or CardType=14;
Insert into tb_CardType  values(12,'MBAѧԱ��',9);
Insert into tb_CardType  values(13,'����',9);
Insert into tb_CardType  values(14,'������',9);
------------------------------------------------------
--�޸�tb_CardInfo��
GO
alter table tb_CardInfo add UserCardType smallint not null default 0;
--�޸�tb_CardOperation��
GO
alter table tb_CardOperation add UserCardType smallint not null default 0;
------------------------------------------------------
----------------------------�·�������м�һ��FileName������tb_LaneUse����Ҫ�޸ĵĴ�����------------------------------------------
--�޸�tb_usercardInfo���еĴ�����Tri_SetSendPara,�·�������Ҫ�Ӷ��ֵ
GO
/****** Object:  Trigger [dbo].[Tri_SetSendPara]    Script Date: 06/22/2011 12:30:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER Trigger [dbo].[Tri_SetSendPara] 
on [dbo].[tb_UserCardInfo] 
for insert,update
as
	--delete from tb_sendpara where sendtype=2 and fieldValue in (select vehPlate from inserted);
	if UPDATE ( VehPlate ) or update (VehPlateImage)
	begin
		delete from tb_sendpara where sendtype=2 and fieldValue in (select vehPlate from inserted);

		if exists(select * from tb_usercardinfo where vehplate in (select vehplate from inserted))
			insert into tb_sendpara 
			select distinct 2,'vehPlate',a.vehPlate,b.laneno,b.lanecomputerip,'WhiteListPic','WhiteListPic'
			from inserted a right outer join tb_LaneUse b on 1=1  
			--from inserted a right outer join tb_lane b on 1=1
		--where Not Exists (select * from tb_SendPara where Sendtype=2 and FieldName='VehPlate'
		--					and FieldValue=a.VehPlate and LaneComputerIP=b.LaneComputerIP
		--					and TableName='WhiteListPic')
	end
GO
------------------------------------------------------
--�޸�tb_userCardInfo��
GO
alter table tb_userCardInfo add VehBrand varchar(30);
alter table tb_userCardInfo alter column ParkingSpace varchar(32);
alter table tb_userCardInfo add StaffNo varchar(32);
alter table tb_userCardInfo add RoomNo varchar(20);
alter table tb_userCardInfo add Address varchar(255);
alter table tb_userCardInfo add LinkMan varchar(20);
alter table tb_userCardInfo add TelePhone varchar(20);
alter table tb_userCardInfo add MobileNumber varchar(20);
alter table tb_userCardInfo add PayEndTime datetime;
alter table tb_userCardInfo add Remark varchar(255);
alter table tb_userCardInfo alter column CardNo varchar(10);
alter table tb_userCardInfo alter column OBU varchar(10);
exec sp_rename 'tb_userCardInfo.UserType' ,'UserCardType', 'column';
------------------------------------------------------
--�޸�tb_UserCardInfoHistory��
GO
alter table tb_UserCardInfoHistory add VehBrand varchar(30);
alter table tb_UserCardInfoHistory alter column ParkingSpace varchar(32);
alter table tb_UserCardInfoHistory add StaffNo varchar(32);
alter table tb_UserCardInfoHistory add RoomNo varchar(20);
alter table tb_UserCardInfoHistory add Address varchar(255);
alter table tb_UserCardInfoHistory add LinkMan varchar(20);
alter table tb_UserCardInfoHistory add TelePhone varchar(20);
alter table tb_UserCardInfoHistory add MobileNumber varchar(20);
alter table tb_UserCardInfoHistory add PayEndTime datetime;
alter table tb_UserCardInfoHistory add Remark varchar(255);
alter table tb_UserCardInfoHistory alter column CardNo varchar(10);
alter table tb_UserCardInfoHistory alter column OBU varchar(10);
exec sp_rename 'tb_UserCardInfoHistory.UserType' ,'UserCardType', 'column';
------------------------------------------------------
--�޸�tb_UserCardInfoHistory������Tri_BackupModifiedData
GO
/****** Object:  Trigger [dbo].[Tri_BackupModifiedData]    Script Date: 06/16/2011 10:05:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


ALTER  trigger [dbo].[Tri_BackupModifiedData]
on [dbo].[tb_UserCardInfo]
for update, delete
as
insert into tb_UserCardInfoHistory
select RecNO,Owner,IDCard,VehPlate,ParkingSpace,OBU,RegisterTime,Status,Deposit,CardNO,UserCardType,GETDATE() as ModifyTime,FeeRuleType,VehBrand,StaffNo,RoomNo,Address,LinkMan,TelePhone,MobileNumber,PayEndTime,Remark from deleted
-------------------------------------------------------------------------------------------------
--�޸�tb_UserCardBill����EndTime�����ǽɷѽ���ʱ����Ҫ��һ�죬֮ǰ���ǵ���ĩ�����һ�죬������������ 00:00:00,�����Ļ��Ͳ��������һ��
GO
update tb_UserCardBill set EndTime=EndTime+1
GO
-------------------------------------------------------------------------------------------------
Go
--����tb_UserCardInfo��PayEndTime���ɷ����޵�ֵ��
update tb_UserCardInfo  set PayEndTime = (select EndTime from (select userRecNo,MAX(EndTime) as EndTime from tb_UserCardBill group by userRecNo) as tb_a where tb_a.UserRecNO = RecNO) where UserCardType=14 and RecNO in (select distinct userRecNo from tb_UserCardBill) 
GO
-------------------------------------------------------------------------------------------------
--�޸İ�ȫ�û���Ϣ���볤��
GO
alter table tb_SecurityUserInfo alter column password char(32) not null
-------------------------------------------------------------------------------------------------

--�޸İ�������ͼ��userType�޸�ΪUserCardType��
GO

/****** Object:  View [dbo].[V_WHITELIST]    Script Date: 06/28/2011 17:12:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



---��������ͼ
ALTER  VIEW [dbo].[V_WHITELIST] AS 
SELECT * FROM 
(
	--���ý�ֹʱ�䲻��ʱ���룬����+1��
	SELECT A.CARDNO, A.VEHPLATE, A.OWNER AS OWNERNAME,A.OBU AS OBUID,
		CASE WHEN B.STARTTIME IS NULL THEN A.REGISTERTIME ELSE B.STARTTIME END AS FIRTIME, 
		CASE WHEN B.ENDTIME IS NULL THEN A.REGISTERTIME ELSE B.ENDTIME+1 END AS INVALIDATETIME,
		A.UserCardType AS CARDTYPE, 
		CASE WHEN A.STATUS=0 AND (B.ENDTIME IS NULL OR B.ENDTIME<CONVERT(CHAR(10),GETDATE(),120)) THEN 9 ELSE A.STATUS END AS STATUS,
		CASE WHEN VehPlateImage IS NULL THEN 0 ELSE 1 END AS HasVehPic,0 as FeeRuleType   --�����еĳ����̶�Ϊ��ҹ�� 2011-3-24
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
	SELECT A.CARDNO, A.VEHPLATE, A.OWNER AS OWNERNAME,A.OBU AS OBUID,GETDATE()-120 AS FIRTIME, GETDATE()+1000 AS INVALIDATETIME,
		A.UserCardType AS CARDTYPE, A.STATUS, CASE WHEN A.VehPlateImage IS NULL THEN 0 ELSE 1 END AS HasVehPic,A.FeeRuleType
	FROM TB_USERCARDINFO A
	WHERE A.UserCardType=13	or A.UserCardType=12--ҵ��������MBAѧԱ��
	union all 
	SELECT CARDNO, VEHPLATE, OWNERName , OBUID, GETDATE()-120 AS FIRTIME, GETDATE()+1000 AS INVALIDATETIME,
		13 as Usetype, 0 as Status, CASE WHEN VehPlateImage IS NULL THEN 0 ELSE 1 END AS HasVehPic,0 AS FeeRuleType
	FROM tb_testwl
	
) TMP

GO

-------------------------------------------------------------------------------------------------
--�����̹���
GO
CREATE TABLE tb_Staff(
    CardNo [char](10) primary key,
    StaffName [varchar](32) null,
    StaffAddress [varchar](255) null,
    Relation  [varchar](32) null,
)
GO
-------------------------------------------------------------------------------------------------
 --�޸�tb_SpEventCode�����¼�������ֵ���Ը���������ϣ�����û����������е�ֵ�����ֵ������ˮ��ѯ����Ŵ���29�Ժ�Ĳ��ã�
  Go
  delete from tb_SpEventCode where SpEventNo>18 and SpEventNo<30;
  insert into tb_SpEventCode values(19,'��д�������Ϣ');
  insert into tb_SpEventCode values(20,'δ����');
  insert into tb_SpEventCode values(23,'̧�˷���');
  insert into tb_SpEventCode values(24,'�Żݳ���');
  insert into tb_SpEventCode values(25,'�ط���');
  insert into tb_SpEventCode values(26,'���غ����');
  insert into tb_SpEventCode values(27,'���⴦����');
  insert into tb_SpEventCode values(28,'��ѷ���');
  insert into tb_SpEventCode values(29,'������ȡ�ֽ�');
  -------------------------------------------------------------------------------------------------
----------------------------�·�������м�һ��FileName������tb_LaneUse����Ҫ�޸ĵĴ�����------------------------------------------
--�޸�tb_CardDynamic���еĴ�����Tr_CardDynamicToLoseCard,�·�������Ҫ�Ӷ��ֵ
GO
/****** Object:  Trigger [dbo].[Tr_CardDynamicToLoseCard]    Script Date: 06/23/2011 14:37:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--����ʧ����ʱ������ʱ,�ô�����������,�����µĶ����б��·�������
--�����µĶ���ʱ,���µĶ����б��·�
ALTER trigger [dbo].[Tr_CardDynamicToLoseCard] 
		on [dbo].[tb_CardDynamic]
		for insert,update
as
begin
	--�������ʱ���Ķ���״̬���ı�
	--��ÿһ����������·���ͼTableName
	if exists(select * from inserted where Status=13) or exists(select * from deleted where Status=13)
	begin
		declare @LaneIP char(15),@LaneNo smallint
		declare SendParaCursor cursor
			--for select LaneComputerIP,LaneNo from tb_Lane
              for select LaneComputerIP,LaneNo from tb_LaneUse 
		open SendParaCursor
		fetch next from SendParaCursor into @LaneIP,@LaneNo
		while @@fetch_status=0
		begin
			if not exists (select * from tb_SendPara where LaneNo=@LaneNo and LaneComputerIP=@LaneIP and TableName='V_LoseCardList')
			begin
				insert into tb_SendPara values(1,'0','0',@LaneNo,@LaneIp,'V_LoseCardList','V_LoseCardList')
			end
			
			fetch next from SendParaCursor into @LaneIP,@LaneNo
		end

		close SendParaCursor
		deallocate SendParaCursor
	end
end
GO
-------------------------------------------------------------------------------------------------
--�޸�tb_CardDynamic����̬��
GO
--�����û�������
alter table tb_CardDynamic add UserCardType smallint not null default 0
--���ӳ���
alter table tb_CardDynamic add VehType smallint not null default 0
--���ӹ����
alter table tb_CardDynamic add SquadNo smallint not null default 1
--���������ˮ��
alter table tb_CardDynamic add inListNo Char(16) 
--���ӳ�����ˮ��
alter table tb_CardDynamic add OutListNo Char(16) 
--���ӳ���
alter table tb_CardDynamic add VehBrand varchar(30) 
--����ͨ�о����� 
alter table tb_cardDynamic add TicketType TinyInt not null default 1
--���Ӵ������� 
alter table tb_cardDynamic add GateName Char(20)
--����һ�����ݱ�
select * into temp_tb_carddynamic from tb_CardDynamic 
GO
 update tb_CardDynamic set outlistNo= 
 (select tb.ListNo from tb_CardDynamic tb,temp_tb_carddynamic temp where tb.ListNo=temp.listNo and tb.Status =12 and temp.status =12 and tb.ListNo=tb_CardDynamic.ListNo)
GO
update tb_CardDynamic set inlistNo= 
 (select tb.ListNo from tb_CardDynamic tb,temp_tb_carddynamic temp where tb.ListNo=temp.listNo and tb.Status !=12 and temp.status !=12 and tb.ListNo=tb_CardDynamic.ListNo)
GO
--ɾ��listNo��
alter table tb_cardDynamic drop COLUMN  listNo
-------------------------------------------------------------------------------------------------
----------------------------�·�������м�һ��FileName������tb_LaneUse����Ҫ�޸ĵĴ������ʹ洢����------------------------------------------
--�޸�tb_InList_Tmp���еĴ�����Tr_YCTInListSplit,�·�������Ҫ�Ӷ��ֵ
GO
/****** Object:  Trigger [dbo].[Tr_YCTInListSplit]    Script Date: 06/23/2011 14:50:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER TRIGGER [dbo].[Tr_YCTInListSplit]
ON [dbo].[tb_InList_Tmp]
FOR INSERT
AS
IF (SELECT Count(*) FROM inserted WHERE TicketType = 10 and CardID <> '' and CardID <> '0') > 0 
BEGIN
	INSERT INTO tb_YCTInList_Tmp
	SELECT CardID, ListNo as InListNo, GateNo as InGateNo, LaneNo as InLaneNo,
		VehType as InVehType, VehClass as InVehClass, VehPlate as InVehPlate,
		PlateImg as InPlateImg, OperatorNo as InOperatorNo, OpTime as InOpTime,
		VehTypeAuto as InVehTypeAuto, VehPlateAuto as InVehPlateAuto
	FROM inserted
	WHERE TicketType = 10 and CardID <> '' and CardID <> '0'
	--�·������г���
	DELETE FROM tb_SendPara WHERE TableName = 'tb_YCTInList_Tmp'
	INSERT INTO tb_SendPara
	SELECT 1 as SendType, 0 as FieldName, 0 as FieldValue, LaneNo, LaneComputerIP, 
		'tb_YCTInList_Tmp' as TableName,'tb_YCTInList_Tmp' as FileName
	FROM tb_LaneUse
	--FROM tb_Lane
	--WHERE LaneTypeNo = 2
END
GO
-------------------------------------------------------------------------------------------------
--�޸�tb_OutList_Tmp���еĴ�����Tr_YCTOutListSplit,�·�������Ҫ�Ӷ��ֵ
GO
/****** Object:  Trigger [dbo].[Tr_YCTOutListSplit]    Script Date: 06/23/2011 15:00:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER TRIGGER [dbo].[Tr_YCTOutListSplit]
ON [dbo].[tb_OutList_Tmp]
FOR INSERT
AS
IF (SELECT Count(*) FROM inserted WHERE TicketType = 10 and CardID <> '' and CardID <> '0') > 0 
BEGIN
	DELETE tb_YCTInList_Tmp 
	FROM inserted
	WHERE inserted.CardID <> '' and inserted.CardID <> '0' and tb_YCTInList_Tmp.CardID = inserted.CardID
	--�·������г���
	DELETE FROM tb_SendPara WHERE TableName = 'tb_YCTInList_Tmp'
	INSERT INTO tb_SendPara
	SELECT 1 as SendType, 0 as FieldName, 0 as FieldValue, LaneNo, LaneComputerIP, 
		'tb_YCTInList_Tmp' as TableName,'tb_YCTInList_Tmp' as FileName
	FROM tb_LaneUse
	--FROM tb_Lane
	--WHERE LaneTypeNo = 2
END
GO
-------------------------------------------------------------------------------------------------------
--�޸�tb_SecurityCommand���еĴ�����Tr_SecurityCommanDelete�·�������Ҫ�Ӷ��ֵ
GO
/****** Object:  Trigger [dbo].[Tr_SecurityCommandDelete]    Script Date: 06/23/2011 15:13:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER trigger [dbo].[Tr_SecurityCommandDelete]
on [dbo].[tb_SecurityCommand]
for delete     
AS
	--ɾ������Ч������ָ��,��Ҫ�����·�һ�ݰ�ȫָ�����
	if exists(select * from deleted where type=1 and attribute=0)
	begin
		declare @LaneIP char(15),@LaneNo smallint
		declare SendParaCursor_UpdateSecurityCommand cursor
			--for select LaneComputerIP,LaneNo from tb_Lane
             for select LaneComputerIP,LaneNo from tb_LaneUse 
		open SendParaCursor_UpdateSecurityCommand
		fetch next from SendParaCursor_UpdateSecurityCommand into @LaneIP,@LaneNo
		while @@fetch_status=0
		begin
			if not exists (select * from tb_SendPara where LaneNo=@LaneNo and LaneComputerIP=@LaneIP and TableName='v_securitycommand')
			begin
				insert into tb_SendPara values(1,'0','0',@LaneNo,@LaneIp,'v_securitycommand','v_securitycommand')
			end
			
			fetch next from SendParaCursor_UpdateSecurityCommand into @LaneIP,@LaneNo
		end

		close SendParaCursor_UpdateSecurityCommand
		deallocate SendParaCursor_UpdateSecurityCommand
	end
	
	--����ԭ�����ݱ��е�ָ�����ЧλΪ0
	update tb_SecurityCommandBackup set IsValid=0
	where CommandID in (select distinct CommandID from deleted) and IsValid=1

        --�Ա�����Ϊ��Ч��ָ��,�������е���ʷָ�����Ϊ��Ч
        update tb_SecurityCommandBackup set Attribute=1
        from tb_SecurityCommandBackup b, deleted d
        where b.CommandID=d.CommandID

	--�򱸷ݱ�������µı���ָ��
	insert into tb_SecurityCommandBackup
	select CommandID,CardNo,Type,ValidType,UseType,
		(select top 1 sbk.AddTime from tb_SecurityCommandBackup sbk,deleted i where sbk.CommandID=i.CommandID order by sbk.AddTime) as AddTime,
		StartTime,EndTime,getdate() OpTime,Status,1 Attribute,
		(select case when MAX(ModID) is null then 1 else MAX(ModID)+1 end from tb_SecurityCommandBackup sbk,deleted i where sbk.CommandID=i.CommandID) as ModID,
		0 OperatorType,0 OperatorNo,1
	from deleted

	--ʹ���α�������delete�еĲ�����¼�������¼������Ӳ�����¼
	declare @CommandID int,@Attribute smallint
	declare DeletedCursor cursor for select distinct CommandID,Attribute from deleted
	open DeletedCursor
	fetch next from DeletedCursor into @CommandID,@Attribute
	while @@fetch_status=0
	begin
		insert into tb_SecurityCommandOperation
		select (select case when Max(OperationID) is null then 1 else Max(OperationID)+1 end from tb_SecurityCommandOperation) as OperationID,
		3 OperationType,
		(select Max(PostModID) from tb_SecurityCommandOperation t1 where t1.CommandID=@CommandID) as 
PreModID,
     	(select Max(PostModID)+1 from tb_SecurityCommandOperation t1 where t1.CommandID=@CommandID) 
as PostModID,
	@CommandID
		
		fetch next from DeletedCursor into @CommandID,@Attribute
	end
	close DeletedCursor
	deallocate DeletedCursor
GO
------------------------------------------------------------------------------------------------------------
--�޸�tb_SecurityCommand���еĴ�����Tr_SecurityCommandInsert�·�������Ҫ�Ӷ��ֵ
GO
/****** Object:  Trigger [dbo].[Tr_SecurityCommandInsert]    Script Date: 06/23/2011 15:32:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER trigger 	[dbo].[Tr_SecurityCommandInsert]
		on [dbo].[tb_SecurityCommand] 
		for insert
AS	
	--������µ�����ָ��
	if exists(select * from inserted where type=1)
	begin
		declare @LaneIP char(15),@LaneNo smallint
		declare SendParaCursor_InsertSecurityCommand cursor
			--for select LaneComputerIP,LaneNo from tb_Lane
           for select LaneComputerIP,LaneNo from tb_LaneUse 
		open SendParaCursor_InsertSecurityCommand
		fetch next from SendParaCursor_InsertSecurityCommand into @LaneIP,@LaneNo
		while @@fetch_status=0
		begin
			if not exists (select * from tb_SendPara where LaneNo=@LaneNo and LaneComputerIP=@LaneIP and TableName='v_securitycommand')
			begin
				insert into tb_SendPara values(1,'0','0',@LaneNo,@LaneIp,'v_securitycommand','v_securitycommand')
			end
			
			fetch next from SendParaCursor_InsertSecurityCommand into @LaneIP,@LaneNo
		end

		close SendParaCursor_InsertSecurityCommand
		deallocate SendParaCursor_InsertSecurityCommand
	end
	
	--����һ�ݼ�¼��tb_SecurityCommandBackup��
	insert into tb_SecurityCommandBackup	
	select CommandID,CardNo,Type,ValidType,UseType,OpTime,StartTime,EndTime,OpTime,Status,Attribute,1,OperatorType,OperatorNo,1 	
	from inserted

	--ʹ���α�������inserted�еĲ�����¼�������¼������Ӳ�����¼
	declare @CommandID int
	declare InsertedCursor cursor for select distinct CommandID from inserted
	open InsertedCursor
	fetch next from InsertedCursor into @CommandID
	while @@fetch_status=0
	begin
		insert into tb_SecurityCommandOperation
		select (select case when Max(OperationID) is null then 1 else Max(OperationID)+1 end from tb_SecurityCommandOperation) as OperationID,
		1,1,1,@CommandID
		
		fetch next from InsertedCursor into @CommandID
	end
	close InsertedCursor
	deallocate InsertedCursor
GO
------------------------------------------------------------------------------------------------------------
--�޸�tb_SecurityCommand���еĴ�����Tr_SecurityCommandUpdate�·�������Ҫ�Ӷ��ֵ
GO
/****** Object:  Trigger [dbo].[Tr_SecurityCommandUpdate]    Script Date: 06/23/2011 15:38:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER trigger 	[dbo].[Tr_SecurityCommandUpdate]
		on [dbo].[tb_SecurityCommand] 
		for update
AS
	--�޸�������ָ��
	if exists(select * from inserted where type=1)
	begin
		declare @LaneIP char(15),@LaneNo smallint
		declare SendParaCursor_UpdateSecurityCommand cursor
			--for select LaneComputerIP,LaneNo from tb_Lane
            for select LaneComputerIP,LaneNo from tb_LaneUse 
		open SendParaCursor_UpdateSecurityCommand
		fetch next from SendParaCursor_UpdateSecurityCommand into @LaneIP,@LaneNo
		while @@fetch_status=0
		begin
			if not exists (select * from tb_SendPara where LaneNo=@LaneNo and LaneComputerIP=@LaneIP and TableName='v_securitycommand')
			begin
				insert into tb_SendPara values(1,'0','0',@LaneNo,@LaneIp,'v_securitycommand','v_securitycommand')
			end
			
			fetch next from SendParaCursor_UpdateSecurityCommand into @LaneIP,@LaneNo
		end

		close SendParaCursor_UpdateSecurityCommand
		deallocate SendParaCursor_UpdateSecurityCommand
	end
	
	--����ԭ�����ݱ��е�ָ�����ЧλΪ0
	update tb_SecurityCommandBackup set IsValid=0
	where CommandID in (select distinct CommandID from inserted) and IsValid=1

        --�Ա�����Ϊ��Ч��ָ��,�������е���ʷָ�����Ϊ��Ч
        update tb_SecurityCommandBackup set Attribute=i.Attribute
        from tb_SecurityCommandBackup b, inserted i
        where i.Attribute<>0 and b.CommandID=i.CommandID

	--�򱸷ݱ�������µı���ָ��
	insert into tb_SecurityCommandBackup
	select CommandID,CardNo,Type,ValidType,UseType,
		(select top 1 sbk.AddTime from tb_SecurityCommandBackup sbk,inserted i where sbk.CommandID=i.CommandID order by sbk.AddTime) as AddTime,
		StartTime,EndTime,OpTime,Status,Attribute,
		(select case when MAX(ModID) is null then 1 else MAX(ModID)+1 end from tb_SecurityCommandBackup sbk,inserted i where sbk.CommandID=i.CommandID) as ModID,
		OperatorType,OperatorNo,1
	from inserted

	--ʹ���α�������inserted�еĲ�����¼�������¼������Ӳ�����¼
	declare @CommandID int,@Attribute smallint
	declare InsertedCursor cursor for select distinct CommandID,Attribute from inserted
	open InsertedCursor
	fetch next from InsertedCursor into @CommandID,@Attribute
	while @@fetch_status=0
	begin
		insert into tb_SecurityCommandOperation
		select (select case when Max(OperationID) is null then 1 else Max(OperationID)+1 end from tb_SecurityCommandOperation) as OperationID,
		case @Attribute when 1 then 3 else 2 end as OperationType,
		(select Max(PostModID) from tb_SecurityCommandOperation t1 where t1.CommandID=@CommandID) as 
PreModID,
     	(select Max(PostModID)+1 from tb_SecurityCommandOperation t1 where t1.CommandID=@CommandID) 
as PostModID,
	@CommandID
		
		fetch next from InsertedCursor into @CommandID,@Attribute
	end
	close InsertedCursor
	deallocate InsertedCursor
GO

-------------------------------------------------------------------------------------------------
----------------------------�洢�������·��������Ҫ��һ��------------------------------------------
-------------------------------------------------------------------------------------------------
--�޸Ĵ洢����PROC_SendPara����һ��
GO
/****** Object:  StoredProcedure [dbo].[PROC_SendPara]    Script Date: 06/23/2011 16:19:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[PROC_SendPara](@TableName varchar(255))
AS
	delete tb_SendPara
	from tb_SendPara, (select LaneNo, LaneComputerIP from tb_Lane) tb1
	where tb_SendPara.LaneNo = tb1.LaneNo and
	tb_SendPara.LaneComputerIP = tb1.LaneComputerIP and
	tb_SendPara.TableName = @TableName
	
	insert into tb_SendPara
	select 1 as SendType, '0' as FieldName, '0' as FieldValue,
	tb1.LaneNo, tb1.LaneComputerIP, @TableName,@TableName
	from (select LaneNo, LaneComputerIP from tb_LaneUse ) tb1
GO
-------------------------------------------------------------------------------------------------
--�޸�(tb_InList_Tmp)�д�����Tr_InlistSplit
GO
/****** Object:  Trigger [dbo].[Tr_InlistSplit]    Script Date: 06/21/2011 10:19:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--�������ˮ������ݷֱ�洢
ALTER Trigger [dbo].[Tr_InlistSplit]
	on [dbo].[tb_InList_Tmp]
	for insert
As
	declare @Months						tinyint

	--���ݹ������ڣ��ֱ�洢��ˮ����
	select @Months=DATEPART(month,SquadDate) from inserted
	--��ȡ������ˮ������������ˮ
	if @Months = 1
		insert into tb_InList01 	
  		select * from inserted
  else if @Months = 2
		insert into tb_InList02 	
  		select * from inserted
  else if @Months = 3
		insert into tb_InList03 	
  		select * from inserted
  else if @Months = 4
		insert into tb_InList04 	
  		select * from inserted
  else if @Months = 5
		insert into tb_InList05 	
  		select * from inserted
  else if @Months = 6
		insert into tb_InList06 	
  		select * from inserted
  else if @Months = 7
		insert into tb_InList07 	
  		select * from inserted
  else if @Months = 8
		insert into tb_InList08 	
  		select * from inserted
  else if @Months = 9
		insert into tb_InList09 	
  		select * from inserted
  else if @Months = 10
		insert into tb_InList10 	
  		select * from inserted
  else if @Months = 11
  		insert into tb_InList11 	
  		select * from inserted
  else if @Months = 12
		insert into tb_InList12 	
  		select * from inserted

	--�޸�tb_CardDynamic���¼��cardNo>0�����ݲŲ���
	if exists (select t1.cardno from tb_CardDynamic t1, inserted t2
				where t1.cardno=t2.cardno and t2.CardNo>0)
	begin
		update tb_CardDynamic set UserCardType=t2.UserCardType,status=11, Optime=t2.Optime, ParkNo=t2.ParkNo,
				 GateNo=t2.GateNo, LaneNo=t2.LaneNo,VehType=t2.Vehtype,VehPlate = t2.VehPlate,OperatorNo = t2.OperatorNo,
				 OperatorName = t2.OperatorName,SquadDate = t2.SquadDate,SquadNo=t2.SquadNo,InListNo=t2.ListNo,OutListNo='',
				 Owner=' ',VehBrand='',TicKetType=t2.TicKetType,GateName=t2.GateName 
		from tb_CardDynamic t1, inserted t2
		where t1.OpTime < t2.OpTime and t1.cardno = t2.cardno
		
	end
	else
	begin
		insert into tb_CardDynamic select CardNo, 11, OpTime, ParkNo, GateNo, LaneNo, VehPlate ,OperatorNo ,
OperatorName ,SquadDate ,' ',UserCardType,VehType,SquadNo,ListNo,' ',' ', TicKetType,GateName
		from inserted t1
		where t1.CardNo>0
	end

	--  ͳ����ˮ��Ϣ��������
	declare		@iAreaNo		smallint
  	declare		@iParkNo		smallint
  	declare		@iGateNo		smallint
  	declare		@iLaneNo		smallint
  	declare		@dtSquadDate	DATETIME
  	declare		@iSquadNo		smallint
  	declare		@iOperatorNo	integer
  	declare		@iCashMoney		smallint
  	declare		@dtUploadTime	DATETIME

	declare cur_inserted cursor
	for
	select AreaNo,ParkNo,GateNo,LaneNo,SquadDate,SquadNo,OperatorNo,
		   0 CashMoney,UploadTime
	from inserted
	for read only
	
	open cur_inserted
	/* get the first row from the cursor */
	fetch next from cur_inserted into @iAreaNo,@iParkNo,@iGateNo,@iLaneNo,
									  @dtSquadDate,@iSquadNo,@iOperatorNo,
									  @iCashMoney,@dtUploadTime
	
	/* loop the rows in the cursor*/
	while @@fetch_status = 0
	begin
		
	   	-- ���� tb_LaneStatus ��	   	
	   	exec Proc_UpdateLaneStatus @iAreaNo,@iParkNo,@iGateNo,@iLaneNo,@dtSquadDate,@iSquadNo,@iOperatorNo,@iCashMoney,@dtUploadTime
	   	
	   	-- ���� tb_StaVehCount ��
	   	-- exec sp_UpdateStaVehCount @iAreaNo,@iParkNo,@iGateNo,@iVehCount,@dtOpTime,2
	   	
	   	/* get next row */
		fetch next from cur_inserted into @iAreaNo,@iParkNo,@iGateNo,@iLaneNo,
										  @dtSquadDate,@iSquadNo,@iOperatorNo,
									  	  @iCashMoney,@dtUploadTime
	end 
	/* close the cursor */
	deallocate cur_inserted 

  delete from tb_Inlist_Tmp
-------------------------------------------------------------------------------------------------
--�޸�(tb_OutList_Tmp)�д�����Tr_OutlistSplit

GO
/****** Object:  Trigger [dbo].[Tr_OutlistSplit]    Script Date: 06/21/2011 11:44:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--��������ˮ������ݷֱ�洢
ALTER Trigger [dbo].[Tr_OutlistSplit]
	on [dbo].[tb_OutList_Tmp]
	for insert
As
	declare @Months						tinyint

	--���ݹ������ڣ��ֱ�洢��ˮ����
	select @Months=DATEPART(month,SquadDate) from inserted
	--��ȡ������ˮ������������ˮ
	if @Months = 1
		insert into tb_OutList01 	
  		select * from inserted
  else if @Months = 2
		insert into tb_OutList02 	
  		select * from inserted
  else if @Months = 3
		insert into tb_OutList03 	
  		select * from inserted
  else if @Months = 4
		insert into tb_OutList04 	
  		select * from inserted
  else if @Months = 5
		insert into tb_OutList05 	
  		select * from inserted
  else if @Months = 6
		insert into tb_OutList06 	
  		select * from inserted
  else if @Months = 7
		insert into tb_OutList07 	
  		select * from inserted
  else if @Months = 8
		insert into tb_OutList08 	
  		select * from inserted
  else if @Months = 9
		insert into tb_OutList09 	
  		select * from inserted
  else if @Months = 10
		insert into tb_OutList10 	
  		select * from inserted
  else if @Months = 11
  	insert into tb_OutList11 	
  		select * from inserted
  else if @Months = 12
		insert into tb_OutList12 	
  		select * from inserted
  	
	--�޸�tb_CardDynamic���¼��cardNo>0�����ݲŲ���
	if exists (select t1.cardno from tb_CardDynamic t1, inserted t2
				where t1.cardno=t2.cardno and t2.CardNo>0)
	begin
		update tb_CardDynamic set UserCardType=t2.UserCardType,status=12, Optime=t2.Optime, ParkNo=t2.ParkNo,
				 GateNo=t2.GateNo, LaneNo=t2.LaneNo,VehType=t2.Vehtype,VehPlate = t2.VehPlate,OperatorNo = t2.OperatorNo,
				 OperatorName = t2.OperatorName,SquadDate = t2.SquadDate,SquadNo=t2.SquadNo,InListNo='',OutListNo=t2.ListNo,
				 Owner=' ',VehBrand='',TicKetType=t2.TicKetType,GateName=t2.GateName 
		from tb_CardDynamic t1, inserted t2
		where t1.cardno = t2.cardno and t1.OpTime < t2.OpTime
		
	end
	else
	begin
		insert into tb_CardDynamic select CardNo, 12, OpTime, ParkNo, GateNo, LaneNo, VehPlate ,OperatorNo ,
OperatorName ,SquadDate ,' ',UserCardType,VehType,SquadNo,' ',ListNo,' ', TicKetType,GateName
		from inserted t1
		where t1.CardNo>0
	end

	--�����ˮ��¼�������¼���"����"(��8λ), �޸�tb_CardDynamic����ʱ����״̬Ϊ"����"(13)
	if exists (select t1.cardno from tb_CardDynamic t1, inserted t2
                    where t2.spevent&0x00000080<>0 and t1.cardno=t2.cardno and t1.optime<t2.optime)
	begin
                update tb_CardDynamic set Status=13
                from tb_CardDynamic t1, inserted t2
                where t2.spevent&0x00000080<>0 and t1.cardno=t2.cardno and t1.optime<t2.optime
	end

	--�����ˮ��¼�������¼���"����"(��9λ), �޸�tb_CardDynamic����ʱ����״̬Ϊ"����"(15)
	if exists (select t1.cardno from tb_CardDynamic t1, inserted t2
                    where t2.spevent&0x00000100<>0 and t1.cardno=t2.cardno and t1.optime<t2.optime)
	begin
                update tb_CardDynamic set Status=15
                from tb_CardDynamic t1, inserted t2
                where t2.spevent&0x00000100<>0 and t1.cardno=t2.cardno and t1.optime<t2.optime
	end

	--  ͳ����ˮ��Ϣ��������
	declare		@iAreaNo		smallint
  	declare		@iParkNo		smallint
  	declare		@iGateNo		smallint
  	declare		@iLaneNo		smallint
  	declare		@dtSquadDate	DATETIME
  	declare		@iSquadNo		smallint
  	declare		@iOperatorNo	integer
  	declare		@iCashMoney		smallint
  	declare		@dtUploadTime	DATETIME

	declare cur_inserted cursor
	for
	select AreaNo,ParkNo,GateNo,LaneNo,SquadDate,SquadNo,OperatorNo,
		   CashMoney,UploadTime
	from inserted
	for read only
	
	open cur_inserted
	/* get the first row from the cursor */
	fetch next from cur_inserted into @iAreaNo,@iParkNo,@iGateNo,@iLaneNo,
									  @dtSquadDate,@iSquadNo,@iOperatorNo,
									  @iCashMoney,@dtUploadTime
	
	/* loop the rows in the cursor*/
	while @@fetch_status = 0
	begin
		
	   	-- ���� tb_LaneStatus ��	   	
	   	exec Proc_UpdateLaneStatus @iAreaNo,@iParkNo,@iGateNo,@iLaneNo,@dtSquadDate,@iSquadNo,@iOperatorNo,@iCashMoney,@dtUploadTime
	   	
	   	-- ���� tb_StaVehCount ��
	   	-- exec sp_UpdateStaVehCount @iAreaNo,@iParkNo,@iGateNo,@iVehCount,@dtOpTime,2
	   	
	   	/* get next row */
		fetch next from cur_inserted into @iAreaNo,@iParkNo,@iGateNo,@iLaneNo,
										  @dtSquadDate,@iSquadNo,@iOperatorNo,
									  	  @iCashMoney,@dtUploadTime
	end 
	/* close the cursor */
	deallocate cur_inserted 

  delete from tb_Outlist_Tmp
---------------------һ���೵----------------------------------------------------------------------------
 --�жϱ�tb_CardGroup�Ƿ���ڣ�������ʱ�򴴽�
GO
if not exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_CardGroup]') and OBJECTPROPERTY(id,N'IsUserTable') = 1) 
CREATE TABLE [dbo].[tb_CardGroup](
	[RecNo] [int] NOT NULL,
	[CardNo] [varchar](16) NOT NULL,
	[VehPlate] [varchar](10) NOT NULL,
	[GroupNo] [int] NOT NULL,
	[FirstInOut] [int] ,
	[Optime] [datetime] ,
	[LaneGroupNo] [int] NOT NULL,
	constraint pk_pams_CardGroup_id primary key(RecNo,LaneGroupNo),
	)
GO
-------------------------------------------------------------------------------------------------

  --�жϱ�tb_CardGroupInfo�Ƿ���ڣ�������ʱ�򴴽�
GO
if not exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_CardGroupInfo]') and OBJECTPROPERTY(id,N'IsUserTable') = 1) 
CREATE TABLE [dbo].[tb_CardGroupInfo](
	[GroupNo] [int] NOT NULL,
	[LaneGroupNo] [char](1) NOT NULL,
	[GroupName] [varchar](20) NOT NULL,
	[ParkSum] [int] ,
	[ParkRemant] [int] ,
	[Optime] [datetime] ,
	constraint pk_pams_CardGroupInfo_id primary key(GroupNo,LaneGroupNo),
	)
-----------------------------------��ݿ�����-------------------------------------------------------------
--�жϱ�tb_IDCardInfo�Ƿ���ڣ�������ʱ�򴴽�
GO
if not exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_IDCardInfo]') and OBJECTPROPERTY(id,N'IsUserTable') = 1) 
CREATE TABLE [dbo].[tb_IDCardInfo](
	[IDCardNo] [varchar](10) primary key,
	[UserName] [varchar](16) NOT NULL,
	[Department] [varchar](40) NOT NULL,
	[Job] [varchar](40) NOT NULL,
	[PlateList] [varchar](255) NOT NULL,
	[Photo] [image] NULL,
	)
GO
-------------------------------------------------------------------------------------------------


GO
-------------------------------------------------------------------------------------------------

GO
-------------------------------------------------------------------------------------------------
--ͼ���ѯ��أ�
--ԭ��ԭ���Ĵ洢���̲��ģ��ڲ�������ˮʱ�������ֵ��õĴ洢���̲�����һ��ʱ�����²�����ʽ������Ӧ�Ĵ洢����

/*
 *ԭ��ʹ�õ�
 */
--���ݿ��Ų��������ˮ������Ƕ��洢���̣�
if exists ( select * from dbo.sysobjects where id = object_id(N'[dbo].[proc_FindInListByCardNo2Table]') and OBJECTPROPERTY(id,N'IsProcedure') = 1)
drop Procedure [dbo].[proc_FindInListByCardNo2Table]
go
create procedure proc_FindInListByCardNo2Table
	@MonthNum int,
	@RecordCount int,
	@CardNO	int,
	--@LaneFlg int,		--1:��Χ����,	����:����
	@SpeventFlg int 	--1:������,		����:����
as
begin
	declare @iMonth int
	declare @iCount int
	declare @iRecord int


	set @iMonth = month(getdate()+1)
	set @iCount = 0
	set @iRecord = @RecordCount


	while(@iCount<@MonthNum and @iRecord>0)
	begin
		set rowcount @iRecord
		if(@iMonth=1)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist01
				WITH(index(idx_card_in)) where cardno=@CardNO and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=2)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist02
				WITH(index(idx_card_in)) where cardno=@CardNO and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=3)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist03
				WITH(index(idx_card_in)) where cardno=@CardNO and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=4)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist04
				WITH(index(idx_card_in)) where cardno=@CardNO and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=5)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist05
				WITH(index(idx_card_in)) where cardno=@CardNO and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=6)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist06
				WITH(index(idx_card_in)) where cardno=@CardNO and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=7)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist07
				WITH(index(idx_card_in)) where cardno=@CardNO and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=8)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist08
				WITH(index(idx_card_in)) where cardno=@CardNO and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=9)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist09
				WITH(index(idx_card_in)) where cardno=@CardNO and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=10)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist10
				WITH(index(idx_card_in)) where cardno=@CardNO and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=11)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist11
				WITH(index(idx_card_in)) where cardno=@CardNO and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=12)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist12
				WITH(index(idx_card_in)) where cardno=@CardNO and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc

		set @iRecord = @iRecord - @@ROWCOUNT
		set @iCount = @iCount + 1

		if (@iMonth=1)	set @iMonth = 12
		else		set @iMonth = @iMonth - 1
	end

	set rowcount 0

--	select * from #t_list
-- order by optime desc

end
GO


--���ݳ��Ʋ��������ˮ������Ƕ��洢���̣�
if exists ( select * from dbo.sysobjects where id = object_id(N'[dbo].[proc_FindInListByVehPlate2Table]') and OBJECTPROPERTY(id,N'IsProcedure') = 1)
drop Procedure [dbo].[proc_FindInListByVehPlate2Table]
go
create procedure proc_FindInListByVehPlate2Table
	@MonthNum int,
	@RecordCount int,
	@VehPlate VARCHAR(10),
	--@LaneFlg int,		--1:��Χ����,	����:����
	@SpeventFlg int 	--1:������,		����:����
as
begin
	declare @iMonth int
	declare @iCount int
	declare @iRecord int

	set @iMonth = month(getdate()+1)
	set @iCount = 0
	set @iRecord = @RecordCount

	while(@iCount<@MonthNum and @iRecord>0)
	begin
		set rowcount @iRecord
		if(@iMonth=1)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist01
				where Vehplate like @VehPlate and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=2)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist02
				where Vehplate like @VehPlate and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=3)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist03
				where Vehplate like @VehPlate and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=4)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist04
				where Vehplate like @VehPlate and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=5)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist05
				where Vehplate like @VehPlate and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=6)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist06
				where Vehplate like @VehPlate and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=7)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist07
				where Vehplate like @VehPlate and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=8)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist08
				where Vehplate like @VehPlate and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=9)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist09
				where Vehplate like @VehPlate and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=10)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist10
				where Vehplate like @VehPlate and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=11)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist11
				where Vehplate like @VehPlate and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=12)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist12
				where Vehplate like @VehPlate and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc

		set @iRecord = @iRecord - @@ROWCOUNT
		set @iCount = @iCount + 1

		if (@iMonth=1)	set @iMonth = 12
		else		set @iMonth = @iMonth - 1
	end

	set rowcount 0

-- select * from #t_list
-- order by optime desc

end
GO



--�����ˮ��ѯ�����ţ��������ݿ��Ų�ѯ��ڣ�
if exists ( select * from dbo.sysobjects where id = object_id(N'[dbo].[proc_FindInListByCardNo]') and OBJECTPROPERTY(id,N'IsProcedure') = 1)
drop Procedure [dbo].[proc_FindInListByCardNo]
go
create procedure proc_FindInListByCardNo
	@MonthNum int,
	@RecordCount int,
	@CardNO	int,
	@SpeventFlg int 	--1:������,		����:����
as
begin
	create table #t_list(
	[ListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[ParkNo] [smallint] NULL,
	[GateNo] [smallint] NULL ,
	[GateName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[LaneNo] [smallint] NULL ,
	[CardNo] [int] NULL ,
	[OpTime] [datetime] NULL ,
	[SquadDate] [datetime] NULL,
	[VehPlate] [varchar] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[usercardtype] [smallint] NULL,
	[Flg]	[smallint] NOT NULL )

	exec proc_FindInListByCardNo2Table @MonthNum,@RecordCount,@CardNO,@SpeventFlg

	update #t_list set flg=1 from #t_list a ,tb_carddynamic b where a.cardno=b.cardno and a.optime<b.optime
	if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_usercarddynamic]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
		update #t_list set flg=1 from #t_list a ,tb_usercarddynamic b where a.cardno=b.cardno and a.optime<b.optime

	select * from #t_list order by optime desc
end
GO



--�����ˮ��ѯ�����ƣ��������ݳ��Ʋ�ѯ��ڣ�
if exists ( select * from dbo.sysobjects where id = object_id(N'[dbo].[proc_FindInListByVehPlate]') and OBJECTPROPERTY(id,N'IsProcedure') = 1)
drop Procedure [dbo].[proc_FindInListByVehPlate]
go
create procedure proc_FindInListByVehPlate
	@MonthNum int,
	@RecordCount int,
	@VehPlate VARCHAR(10),
	@SpeventFlg int 	--1:������,		����:����
as
begin
	create table #t_list(
	[ListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[ParkNo] [smallint] NULL,
	[GateNo] [smallint] NULL ,
	[GateName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[LaneNo] [smallint] NULL ,
	[CardNo] [int] NULL ,
	[OpTime] [datetime] NULL ,
	[SquadDate] [datetime] NULL,
	[VehPlate] [varchar] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[usercardtype] [smallint] NULL,
	[Flg]	[smallint] NOT NULL )

	exec proc_FindInListByVehplate2Table @MonthNum,@RecordCount,@VehPlate,@SpeventFlg

	update #t_list set flg=1 from #t_list a ,tb_carddynamic b where a.cardno=b.cardno and a.optime<b.optime
	if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_usercarddynamic]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
		update #t_list set flg=1 from #t_list a ,tb_usercarddynamic b where a.cardno=b.cardno and a.optime<b.optime

	select * from #t_list order by optime desc
end
GO



--�� ����̬���в�
if exists ( select * from dbo.sysobjects where id = object_id(N'[dbo].[proc_FindInListByListNo]') and OBJECTPROPERTY(id,N'IsProcedure') = 1)
drop Procedure [dbo].[proc_FindInListByListNo]
go
create procedure proc_FindInListByListNo
	@ListNo	Char(16)
as
begin
	declare @iMonth int
	declare @iCount int
	declare @iRecord int
	declare @t_list table(
	[ListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[ParkNo] [smallint] NULL,
	[GateNo] [smallint] NULL ,
	[GateName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[LaneNo] [smallint] NULL ,
	[CardNo] [int] NULL ,
	[OpTime] [datetime] NULL ,
	[SquadDate] [datetime] NULL,
	[VehPlate] [varchar] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[usercardtype] [smallint] NULL,
	[Flg]	[smallint] NOT NULL )

	insert @t_list
	select inlistno as listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype, (case when Status=12 then 1 else 0 end) as flg
	from tb_CardDynamic
	where inlistno=@ListNo
	order by optime desc

	select * from @t_list order by optime desc

end
GO



/*
 *������
 */
--���ݿ��Ų��������ˮ
if exists ( select * from dbo.sysobjects where id = object_id(N'[dbo].[proc_FindOutListByCardNo]') and OBJECTPROPERTY(id,N'IsProcedure') = 1)
drop Procedure [dbo].[proc_FindOutListByCardNo]
go

CREATE   proc proc_FindOutListByCardNo
	@MonthNum int,
	@RecordCount int,
	@CardNO	int
as
begin
	declare @iMonth int
	declare @iCount int
	declare @iRecord int


	set @iMonth = month(getdate()+1)
	--set @iMonth = month(getdate())
	set @iCount = 0
	set @iRecord = @RecordCount

	while(@iCount<@MonthNum and @iRecord>0)
	begin
		set rowcount @iRecord
		if(@iMonth=1)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,1 from tb_outlist01 where cardno=@CardNO order by optime desc
		else if(@iMonth=2)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,1 from tb_outlist02 where cardno=@CardNO order by optime desc
		else if(@iMonth=3)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,1 from tb_outlist03 where cardno=@CardNO order by optime desc
		else if(@iMonth=4)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,1 from tb_outlist04 where cardno=@CardNO order by optime desc
		else if(@iMonth=5)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,1 from tb_outlist05 where cardno=@CardNO order by optime desc
		else if(@iMonth=6)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,1 from tb_outlist06 where cardno=@CardNO order by optime desc
		else if(@iMonth=7)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,1 from tb_outlist07 where cardno=@CardNO order by optime desc
		else if(@iMonth=8)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,1 from tb_outlist08 where cardno=@CardNO order by optime desc
		else if(@iMonth=9)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,1 from tb_outlist09 where cardno=@CardNO order by optime desc
		else if(@iMonth=10)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,1 from tb_outlist10 where cardno=@CardNO order by optime desc
		else if(@iMonth=11)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,1 from tb_outlist11 where cardno=@CardNO order by optime desc
		else if(@iMonth=12)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,1 from tb_outlist12 where cardno=@CardNO order by optime desc

		set @iRecord = @iRecord - @@ROWCOUNT
		set @iCount = @iCount + 1

		if (@iMonth=1)	set @iMonth = 12
		else		set @iMonth = @iMonth - 1
	end

	set rowcount 0

--	select * from #t_list
-- order by optime desc

end
GO


--���ݳ��Ʋ��������ˮ
if exists ( select * from dbo.sysobjects where id = object_id(N'[dbo].[proc_FindOutListByVehPlate]') and OBJECTPROPERTY(id,N'IsProcedure') = 1)
drop Procedure [dbo].[proc_FindOutListByVehPlate]
go

CREATE       proc proc_FindOutListByVehPlate
	@MonthNum int,
	@RecordCount int,
	@VehPlate VARCHAR(10),
    @StartTime datetime,
    @EndTime   datetime
as
begin
	declare @iMonth int
	declare @iCount int
	declare @iRecord int


	--set @iMonth = month(getdate()+1)
	--set @iMonth = month(getdate())

    set @iMonth = month(@EndTime + 1)

	set @iCount = 0
	set @iRecord = @RecordCount

	while(@iCount<@MonthNum and @iRecord>0)
	begin
		set rowcount @iRecord
		if(@iMonth=1)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,1
            from tb_outlist01 WITH(index(idx_veh_out)) where Optime between @StartTime and @EndTime and Vehplate like @VehPlate order by optime desc
		else if(@iMonth=2)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,1
            from tb_outlist02 WITH(index(idx_veh_out)) where Optime between @StartTime and @EndTime and Vehplate like @VehPlate order by optime desc
		else if(@iMonth=3)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,1
            from tb_outlist03 WITH(index(idx_veh_out)) where Optime between @StartTime and @EndTime and Vehplate like @VehPlate order by optime desc
		else if(@iMonth=4)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,1
            from tb_outlist04 WITH(index(idx_veh_out)) where Optime between @StartTime and @EndTime and Vehplate like @VehPlate order by optime desc
		else if(@iMonth=5)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,1
            from tb_outlist05 WITH(index(idx_veh_out)) where Optime between @StartTime and @EndTime and Vehplate like @VehPlate order by optime desc
		else if(@iMonth=6)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,1
            from tb_outlist06 WITH(index(idx_veh_out)) where Optime between @StartTime and @EndTime and Vehplate like @VehPlate order by optime desc
		else if(@iMonth=7)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,1
            from tb_outlist07 WITH(index(idx_veh_out)) where Optime between @StartTime and @EndTime and Vehplate like @VehPlate order by optime desc
		else if(@iMonth=8)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,1
            from tb_outlist08 WITH(index(idx_veh_out)) where Optime between @StartTime and @EndTime and Vehplate like @VehPlate order by optime desc
		else if(@iMonth=9)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,1
            from tb_outlist09 WITH(index(idx_veh_out)) where Optime between @StartTime and @EndTime and Vehplate like @VehPlate order by optime desc
		else if(@iMonth=10)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,1
            from tb_outlist10 WITH(index(idx_veh_out)) where Optime between @StartTime and @EndTime and Vehplate like @VehPlate order by optime desc
		else if(@iMonth=11)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,1
            from tb_outlist11 WITH(index(idx_veh_out)) where Optime between @StartTime and @EndTime and Vehplate like @VehPlate order by optime desc
		else if(@iMonth=12)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,1
            from tb_outlist12 WITH(index(idx_veh_out)) where Optime between @StartTime and @EndTime and Vehplate like @VehPlate order by optime desc

		set @iRecord = @iRecord - @@ROWCOUNT
		set @iCount = @iCount + 1

		if (@iMonth=1)	set @iMonth = 12
		else		set @iMonth = @iMonth - 1
	end

	set rowcount 0

--	select * from #t_list
-- order by optime desc

end
Go


-- �������Ҫ��tb_LaneGroup�����Ϊͳһ�汾�����Ӹø����ֵ���ͼ
if exists (select table_name from information_schema.views where table_name = 'tb_LaneGroup')
drop view tb_LaneGroup
Go

create view tb_LaneGroup
as
	Select 1 as LaneGroupNo,LaneNo,LaneTypeNo
	From tb_Lane

Go



--���ݿ��Ų��������ˮ
if exists ( select * from dbo.sysobjects where id = object_id(N'[dbo].[proc_FindInListByCardNo2Table_Ex]') and OBJECTPROPERTY(id,N'IsProcedure') = 1)
drop Procedure [dbo].[proc_FindInListByCardNo2Table_Ex]
go
CREATE    proc proc_FindInListByCardNo2Table_Ex
	@MonthNum int,
	@RecordCount int,
	@CardNO	int,
	@LaneFlg int,		--1:��Χ����,	����:����
	@SpeventFlg int 	--1:������,		����:����
as
begin
	declare @iMonth int
	declare @iCount int
	declare @iRecord int


	set @iMonth = month(getdate()+1)
	--set @iMonth = month(getdate())
	set @iCount = 0
	set @iRecord = @RecordCount


	while(@iCount<@MonthNum and @iRecord>0)
	begin
		set rowcount @iRecord
		if(@iMonth=1)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist01
				where cardno=@CardNO and (@LaneFlg<>1 or LaneNo in (select LaneNo from tb_lanegroup where LaneGroupNo = 1 and LaneTypeNo = 1))
					and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=2)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist02
				where cardno=@CardNO and (@LaneFlg<>1 or LaneNo in (select LaneNo from tb_lanegroup where LaneGroupNo = 1 and LaneTypeNo = 1))
					and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=3)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist03
				where cardno=@CardNO and (@LaneFlg<>1 or LaneNo in (select LaneNo from tb_lanegroup where LaneGroupNo = 1 and LaneTypeNo = 1))
					and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=4)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist04
				where cardno=@CardNO and (@LaneFlg<>1 or LaneNo in (select LaneNo from tb_lanegroup where LaneGroupNo = 1 and LaneTypeNo = 1))
					and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=5)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist05
				where cardno=@CardNO and (@LaneFlg<>1 or LaneNo in (select LaneNo from tb_lanegroup where LaneGroupNo = 1 and LaneTypeNo = 1))
					and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=6)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist06
				where cardno=@CardNO and (@LaneFlg<>1 or LaneNo in (select LaneNo from tb_lanegroup where LaneGroupNo = 1 and LaneTypeNo = 1))
					and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=7)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist07
				where cardno=@CardNO and (@LaneFlg<>1 or LaneNo in (select LaneNo from tb_lanegroup where LaneGroupNo = 1 and LaneTypeNo = 1))
					and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=8)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist08
				where cardno=@CardNO and (@LaneFlg<>1 or LaneNo in (select LaneNo from tb_lanegroup where LaneGroupNo = 1 and LaneTypeNo = 1))
					and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=9)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist09
				where cardno=@CardNO and (@LaneFlg<>1 or LaneNo in (select LaneNo from tb_lanegroup where LaneGroupNo = 1 and LaneTypeNo = 1))
					and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=10)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist10
				where cardno=@CardNO and (@LaneFlg<>1 or LaneNo in (select LaneNo from tb_lanegroup where LaneGroupNo = 1 and LaneTypeNo = 1))
					and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=11)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist11
				where cardno=@CardNO and (@LaneFlg<>1 or LaneNo in (select LaneNo from tb_lanegroup where LaneGroupNo = 1 and LaneTypeNo = 1))
					and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=12)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist12
				where cardno=@CardNO and (@LaneFlg<>1 or LaneNo in (select LaneNo from tb_lanegroup where LaneGroupNo = 1 and LaneTypeNo = 1))
					and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc

		set @iRecord = @iRecord - @@ROWCOUNT
		set @iCount = @iCount + 1

		if (@iMonth=1)	set @iMonth = 12
		else		set @iMonth = @iMonth - 1
	end

	set rowcount 0

--	select * from #t_list
-- order by optime desc

end
GO



--���ݳ��Ʋ��������ˮ
if exists ( select * from dbo.sysobjects where id = object_id(N'[dbo].[proc_FindInListByVehPlate2Table_Ex]') and OBJECTPROPERTY(id,N'IsProcedure') = 1)
drop Procedure [dbo].[proc_FindInListByVehPlate2Table_Ex]
go
CREATE     proc proc_FindInListByVehPlate2Table_Ex
	@MonthNum int,
	@RecordCount int,
	@VehPlate VARCHAR(10),
	@LaneFlg int,		--1:��Χ����,	����:����
	@SpeventFlg int, 	--1:������,		����:����
    @StartTime  datetime,
    @EndTime    datetime
as
begin
	declare @iMonth int
	declare @iCount int
	declare @iRecord int

	--set @iMonth = month(getdate()+1)
	--set @iMonth = month(getdate())
--�µ����һ���鵽��һ���µı�
    set @iMonth = month(@EndTime + 1)
	set @iCount = 0
	set @iRecord = @RecordCount

	while(@iCount<@MonthNum and @iRecord>0)
	begin
		set rowcount @iRecord
		if(@iMonth=1)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist01 WITH(index(idx_veh_in))
				where Optime between @StartTime and @EndTime and
                Vehplate like @VehPlate and (@LaneFlg<>1 or LaneNo in (select LaneNo from tb_lanegroup where LaneGroupNo = 1 and LaneTypeNo = 1))
					and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=2)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist02 WITH(index(idx_veh_in))
				where Optime between @StartTime and @EndTime and
                Vehplate like @VehPlate and (@LaneFlg<>1 or LaneNo in (select LaneNo from tb_lanegroup where LaneGroupNo = 1 and LaneTypeNo = 1))
					and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=3)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist03 WITH(index(idx_veh_in))
				where Optime between @StartTime and @EndTime and
                Vehplate like @VehPlate and (@LaneFlg<>1 or LaneNo in (select LaneNo from tb_lanegroup where LaneGroupNo = 1 and LaneTypeNo = 1))
					and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=4)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist04 WITH(index(idx_veh_in))
				where Optime between @StartTime and @EndTime and
                Vehplate like @VehPlate and (@LaneFlg<>1 or LaneNo in (select LaneNo from tb_lanegroup where LaneGroupNo = 1 and LaneTypeNo = 1))
					and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=5)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist05 WITH(index(idx_veh_in))
				where Optime between @StartTime and @EndTime and
                Vehplate like @VehPlate and (@LaneFlg<>1 or LaneNo in (select LaneNo from tb_lanegroup where LaneGroupNo = 1 and LaneTypeNo = 1))
					and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=6)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist06 WITH(index(idx_veh_in))
				where Optime between @StartTime and @EndTime and
                Vehplate like @VehPlate and (@LaneFlg<>1 or LaneNo in (select LaneNo from tb_lanegroup where LaneGroupNo = 1 and LaneTypeNo = 1))
					and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=7)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist07 WITH(index(idx_veh_in))
				where Optime between @StartTime and @EndTime and
                Vehplate like @VehPlate and (@LaneFlg<>1 or LaneNo in (select LaneNo from tb_lanegroup where LaneGroupNo = 1 and LaneTypeNo = 1))
					and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=8)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist08 WITH(index(idx_veh_in))
				where Optime between @StartTime and @EndTime and
                Vehplate like @VehPlate and (@LaneFlg<>1 or LaneNo in (select LaneNo from tb_lanegroup where LaneGroupNo = 1 and LaneTypeNo = 1))
					and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=9)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist09 WITH(index(idx_veh_in))
				where Optime between @StartTime and @EndTime and
                Vehplate like @VehPlate and (@LaneFlg<>1 or LaneNo in (select LaneNo from tb_lanegroup where LaneGroupNo = 1 and LaneTypeNo = 1))
					and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=10)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist10 WITH(index(idx_veh_in))
				where Optime between @StartTime and @EndTime and
                Vehplate like @VehPlate and (@LaneFlg<>1 or LaneNo in (select LaneNo from tb_lanegroup where LaneGroupNo = 1 and LaneTypeNo = 1))
					and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=11)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist11 WITH(index(idx_veh_in))
				where Optime between @StartTime and @EndTime and
                Vehplate like @VehPlate and (@LaneFlg<>1 or LaneNo in (select LaneNo from tb_lanegroup where LaneGroupNo = 1 and LaneTypeNo = 1))
					and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc
		else if(@iMonth=12)
			insert into #t_list select listno,parkno,gateno,gatename,laneno,cardno,optime,squaddate,vehplate,usercardtype,0 from tb_inlist12 WITH(index(idx_veh_in))
				where Optime between @StartTime and @EndTime and
                Vehplate like @VehPlate and (@LaneFlg<>1 or LaneNo in (select LaneNo from tb_lanegroup where LaneGroupNo = 1 and LaneTypeNo = 1))
					and (@SpeventFlg<>1 or (SpEvent&0x8000 <> 0 or SpEvent&0x400000 <> 0))	order by optime desc

		set @iRecord = @iRecord - @@ROWCOUNT
		set @iCount = @iCount + 1

		if (@iMonth=1)	set @iMonth = 12
		else		set @iMonth = @iMonth - 1
	end

	set rowcount 0

-- select * from #t_list
-- order by optime desc

end
GO

--����ڲ�ѯ
if exists ( select * from dbo.sysobjects where id = object_id(N'[dbo].[proc_FindInOutListByCardNO]') and OBJECTPROPERTY(id,N'IsProcedure') = 1)
drop Procedure [dbo].[proc_FindInOutListByCardNO]
go
create proc proc_FindInOutListByCardNO
	@MonthNum int,
	@RecordCount int,
	@CardNO	int
as
begin
	create table #t_list(
	[ListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[ParkNo] [smallint] NULL,
	[GateNo] [smallint] NULL ,
	[GateName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[LaneNo] [smallint] NULL ,
	[CardNo] [int] NULL ,
	[OpTime] [datetime] NULL ,
	[SquadDate] [datetime] NULL,
	[VehPlate] [varchar] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[usercardtype] [smallint] NULL,
	[Flg]	[smallint] NOT NULL )

	exec proc_FindInListByCardNo2Table_Ex @MonthNum,@RecordCount,@CardNO,0,0
	exec proc_FindOutListByCardNo @MonthNum,@RecordCount,@CardNO

	select * from #t_list order by optime desc

end
GO

--����ڲ�ѯ
if exists ( select * from dbo.sysobjects where id = object_id(N'[dbo].[proc_FindInOutListByVehPlate]') and OBJECTPROPERTY(id,N'IsProcedure') = 1)
drop Procedure [dbo].[proc_FindInOutListByVehPlate]
go
CREATE   proc proc_FindInOutListByVehPlate
	@MonthNum int,
	@RecordCount int,
	@VehPlate VARCHAR(10),
    @StartTime datetime,
    @EndTime   datetime
as
begin
	create table #t_list(
	[ListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[ParkNo] [smallint] NULL,
	[GateNo] [smallint] NULL ,
	[GateName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[LaneNo] [smallint] NULL ,
	[CardNo] [int] NULL ,
	[OpTime] [datetime] NULL ,
	[SquadDate] [datetime] NULL,
	[VehPlate] [varchar] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[usercardtype] [smallint] NULL,
	[Flg]	[smallint] NOT NULL )

    --declare @MonthNum int

    --set @MonthNum = ABS(Month(@EndTime + 1) - Month(@StartTime)) + 1
    --������������Ҫ��12ȡģ
    set @MonthNum = (Month(@EndTime + 1) - Month(@StartTime) + 12)%12 + 1

	exec proc_FindInListByVehPlate2Table_Ex @MonthNum,@RecordCount,@VehPlate,0,0,@StartTime,@EndTime
	exec proc_FindOutListByVehPlate @MonthNum,@RecordCount,@VehPlate,@StartTime,@EndTime

	select * from #t_list order by optime desc

end

GO


--�����ˮ��ѯ������
--����ڲ�ѯ
if exists ( select * from dbo.sysobjects where id = object_id(N'[dbo].[proc_FindInListByVehPlate_Ex]') and OBJECTPROPERTY(id,N'IsProcedure') = 1)
drop Procedure [dbo].[proc_FindInListByVehPlate_Ex]
go
CREATE   proc proc_FindInListByVehPlate_Ex
	@MonthNum int,
	@RecordCount int,
	@VehPlate VARCHAR(10),
	@SpeventFlg int, 	--1:������,		����:����
    @StartTime datetime,
    @EndTime   datetime
as
begin
	create table #t_list(
	[ListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[ParkNo] [smallint] NULL,
	[GateNo] [smallint] NULL ,
	[GateName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[LaneNo] [smallint] NULL ,
	[CardNo] [int] NULL ,
	[OpTime] [datetime] NULL ,
	[SquadDate] [datetime] NULL,
	[VehPlate] [varchar] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[usercardtype] [smallint] NULL,
	[Flg]	[smallint] NOT NULL )

	exec proc_FindInListByVehplate2Table_Ex @MonthNum,@RecordCount,@VehPlate,1,@SpeventFlg,@StartTime,@EndTime

	update #t_list set flg=1 from #t_list a ,tb_carddynamic b where a.cardno=b.cardno and a.optime<b.optime
	if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_usercarddynamic]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
		update #t_list set flg=1 from #t_list a ,tb_usercarddynamic b where a.cardno=b.cardno and a.optime<b.optime

	select * from #t_list order by optime desc
end

GO


--�����ˮ��ѯ������
if exists ( select * from dbo.sysobjects where id = object_id(N'[dbo].[proc_FindInListByCardNo_Ex]') and OBJECTPROPERTY(id,N'IsProcedure') = 1)
drop Procedure [dbo].[proc_FindInListByCardNo_Ex]
go
create proc proc_FindInListByCardNo_Ex
	@MonthNum int,
	@RecordCount int,
	@CardNO	int,
	@SpeventFlg int 	--1:������,		����:����
as
begin
	create table #t_list(
	[ListNo] [char] (16) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[ParkNo] [smallint] NULL,
	[GateNo] [smallint] NULL ,
	[GateName] [char] (8) COLLATE Chinese_PRC_CI_AS NULL ,
	[LaneNo] [smallint] NULL ,
	[CardNo] [int] NULL ,
	[OpTime] [datetime] NULL ,
	[SquadDate] [datetime] NULL,
	[VehPlate] [varchar] (10) COLLATE Chinese_PRC_CI_AS NULL ,
	[usercardtype] [smallint] NULL,
	[Flg]	[smallint] NOT NULL )

	exec proc_FindInListByCardNo2Table_Ex @MonthNum,@RecordCount,@CardNO,1,@SpeventFlg

	update #t_list set flg=1 from #t_list a ,tb_carddynamic b where a.cardno=b.cardno and a.optime<b.optime
	if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_usercarddynamic]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
		update #t_list set flg=1 from #t_list a ,tb_usercarddynamic b where a.cardno=b.cardno and a.optime<b.optime

	select * from #t_list order by optime desc
end

GO

--Ϊ��ͳһ�汾�����ʹ�øô洢����
--����ͬһ�û������г�
if exists ( select * from dbo.sysobjects where id = object_id(N'[dbo].[proc_FindAllListByCardNo]') and OBJECTPROPERTY(id,N'IsProcedure') = 1)
drop Procedure [dbo].[proc_FindAllListByCardNo]
go
create proc proc_FindAllListByCardNo
	@CardNO	int
as
begin

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_usercarddynamic]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	select a.ListNo,a.GateNo,b.GateName,a.LaneNo,a.CardNo,a.OpTime,a.squaddate,a.VehPlate,14 as usercardtype,case when a.Status=11 then 0 else 1 end as Flg
	from tb_UserCardDynamic	a left join tb_gateway b on a.GateNo=b.GateNo
	where a.cardno in (select cardno from tb_cardgroup where groupno =(select top 1 groupno from tb_cardgroup where cardno=@CardNo and groupno<>0))
	order by optime desc
end

GO

--Ϊ��ͳһ�汾�����ʹ�øô洢����
--����ͬһ�û������г�
if exists ( select * from dbo.sysobjects where id = object_id(N'[dbo].[proc_FindAllListByVehPlate]') and OBJECTPROPERTY(id,N'IsProcedure') = 1)
drop Procedure [dbo].[proc_FindAllListByVehPlate]
go
create proc proc_FindAllListByVehPlate
	@VehPlate char(10)
as
begin
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_usercarddynamic]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	select a.ListNo,a.GateNo,b.GateName,a.LaneNo,a.CardNo,a.OpTime,a.squaddate,a.VehPlate,14 as usercardtype,case when a.Status=11 then 0 else 1 end as Flg
	from tb_UserCardDynamic	a left join tb_gateway b on a.GateNo=b.GateNo
	where a.cardno in (select cardno from tb_cardgroup where groupno in (select groupno from tb_cardgroup where vehplate like @VehPlate and groupno<>0))
	order by optime desc
end
GO
------------------------------------------------------------------------------------------------------------
--------------------------------------�����ʼ��ϵͳ����sql--------------------------------------------------
--ϵͳ����������Ϣ
--�·�����->������ϢBaseCode 1
delete tb_SystemPara where ParaClass=1
GO

delete tb_SystemPara where ParaClass=1 and GroupName='BaseCode'
GO
INSERT INTO tb_SystemPara(ParaClass ,Item,ItemValue,GroupName,ItemOrder,SendControl) VALUES(1,'���б���','tb_City','BaseCode',0,1)

INSERT INTO tb_SystemPara(ParaClass ,Item,ItemValue,GroupName,ItemOrder,SendControl) VALUES(1,'�������','tb_Area','BaseCode',1,1)

INSERT INTO tb_SystemPara(ParaClass ,Item,ItemValue,GroupName,ItemOrder,SendControl) VALUES(1,'У������','tb_Park','BaseCode',2,1)

INSERT INTO tb_SystemPara(ParaClass ,Item,ItemValue,GroupName,ItemOrder,SendControl) VALUES(1,'���ű���','tb_Gateway','BaseCode',3,1)

INSERT INTO tb_SystemPara(ParaClass ,Item,ItemValue,GroupName,ItemOrder,SendControl) VALUES(1,'��������','tb_Lane','BaseCode',4,1)
GO

--�·�����->Ӫ�˲���AdvCode 2
delete tb_SystemPara where ParaClass=1 and GroupName='AdvCode'
GO
INSERT INTO tb_SystemPara(ParaClass ,Item,ItemValue,GroupName,ItemOrder,SendControl) VALUES(1,'���ܼ���','tb_FunctionKey','AdvCode',0,1)
INSERT INTO tb_SystemPara(ParaClass ,Item,ItemValue,GroupName,ItemOrder,SendControl) VALUES(1,'�豸����� ','tb_devicecode','AdvCode',1,1)
INSERT INTO tb_SystemPara(ParaClass ,Item,ItemValue,GroupName,ItemOrder,SendControl) VALUES(1,'�豸��������','tb_deviceerrorcode','AdvCode',2,1)
INSERT INTO tb_SystemPara(ParaClass ,Item,ItemValue,GroupName,ItemOrder,SendControl) VALUES(1,'���ֱ����','tb_VehClassCode','AdvCode',3,1)
INSERT INTO tb_SystemPara(ParaClass ,Item,ItemValue,GroupName,ItemOrder,SendControl) VALUES(1,'����ת����','tb_carTypeTrans','AdvCode',4,1)
INSERT INTO tb_SystemPara(ParaClass ,Item,ItemValue,GroupName,ItemOrder,SendControl) VALUES(1,'���ͱ����','tb_VehTypeCode','AdvCode',5,1)
INSERT INTO tb_SystemPara(ParaClass ,Item,ItemValue,GroupName,ItemOrder,SendControl) VALUES(1,'ͨ��ȯ���ͱ���� ','tb_tickettypecode','AdvCode',6,1)
INSERT INTO tb_SystemPara(ParaClass ,Item,ItemValue,GroupName,ItemOrder,SendControl) VALUES(1,'�����¼������ ','tb_speventcode','AdvCode',7,1)
INSERT INTO tb_SystemPara(ParaClass ,Item,ItemValue,GroupName,ItemOrder,SendControl) VALUES(1,'����','tb_Squad','AdvCode',8,1)
GO

--�·���->����ϢCardInfo 3
delete tb_SystemPara where ParaClass=1 and GroupName='CardInfo'
GO
INSERT INTO tb_SystemPara(ParaClass ,Item,ItemValue,GroupName,ItemOrder,SendControl) VALUES(1,'�������������','tb_SpecialVeh','CardInfo',0,1)
INSERT INTO tb_SystemPara(ParaClass ,Item,ItemValue,GroupName,ItemOrder,SendControl) VALUES(1,'ͨ�п���������','V_PassCardBlackList','CardInfo',1,1)
INSERT INTO tb_SystemPara(ParaClass ,Item,ItemValue,GroupName,ItemOrder,SendControl) VALUES(1,'��ݿ�������','tb_OpCardBlackList','CardInfo',2,1)
INSERT INTO tb_SystemPara(ParaClass ,Item,ItemValue,GroupName,ItemOrder,SendControl) VALUES(1,'ͨ�п��ǼǱ�','V_PassCardWL','CardInfo',3,1)
INSERT INTO tb_SystemPara(ParaClass ,Item,ItemValue,GroupName,ItemOrder,SendControl) VALUES(1,'����Ϣ��','tb_CardInfo','CardInfo',4,1)
INSERT INTO tb_SystemPara(ParaClass ,Item,ItemValue,GroupName,ItemOrder,SendControl) VALUES(1,'������','v_WhiteList','CardInfo',5,1)
INSERT INTO tb_SystemPara(ParaClass ,Item,ItemValue,GroupName,ItemOrder,SendControl) VALUES(1,'���⳵��������Ϣ��','tb_SpVehHandle','CardInfo',6,1)
GO

--�·�����->����Price 4
delete tb_SystemPara where ParaClass=1 and GroupName='Price'
GO

INSERT INTO tb_SystemPara(ParaClass ,Item,ItemValue,GroupName,ItemOrder,SendControl) VALUES(1,'�շ�����ӳ��� ','tb_pricepasstype','Price',0,1)
INSERT INTO tb_SystemPara(ParaClass ,Item,ItemValue,GroupName,ItemOrder,SendControl) VALUES(1,'���ʹ����','tb_PriceRule','Price',1,1)
GO
delete from tb_SystemPara where ItemValue='tb_FreeDays'
Go
insert into tb_SystemPara values (1,'�������','tb_FreeDays','Price',2,1)
--�·�����->����Ա��ϢOperator 5
delete tb_SystemPara where ParaClass=1 and GroupName='Operator'
GO

INSERT INTO tb_SystemPara(ParaClass ,Item,ItemValue,GroupName,ItemOrder,SendControl) VALUES(1,'����Ա��Ϣ','tb_Operator','Operator',0,1)
INSERT INTO tb_SystemPara(ParaClass ,Item,ItemValue,GroupName,ItemOrder,SendControl) VALUES(1,'����Ա��ɫ','tb_OperatorRole','Operator',1,1)

GO

--�·�����->����Default 6
delete tb_SystemPara where ParaClass=1 and GroupName='Default'
GO
INSERT INTO tb_SystemPara(ParaClass ,Item,ItemValue,GroupName,ItemOrder,SendControl) VALUES(1,'����ƿ���ʱ��� ','tb_Supplylight','Default',0,1)
GO

--�·�����->������BlackList 7
delete tb_SystemPara where ParaClass=1 and GroupName='BlackList'
GO
INSERT INTO tb_SystemPara(ParaClass ,Item,ItemValue,GroupName,ItemOrder,SendControl) VALUES(1,'OBU��Ч�������� ','tb_OBUDate','BlackList',0,1)
INSERT INTO tb_SystemPara(ParaClass ,Item,ItemValue,GroupName,ItemOrder,SendControl) VALUES(1,'��ֵ�������� ','tb_StoreCardBlackList','BlackList',1,1)
INSERT INTO tb_SystemPara(ParaClass ,Item,ItemValue,GroupName,ItemOrder,SendControl) VALUES(1,'��ֵ����Ч��������  ','tb_StoreCardDate','BlackList',2,1)
INSERT INTO tb_SystemPara(ParaClass ,Item,ItemValue,GroupName,ItemOrder,SendControl) VALUES(1,'���ʿ������� ','tb_TollyCardBlackList','BlackList',3,1)
INSERT INTO tb_SystemPara(ParaClass ,Item,ItemValue,GroupName,ItemOrder,SendControl) VALUES(1,'���ʿ���Ч�������� ','tb_TollyCardDate','BlackList',4,1)
GO

--�·�����->��ȫ��ϢSecurity 8
delete tb_SystemPara where ParaClass=1 and GroupName='Security'
GO
INSERT INTO tb_SystemPara(ParaClass ,Item,ItemValue,GroupName,ItemOrder,SendControl) VALUES(1,'��ǰ������¼��  ','V_LoseCardList','Security',0,1)
INSERT INTO tb_SystemPara(ParaClass ,Item,ItemValue,GroupName,ItemOrder,SendControl) VALUES(1,'����ʱ��� ','v_securitycommand','Security',1,1)
GO
------------------------------------------------------------------------------------------------------------
--Ϊ�����ݿ�ͳһ��Ŀǰֻ�и�������
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[V_AOwnerNVeh]') and OBJECTPROPERTY(id,N'IsView') = 1)    
  --   ɾ����ͼ    
  drop view [dbo].[V_AOwnerNVeh]
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
---------------------------------------------------------------------------------------------
GO
--Ϊ�����ݿ�ͳһ��Ŀǰֻ�и������ã�����У������һ��Ҫ����parkingspaceֻ�ĳ��ȴ���1�͡�-�������-һ��Ҫ�ã������ڵ�һλ����������
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[v_LimitParkInfo]') and OBJECTPROPERTY(id,N'IsView') = 1)    
  --   ɾ����ͼ    
  drop view [dbo].[v_LimitParkInfo]
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
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_CarSpaceDynamic]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE tb_CarSpaceDynamic
GO
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_InPark]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE tb_InPark
GO
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_OutPark]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE tb_OutPark
GO
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_CarSpaceDynamicBackUp]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE tb_CarSpaceDynamicBackUp
GO
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_InParkBackUp]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE tb_InParkBackUp
GO
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb_OutParkBackUp]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
DROP TABLE tb_OutParkBackUp
GO
create table tb_CarSpaceDynamic
(
  RecNo                int identity(1,1) primary key,
  ParkNo               varchar(10) NOT NUll,
  TotalSpace           int  NOT NUll,
  MonthlyRentSpace     int  NOT NUll,
  TemporarySpace       int  NOT NUll,
  CurrentEmptySpace    int  NOT NUll,
  OutParkTotal         int  NOT NUll,
  InParkTotal          int  NOT NUll,
  MonthlyRentInPark    int  NOT NUll,
  MonthlyRentOutPark   int  NOT NUll,
  TemporaryInPark      int  NOT NUll,
  TemporaryOutPark     int  NOT NUll,
  ModifyTime           datetime NOT NUll,
  BackUp1              int  NUll,
  BackUp2              varchar(50) NUll
)
GO
Insert into tb_CarSpaceDynamic(ParkNo,TotalSpace,MonthlyRentSpace,TemporarySpace,CurrentEmptySpace,OutParkTotal,InParkTotal,MonthlyRentInPark,MonthlyRentOutPark,
TemporaryInPark,TemporaryOutPark,ModifyTime,BackUp1,BackUp2) values('101',80,40,40,0,0,0,0,80,0,0,'2011-10-10 15:42:00',null,null)
GO
create table tb_InPark
(
  RecNo                int identity(1,1) primary key,
  ParkNo               varchar(10) NOT NUll,
  VehPlate             varchar(10) NOT NUll,
  InOptime             datetime NOT NUll,
  CurrentEmptySpace    int  NOT NUll,
  ModifyTime           datetime NOT NUll,
  BackUp1              int  NUll,
  BackUp2              varchar(50) NUll
)
GO
create table tb_OutPark
(
  RecNo                int identity(1,1) primary key,
  ParkNo               varchar(10) NOT NUll,
  VehPlate             varchar(10) NOT NUll,
  InOptime             datetime NOT NUll,
  Optime               datetime NOT NUll,
  ChargeType           varchar(10) NOT NUll,
  ChargeTime           varchar(10) NOT NUll,
  TotalMoney           int  NOT NUll,  
  CurrentEmptySpace    int  NOT NUll,
  ModifyTime           datetime NOT NUll,
  BackUp1              int  NUll,
  BackUp2              varchar(50) NUll
)

GO
create table tb_CarSpaceDynamicBackUp
(
  RecNo                int NULL,
  ParkNo               varchar(10)  NUll,
  TotalSpace           int   NUll,
  MonthlyRentSpace     int   NUll,
  TemporarySpace       int   NUll,
  CurrentEmptySpace    int   NUll,
  OutParkTotal         int   NUll,
  InParkTotal          int   NUll,
  MonthlyRentInPark    int   NUll,
  MonthlyRentOutPark   int   NUll,
  TemporaryInPark      int   NUll,
  TemporaryOutPark     int   NUll,
  ModifyTime           datetime  NUll,
  SendTime             datetime  NUll,
  RequestRecNO         varchar(20) NUll,
  Keywords             varchar(20) NUll,
  SendMessage          varchar(250) NUll,
  ReturnMessage        varchar(250) NUll,
  IsSucceed            int   NUll,
  BackUp1              int  NUll,
  BackUp2              varchar(50) NUll
)
GO
create table tb_InParkBackUp
(
  RecNo                int NULl,
  ParkNo               varchar(10)  NUll,
  VehPlate             varchar(10)  NUll,
  InOptime             datetime  NUll,
  CurrentEmptySpace    int   NUll,
  ModifyTime           datetime  NUll,
  SendTime             datetime  NUll,
  RequestRecNO         varchar(20) NUll,
  Keywords             varchar(20) NUll,
  SendMessage          varchar(250) NUll,
  ReturnMessage        varchar(250) NUll,
  IsSucceed            int   NUll,
  BackUp1              int  NUll,
  BackUp2              varchar(50) NUll
)
create table tb_OutParkBackUp
(
  RecNo                int NULL,
  ParkNo               varchar(10) NUll,
  VehPlate             varchar(10)  NUll,
  InOptime             datetime  NUll,
  Optime               datetime  NUll,
  ChargeType           varchar(10)  NUll,
  ChargeTime           varchar(10)  NUll,
  TotalMoney           int   NUll,  
  CurrentEmptySpace    int   NUll,
  ModifyTime           datetime  NUll,
  SendTime             datetime  NUll,
  RequestRecNO         varchar(20) NUll,
  Keywords             varchar(20) NUll,
  SendMessage          varchar(250) NUll,
  ReturnMessage        varchar(250) NUll,
  IsSucceed            int   NUll,
  BackUp1              int  NUll,
  BackUp2              varchar(50) NUll
)
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tr_InlistCarSpaceDynamicAndInPark]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[Tr_InlistCarSpaceDynamicAndInPark]
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

Create Trigger [dbo].[Tr_InlistCarSpaceDynamicAndInPark]--�޸ĳ�λ��̬��Ϣ�Ͳ�����Ϣ������ͣ������Ϣ��tb_InPark���У��ϴ��������ã�
	on [dbo].[tb_InList_Tmp]
	for insert
As
	declare @AreaNo				smallint     
	declare @ParkNo				smallint     
	declare @GateNo				smallint     
	declare @LaneNo				smallint 
	declare @sVehPlate          varchar(10)
	declare @VehType			smallint     
	declare @VehClass			smallint     
	declare @TicketType			smallint      
	declare @UserCardType       smallint     
	declare @VehCount			smallint     
	declare @SquadDate			datetime
	declare @SquadNo			smallint     
	declare @OperatorNo			int     
	declare @OperatorName		char(8)         
	declare @OpTime				datetime 
	declare @iCurrentEmptySpace int   
	declare @sParkNo            varchar(10)
	
		
	select @AreaNo=AreaNo,@ParkNo=ParkNo,@GateNo=GateNo,@LaneNo=LaneNo,@sVehPlate=VehPlate,@VehType=VehType,@VehClass=VehClass,@TicketType=TicketType,
	@UserCardType=UserCardType,@VehCount=VehCount,@SquadDate=SquadDate,@SquadNo=SquadNo,@OperatorNo=OperatorNo,@OperatorName=OperatorName,@OpTime=OpTime 
	from inserted
	if exists(select * from tb_CarSpaceDynamic)--��λ��̬���д�����Ϣ
	   begin
	       select @sParkNo=ParkNo,@iCurrentEmptySpace=CurrentEmptySpace from tb_CarSpaceDynamic--��ѯ��ǰ�ճ�λ��
	       if(@iCurrentEmptySpace>0)--��ǰ�ճ�λ������0ʱ
	          begin
	             update tb_CarSpaceDynamic set CurrentEmptySpace=CurrentEmptySpace-1--�޸ĵ�ǰ�ճ�λ��
	          end
	       else--��ǰ�ճ�λ��������0ʱ
	          begin
	             update tb_CarSpaceDynamic set CurrentEmptySpace=0--�޸ĵ�ǰ�ճ�λ��
	          end
	       if(@UserCardType=0)--�ٱ�����ˢ��ʱ��ʱ�ӳ�����д����UserCardType��ֵΪ0��
	           begin
	              update tb_CarSpaceDynamic set TemporaryInPark=TemporaryInPark+1--�޸��ٱ���������                   
	           end
	       else--�±���
	           begin
	               update tb_CarSpaceDynamic set MonthlyRentInPark=MonthlyRentInPark+1--�޸��±���������  
	           end
	       update tb_CarSpaceDynamic set InParkTotal=TemporaryInPark+MonthlyRentInPark--�޸Ľ��������������ֽ���������=�±���������+�ٱ���������

	       select @sParkNo=ParkNo,@iCurrentEmptySpace=CurrentEmptySpace from tb_CarSpaceDynamic--��ѯ��ǰ�ճ�λ����ͣ�������
	       insert into tb_InPark(ParkNo,VehPlate,InOptime,CurrentEmptySpace,ModifyTime,BackUp1,BackUp2) values(@sParkNo,@sVehPlate,@OpTime,@iCurrentEmptySpace,getDate(),null,null)	          
	   end
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tr_OutlistCarSpaceDynamicAndOutPark]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[Tr_OutlistCarSpaceDynamicAndOutPark]
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

Create Trigger [dbo].[Tr_OutlistCarSpaceDynamicAndOutPark]--�޸ĳ�λ��̬��Ϣ�Ͳ�����Ϣ������ͣ������Ϣ��tb_OutPark���У��ϴ��������ã�
	on [dbo].[tb_OutList_Tmp]
	for insert
As
	declare @AreaNo				smallint     
	declare @ParkNo				smallint     
	declare @GateNo				smallint     
	declare @LaneNo				smallint
	declare @sVehPlate          varchar(10)     
	declare @VehType			smallint     
	declare @VehClass			smallint     
	declare @TicketType			smallint      
	declare @UserCardType       smallint     
	declare @CheckType			smallint
	declare @VehCount			smallint     
	declare @SquadDate			datetime
	declare @SquadNo			smallint     
	declare @OperatorNo			int     
	declare @OperatorName		char(8)         
	declare @CashMoney			int 											
	declare @FreeMoney			int											
	declare @UnpayMoney			int								
	declare @ETCMoney			int
	declare @OpTime				datetime 
	declare @InOpTime			datetime 
	declare @iCurrentEmptySpace int   
	declare @sParkNo            varchar(10) 
	declare @iTotalMoney        int
	declare @iTotalMinute       int--����ʱ�������ܷ���
	declare @iDay               int--����ʱ����������
	declare @iHour              int--����ʱ������Сʱ
	declare @iMinute            int--����ʱ�����ķ���
	declare @sDay               varchar(10)--ת�����ַ�������ʽ��ʽΪ��λ��������λǰ�油0
	declare @sHour              varchar(10)--ת�����ַ�������ʽ��ʽΪ��λ��������λǰ�油0
	declare @sMinute            varchar(10)--ת�����ַ�������ʽ��ʽΪ��λ��������λǰ�油0
	declare @sChargeTime        varchar(10)--��ʽΪ00��00��00 ������˼ �죺Сʱ������
	
	select @AreaNo=AreaNo,@ParkNo=ParkNo,@GateNo=GateNo,@LaneNo=LaneNo,@VehType=VehType,@VehClass=VehClass,@TicketType=TicketType,
		   @UserCardType=UserCardType,@CheckType=CheckType,@InOpTime=InOpTime,@sVehPlate=VehPlate,
		   @VehCount=VehCount,@SquadDate=SquadDate,@SquadNo=SquadNo,@OperatorNo=OperatorNo,@OperatorName=OperatorName,
		   @CashMoney=CashMoney,@FreeMoney=FreeMoney,@UnpayMoney=UnpayMoney,@ETCMoney=ETCMoney,@OpTime=OpTime 
	from inserted
	
	if exists(select * from tb_CarSpaceDynamic)--��λ��̬���д�����Ϣ
	   begin	       
	       update tb_CarSpaceDynamic set CurrentEmptySpace=CurrentEmptySpace+1--�޸ĵ�ǰ�ճ�λ��
	       select @sParkNo=ParkNo,@iCurrentEmptySpace=CurrentEmptySpace from tb_CarSpaceDynamic--��ѯ��ǰ�ճ�λ����ͣ�������	
	       set @iTotalMoney=@CashMoney+@FreeMoney+@UnpayMoney+@ETCMoney--��ȡƱ���ܼ� 
	       --���ͣ����ʱ�����ͣ����֮��Ĳ��ʽΪ 00:00:00(�����죺Сʱ�����ӣ�
	       set @iTotalMinute=sum(datediff(minute,@InOpTime, @OpTime)) --��ʱ�����ܷ���
	       set @iDay = @iTotalMinute/1440--����=�ܷ���/(60*24)
	       set @iHour = (@iTotalMinute-@iDay*1440)/60--Сʱ=���ܷ���-����*60*24��/60
	       set @iMinute = @iTotalMinute-@iDay*1440-@iHour*60--����=�ܷ���-��*60*24-Сʱ*60
	        if(@iDay<10) 
	            begin
	             set @sDay='0'+LTrim(str(@iDay))
	            end
	        else
	            begin
	             set @sDay=LTrim(str(@iDay))
	            end        
	        if(@iHour<10) 
	            begin
	             set @sHour='0'+LTrim(str(@iHour))
	            end
	        else
	            begin
	               set @sHour=LTrim(str(@iHour))
	            end
	        if(@iMinute<10)
	           begin
	              set @sMinute='0'+LTrim(str(@iMinute))
	           end 
	        else
	           begin
	            set @sMinute=LTrim(str(@iMinute))
	           end
	        set  @sChargeTime=@sDay+'-'+@sHour+'-'+@sMinute
	            
	       if(@UserCardType=0)--�ٱ�����ˢ��ʱ��ʱ�ӳ�����д����UserCardType��ֵΪ0��
	           begin
	              update tb_CarSpaceDynamic set TemporaryOutPark=TemporaryOutPark+1--�޸��ٱ���������
	              Insert into tb_OutPark(ParkNo,VehPlate,InOptime,Optime,ChargeType,ChargeTime,TotalMoney,CurrentEmptySpace,ModifyTime,BackUp1,BackUp2)
	              values(@sParkNo,@sVehPlate,@InOpTime,@OpTime,'�ٱ�',@sChargeTime,@iTotalMoney,@iCurrentEmptySpace,getDate(),null,null)                   
	           end
	       else--�±���
	           begin
	               update tb_CarSpaceDynamic set MonthlyRentOutPark=MonthlyRentOutPark+1--�޸��±��������� 
	               if(@UserCardType=13)
	                  begin
	                     Insert into tb_OutPark(ParkNo,VehPlate,InOptime,Optime,ChargeType,ChargeTime,TotalMoney,CurrentEmptySpace,ModifyTime,BackUp1,BackUp2)
	                     values(@sParkNo,@sVehPlate,@InOpTime,@OpTime,'Vip',@sChargeTime,@iTotalMoney,@iCurrentEmptySpace,getDate(),null,null) 
	                  end
	               else
	                  begin 
	                     Insert into tb_OutPark(ParkNo,VehPlate,InOptime,Optime,ChargeType,ChargeTime,TotalMoney,CurrentEmptySpace,ModifyTime,BackUp1,BackUp2)
	                     values(@sParkNo,@sVehPlate,@InOpTime,@OpTime,'�±�',@sChargeTime,@iTotalMoney,@iCurrentEmptySpace,getDate(),null,null)
	                  end
	           end
	       update tb_CarSpaceDynamic set OutParkTotal=TemporaryOutPark+MonthlyRentOutPark--�޸ĳ��������������ֳ���������=�±���������+�ٱ���������
	   end


GO








