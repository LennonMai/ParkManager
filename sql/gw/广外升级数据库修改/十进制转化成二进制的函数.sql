--通用版修改查询流水特殊事件所需要执行的sql语句
--十进制转化成二进制的函数sql.txt
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Dec2Bin]') and xtype in (N'FN', N'IF', N'TF'))
-- 删除函数
drop function [dbo].[Dec2Bin]
Go
-- 功能: 将十进制数(INT)转换为二进制字符串(VARCHAR)  
-- 输入参数: @Dec 待转换的十进制数,正数,  @StrLen 返回的二进制字符串的长度  
-- 返回值: 二进制形式表示的字符串  
-- 注意: 如果@Dec转换后的实际长度小于@StrLen,则左边补足"0",如果@Dec转换后的实际长度  
--       大于@StrLen,则以实际长度返回  
-- 作者: cheyfuyuan   
-- 日期: 2005-09-29  
-- 例子: SELECT 'B' + dbo.Dec2Bin(15, 4) AS '15的二进制表示'  
CREATE FUNCTION Dec2Bin(@Dec INT, @StrLen TINYINT)  
RETURNS VARCHAR(31) -- INT型,4字节,正数转为二进制字符串最多31位  
AS  
BEGIN  
    DECLARE @BinStr AS VARCHAR(31)      -- 二进制表示的字符串  
    DECLARE @Div2 AS INT                -- 商  
    DECLARE @Mod2 AS INT                -- 模/余数  
    IF @Dec < 0  
        RETURN 'NULL'              -- 不支持负数的转换  
    SET @Div2 = @Dec / 2    
    SET @Mod2 = @Dec % 2    
    SET @BinStr = ''  
    WHILE @Div2 <> 0  
    BEGIN  
        SET @BinStr = CAST(@Mod2 AS CHAR(1)) + @BinStr  
        SET @Dec = @Dec / 2  
        SET @Div2 = @Dec / 2  
        SET @Mod2 = @Dec % 2  
    END  
      
    SET @BinStr = CAST(@Mod2 AS CHAR(1)) + @BinStr -- 至此,已完成十进制到二进制的转换  
    IF @StrLen > LEN(@BinStr)    -- 如果用户指定的长度大于实际长度，则需要左边补0  
        BEGIN  
            IF @StrLen > 31    -- 返回的长度，最长为32  
                SET @StrLen = 31  
      
            DECLARE @ZeroStr VARCHAR(31)    -- 需要补充的"0000..."  
            DECLARE @OffsetLen TINYINT       -- 需要补充几个"0"  
            SET @ZeroStr = ''  
            SET @OffsetLen = @StrLen - LEN(@BinStr)  
      
            WHILE  @OffsetLen > 0  
            BEGIN  
                SET @ZeroStr = @ZeroStr + '0'   
                SET @OffsetLen = @OffsetLen - 1  
            END  
      
            SET @BinStr = @ZeroStr + @BinStr  
        END  
    RETURN @BinStr  
END  