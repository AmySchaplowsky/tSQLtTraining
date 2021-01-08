SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [RptContactTypes].[test to check RptContactTypes exists]
AS
BEGIN
    --Assemble

    --Act

    --Assert
    EXEC tSQLt.AssertObjectExists @ObjectName = N'dbo.RptContactTypes',                         -- nvarchar(max)
                                  @Message = N'The object dbo.RptContactTypes does not exist.'; -- nvarchar(max)
END;
GO
