CREATE Trigger [dbo].[Tr_OutlistSplit]
	on [dbo].[tb_OutList_Tmp]
	for insert
As
	if exists (select t1.IDCardNo from tb_IDCardInfo t1, inserted t2
				where t1.IDCardNo=t2.cardno and t2.CardNo>0)
	begin
		
		insert into tb_vipOutList 	
  		select * from inserted
		delete from tb_OutList_Tmp
	end
	else 
	begin
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
  end
---------------------һ���೵----------------------------------------------------------------------------
 --�жϱ�tb_CardGroup�Ƿ���ڣ�������ʱ�򴴽�


GO