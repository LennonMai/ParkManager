--2012-11-29
--��ʦˢ���Ż�ģ��
INSERT [dbo].[t_park_module] ( [parent], [name], [url], [functions], [priority], [display], [level], [remark]) VALUES ( 3, N'ˢ���Ż�', N'/freeAction_index.do', N'/freeAction_isSysCard.do', 100, 1, 2, N'')
--2012-12-10
--��ʦͨ�зѷֳ�����ʱ�α���ģ��
INSERT [dbo].[t_park_module] ( [parent], [name], [url], [functions], [priority], [display], [level], [remark]) VALUES (27, N'ͨ�зѷֳ�����ʱ�α���',N'/tollsReport_tollsLane.do',N'/tollsReport_tollsLane.do',90,1,3,N'')
--��ʦͨ�зѷֳ�����ʱ�α���2��ģ��
INSERT [dbo].[t_park_module] ( [parent], [name], [url], [functions], [priority], [display], [level], [remark]) VALUES (27, N'ͨ�зѷֳ�����ʱ�α���(2)',N'/otherTollsReport_tollsLane.do',N'/otherTollsReport_tollsLane.do',100,1,3,N'')



INSERT [dbo].[t_park_module] ( [parent], [name], [url], [functions], [priority], [display], [level], [remark]) VALUES (485, N'����HTML����and��ѯ',N'/tollsReport_tollsLaneReport.do',N'/tollsReport_tollsLaneReport.do',10,0,4,N'')
INSERT [dbo].[t_park_module] ( [parent], [name], [url], [functions], [priority], [display], [level], [remark]) VALUES (485, N'����PDF����',N'/tollsReport_tollsLaneReportPDF.do',N'/tollsReport_tollsLaneReportPDF.do',20,0,4,N'')
INSERT [dbo].[t_park_module] ( [parent], [name], [url], [functions], [priority], [display], [level], [remark]) VALUES (486, N'����HTML����and��ѯ',N'/otherTollsReport_tollsLaneReport.do',N'/otherTollsReport_tollsLaneReport.do',10,0,4,N'')
INSERT [dbo].[t_park_module] ( [parent], [name], [url], [functions], [priority], [display], [level], [remark]) VALUES (486, N'����PDF����',N'/otherTollsReport_tollsLaneReportPDF.do',N'/otherTollsReport_tollsLaneReportPDF.do',20,0,4,N'')

--�����ɫģ��� 
insert into t_park_role_module values(1,484)
insert into t_park_role_module values(1,485)
insert into t_park_role_module values(1,486) 
insert into t_park_role_module values(1,487)
insert into t_park_role_module values(1,488) 
insert into t_park_role_module values(1,489) 
insert into t_park_role_module values(1,490)  
