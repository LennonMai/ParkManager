use [parkdb]
----------------------------------------------------------------ɾ��������------------------------------------------------------
GO
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tr_AccountTrade]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[Tr_AccountTrade]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tr_CardDynamicToLoseCard]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[Tr_CardDynamicToLoseCard]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tr_YCTInListSplit]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[Tr_YCTInListSplit]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tr_InlistStat]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[Tr_InlistStat]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tr_InlistSplit]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[Tr_InlistSplit]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tr_OutlistSplit]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[Tr_OutlistSplit]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tr_YCTOutListSplit]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[Tr_YCTOutListSplit]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tr_OutlistStat]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[Tr_OutlistStat]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tr_PlateToObuId]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[Tr_PlateToObuId]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tr_UserVehPlate]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[tr_UserVehPlate]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tr_SecurityCommandDelete]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[Tr_SecurityCommandDelete]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tr_SecurityCommandInsert]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[Tr_SecurityCommandInsert]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tr_SecurityCommandUpdate]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[Tr_SecurityCommandUpdate]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tr_SpVehMonitor]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[tr_SpVehMonitor]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tri_ToYZList_Tmp]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[Tri_ToYZList_Tmp]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tri_BackupModifiedData]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[Tri_BackupModifiedData]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tri_SetSendPara]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[Tri_SetSendPara]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tri_SetUsercardbill]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[Tri_SetUsercardbill]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tr_VehFreeTimesSplit]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[Tr_VehFreeTimesSplit]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tr_CarCountIff]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[Tr_CarCountIff]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tr_CarCountAdd]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[Tr_CarCountAdd]
GO
--�����ӿ���Ŀ��Ҫ��ӵĴ�������2011-10-14���������ϴ����ݸ�������
----------------------------------------------------------------
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tr_InlistCarSpaceDynamicAndInPark]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[Tr_InlistCarSpaceDynamicAndInPark]
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tr_OutlistCarSpaceDynamicAndOutPark]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[Tr_OutlistCarSpaceDynamicAndOutPark]
GO
---------------------------------------------------------------
--�����豸���
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tr_systemStatusInserted]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[Tr_systemStatusInserted]
Go

-----------------------------------------------------------------
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Tr_SendAccountCard]') and OBJECTPROPERTY(id, N'IsTrigger') = 1)
drop trigger [dbo].[Tr_SendAccountCard]
Go

-----------------------------------------------����������----------------------------------------------------------------------------------
GO

/****** Object:  Trigger [dbo].[Tr_AccountTrade]    Script Date: 10/13/2011 15:34:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
   CREATE TRIGGER [dbo].[Tr_AccountTrade] 
    ON  [dbo].[tb_AccountTrade] 
   instead of insert
   
AS 

   declare @Months                           tinyint
   declare @SeqNo                            int
   declare @TradeType                        int
   declare @AccountNo                        int 
   declare @BackoutedListNo                  varchar(30) 
   declare @ListNo                           varchar(30)
   declare @ParkNo                           int
   declare @VehPlate                         varchar(10)
   declare @CardNo                           varchar(30)
   declare @Balance                          int

select  @Months=DATEPART(month,convert(datetime,OpTime)),@TradeType=tradeType,@ListNo=listNo,@BackoutedListNo=backoutedListNo,@AccountNo=accountNo ,@SeqNo=seqNo,@CardNo=cardNo,@Balance=balance from inserted
if @Months is null
select @Months=DATEPART(month,convert(datetime,tradeTime)) from inserted
if @Months=1
  Begin
   if not exists(select * from tb_AccountTrade01 where listNo=@ListNo)--��ˮ�Ų�����ʱ����ֹվ�����������ϴ���
    begin
    insert into [dbo].[tb_AccountTrade] select * from inserted 
    insert into tb_AccountTrade01 select * from inserted   
    delete from [dbo].[tb_AccountTrade] where accountNo = @AccountNo and tradetype !=1 and tradetype !=2 and seqNo < @SeqNo --��֤tb_AccountTrade�б��ֲ��ǳ���/��ֵ����ˮ���ֻ��һ��������seqNo��������������ֵ/��������ˮ����tb_AccountTrade��Ҳ������12���е�����һ����
    update t_park_account set balance=@Balance where cardNo=@CardNo and sys_id = @AccountNo--����t_park_account�е����
    end
    if not exists(select * from t_park_account where cardNo=@CardNo and status!=5)--���Ų����ڻ���������
     begin
        insert into tb_UnusualAccountTrade select * from inserted where @TradeType!=3--�����쳣��ˮ��
     end
   end
    
    
else if @Months=2
  Begin
   if not exists(select * from tb_AccountTrade02 where listNo=@ListNo)
    begin
    insert into [dbo].[tb_AccountTrade] select * from inserted 
    insert into tb_AccountTrade02 select * from inserted   
    delete from [dbo].[tb_AccountTrade] where accountNo = @AccountNo and tradetype !=1 and tradetype !=2 and seqNo < @SeqNo
    update t_park_account set balance=@Balance where cardNo=@CardNo and sys_id = @AccountNo
    end
    if not exists(select * from t_park_account where cardNo=@CardNo and status!=5)--���Ų����ڻ���������
     begin
        insert into tb_UnusualAccountTrade select * from inserted where @TradeType!=3--�����쳣��ˮ��
     end
  end

else if @Months=3
  Begin
   if not exists(select * from tb_AccountTrade03 where listNo=@ListNo)
    begin
    insert into [dbo].[tb_AccountTrade] select * from inserted 
    insert into tb_AccountTrade03 select * from inserted   
    delete from [dbo].[tb_AccountTrade] where accountNo = @AccountNo and tradetype !=1 and tradetype !=2 and seqNo < @SeqNo
    update t_park_account set balance=@Balance where cardNo=@CardNo and sys_id = @AccountNo
    end
    if not exists(select * from t_park_account where cardNo=@CardNo and status!=5)--���Ų����ڻ���������
     begin
        insert into tb_UnusualAccountTrade select * from inserted where @TradeType!=3--�����쳣��ˮ��
     end
  end
    
else if @Months=4
   Begin
   if not exists(select * from tb_AccountTrade04 where listNo=@ListNo)
    begin
    insert into [dbo].[tb_AccountTrade] select * from inserted 
    insert into tb_AccountTrade04 select * from inserted   
    delete from [dbo].[tb_AccountTrade] where accountNo = @AccountNo and tradetype !=1 and tradetype !=2 and seqNo < @SeqNo
    update t_park_account set balance=@Balance where cardNo=@CardNo and sys_id = @AccountNo
    end
    if not exists(select * from t_park_account where cardNo=@CardNo and status!=5)--���Ų����ڻ���������
     begin
        insert into tb_UnusualAccountTrade select * from inserted where @TradeType!=3--�����쳣��ˮ��
     end
  end

else if @Months=5
  Begin
   if not exists(select * from tb_AccountTrade05 where listNo=@ListNo)
    begin
    insert into [dbo].[tb_AccountTrade] select * from inserted 
    insert into tb_AccountTrade05 select * from inserted   
    delete from [dbo].[tb_AccountTrade] where accountNo = @AccountNo and tradetype !=1 and tradetype !=2 and seqNo < @SeqNo
    update t_park_account set balance=@Balance where cardNo=@CardNo and sys_id = @AccountNo
    end
    if not exists(select * from t_park_account where cardNo=@CardNo and status!=5)--���Ų����ڻ���������
     begin
        insert into tb_UnusualAccountTrade select * from inserted where @TradeType!=3--�����쳣��ˮ��
     end
  end

else if @Months=6
  Begin
   if not exists(select * from tb_AccountTrade06 where listNo=@ListNo)
    begin
    insert into [dbo].[tb_AccountTrade] select * from inserted 
    insert into tb_AccountTrade06 select * from inserted   
    delete from [dbo].[tb_AccountTrade] where accountNo = @AccountNo and tradetype !=1 and tradetype !=2 and seqNo < @SeqNo
    update t_park_account set balance=@Balance where cardNo=@CardNo and sys_id = @AccountNo
    end
    if not exists(select * from t_park_account where cardNo=@CardNo and status!=5)--���Ų����ڻ���������
     begin
        insert into tb_UnusualAccountTrade select * from inserted where @TradeType!=3--�����쳣��ˮ��
     end
  end
    
else if @Months=7
  Begin
   if not exists(select * from tb_AccountTrade07 where listNo=@ListNo)
    begin
    insert into [dbo].[tb_AccountTrade] select * from inserted 
    insert into tb_AccountTrade07 select * from inserted   
    delete from [dbo].[tb_AccountTrade] where accountNo = @AccountNo and tradetype !=1 and tradetype !=2 and seqNo < @SeqNo
    update t_park_account set balance=@Balance where cardNo=@CardNo and sys_id = @AccountNo
    end
    if not exists(select * from t_park_account where cardNo=@CardNo and status!=5)--���Ų����ڻ���������
     begin
        insert into tb_UnusualAccountTrade select * from inserted where @TradeType!=3--�����쳣��ˮ��
     end
  end
    
else if @Months=8
  Begin
   if not exists(select * from tb_AccountTrade08 where listNo=@ListNo)
    begin
    insert into [dbo].[tb_AccountTrade] select * from inserted 
    insert into tb_AccountTrade08 select * from inserted   
    delete from [dbo].[tb_AccountTrade] where accountNo = @AccountNo and tradetype !=1 and tradetype !=2 and seqNo < @SeqNo
    update t_park_account set balance=@Balance where cardNo=@CardNo and sys_id = @AccountNo
    end
    if not exists(select * from t_park_account where cardNo=@CardNo and status!=5)--���Ų����ڻ���������
     begin
        insert into tb_UnusualAccountTrade select * from inserted where @TradeType!=3--�����쳣��ˮ��
     end
  end
    
else if @Months=9
  Begin
   if not exists(select * from tb_AccountTrade09 where listNo=@ListNo)
    begin
    insert into [dbo].[tb_AccountTrade] select * from inserted 
    insert into tb_AccountTrade09 select * from inserted   
    delete from [dbo].[tb_AccountTrade] where accountNo = @AccountNo and tradetype !=1 and tradetype !=2 and seqNo < @SeqNo
    update t_park_account set balance=@Balance where cardNo=@CardNo and sys_id = @AccountNo
    end
    if not exists(select * from t_park_account where cardNo=@CardNo and status!=5)--���Ų����ڻ���������
     begin
        insert into tb_UnusualAccountTrade select * from inserted where @TradeType!=3--�����쳣��ˮ��
     end
  end
    
else if @Months=10
  Begin
   if not exists(select * from tb_AccountTrade10 where listNo=@ListNo)
    begin
    insert into [dbo].[tb_AccountTrade] select * from inserted 
    insert into tb_AccountTrade10 select * from inserted   
    delete from [dbo].[tb_AccountTrade] where accountNo = @AccountNo and tradetype !=1 and tradetype !=2 and seqNo < @SeqNo
    update t_park_account set balance=@Balance where cardNo=@CardNo and sys_id = @AccountNo
    end
    if not exists(select * from t_park_account where cardNo=@CardNo and status!=5)--���Ų����ڻ���������
     begin
        insert into tb_UnusualAccountTrade select * from inserted where @TradeType!=3--�����쳣��ˮ��
     end
  end
    
else if @Months=11
  Begin
   if not exists(select * from tb_AccountTrade11 where listNo=@ListNo)
    begin
    insert into [dbo].[tb_AccountTrade] select * from inserted 
    insert into tb_AccountTrade11 select * from inserted   
    delete from [dbo].[tb_AccountTrade] where accountNo = @AccountNo and tradetype !=1 and tradetype !=2 and seqNo < @SeqNo
    update t_park_account set balance=@Balance where cardNo=@CardNo and sys_id = @AccountNo
    end
    if not exists(select * from t_park_account where cardNo=@CardNo and status!=5)--���Ų����ڻ���������
     begin
        insert into tb_UnusualAccountTrade select * from inserted where @TradeType!=3--�����쳣��ˮ��
     end
  end
    
else if @Months=12
  Begin
   if not exists(select * from tb_AccountTrade12 where listNo=@ListNo)
    begin
    insert into [dbo].[tb_AccountTrade] select * from inserted 
    insert into tb_AccountTrade12 select * from inserted   
    delete from [dbo].[tb_AccountTrade] where accountNo = @AccountNo and tradetype !=1 and tradetype !=2 and seqNo < @SeqNo
    update t_park_account set balance=@Balance where cardNo=@CardNo and sys_id = @AccountNo
    end
    if not exists(select * from t_park_account where cardNo=@CardNo and status!=5)--���Ų����ڻ���������
     begin
        insert into tb_UnusualAccountTrade select * from inserted where @TradeType!=3--�����쳣��ˮ��
     end
  end

GO

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE  trigger [dbo].[Tr_CardDynamicToLoseCard] 
		on [dbo].[tb_CardDynamic]
		for insert
as
begin
    --tb_LoseCardHis����
    declare @iParkNo            smallint
    declare @iGateNo            smallint
    declare @iLaneNo            smallint
	declare @sVehPlate          varchar(10)
	declare @sCardNo            varchar(10)
	declare @iStatus            smallint
	declare @dOpTime            datetime
	declare @iOperatorNo	    int
	declare @sOperatorname      varchar(8)
	declare @dSquadDate         date
	declare @sInListNo          varchar(16)
	declare @sOwner             varchar(32)
	
	--tb_CardDynamic���������ֵ
	declare @iIParkNo            smallint
    declare @iIGateNo            smallint
    declare @iILaneNo            smallint
	declare @sIVehPlate          varchar(10)
	declare @sICardNo            varchar(10)
	declare @iIStatus            smallint
	declare @dIOpTime            datetime
	declare @iIOperatorNo	     int
	declare @sIOperatorname      varchar(8)
	declare @dISquadDate         date
	declare @sIInListNo          varchar(16)
	declare @sIOutListNo         varchar(16)
	declare @sIOwner             varchar(32)
	select @sICardNo=CardNo,@dIOpTime=OpTime,@iIParkNo=ParkNo,@iIGateNo=GateNo,@iILaneNo=LaneNo,@sIVehPlate=VehPlate,@iIOperatorNo=OperatorNo,@sIOperatorname=Operatorname,@dISquadDate=SquadDate,@sIInListNo=inListNo,@sIOutListNo=OutListNo,@sIOwner=Owner,@iIStatus=Status from inserted
	if(@iIStatus=13)--��������ˮ�п�״̬����13��������������"����"��ť��
		begin
			delete from tb_LoseCardHis where CardNo=@sICardNo and OpTime=@dIOpTime
			insert into tb_LoseCardHis(CardNo,OpTime,ParkNo,GateNo,LaneNo,VehPlate,OperatorNo,OperatorName,SquadDate,ListNo,Owner,OutListNo,OutParkNo,OutGateNo,OutLaneNo,OutOpTime,OutSquadDate,OutRemark,OutOperatorNo,OutOperatorName,CardStatus)
			values('0',@dIOpTime,0,0,0,'0',0,'0',getDate(),@sIInListNo,'0',@sIOutListNo,@iIParkNo,@iIGateNo,@iILaneNo,@dIOpTime,@dISquadDate,'��������Ա����Ϊ����',@iIOperatorNo,@sIOperatorname,13) 	
			delete from tb_SendPara where tablename='V_LoseCardList'
			insert into tb_SendPara select 1,0,0,laneno,laneComputerIP,'V_LoseCardList','V_LoseCardList' from tb_LaneUse
		end
	else
		begin
			if exists(select * from tb_CardDynamic where VehPlate=@sIVehPlate and CardNo!=@sICardNo and status=11 and UserCardType=0 and VehPlate!='0')--������ʱ����ڷ��������ƺ���ȣ����Ų����
				begin 
					select @sCardNo=CardNo,@dOpTime=OpTime,@iParkNo=ParkNo,@iGateNo=GateNo,@iLaneNo=LaneNo,@sVehPlate=VehPlate,@iOperatorNo=OperatorNo,@sOperatorname=Operatorname,@dSquadDate=SquadDate,@sInListNo=inListNo,@sOwner=Owner,@iStatus=Status from tb_CardDynamic where VehPlate=@sIVehPlate and CardNo!=@sICardNo and status=11 and UserCardType=0 and VehPlate!='0'
					update tb_CardDynamic set status=13 where  VehPlate=@sIVehPlate and CardNo!=@sICardNo and status=11 and UserCardType=0 and VehPlate!='0'--UserCardType����0��ʾΪʹ����ʱ����status״̬Ϊ��11����ڷ����������ƺ���ȶ����Ų����������״̬Ϊ��13��������		
					if(@iIStatus=11)--11:��ڷ�����������������Ϊ�����ˮ��Ϣ,�������ʱ����ʶ��׼ȷʱ�ᷢ�����ʱ�Ų��ҵ�����
					begin
						delete from tb_LoseCardHis where CardNo=@SCardNo and OpTime=@dIOpTime
						insert into tb_LoseCardHis(CardNo,OpTime,ParkNo,GateNo,LaneNo,VehPlate,OperatorNo,OperatorName,SquadDate,ListNo,Owner,OutListNo,OutParkNo,OutGateNo,OutLaneNo,OutOpTime,OutSquadDate,OutRemark,OutOperatorNo,OutOperatorName,CardStatus)
						values(@sCardNo,@dOpTime,@iParkNo,@iGateNo,@iLaneNo,@sVehPlate,@iOperatorNo,@sOperatorname,@dSquadDate,@sInListNo,@sOwner,'0',0,0,0,null,null,'�ó��ѳ�����û����',0,'0',13) 
					end
					if(@iIStatus=12)--12:���ڻ��գ�������������Ϊ������ˮ��Ϣ
					begin
						delete from tb_LoseCardHis where CardNo=@SCardNo and OpTime=@dIOpTime
						insert into tb_LoseCardHis(CardNo,OpTime,ParkNo,GateNo,LaneNo,VehPlate,OperatorNo,OperatorName,SquadDate,ListNo,Owner,OutListNo,OutParkNo,OutGateNo,OutLaneNo,OutOpTime,OutSquadDate,OutRemark,OutOperatorNo,OutOperatorName,CardStatus)
						values(@sCardNo,@dOpTime,@iParkNo,@iGateNo,@iLaneNo,@sVehPlate,@iOperatorNo,@sOperatorname,@dSquadDate,@sInListNo,@sOwner,@sIOutListNo,@iIParkNo,@iIGateNo,@iILaneNo,@dIOpTime,@dISquadDate,'�ó��ѳ�����û����',@iIOperatorNo,@sIOperatorname,13) 
					end
					delete from tb_SendPara where tablename='V_LoseCardList'
					insert into tb_SendPara select 1,0,0,laneno,laneComputerIP,'V_LoseCardList','V_LoseCardList' from tb_LaneUse
				 end
		end
	
	
end

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE TRIGGER [dbo].[Tr_YCTInListSplit]
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

Create Trigger Tr_InlistStat
	on tb_InList_Tmp
	for insert
As
	declare @AreaNo				smallint     
	declare @ParkNo				smallint     
	declare @GateNo				smallint     
	declare @LaneNo				smallint     
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
	
	
	select @AreaNo=AreaNo,@ParkNo=ParkNo,@GateNo=GateNo,@LaneNo=LaneNo,@VehType=VehType,@VehClass=VehClass,@TicketType=TicketType,
		@UserCardType=UserCardType,
		@VehCount=VehCount,@SquadDate=SquadDate,@SquadNo=SquadNo,
		@OperatorNo=OperatorNo,@OperatorName=OperatorName,@OpTime=OpTime 
	from inserted
	
	--���ɱ���ͳ������
	update tb_InListSum                         
		set VehCountSum=VehCountSum+@VehCount,StatTime=@OpTime  
		where AreaNo=@AreaNo and ParkNo=@ParkNo and GateNo=@GateNo and LaneNo=@LaneNo and VehType=@VehType and VehClass=@VehClass and 
			TicketType=@TicketType and UserCardType=@UserCardType and SquadDate=@SquadDate and SquadNo=@SquadNo and 
			OperatorNo=@OperatorNo and OperatorName=@OperatorName
    
    if @@ROWCOUNT = 0
    Begin   
		insert into tb_InListSum(AreaNo,ParkNo,GateNo,LaneNo,VehType,VehClass,TicketType,UserCardType,VehCountSum,
				SquadDate,SquadNo,OperatorNo,OperatorName,StatTime)
			values(@AreaNo,@ParkNo,@GateNo,@LaneNo,@VehType,@VehClass,@TicketType,@UserCardType,@VehCount,
				@SquadDate,@SquadNo,@OperatorNo,@OperatorName,@OpTime)
    End

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

--�������ˮ������ݷֱ�洢
CREATE Trigger [dbo].[Tr_InlistSplit]
	on [dbo].[tb_InList_Tmp]
	for insert
As
	declare @Months						tinyint
	declare @sCardNo						varchar(10)

	--���ݹ������ڣ��ֱ�洢��ˮ����
	select @Months=DATEPART(month,SquadDate),@sCardNo=CardNo from inserted
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
		--�жϿ���̬���еĲ���ʱ��С���ϴ���ˮ�Ĳ���ʱ��		
		if exists (select t1.cardno from tb_CardDynamic t1, inserted t2 where  t1.cardno=t2.cardno and t1.optime<t2.optime)
		begin
			delete from tb_CardDynamic where cardno=@sCardNo
			insert into tb_CardDynamic select CardNo, 11, OpTime, ParkNo, GateNo, LaneNo, VehPlate ,OperatorNo ,
			OperatorName ,SquadDate ,' ',UserCardType,VehType,SquadNo,ListNo,' ',' ', TicKetType,GateName
			from inserted t1
			where t1.CardNo>0
		end
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
GO

-------------------------------------------------------------------------------------------------
--�޸�(tb_OutList_Tmp)�д�����Tr_OutlistSplit


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

--��������ˮ������ݷֱ�洢
CREATE Trigger [dbo].[Tr_OutlistSplit]
	on [dbo].[tb_OutList_Tmp]
	for insert
As
	declare @Months						tinyint
	declare @sCardNo						varchar(10)
	declare @iSpevent					int

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
  	
  	select @iSpevent=spevent,@sCardNo=cardNo from inserted
  	
	--�޸�tb_CardDynamic���¼��cardNo>0�����ݲŲ�����ʹ�ÿ������������
	if exists (select t1.cardno from tb_CardDynamic t1, inserted t2
				where t1.cardno=t2.cardno and t2.CardNo>0)
	begin
		--�жϿ���̬���еĲ���ʱ��С���ϴ���ˮ�Ĳ���ʱ��		
		if exists (select t1.cardno from tb_CardDynamic t1, inserted t2 where  t1.cardno=t2.cardno and t1.optime<t2.optime)
		begin
			delete from tb_CardDynamic where cardno=@sCardNo
			--�����ˮ��¼�������¼���"����"(��8λ), �޸�tb_CardDynamic����ʱ����״̬Ϊ"����"(13)
			if(@iSpevent&0x00000080<>0)
			begin
				insert into tb_CardDynamic select CardNo, 13, OpTime, ParkNo, GateNo, LaneNo, VehPlate ,OperatorNo ,
				OperatorName ,SquadDate ,' ',UserCardType,VehType,SquadNo,' ',ListNo,' ', TicKetType,GateName
				from inserted t1
				where t1.CardNo>0
			end
			--�����ˮ��¼�������¼���"����"(��9λ), �޸�tb_CardDynamic����ʱ����״̬Ϊ"����"(15)
			else if(@iSpevent&0x00000100<>0)
			begin
				insert into tb_CardDynamic select CardNo, 15, OpTime, ParkNo, GateNo, LaneNo, VehPlate ,OperatorNo ,
				OperatorName ,SquadDate ,' ',UserCardType,VehType,SquadNo,' ',ListNo,' ', TicKetType,GateName
				from inserted t1
				where t1.CardNo>0
			end
			--�������ڻ���, �޸�tb_CardDynamic����ʱ����״̬Ϊ"���ڻ���"(12)
			else
			begin
				insert into tb_CardDynamic select CardNo, 12, OpTime, ParkNo, GateNo, LaneNo, VehPlate ,OperatorNo ,
				OperatorName ,SquadDate ,' ',UserCardType,VehType,SquadNo,' ',ListNo,' ', TicKetType,GateName
				from inserted t1
				where t1.CardNo>0
			end		
		end
	end
	else
	--ʹ���¿�Ƭ�������ˡ����г�֮����޿�Ƭ���
	begin
		delete from tb_CardDynamic where cardno=@sCardNo
		--�����ˮ��¼�������¼���"����"(��8λ), �޸�tb_CardDynamic����ʱ����״̬Ϊ"����"(13)
		if(@iSpevent&0x00000080<>0)
			begin
				insert into tb_CardDynamic select CardNo, 13, OpTime, ParkNo, GateNo, LaneNo, VehPlate ,OperatorNo ,
				OperatorName ,SquadDate ,' ',UserCardType,VehType,SquadNo,' ',ListNo,' ', TicKetType,GateName
				from inserted t1
				where t1.CardNo>0
			end
		--�����ˮ��¼�������¼���"����"(��9λ), �޸�tb_CardDynamic����ʱ����״̬Ϊ"����"(15)
		else if(@iSpevent&0x00000100<>0)
			begin
				insert into tb_CardDynamic select CardNo, 15, OpTime, ParkNo, GateNo, LaneNo, VehPlate ,OperatorNo ,
				OperatorName ,SquadDate ,' ',UserCardType,VehType,SquadNo,' ',ListNo,' ', TicKetType,GateName
				from inserted t1
				where t1.CardNo>0
			end
		--�������ڻ���, �޸�tb_CardDynamic����ʱ����״̬Ϊ"���ڻ���"(12)
		else
			begin
				insert into tb_CardDynamic select CardNo, 12, OpTime, ParkNo, GateNo, LaneNo, VehPlate ,OperatorNo ,
				OperatorName ,SquadDate ,' ',UserCardType,VehType,SquadNo,' ',ListNo,' ', TicKetType,GateName
				from inserted t1
				where t1.CardNo>0
			end		
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
GO
---------------------һ���೵----------------------------------------------------------------------------
 --�жϱ�tb_CardGroup�Ƿ���ڣ�������ʱ�򴴽�

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE TRIGGER [dbo].[Tr_YCTOutListSplit]
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

Create Trigger Tr_OutlistStat
	on tb_OutList_Tmp
	for insert
As
	declare @AreaNo				smallint     
	declare @ParkNo				smallint     
	declare @GateNo				smallint     
	declare @LaneNo				smallint     
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
	
	
	select @AreaNo=AreaNo,@ParkNo=ParkNo,@GateNo=GateNo,@LaneNo=LaneNo,@VehType=VehType,@VehClass=VehClass,@TicketType=TicketType,
		@UserCardType=UserCardType,@CheckType=CheckType,
		@VehCount=VehCount,@SquadDate=SquadDate,@SquadNo=SquadNo,@OperatorNo=OperatorNo,@OperatorName=OperatorName,
		@CashMoney=CashMoney,@FreeMoney=FreeMoney,@UnpayMoney=UnpayMoney,@ETCMoney=ETCMoney,@OpTime=OpTime 
	from inserted
	
	--���ɱ���ͳ������
	update tb_OutListSum                         
		set VehCountSum=VehCountSum+@VehCount,CashMoneySum=CashMoneySum+@CashMoney,FreeMoneySum=FreeMoneySum+@FreeMoney,
			UnpayMoneySum=UnpayMoneySum+@UnpayMoney,ETCMoneySum=ETCMoneySum+@ETCMoney,StatTime=@OpTime  
		where AreaNo=@AreaNo and ParkNo=@ParkNo and GateNo=@GateNo and LaneNo=@LaneNo and VehType=@VehType and VehClass=@VehClass and 
			TicketType=@TicketType and UserCardType=@UserCardType and CheckType=@CheckType and SquadDate=@SquadDate and SquadNo=@SquadNo and 
			OperatorNo=@OperatorNo and OperatorName=@OperatorName
    
    if @@ROWCOUNT = 0
    Begin   
		insert into tb_OutListSum(AreaNo,ParkNo,GateNo,LaneNo,VehType,VehClass,TicketType,UserCardType,CheckType,VehCountSum,
				SquadDate,SquadNo,OperatorNo,OperatorName,CashMoneySum,FreeMoneySum,UnpayMoneySum,ETCMoneySum,StatTime)
			values(@AreaNo,@ParkNo,@GateNo,@LaneNo,@VehType,@VehClass,@TicketType,@UserCardType,@CheckType,@VehCount,
				@SquadDate,@SquadNo,@OperatorNo,@OperatorName,@CashMoney,@FreeMoney,@UnpayMoney,@ETCMoney,@OpTime)
    End

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

--��tb_CardUserInfo��Ӧ�ĳ��Ƶ�OBUid����
Create Trigger Tr_PlateToObuId
	on tb_PlateToObuId
	for insert
As
	update tb_UserCardInfo 
	set OBU=t2.ObuId
	from tb_UserCardInfo t1, inserted t2
	where t1.VehPlate=t2.VehPlate
  
  	delete from tb_PlateToObuId
  

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


--���³����ϴ��İ���������ͼƬ
create Trigger tr_UserVehPlate 
on tb_PlateToPic
INSTEAD OF INSERT
AS
BEGIN
	if exists (select * from tb_usercardinfo where vehplate in (select vehplate from inserted))
		update tb_UserCardInfo 
		set VehPlateImage=t2.Picture
		from tb_UserCardInfo t1, inserted t2
		where t1.VehPlate=t2.VehPlate
		
	if exists (select * from tb_testwl where vehplate in (select vehplate from inserted))
		update tb_testwl 
		set VehPlateImage=t2.Picture
		from tb_testwl t1, inserted t2
		where t1.VehPlate=t2.VehPlate
END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE trigger [dbo].[Tr_SecurityCommandDelete]
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE trigger 	[dbo].[Tr_SecurityCommandInsert]
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE trigger 	[dbo].[Tr_SecurityCommandUpdate]
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


CREATE TRIGGER tr_SpVehMonitor
ON tb_SpVehMonitor
FOR UPDATE
AS
	INSERT INTO tb_SpVehMonitorLog 
		SELECT AreaNo, ParkNo, GateNo, LaneNo, VehPlate, CardNo, Operation, OpTime, GETDATE()  
		FROM tb_SpVehMonitor
		WHERE IsRead = 1
	DELETE FROM tb_SpVehMonitor
	WHERE IsRead = 1

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

create Trigger Tri_ToYZList_Tmp 
on tb_ToYZList_Tmp
for insert
as

	--Begin TRANSACTION

	insert into tb_YZList_Tmp
	select CardNo, VehPlate, OwnerName, ObuId, Getdate()-1,  Getdate()+60, 14, 0
	from inserted t1

	--commit

	delete from tb_ToYZList_Tmp


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO



CREATE  trigger [dbo].[Tri_BackupModifiedData]
on [dbo].[tb_UserCardInfo]
for update, delete
as
insert into tb_UserCardInfoHistory
select RecNO,Owner,IDCard,VehPlate,ParkingSpace,OBU,RegisterTime,Status,Deposit,CardNO,UserCardType,GETDATE() as ModifyTime,FeeRuleType,RoomNo,TelePhone,PayEndTime,MobileNumber,Address,StaffNo,VehBrand,LinkMan,Remark from deleted
-------------------------------------------------------------------------------------------------
--�޸�tb_UserCardBill����EndTime�����ǽɷѽ���ʱ����Ҫ��һ�죬֮ǰ���ǵ���ĩ�����һ�죬������������ 00:00:00,�����Ļ��Ͳ��������һ��

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

CREATE Trigger [dbo].[Tri_SetSendPara] 
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
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO


create   Trigger Tri_SetUsercardbill
on dbo.tb_UserCardInfo 
for delete
as
	begin
		delete from tb_usercardbill
		where userRecno in (select recno from deleted)
	end


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
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
CREATE trigger [dbo].[Tr_CarCountAdd]
on [dbo].[tb_InList_Tmp]
for insert
as
declare @iParkNo            smallint
declare @sGateNo            varchar(10)
declare @iCardNo			int 
declare @iUserCardType      int
select @iParkNo=ParkNo,@sGateNo=GateNo,@iCardNo=CardNo,@iUserCardType=UserCardType from inserted
if(@iCardNo!=0 and @iUserCardType=0)--��ʱ�����㳵λ
begin
	if exists(select * from tb_CarSpace where ParkNo=@iParkNo and GateNo=@sGateNo)
		begin
			 update tb_CarSpace set CarCount = CarCount +1,ModifyTime = getdate() where ParkNo=@iParkNo and GateNo=@sGateNo and MaxSpace>CarCount
		end
	else
		begin
			 update tb_CarSpace set CarCount = CarCount +1,ModifyTime = getdate() where ParkNo=@iParkNo and GateNo='all' and MaxSpace>CarCount
		end
  delete from tb_SendPara where tablename='v_ShowInfo'
  insert into tb_SendPara select 1,0,0,laneno,laneComputerIP,'v_ShowInfo','v_ShowInfo' from tb_LaneUse
end


GO
exec sp_settriggerorder @triggername ='Tr_CarCountAdd',
                        @order = 'first',
                        @stmttype = 'insert',
                        @namespace = null
GO
GO
create trigger [dbo].[Tr_CarCountIff]
on [dbo].[tb_OutList_Tmp]
for insert
as
declare @iParkNo            smallint
declare @sGateNo            varchar(10)
declare @iCardNo			int 
declare @iUserCardType      int
select @iParkNo=ParkNo,@sGateNo=GateNo,@iCardNo=CardNo,@iUserCardType=UserCardType from inserted
if(@iCardNo!=0 and @iUserCardType=0)--��ʱ�����㳵λ
begin
	if exists(select * from tb_CarSpace where ParkNo=@iParkNo and GateNo=@sGateNo)
		begin
			 update tb_CarSpace set CarCount = CarCount -1,ModifyTime = getdate() where ParkNo=@iParkNo and GateNo=@sGateNo and CarCount>0
		end
	else
		begin
			 update tb_CarSpace set CarCount = CarCount -1,ModifyTime = getdate() where ParkNo=@iParkNo and GateNo='all' and CarCount>0
		end
  delete from tb_SendPara where tablename='v_ShowInfo'
  insert into tb_SendPara select 1,0,0,laneno,laneComputerIP,'v_ShowInfo','v_ShowInfo' from tb_LaneUse
end

GO
exec sp_settriggerorder @triggername ='Tr_CarCountIff',
                        @order = 'first',
                        @stmttype = 'insert',
                        @namespace = null
GO

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Trigger [dbo].[Tr_InlistCarSpaceDynamicAndInPark]--�޸ĳ�λ��̬��Ϣ�Ͳ�����Ϣ������ͣ������Ϣ��tb_InPark���У��ϴ��������ã�
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
	declare @iCardNo			int 
			
	select @AreaNo=AreaNo,@ParkNo=ParkNo,@GateNo=GateNo,@LaneNo=LaneNo,@sVehPlate=VehPlate,@VehType=VehType,@VehClass=VehClass,@TicketType=TicketType,
	@UserCardType=UserCardType,@VehCount=VehCount,@SquadDate=SquadDate,@SquadNo=SquadNo,@OperatorNo=OperatorNo,@OperatorName=OperatorName,@OpTime=OpTime,@iCardNo=CardNo
	from inserted
	if(@iCardNo!=0)
	begin
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
			   insert into tb_InPark(ParkNo,VehPlate,InOptime,CurrentEmptySpace,ModifyTime,BackUp1,BackUp2)
			   values(@sParkNo,@sVehPlate,@OpTime,@iCurrentEmptySpace,getDate(),null,null)	          
		   end
	   end

GO

GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE Trigger [dbo].[Tr_OutlistCarSpaceDynamicAndOutPark]--�޸ĳ�λ��̬��Ϣ�Ͳ�����Ϣ������ͣ������Ϣ��tb_OutPark���У��ϴ��������ã�
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
	declare @iCardNo			int 
	
	select @AreaNo=AreaNo,@ParkNo=ParkNo,@GateNo=GateNo,@LaneNo=LaneNo,@VehType=VehType,@VehClass=VehClass,@TicketType=TicketType,
		   @UserCardType=UserCardType,@CheckType=CheckType,@InOpTime=InOpTime,@sVehPlate=VehPlate,
		   @VehCount=VehCount,@SquadDate=SquadDate,@SquadNo=SquadNo,@OperatorNo=OperatorNo,@OperatorName=OperatorName,
		   @CashMoney=CashMoney,@FreeMoney=FreeMoney,@UnpayMoney=UnpayMoney,@ETCMoney=ETCMoney,@OpTime=OpTime,@iCardNo=CardNo 
	from inserted
	if(@iCardNo!=0)
	begin
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
				if(@iDay>99)
					begin
					   set @sDay='99'
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
				set  @sChargeTime=@sDay+':'+@sHour+':'+@sMinute
		            
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
	   end

GO
Go
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE trigger [dbo].[Tr_SendAccountCard]
on [dbo].[t_park_account]
for update
as
delete from tb_SendPara where tablename='tb_AccountCard'
insert into tb_SendPara select 1,0,0,laneno,laneComputerIP,'tb_AccountCard','tb_AccountCard' from tb_LaneUse
GO

--�����豸��ش�����
GO

/****** Object:  Trigger [dbo].[Tr_systemStatusInserted]    Script Date: 01/05/2012 15:03:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE Trigger [dbo].[Tr_systemStatusInserted] 
	on [dbo].[tb_SystemEventLog] for insert
	as 
	Begin
	 declare @iStatus smallint
	 declare @dOccurTime dateTime
	 select @iStatus = DeviceErrorNo,@dOccurTime = OccurTime from inserted;
	if not exists (select * from tb_SystemStatus where stationId in (select stationId from inserted) and RoadNum in (select RoadNum from inserted) and DeviceNo in (select DeviceNo from inserted))
		insert into tb_SystemStatus(stationId,RoadNum,DeviceNo,SystemTypeNo,Status,OccurTime) select stationId,RoadNum,DeviceNo,0,DeviceErrorNo,OccurTime from inserted;
	else
		update tb_SystemStatus set status = @iStatus,OccurTime = @dOccurTime where stationId in (select stationId from inserted) and RoadNum in (select RoadNum from inserted) and DeviceNo in (select DeviceNo from inserted)
	End
	
GO