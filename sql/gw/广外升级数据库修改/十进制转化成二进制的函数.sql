--ͨ�ð��޸Ĳ�ѯ��ˮ�����¼�����Ҫִ�е�sql���
--ʮ����ת���ɶ����Ƶĺ���sql.txt
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Dec2Bin]') and xtype in (N'FN', N'IF', N'TF'))
-- ɾ������
drop function [dbo].[Dec2Bin]
Go
-- ����: ��ʮ������(INT)ת��Ϊ�������ַ���(VARCHAR)  
-- �������: @Dec ��ת����ʮ������,����,  @StrLen ���صĶ������ַ����ĳ���  
-- ����ֵ: ��������ʽ��ʾ���ַ���  
-- ע��: ���@Decת�����ʵ�ʳ���С��@StrLen,����߲���"0",���@Decת�����ʵ�ʳ���  
--       ����@StrLen,����ʵ�ʳ��ȷ���  
-- ����: cheyfuyuan   
-- ����: 2005-09-29  
-- ����: SELECT 'B' + dbo.Dec2Bin(15, 4) AS '15�Ķ����Ʊ�ʾ'  
CREATE FUNCTION Dec2Bin(@Dec INT, @StrLen TINYINT)  
RETURNS VARCHAR(31) -- INT��,4�ֽ�,����תΪ�������ַ������31λ  
AS  
BEGIN  
    DECLARE @BinStr AS VARCHAR(31)      -- �����Ʊ�ʾ���ַ���  
    DECLARE @Div2 AS INT                -- ��  
    DECLARE @Mod2 AS INT                -- ģ/����  
    IF @Dec < 0  
        RETURN 'NULL'              -- ��֧�ָ�����ת��  
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
      
    SET @BinStr = CAST(@Mod2 AS CHAR(1)) + @BinStr -- ����,�����ʮ���Ƶ������Ƶ�ת��  
    IF @StrLen > LEN(@BinStr)    -- ����û�ָ���ĳ��ȴ���ʵ�ʳ��ȣ�����Ҫ��߲�0  
        BEGIN  
            IF @StrLen > 31    -- ���صĳ��ȣ��Ϊ32  
                SET @StrLen = 31  
      
            DECLARE @ZeroStr VARCHAR(31)    -- ��Ҫ�����"0000..."  
            DECLARE @OffsetLen TINYINT       -- ��Ҫ���伸��"0"  
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