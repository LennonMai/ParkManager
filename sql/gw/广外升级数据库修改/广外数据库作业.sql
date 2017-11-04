------------------------------------------------�������ݿⱸ����ҵ-------------------------------------
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[PROC_BackUpParkdb]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[PROC_BackUpParkdb]

GO
--���ݿⱸ�����ݴ����D��
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

create procedure PROC_BackUpParkdb
as
declare @nowdt datetime,@path varchar(255),@shell varchar(500)
set @nowdt=getdate()
EXEC sp_configure 'show advanced options', 1
RECONFIGURE
--EXEC sp_configure 'xp_cmdshell', 1
--RECONFIGURE

ExEc master..xp_cmdshell 'mkdir d:\DataBak\parkdb'
ExEc master..xp_cmdshell 'mkdir d:\DataBak\parkdb\monthly'

set @shell='del d:\DataBak\parkdb\parkdb_'+convert(varchar(30),dateadd(day,-3,@nowdt),112)+'.bak /Q'
ExEc master..xp_cmdshell @shell

set @shell='del d:\DataBak\parkdb\parkdb_'+substring(convert(varchar(30),dateadd(month,-2,@nowdt),112),1,6)+'*.bak /Q'
ExEc master..xp_cmdshell @shell

set @shell='del d:\DataBak\parkdb\monthly\parkdb_'+substring(convert(varchar(30),dateadd(month,-2,@nowdt),112),1,6)+'*.bak /Q'
ExEc master..xp_cmdshell @shell	

set @path='d:\DataBak\parkdb\parkdb_'+convert(varchar(30),@nowdt,112)+'.bak'
exec ('Backup Database parkdb To disk='''+@path+''' with init')

if day(getdate())=1 --ÿ��1��
begin 
	set @shell='copy '+@path+' d:\DataBak\parkdb\monthly\parkdb_'+convert(varchar(30),@nowdt,112)+'.bak'
	ExEc master..xp_cmdshell @shell	
end

--EXEC sp_configure 'xp_cmdshell', 0
--RECONFIGURE



GO
--�����������ݿ���ҵ ��ÿ��� 2:00:00 ִ�С����� 2011-10-2 ��ʼʹ�üƻ���
BEGIN TRANSACTION            
  DECLARE @JobID BINARY(16)  
  DECLARE @ReturnCode INT    
  SELECT @ReturnCode = 0     
IF (SELECT COUNT(*) FROM msdb.dbo.syscategories WHERE name = N'[Uncategorized (Local)]') < 1 
  EXECUTE msdb.dbo.sp_add_category @name = N'[Uncategorized (Local)]'

  -- ɾ��ͬ���ľ���������еĻ�����
  SELECT @JobID = job_id     
  FROM   msdb.dbo.sysjobs    
  WHERE (name = N'BackUpParkdb')       
  IF (@JobID IS NOT NULL)    
  BEGIN  
  -- ������ҵ�Ƿ�Ϊ���ط�������ҵ  
  IF (EXISTS (SELECT  * 
              FROM    msdb.dbo.sysjobservers 
              WHERE   (job_id = @JobID) AND (server_id <> 0))) 
  BEGIN 
    -- �Ѿ����ڣ������ֹ�ű� 
    RAISERROR (N'�޷�������ҵ��BackUpParkdb������Ϊ�Ѿ�����ͬ���ƵĶ��ط�������ҵ��', 16, 1) 
    GOTO QuitWithRollback  
  END 
  ELSE 
    -- ɾ���۱��أ���ҵ 
    EXECUTE msdb.dbo.sp_delete_job @job_name = N'BackUpParkdb' 
    SELECT @JobID = NULL
  END 

BEGIN 

  -- �����ҵ
  EXECUTE @ReturnCode = msdb.dbo.sp_add_job @job_id = @JobID OUTPUT , @job_name = N'BackUpParkdb', @owner_login_name = N'sa', @description = N'û�п��õ�������', @category_name = N'[Uncategorized (Local)]', @enabled = 1, @notify_level_email = 0, @notify_level_page = 0, @notify_level_netsend = 0, @notify_level_eventlog = 2, @delete_level= 0
  IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback 

  -- �����ҵ����
  EXECUTE @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 1, @step_name = N'����', @command = N'EXEC PROC_BackUpParkdb', @database_name = N'parkdb', @server = N'', @database_user_name = N'', @subsystem = N'TSQL', @cmdexec_success_code = 0, @flags = 0, @retry_attempts = 0, @retry_interval = 1, @output_file_name = N'', @on_success_step_id = 0, @on_success_action = 1, @on_fail_step_id = 0, @on_fail_action = 2
  IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback 
  EXECUTE @ReturnCode = msdb.dbo.sp_update_job @job_id = @JobID, @start_step_id = 1 

  IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback 

  -- �����ҵ����
  EXECUTE @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id = @JobID, @name = N'�������ݿ�parkdb', @enabled = 1, @freq_type = 4, @active_start_date = 20120104, @active_start_time = 20000, @freq_interval = 1, @freq_subday_type = 1, @freq_subday_interval = 0, @freq_relative_interval = 0, @freq_recurrence_factor = 0, @active_end_date = 99991231, @active_end_time = 235959
  IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback 

  -- ���Ŀ�������
  EXECUTE @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @JobID, @server_name = N'(local)' 
  IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback 

END
COMMIT TRANSACTION          
GOTO   EndSave              
QuitWithRollback:
  IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION 
EndSave: 

GO
----------------------------------------����ɾ����ںͳ�����ˮ��ҵ---------------------------------------

if not exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[t_park_systemLog]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	CREATE TABLE [dbo].[t_park_systemLog] (
	[sys_id] [int] IDENTITY (1, 1) NOT NULL ,
	[logTime] [datetime] NOT NULL ,
	[logType] [int] NOT NULL ,
	[operatorID] [int] NOT NULL ,
	[logData] [varchar] (400) COLLATE Chinese_PRC_CI_AS NOT NULL ,
	[coverage] [varchar] (400) COLLATE Chinese_PRC_CI_AS NULL ,
	[remark] [varchar] (400) COLLATE Chinese_PRC_CI_AS NULL 
    ) ON [PRIMARY]

GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[PROC_DeleteInList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[PROC_DeleteInList]
GO
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[PROC_DeleteOutList]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[PROC_DeleteOutList]
GO



create   PROCEDURE [dbo].[PROC_DeleteInList]
AS
declare @Months             tinyint --��ǰϵͳ���·�
declare @Time               dateTime --��ǰϵͳʱ��

select @Time = CONVERT(dateTime,getDate(),121)
select @Months = SUBSTRING (CONVERT(varchar,@Time,101),1,2)

if @Months = 1
  begin
    if exists(select * from tb_InList01) 
       begin       
			delete from tb_InList02 where SquadDate<getDate()
			insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'���ݿ���ҵɾ��tb_InList02�е�����',@Time,'tb_InList02')
       end
  end    
if @Months = 2
  begin
    if exists(select * from tb_InList02) 
       begin       
             delete from tb_InList03 where SquadDate<getDate()
             insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'���ݿ���ҵɾ��tb_InList03�е�����',@Time,'tb_InList03')
         end
     end  
if @Months = 3
  begin
    if exists(select * from tb_InList03) 
       begin  
             delete from tb_InList04 where SquadDate<getDate()
             insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'���ݿ���ҵɾ��tb_InList04�е�����',@Time,'tb_InList04')
         end
     end 
if @Months = 4
  begin
    if exists(select * from tb_InList04) 
       begin        
             delete from tb_InList05 where SquadDate<getDate()
             insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'���ݿ���ҵɾ��tb_InList05�е�����',@Time,'tb_InList05')
         end
     end  
if @Months = 5
  begin
    if exists(select * from tb_InList05)   
		begin    
             delete from tb_InList06 where SquadDate<getDate()
             insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'���ݿ���ҵɾ��tb_InList06�е�����',@Time,'tb_InList06')
         end
     end  
if @Months = 6
  begin
    if exists(select * from tb_InList06) 
       begin       
             delete from tb_InList07 where SquadDate<getDate()
             insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'���ݿ���ҵɾ��tb_InList07�е�����',@Time,'tb_InList07')
         end
     end  
if @Months = 7
  begin
    if exists(select * from tb_InList07) 
       begin        
              delete from tb_InList08 where SquadDate<getDate()
              insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'���ݿ���ҵɾ��tb_InList08�е�����',@Time,'tb_InList08')
         end
     end 
if @Months = 8
  begin
    if exists(select * from tb_InList08) 
       begin       
			 delete from tb_InList09 where SquadDate<getDate()
			 insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'���ݿ���ҵɾ��tb_InList09�е�����',@Time,'tb_InList09')
       end
     end
if @Months = 9
  begin
    if exists(select * from tb_InList09) 
       begin       
             delete from tb_InList10 where SquadDate<getDate()
             insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'���ݿ���ҵɾ��tb_InList10�е�����',@Time,'tb_InList10')
       end
     end   
if @Months = 10
  begin
    if exists(select * from tb_InList10) 
       begin        
             delete from tb_InList11 where SquadDate<getDate()
             insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'���ݿ���ҵɾ��tb_InList11�е�����',@Time,'tb_InList11')
       end
     end 
if @Months = 11
  begin
    if exists(select * from tb_InList11) 
       begin         
              delete from tb_InList12 where SquadDate<getDate()
              insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'���ݿ���ҵɾ��tb_InList12�е�����',@Time,'tb_InList12')
       end
     end 
if @Months = 12
  begin
    if exists(select * from tb_InList12) 
       begin        
              delete from tb_InList01 where SquadDate<getDate()
              insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'���ݿ���ҵɾ��tb_InList01�е�����',@Time,'tb_InList01')
        end
  end  
GO
GO
create   PROCEDURE [dbo].[PROC_DeleteOutList]
AS
declare @Months             tinyint --��ǰϵͳ���·�
declare @Time               dateTime --��ǰϵͳʱ��

select @Time = CONVERT(dateTime,getDate(),121)
select @Months = SUBSTRING (CONVERT(varchar,@Time,101),1,2)

if @Months = 1
  begin
    if exists(select * from tb_OutList01) 
       begin       
			delete from tb_OutList02 where SquadDate<getDate()
			insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'���ݿ���ҵɾ��tb_OutList02�е�����',@Time,'tb_OutList02')
       end
  end    
if @Months = 2
  begin
    if exists(select * from tb_OutList02) 
       begin       
             delete from tb_OutList03 where SquadDate<getDate()
             insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'���ݿ���ҵɾ��tb_OutList03�е�����',@Time,'tb_OutList03')
         end
     end  
if @Months = 3
  begin
    if exists(select * from tb_OutList03) 
       begin  
             delete from tb_OutList04 where SquadDate<getDate()
             insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'���ݿ���ҵɾ��tb_OutList04�е�����',@Time,'tb_OutList04')
         end
     end 
if @Months = 4
  begin
    if exists(select * from tb_OutList04) 
       begin        
             delete from tb_OutList05 where SquadDate<getDate()
             insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'���ݿ���ҵɾ��tb_OutList05�е�����',@Time,'tb_OutList05')
         end
     end  
if @Months = 5
  begin
    if exists(select * from tb_OutList05)   
		begin    
             delete from tb_OutList06 where SquadDate<getDate()
             insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'���ݿ���ҵɾ��tb_OutList06�е�����',@Time,'tb_OutList06')
         end
     end  
if @Months = 6
  begin
    if exists(select * from tb_OutList06) 
       begin       
             delete from tb_OutList07 where SquadDate<getDate()
             insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'���ݿ���ҵɾ��tb_OutList07�е�����',@Time,'tb_OutList07')
         end
     end  
if @Months = 7
  begin
    if exists(select * from tb_OutList07) 
       begin        
              delete from tb_OutList08 where SquadDate<getDate()
              insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'���ݿ���ҵɾ��tb_OutList08�е�����',@Time,'tb_OutList08')
         end
     end 
if @Months = 8
  begin
    if exists(select * from tb_OutList08) 
       begin       
			 delete from tb_OutList09 where SquadDate<getDate()
			 insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'���ݿ���ҵɾ��tb_OutList09�е�����',@Time,'tb_OutList09')
       end
     end
if @Months = 9
  begin
    if exists(select * from tb_OutList09) 
       begin       
             delete from tb_OutList10 where SquadDate<getDate()
             insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'���ݿ���ҵɾ��tb_OutList10�е�����',@Time,'tb_OutList10')
       end
     end   
if @Months = 10
  begin
    if exists(select * from tb_OutList10) 
       begin        
             delete from tb_OutList11 where SquadDate<getDate()
             insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'���ݿ���ҵɾ��tb_OutList11�е�����',@Time,'tb_OutList11')
       end
     end 
if @Months = 11
  begin
    if exists(select * from tb_OutList11) 
       begin         
              delete from tb_OutList12 where SquadDate<getDate()
              insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'���ݿ���ҵɾ��tb_OutList12�е�����',@Time,'tb_OutList12')
       end
     end 
if @Months = 12
  begin
    if exists(select * from tb_OutList12) 
       begin        
              delete from tb_OutList01 where SquadDate<getDate()
              insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'���ݿ���ҵɾ��tb_OutList01�е�����',@Time,'tb_OutList01')
        end
  end   
  GO
 --����ɾ���������ˮ��ҵ����ÿ�µ� 15 ��� 0:00:00 ִ�С����� 2011-5-18 ��ʼʹ�üƻ���
  GO
BEGIN TRANSACTION            
  DECLARE @JobID BINARY(16)  
  DECLARE @ReturnCode INT    
  SELECT @ReturnCode = 0     
IF (SELECT COUNT(*) FROM msdb.dbo.syscategories WHERE name = N'[Uncategorized (Local)]') < 1 
  EXECUTE msdb.dbo.sp_add_category @name = N'[Uncategorized (Local)]'

  -- ɾ��ͬ���ľ���������еĻ�����
  SELECT @JobID = job_id     
  FROM   msdb.dbo.sysjobs    
  WHERE (name = N'DeleteOutListAndInList')       
  IF (@JobID IS NOT NULL)    
  BEGIN  
  -- ������ҵ�Ƿ�Ϊ���ط�������ҵ  
  IF (EXISTS (SELECT  * 
              FROM    msdb.dbo.sysjobservers 
              WHERE   (job_id = @JobID) AND (server_id <> 0))) 
  BEGIN 
    -- �Ѿ����ڣ������ֹ�ű� 
    RAISERROR (N'�޷�������ҵ��DeleteOutListAndInList������Ϊ�Ѿ�����ͬ���ƵĶ��ط�������ҵ��', 16, 1) 
    GOTO QuitWithRollback  
  END 
  ELSE 
    -- ɾ���۱��أ���ҵ 
    EXECUTE msdb.dbo.sp_delete_job @job_name = N'DeleteOutListAndInList' 
    SELECT @JobID = NULL
  END 

BEGIN 

  -- �����ҵ
  EXECUTE @ReturnCode = msdb.dbo.sp_add_job @job_id = @JobID OUTPUT , @job_name = N'DeleteOutListAndInList', @owner_login_name = N'sa', @description = N'û�п��õ�������', @category_name = N'[Uncategorized (Local)]', @enabled = 1, @notify_level_email = 0, @notify_level_page = 0, @notify_level_netsend = 0, @notify_level_eventlog = 2, @delete_level= 0
  IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback 

  -- �����ҵ����
  EXECUTE @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 1, @step_name = N'delete', @command = N'EXEC PROC_DeleteOutList
EXEC PROC_DeleteInList
', @database_name = N'parkdb', @server = N'', @database_user_name = N'', @subsystem = N'TSQL', @cmdexec_success_code = 0, @flags = 0, @retry_attempts = 0, @retry_interval = 1, @output_file_name = N'', @on_success_step_id = 0, @on_success_action = 1, @on_fail_step_id = 0, @on_fail_action = 2
  IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback 
  EXECUTE @ReturnCode = msdb.dbo.sp_update_job @job_id = @JobID, @start_step_id = 1 

  IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback 

  -- �����ҵ����
  EXECUTE @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id = @JobID, @name = N'deteleTime', @enabled = 1, @freq_type = 16, @active_start_date = 20110809, @active_start_time = 0, @freq_interval = 15, @freq_subday_type = 1, @freq_subday_interval = 0, @freq_relative_interval = 0, @freq_recurrence_factor = 1, @active_end_date = 99991231, @active_end_time = 235959
  IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback 

  -- ���Ŀ�������
  EXECUTE @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @JobID, @server_name = N'(local)' 
  IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback 

END
COMMIT TRANSACTION          
GOTO   EndSave              
QuitWithRollback:
  IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION 
EndSave: 

GO


/****** ����:  �û�����Ĵ洢���� Proc_DeleteCardDynamicByTicketType  ************/
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Proc_DeleteCardDynamicByTicketType]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[Proc_DeleteCardDynamicByTicketType]
GO
--ɾ��������
CREATE proc [dbo].[Proc_DeleteCardDynamicByTicketType]
as
delete from tb_CardDynamic where TicketType=5 or TicketType=6
GO
---------------------------------------------------------------------------------------------------
--�������ô洢����Proc_DeleteCardDynamicByTicketType����������ҵdeleteCardDynamic,ÿ������ɾ��һ��
Go
IF EXISTS(SELECT * FROM msdb.dbo.sysjobs WHERE name=N'deleteCardDynamic')
EXEC msdb.dbo.sp_delete_job @job_name=N'deleteCardDynamic'

GO

BEGIN TRANSACTION            
  DECLARE @JobID BINARY(16)  
  DECLARE @ReturnCode INT    
  SELECT @ReturnCode = 0     
IF (SELECT COUNT(*) FROM msdb.dbo.syscategories WHERE name = N'[Uncategorized (Local)]') < 1 
  EXECUTE msdb.dbo.sp_add_category @name = N'[Uncategorized (Local)]'

  -- ɾ��ͬ���ľ���������еĻ�����
  SELECT @JobID = job_id     
  FROM   msdb.dbo.sysjobs    
  WHERE (name = N'deleteCardDynamic')       
  IF (@JobID IS NOT NULL)    
  BEGIN  
  -- ������ҵ�Ƿ�Ϊ���ط�������ҵ  
  IF (EXISTS (SELECT  * 
              FROM    msdb.dbo.sysjobservers 
              WHERE   (job_id = @JobID) AND (server_id <> 0))) 
  BEGIN 
    -- �Ѿ����ڣ������ֹ�ű� 
    RAISERROR (N'�޷�������ҵ��deleteCardDynamic������Ϊ�Ѿ�����ͬ���ƵĶ��ط�������ҵ��', 16, 1) 
    GOTO QuitWithRollback  
  END 
  ELSE 
    -- ɾ���۱��أ���ҵ 
    EXECUTE msdb.dbo.sp_delete_job @job_name = N'deleteCardDynamic' 
    SELECT @JobID = NULL
  END 

BEGIN 

  -- �����ҵ
  EXECUTE @ReturnCode = msdb.dbo.sp_add_job @job_id = @JobID OUTPUT , @job_name = N'deleteCardDynamic', @owner_login_name = N'sa', @description = N'û�п��õ�������', @category_name = N'[Uncategorized (Local)]', @enabled = 1, @notify_level_email = 0, @notify_level_page = 0, @notify_level_netsend = 0, @notify_level_eventlog = 2, @delete_level= 0
  IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback 

  -- �����ҵ����
  EXECUTE @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 1, @step_name = N'ɾ������̬��Ϣ', @command = N'exec Proc_DeleteCardDynamicByTicketType', @database_name = N'parkdb', @server = N'', @database_user_name = N'', @subsystem = N'TSQL', @cmdexec_success_code = 0, @flags = 0, @retry_attempts = 0, @retry_interval = 1, @output_file_name = N'', @on_success_step_id = 0, @on_success_action = 1, @on_fail_step_id = 0, @on_fail_action = 2
  IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback 
  EXECUTE @ReturnCode = msdb.dbo.sp_update_job @job_id = @JobID, @start_step_id = 1 

  IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback 

  -- �����ҵ����
  EXECUTE @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id = @JobID, @name = N'ɾ��', @enabled = 1, @freq_type = 16, @active_start_date = 20120302, @active_start_time = 0, @freq_interval = 1, @freq_subday_type = 1, @freq_subday_interval = 0, @freq_relative_interval = 0, @freq_recurrence_factor = 3, @active_end_date = 99991231, @active_end_time = 235959
  IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback 

  -- ���Ŀ�������
  EXECUTE @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @JobID, @server_name = N'(local)' 
  IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback 

END
COMMIT TRANSACTION          
GOTO   EndSave              
QuitWithRollback:
  IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION 
EndSave: 
