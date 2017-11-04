
if  exists(Select   1   From   Msdb..SysJobs   Where   name= 'deleteCardDynamic')
	exec   msdb.dbo.sp_delete_job   @job_name=deleteCardDynamic
GO
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 08/17/2011 10:35:22 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'deleteCardDynamic', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'无描述。', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [delete]    Script Date: 08/17/2011 10:35:22 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'delete', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC Proc_DeleteCardDynamicByTicketType', 
		@database_name=N'parkdb', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'3个月执行一次', 
		@enabled=1, 
		@freq_type=16, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=3, 
		@active_start_date=20110726, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959, 
		@schedule_uid=N'95dd31e6-750e-4f28-85d3-257db9824e0f'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO
------------------------------------------------建立数据库备份作业-------------------------------------
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[PROC_BackUpParkdb]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[PROC_BackUpParkdb]
GO
if  exists(Select   1   From   Msdb..SysJobs   Where   name= 'BackUpParkdb')
	exec   msdb.dbo.sp_delete_job   @job_name=BackUpParkdb
GO
--数据库备份数据存放在D盘
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
EXEC sp_configure 'xp_cmdshell', 1
RECONFIGURE

ExEc xp_cmdshell 'mkdir d:\DataBak\parkdb'
ExEc xp_cmdshell 'mkdir d:\DataBak\parkdb\monthly'

set @shell='del d:\DataBak\parkdb\parkdb_'+convert(varchar(30),dateadd(day,-3,@nowdt),112)+'.bak /Q'
ExEc xp_cmdshell @shell

set @shell='del d:\DataBak\parkdb\parkdb_'+substring(convert(varchar(30),dateadd(month,-2,@nowdt),112),1,6)+'*.bak /Q'
ExEc xp_cmdshell @shell

set @shell='del d:\DataBak\parkdb\monthly\parkdb_'+substring(convert(varchar(30),dateadd(month,-2,@nowdt),112),1,6)+'*.bak /Q'
ExEc xp_cmdshell @shell	

set @path='d:\DataBak\parkdb\parkdb_'+convert(varchar(30),@nowdt,112)+'.bak'
exec ('Backup Database parkdb To disk='''+@path+''' with init')

if day(getdate())=1 --每月1号
begin 
	set @shell='copy '+@path+' d:\DataBak\parkdb\monthly\parkdb_'+convert(varchar(30),@nowdt,112)+'.bak'
	ExEc xp_cmdshell @shell	
end

EXEC sp_configure 'xp_cmdshell', 0
RECONFIGURE



GO
--建立作业 在每天的 2:00:00 执行。将从 2011-10-2 开始使用计划。
/****** Object:  Job [BackUpParkdb]    Script Date: 10/02/2011 20:36:05 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 10/02/2011 20:36:05 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'BackUpParkdb', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'无描述。', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [备份]    Script Date: 10/02/2011 20:36:06 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'备份', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC PROC_BackUpParkdb', 
		@database_name=N'parkdb', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'备份数据库parkdb', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20111002, 
		@active_end_date=99991231, 
		@active_start_time=20000, 
		@active_end_time=235959, 
		@schedule_uid=N'3f7cfc01-cc38-4ab8-bbfd-f8754beb9a6e'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO
----------------------------------------建立删除入口和出口流水作业---------------------------------------

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
if  exists(Select   1   From   Msdb..SysJobs   Where   name= 'DeleteOutListAndInList')
	exec   msdb.dbo.sp_delete_job   @job_name=DeleteOutListAndInList
GO


create   PROCEDURE [dbo].[PROC_DeleteInList]
AS
declare @Months             tinyint --当前系统的月份
declare @Time               dateTime --当前系统时间

select @Time = CONVERT(dateTime,getDate(),121)
select @Months = SUBSTRING (CONVERT(varchar,@Time,101),1,2)

if @Months = 1
  begin
    if exists(select * from tb_InList01) 
       begin       
			delete from tb_InList02 where SquadDate<getDate()
			insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'数据库作业删除tb_InList02中的数据',@Time,'tb_InList02')
       end
  end    
if @Months = 2
  begin
    if exists(select * from tb_InList02) 
       begin       
             delete from tb_InList03 where SquadDate<getDate()
             insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'数据库作业删除tb_InList03中的数据',@Time,'tb_InList03')
         end
     end  
if @Months = 3
  begin
    if exists(select * from tb_InList03) 
       begin  
             delete from tb_InList04 where SquadDate<getDate()
             insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'数据库作业删除tb_InList04中的数据',@Time,'tb_InList04')
         end
     end 
if @Months = 4
  begin
    if exists(select * from tb_InList04) 
       begin        
             delete from tb_InList05 where SquadDate<getDate()
             insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'数据库作业删除tb_InList05中的数据',@Time,'tb_InList05')
         end
     end  
if @Months = 5
  begin
    if exists(select * from tb_InList05)   
		begin    
             delete from tb_InList06 where SquadDate<getDate()
             insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'数据库作业删除tb_InList06中的数据',@Time,'tb_InList06')
         end
     end  
if @Months = 6
  begin
    if exists(select * from tb_InList06) 
       begin       
             delete from tb_InList07 where SquadDate<getDate()
             insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'数据库作业删除tb_InList07中的数据',@Time,'tb_InList07')
         end
     end  
if @Months = 7
  begin
    if exists(select * from tb_InList07) 
       begin        
              delete from tb_InList08 where SquadDate<getDate()
              insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'数据库作业删除tb_InList08中的数据',@Time,'tb_InList08')
         end
     end 
if @Months = 8
  begin
    if exists(select * from tb_InList08) 
       begin       
			 delete from tb_InList09 where SquadDate<getDate()
			 insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'数据库作业删除tb_InList09中的数据',@Time,'tb_InList09')
       end
     end
if @Months = 9
  begin
    if exists(select * from tb_InList09) 
       begin       
             delete from tb_InList10 where SquadDate<getDate()
             insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'数据库作业删除tb_InList10中的数据',@Time,'tb_InList10')
       end
     end   
if @Months = 10
  begin
    if exists(select * from tb_InList10) 
       begin        
             delete from tb_InList11 where SquadDate<getDate()
             insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'数据库作业删除tb_InList11中的数据',@Time,'tb_InList11')
       end
     end 
if @Months = 11
  begin
    if exists(select * from tb_InList11) 
       begin         
              delete from tb_InList12 where SquadDate<getDate()
              insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'数据库作业删除tb_InList12中的数据',@Time,'tb_InList12')
       end
     end 
if @Months = 12
  begin
    if exists(select * from tb_InList12) 
       begin        
              delete from tb_InList01 where SquadDate<getDate()
              insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'数据库作业删除tb_InList01中的数据',@Time,'tb_InList01')
        end
  end  
GO
GO
create   PROCEDURE [dbo].[PROC_DeleteOutList]
AS
declare @Months             tinyint --当前系统的月份
declare @Time               dateTime --当前系统时间

select @Time = CONVERT(dateTime,getDate(),121)
select @Months = SUBSTRING (CONVERT(varchar,@Time,101),1,2)

if @Months = 1
  begin
    if exists(select * from tb_OutList01) 
       begin       
			delete from tb_OutList02 where SquadDate<getDate()
			insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'数据库作业删除tb_OutList02中的数据',@Time,'tb_OutList02')
       end
  end    
if @Months = 2
  begin
    if exists(select * from tb_OutList02) 
       begin       
             delete from tb_OutList03 where SquadDate<getDate()
             insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'数据库作业删除tb_OutList03中的数据',@Time,'tb_OutList03')
         end
     end  
if @Months = 3
  begin
    if exists(select * from tb_OutList03) 
       begin  
             delete from tb_OutList04 where SquadDate<getDate()
             insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'数据库作业删除tb_OutList04中的数据',@Time,'tb_OutList04')
         end
     end 
if @Months = 4
  begin
    if exists(select * from tb_OutList04) 
       begin        
             delete from tb_OutList05 where SquadDate<getDate()
             insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'数据库作业删除tb_OutList05中的数据',@Time,'tb_OutList05')
         end
     end  
if @Months = 5
  begin
    if exists(select * from tb_OutList05)   
		begin    
             delete from tb_OutList06 where SquadDate<getDate()
             insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'数据库作业删除tb_OutList06中的数据',@Time,'tb_OutList06')
         end
     end  
if @Months = 6
  begin
    if exists(select * from tb_OutList06) 
       begin       
             delete from tb_OutList07 where SquadDate<getDate()
             insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'数据库作业删除tb_OutList07中的数据',@Time,'tb_OutList07')
         end
     end  
if @Months = 7
  begin
    if exists(select * from tb_OutList07) 
       begin        
              delete from tb_OutList08 where SquadDate<getDate()
              insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'数据库作业删除tb_OutList08中的数据',@Time,'tb_OutList08')
         end
     end 
if @Months = 8
  begin
    if exists(select * from tb_OutList08) 
       begin       
			 delete from tb_OutList09 where SquadDate<getDate()
			 insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'数据库作业删除tb_OutList09中的数据',@Time,'tb_OutList09')
       end
     end
if @Months = 9
  begin
    if exists(select * from tb_OutList09) 
       begin       
             delete from tb_OutList10 where SquadDate<getDate()
             insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'数据库作业删除tb_OutList10中的数据',@Time,'tb_OutList10')
       end
     end   
if @Months = 10
  begin
    if exists(select * from tb_OutList10) 
       begin        
             delete from tb_OutList11 where SquadDate<getDate()
             insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'数据库作业删除tb_OutList11中的数据',@Time,'tb_OutList11')
       end
     end 
if @Months = 11
  begin
    if exists(select * from tb_OutList11) 
       begin         
              delete from tb_OutList12 where SquadDate<getDate()
              insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'数据库作业删除tb_OutList12中的数据',@Time,'tb_OutList12')
       end
     end 
if @Months = 12
  begin
    if exists(select * from tb_OutList12) 
       begin        
              delete from tb_OutList01 where SquadDate<getDate()
              insert into t_park_systemLog (logTime,logType,operatorID,logData,coverage,remark) values(@Time,1,1,'数据库作业删除tb_OutList01中的数据',@Time,'tb_OutList01')
        end
  end   
  GO
 --建立作业，在每月第 15 天的 0:00:00 执行。将从 2011-5-18 开始使用计划。
  GO
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 08/17/2011 10:36:44 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'DeleteOutListAndInList', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'无描述。', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [delete]    Script Date: 08/17/2011 10:36:44 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'delete', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC PROC_DeleteOutList
EXEC PROC_DeleteInList', 
		@database_name=N'parkdb', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'deteleTime', 
		@enabled=1, 
		@freq_type=16, 
		@freq_interval=15, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20110518, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959, 
		@schedule_uid=N'22585441-db79-403e-9639-1e270702bdfc'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

