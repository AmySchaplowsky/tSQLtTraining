SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [CheckAssertEqualsTable].[test OneLessColinActualThanExpected]
AS
BEGIN
	DECLARE @IsTestDisabled BIT = 1;

	IF (@IsTestDisabled = 1)
	BEGIN
		DECLARE @SchemaName VARCHAR(1000);

		SELECT
			@SchemaName = QUOTENAME(SCHEMA_NAME(schema_id)) + '.'
		FROM sys.procedures
		WHERE object_id = @@procid;

		PRINT 'Disabled Test: ' + @SchemaName + QUOTENAME(OBJECT_NAME(@@procid));

		RETURN 0;
	END;

	BEGIN
		--Assemble
		CREATE TABLE [CheckAssertEqualsTable].Expected
		(
			Col1  INT NULL
			,Col2 INT NULL
			,col3 INT NULL
		);

		CREATE TABLE [CheckAssertEqualsTable].Actual
		(
			Col1  INT NULL
			,Col2 INT NULL
		);

		INSERT [CheckAssertEqualsTable].Expected
		(
			Col1
			,Col2
			,col3
		)
		VALUES
		(
			1
			,2
			,3
		);

		INSERT [CheckAssertEqualsTable].Actual
		(
			Col1
			,Col2
		)
		VALUES
		(
			1
			,2
		);

		--Assert
		EXEC tSQLt.AssertEqualsTable
			@Expected = N'[CheckAssertEqualsTable].Expected'	  -- nvarchar(max)
			,@Actual = N'[CheckAssertEqualsTable].Actual'		  -- nvarchar(max)
			,@FailMsg = N'Expected had one col more than Actual'; -- nvarchar(max)
	END;
END;
GO
