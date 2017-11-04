--2012-10-15 �����⿨����
alter table tb_userCardINfo add feeCardType int ;
--2012-10-23 �û���Ϣ������������
alter table tb_userCardINfo add carType int;
--2012-11-5 �������ͱ�
CREATE TABLE [dbo].[tb_CarType](
	[CarType] [int] NOT NULL,
	[CarTypeName] [char](20) NULL,
 CONSTRAINT [PK_CarType] PRIMARY KEY CLUSTERED 
(
	[CarType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

--2012-12-14  ���ݿⱸ�ݴ������
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[PROC_BackUpParkdb]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[PROC_BackUpParkdb]
GO

create procedure [dbo].[PROC_BackUpParkdb]
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

if day(getdate())=1 --ÿ��1��
begin 
	set @shell='copy '+@path+' d:\DataBak\parkdb\monthly\parkdb_'+convert(varchar(30),@nowdt,112)+'.bak'
	ExEc xp_cmdshell @shell	
end

EXEC sp_configure 'xp_cmdshell', 0
RECONFIGURE
GO