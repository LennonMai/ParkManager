IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'parkdb')
	DROP DATABASE [parkdb]
GO

CREATE DATABASE [parkdb]  ON (NAME = N'parkdb_dat', FILENAME = N'D:\new_hg_parkdb\parkdb\2008data\parkdb.mdf' , SIZE = 3192, FILEGROWTH = 10%) LOG ON (NAME = N'parkdb_log', FILENAME = N'D:\new_hg_parkdb\parkdb\2008data\parkdb.ldf' , SIZE = 2, FILEGROWTH = 10%)
 COLLATE Chinese_PRC_CI_AS
GO