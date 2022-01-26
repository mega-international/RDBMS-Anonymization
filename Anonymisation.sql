



  DECLARE @META_IDABS VARCHAR(50), @UNIQUE_CODE VARCHAR(50);
  DECLARE @Flag_METASTRUCTURE smallint =0;
  DECLARE @Flag_METACLASSFIER smallint =0;
  DECLARE @Flag_FirstMETACLASSFIER smallint =0;
  DECLARE @FlagCursorTableNotFound smallint =1;
  DECLARE @SQLQuery AS NVARCHAR(max)

  DECLARE @ConcatColumn AS VARCHAR(max)

  DECLARE @batchSize INT, @rowsUpdated INT
  SET @batchSize = 100000;
  DECLARE @StrbatchSize as nvarchar(max)
  SET @StrbatchSize = '100000'
  DECLARE @StrStartingRecord as nvarchar(10)
  DECLARE @StrEndingRecord as nvarchar(10)

  DECLARE @LogToShrink VARCHAR(max)

 --Take Database (quotename) name
DECLARE @DBNAME VARCHAR(100)
SET @DBNAME=DB_NAME();

DECLARE @isql VARCHAR(max)


IF @DBNAME not like '%_ANONYME'
	BEGIN
	print 'YOUR DATABASE DOESNT END BY "_ANONYME".'
	print 'PLEASE FOLLOW THE ANONYMISATION GUIDE TO AVOID DESTROYING USEFUL DATABASES'

END

ELSE
BEGIN
	print 'Start ANONYMISATION.'

DECLARE @DBQNAME VARCHAR(100)
SET @DBQNAME=QUOTENAME(DB_NAME());
print @DBQNAME

DECLARE @DBQSessUser VARCHAR(100)
SET @DBQSessUser=QUOTENAME(session_user);
print @DBQSessUser



--SystemDB name
DECLARE @SystemDbName  VARCHAR(MAX)

SELECT @SystemDbName=BulkColumn
FROM   OPENROWSET(BULK'c:\temp\SystemdBName.txt',SINGLE_CLOB) x; 

Print 'Your SystemDb name is : ' + @SystemDbName
IF @SystemDbName not like '%_ANONYME'
	BEGIN
	print 'YOUR SYSTEMDB DOESNT END BY "_ANONYME".'
	print 'PLEASE FOLLOW THE ANONYMISATION GUIDE TO AVOID DESTROYING USEFUL DATABASES'

END

ELSE
BEGIN
	print 'Start SKRINK LOG.'





--SIMPLE MODE + SHRINK
-----------------------------------------------
  
SET @LogToShrink = (SELECT top(1) name  FROM sys.database_files where type_desc ='LOG' )

PRINT @LogToShrink + ' is the logfile to shrink'
DBCC SHRINKFILE (@LogToShrink, 1)

select @isql = 'ALTER DATABASE @dbname SET RECOVERY SIMPLE'
select @isql = replace(@isql,'@dbname',@dbname)
print @isql
exec(@isql)



--exclusion inclusion file
-----------------------------------------------
create TABLE ExclInc(
	EorI int,
	Descrip VARCHAR(100),
	AttrId VARCHAR(100)	);

BULK
INSERT ExclInc
FROM 'c:\temp\ExclusionInclusion.txt'
WITH
(
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n'
)

--auto add of enumerate attributes in the exclude file

DECLARE @char0 varchar(15) = '''0''';
DECLARE @charENUM varchar(15) = '''ENUM''';
DECLARE @charT varchar(15) = '''T''';
DECLARE @charF varchar(15) = '''F''';


SET @SQLQuery = N'INSERT  INTO ExclInc (EorI,  Descrip, AttrId) select  distinct ' +  @char0 + ', ' + @charENUM + ', (IDABS) FROM ' + QUOTENAME(@SystemDbName) +'.'+ @DBQSessUser + '.[C_0000000080000018] where  A_000000004000001C in (' +@charT +',' + @charF +')'				
					PRINT @SQLQuery 

					BEGIN TRANSACTION;
					EXECUTE sp_executesql @SQLQuery 
					COMMIT TRANSACTION;





Print 'Here is the exception table'
SELECT * FROM ExclInc 






IF NOT EXISTS( SELECT DISTINCT *
FROM   ExclInc T1
WHERE  EXISTS (SELECT *
               FROM   ExclInc T2
               WHERE  T1.EorI <> T2.EorI
                 AND  T1.AttrId    = T2.AttrId) )
                 
BEGIN
PRINT 'No matching row exists : good, the ExlInc has no relative (include/exclude) doublons'
END
ELSE
BEGIN
PRINT 'The ExInc file has mistakes : you are required to include and exclude the same element'
END



-- to symplify blob request

create TABLE ExclInc2(AttrId2 bigint)
INSERT into ExclInc2(AttrId2) SELECT CAST(AttrId as bigint) FROM ExclInc where ISNUMERIC(AttrId)=1 and EorI=0
SELECT * FROM ExclInc2 


---------------------------------
-- Delete Log Data
---------------------------------

PRINT 'DELETION OF DATA LOGS'

DECLARE @PracticionerID varchar(max)
create TABLE LogDataToDel(LogDataTable varchar(max))
INSERT into LogDataToDel(LogDataTable) VALUES ('A_BLOB_LOG'), ('L_0000000000000048'), ('C_000000008000002F'), ('L_000000000000004A'), ('L_0000000000000081'), ('L_0000000000000057'), ('L_0000000000000058'), ('C_0000000080000031'), ('L_000000000000005B')

SET @SQLQuery = N'INSERT  INTO LogDataToDel(LogDataTable) SELECT [UNIQUE_CODE_BACKUP] FROM ' + @DBQNAME +'.'+ @DBQSessUser + '.[A_META_BACKUP]'			
	PRINT @SQLQuery 

	BEGIN TRANSACTION;
	EXECUTE sp_executesql @SQLQuery 
	COMMIT TRANSACTION;



DECLARE @PractitionerList TABLE(PracticionerID varchar(max))

    
INSERT @PractitionerList(PracticionerID) SELECT LogDataTable FROM LogDataToDel
    
WHILE(1 = 1)
BEGIN
            
    SET @PracticionerID = NULL
    SELECT TOP(1) @PracticionerID = PracticionerID
    FROM @PractitionerList
    
    IF @PracticionerID IS NULL
        BREAK
            
    PRINT @PracticionerID
	IF (OBJECT_ID(@PracticionerID) IS NOT NULL )
		BEGIN
			
			SET @SQLQuery = N'TRUNCATE TABLE '  + @DBQNAME +'.'+ @DBQSessUser + '.' +@PracticionerID	
			PRINT @SQLQuery 

			BEGIN TRANSACTION;
			EXECUTE sp_executesql @SQLQuery 
			COMMIT TRANSACTION;
		END

    DELETE TOP(1) FROM @PractitionerList
    
END


PRINT 'DATA LOGS HAVE BEEN DELETED'

---------------------------------
-- CLEAN AND CONSOLIDATE STORED PROC
---------------------------------

--PRINT 'STARTING CLEAN PROCEDURE'
--EXEC dbo.SP_CLEAN_MEGA_DATABASE 
--PRINT 'CLEAN PROCEDURE HAS ENDED'

--SET @LogToShrink = (SELECT top(1) name  FROM sys.database_files where type_desc ='LOG' )
--DBCC SHRINKFILE (@LogToShrink, 1)






--PRINT 'START CONSOLIDATE PROCEDURE'
--EXEC dbo.SP_CONSOLIDATE_MEGA_DATABASE
--SET @LogToShrink = (SELECT name  FROM sys.database_files where name like '%log' )
--DBCC SHRINKFILE (@LogToShrink, 1)
--PRINT 'CONSOLIDATE PROCEDURE HAS ENDED'

----------------------------
--rename database idabs : UPDATE [EnvTestsLab_900_005_tst_5888_EA1].[dbo].[A_DBINFOS] SET [DBIDABS] = [DBIDABS]+1;
-----------------------------
DECLARE @SQLQueryDBInit AS NVARCHAR(500)
DECLARE @DBInfoTable AS NVARCHAR(200)

SET @DBInfoTable = CONCAT(@DBQNAME,NULL,'.');
SET @DBInfoTable = CONCAT(@DBInfoTable,NULL,@DBQSessUser);
SET @DBInfoTable = CONCAT(@DBInfoTable,NULL,'.[A_DBINFOS]');
SET @SQLQueryDBInit = N'UPDATE '+ @DBInfoTable + ' SET [DBIDABS] = [DBIDABS]+1; ' ;

BEGIN TRANSACTION
EXECUTE sp_executesql @SQLQueryDBInit
COMMIT TRANSACTION


-- fetch on tables
  DECLARE METACLASSFIER_cursor CURSOR FOR  
	SELECT  [META_IDABS]
      ,[UNIQUE_CODE]      
  FROM [A_METACLASSIFIER] WHERE META_NATURE <>4 -- @ClassifierTable --[EnvTestsLab_900_005_tst_5888_EA1].[dbo].[A_METACLASSIFIER]

	OPEN METACLASSFIER_cursor;  
  
	-- Perform the first fetch.  
	FETCH NEXT FROM METACLASSFIER_cursor INTO @META_IDABS, @UNIQUE_CODE;   
	
	


	-- Check @@FETCH_STATUS to see if there are any more rows to fetch.  
	WHILE @@FETCH_STATUS = 0  
	BEGIN  

	print @UNIQUE_CODE
	SET @ConcatColumn=null
	

	 --exception table
	 /*
	 IF @UNIQUE_CODE='C_B1EDB2562C140173'
	 BEGIN
        FETCH NEXT FROM METACLASSFIER_cursor INTO @META_IDABS, @UNIQUE_CODE; 
     END;
	*/



	IF @@FETCH_STATUS<>0 
	 BEGIN
        SET @Flag_METACLASSFIER=1;
     END ;

		DECLARE @CheckTableExist VARCHAR(200)
		--SET @CheckTableExist= CONCAT('[EnvTestsLab_900_005_tst_5888_EA1].[dbo].', NULL, QUOTENAME(@UNIQUE_CODE));
		SET @CheckTableExist= CONCAT(@DBQNAME, NULL, '.');
		SET @CheckTableExist= CONCAT(@CheckTableExist, NULL, @DBQSessUser);
		SET @CheckTableExist= CONCAT(@CheckTableExist, NULL, '.');
		SET @CheckTableExist= CONCAT(@CheckTableExist, NULL, QUOTENAME(@UNIQUE_CODE));
		
		IF object_id(@CheckTableExist) is not null
		BEGIN
		SET @FlagCursorTableNotFound = 1; 
		--PRINT '[META_IDABS]: ' + @META_IDABS + '   [UNIQUE_CODE] : ' +  @UNIQUE_CODE  

		-----------------------------------------------------------------------------------------------
		--for each Tables listed in dbo.A_METACLASSIFIER, we get the [ATTRIBUTEIDABS] it contains
		-----------------------------------------------------------------------------------------------
		DECLARE @IDMETASTRUCTURE VARCHAR(50), @ATTRIBUTEIDABS VARCHAR(50);
		DECLARE METASTRUCTURE_cursor CURSOR FOR  

		SELECT  [IDMETASTRUCTURE]
		,[ATTRIBUTEIDABS]
		FROM [A_METASTRUCTURE] where [IDMETASTRUCTURE]=@META_IDABS
		

		OPEN METASTRUCTURE_cursor;  
  
		-- Perform the first fetch.  
		FETCH NEXT FROM METASTRUCTURE_cursor INTO @IDMETASTRUCTURE, @ATTRIBUTEIDABS;   
	
		-- Check @@FETCH_STATUS to see if there are any more rows to fetch.  
		WHILE @@FETCH_STATUS = 0  
			BEGIN  

			IF @@FETCH_STATUS<>0 
			BEGIN
				SET @Flag_METASTRUCTURE=1;
			END ;
			--PRINT '[IDMETASTRUCTURE]: ' + @IDMETASTRUCTURE + '   [ATTRIBUTEIDABS] : ' +  @ATTRIBUTEIDABS 

				-----------------------------------------------------------------------------------------------
				--for each column listed in dbo.A_METASTRUCTURE we get the [ATTRIBUTEIDABS] it contains
				-----------------------------------------------------------------------------------------------
				DECLARE @AT_ATTRIBUTEIDABS VARCHAR(50), @AT_UNIQUE_CODE VARCHAR(4096), @ATTRIBUTEFORMAT VARCHAR(50),  @LCID VARCHAR(50), @AT_LENGTH INT;
				DECLARE METAATTRIBUTE_cursor CURSOR FOR  

				SELECT [ATTRIBUTEIDABS]
					,[UNIQUE_CODE]
					,[ATTRIBUTEFORMAT]
					,[LCID]
					,[ATTRIBUTELENGTH]
				FROM [A_METAATTRIBUTE] where [ATTRIBUTEIDABS]=@ATTRIBUTEIDABS 
				

				OPEN METAATTRIBUTE_cursor;  
  
				-- Perform the first fetch.  
				FETCH NEXT FROM METAATTRIBUTE_cursor INTO @AT_ATTRIBUTEIDABS, @AT_UNIQUE_CODE, @ATTRIBUTEFORMAT, @LCID, @AT_LENGTH;   
	
				-- Check @@FETCH_STATUS to see if there are any more rows to fetch.  
				WHILE @@FETCH_STATUS = 0  
					BEGIN  

					DECLARE @clm VARCHAR(50) =@UNIQUE_CODE;	--DECLARE @UNIQUE_CODE VARCHAR(50) ='C_FF48012F4535004C';									
					DECLARE @Monatt VARCHAR(50) =@AT_UNIQUE_CODE; --DECLARE @AT_UNIQUE_CODE VARCHAR(50)='GBM_NAME';	
					DECLARE @QMonatt VARCHAR(50)=null
					-- Variable Declaration for Query
					
					DECLARE @ParameterDefinition AS NVARCHAR(100)
					DECLARE @TableName AS NVARCHAR(200)
					DECLARE @ClmName AS NVARCHAR(300)
					DECLARE @GLN varchar(150) = '''%[[][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9][a-f0-9]]''';
					DECLARE @PlusSign varchar(15) = '''+''';
					--DECLARE @AttrXA varchar(15) = '''%A%''';
					--DECLARE @AttrXK varchar(15) = '''%K%''';


					IF @ATTRIBUTEFORMAT='X' AND @AT_UNIQUE_CODE not in (select AttrId from ExclInc where EorI=0) and  @AT_ATTRIBUTEIDABS not in (select AttrId from ExclInc where EorI=0)
					BEGIN				
					
					SET @QMonatt= QUOTENAME(@Monatt)
					

					--construction tablename : '[EnvTestsLab_900_005_tst_5888_EA].[dbo].[C_FF48012F4535004C]'
					SET @TableName = CONCAT(@DBQNAME,NULL,'.');
					SET @TableName = CONCAT(@TableName,NULL,@DBQSessUser);
					SET @TableName = CONCAT(@TableName,NULL,'.');
					SET @TableName = CONCAT(@TableName,NULL, QUOTENAME(@clm));
					
					--construction colonne : [dbo].lipsum([@AT_UNIQUE_CODE]) -- [@AT_UNIQUE_CODE]
					------------------------------------------------------------------------------------------

						
						SET @ClmName = CONCAT(' LEFT(CONCAT(SUBSTRING([dbo].lipsum([',NULL,@Monatt); 
						SET @ClmName = CONCAT(@ClmName,NULL,'],');
						SET @ClmName = CONCAT(@ClmName,NULL,@LCID);
						SET @ClmName = CONCAT(@ClmName,NULL,'), 0, LEN ([');
						--SET @ClmName = CONCAT(@ClmName,NULL,']), 0, LEN ([');
						SET @ClmName = CONCAT(@ClmName,NULL,@Monatt);
						SET @ClmName = CONCAT(@ClmName,NULL,'])-18), NULL, SUBSTRING([');
						SET @ClmName = CONCAT(@ClmName,NULL,@Monatt);
						SET @ClmName = CONCAT(@ClmName,NULL,'], LEN ( [');
						SET @ClmName = CONCAT(@ClmName,NULL,@Monatt);
						SET @ClmName = CONCAT(@ClmName,NULL,'] )-18, 19)),LEN (');
						SET @ClmName = CONCAT(@ClmName,NULL,@Monatt);
						SET @ClmName = CONCAT(@ClmName,NULL,'))');

						--select version
						--SET @SQLQuery = N'SELECT '+ @ClmName + ' FROM ' + @TableName


						/*
						SET @rowsUpdated = @batchSize;

					DECLARE @Rowcount INT = 1
						 ,   @StartingRecord BIGINT = 1
						 ,   @EndingRecord BIGINT = 1;


						   DECLARE @StrRowcount as nvarchar(max)
					SET @StrRowcount = '1'

						--BATCHING @Rowcount
					--WHILE (@batchSize = @rowsUpdated)
					WHILE (@Rowcount > 0)
					BEGIN
									
					 SET @StrStartingRecord = convert(nvarchar(10), @StartingRecord)	
					 SET @EndingRecord= @StartingRecord + @batchSize - 1
					 SET @StrEndingRecord = convert(nvarchar(10), @EndingRecord)	
					 */


					--SET @SQLQuery = N'UPDATE TOP ('+ @StrbatchSize + ') ' + @TableName + ' SET ' + QUOTENAME(@Monatt) + ' = ' + @ClmName + ' WHERE ' + QUOTENAME(@Monatt) + ' like '+   @GLN + ' and ISNUMERIC('+QUOTENAME(@Monatt) + ')<>1' ;
					 			
					SET @SQLQuery = N'UPDATE ' + @TableName + ' SET ' + QUOTENAME(@Monatt) + ' = ' + @ClmName + ' WHERE ' + QUOTENAME(@Monatt) + ' like '+   @GLN + ' and ISNUMERIC('+QUOTENAME(@Monatt) + ')<>1' --  and  @Rowcount  BETWEEN ' + @StrStartingRecord + ' AND ' + @StrEndingRecord ;
					PRINT @SQLQuery
				
					BEGIN TRANSACTION;
					EXECUTE sp_executesql @SQLQuery  , N'@ClmName VARCHAR(100), @TableName VARCHAR(100)', @ClmName, @TableName ;
					COMMIT TRANSACTION;
					
					--SET @SQLQuery = N'UPDATE TOP ('+ @StrbatchSize + ') ' + @TableName + ' SET ' + QUOTENAME(@Monatt) + ' = [dbo].lipsum(' + QUOTENAME(@Monatt) + ',' + @LCID + ') WHERE ' + QUOTENAME(@Monatt) + ' not like '+   @GLN  + ' and ISNUMERIC('+QUOTENAME(@Monatt) + ')<>1 and ' +  QUOTENAME(@Monatt) + ' is not null';					
					--PRINT @SQLQuery 

					SET @SQLQuery = N'UPDATE ' + @TableName + ' SET ' + QUOTENAME(@Monatt) + ' = [dbo].lipsum(' + QUOTENAME(@Monatt) + ',' + @LCID + ') WHERE ' + QUOTENAME(@Monatt) + ' not like '+   @GLN  + ' and ISNUMERIC('+QUOTENAME(@Monatt) + ')<>1 and ' +  QUOTENAME(@Monatt) + ' is not null ' --and @Rowcount BETWEEN ' + @StrStartingRecord + ' AND ' + @StrEndingRecord ;					
					--PRINT @SQLQuery 

					BEGIN TRANSACTION;
					EXECUTE sp_executesql @SQLQuery  , N'@ClmName VARCHAR(100), @TableName VARCHAR(100)', @ClmName, @TableName ;
					COMMIT TRANSACTION;

					/*
					print @Rowcount
					SET @Rowcount = @@ROWCOUNT;
					SET @StrRowcount = convert(nvarchar(10), @Rowcount)	
					SET @StartingRecord=@StartingRecord+@batchSize

					
					END -- end batching
					*/

					--PRINT '[ATTRIBUTEIDABS]: ' + @AT_ATTRIBUTEIDABS + '   [AT UNIQUE_CODE] : ' +  @AT_UNIQUE_CODE + '   [UNIQUE_CODE] : ' +  @UNIQUE_CODE + '   [ATTRIBUTEFORMAT] : ' +  @ATTRIBUTEFORMAT + '   [LCID] : ' +  @LCID 
					END;

					--3) or here belong to include and not to exclude
					--
					IF EXISTS (SELECT * from ExclInc where EorI=1 and  AttrId=@AT_UNIQUE_CODE  )
					BEGIN	

					--PRINT '[ATTRIBUTEIDABS]: ' + @AT_ATTRIBUTEIDABS + '   [AT UNIQUE_CODE] : ' +  @AT_UNIQUE_CODE + '   [UNIQUE_CODE] : ' +  @UNIQUE_CODE + '   [ATTRIBUTEFORMAT] : ' +  @ATTRIBUTEFORMAT + '   [LCID] : ' +  @LCID 					
					
						IF @ATTRIBUTEFORMAT='D'
						BEGIN
						--UPDATE [EnvTestsLab_900_005_tst_5937_EA_ANONYME].[dbo].@UNIQUE_CODE SET @AT_ATTRIBUTEIDABS = DATEADD(day, (ABS(CHECKSUM(NEWID())) % 65530), @AT_ATTRIBUTEIDABS)
						SET @SQLQuery = N'UPDATE ' + @DBQNAME +'.' + @DBQSessUser + '.' + QUOTENAME(@clm) + ' SET ' + QUOTENAME(@Monatt) + ' = DATEADD(day, (ABS(CHECKSUM(NEWID())) % 65530),0);--' +@Monatt +')';
						--PRINT @SQLQuery
						
						BEGIN TRANSACTION;
						EXECUTE sp_executesql @SQLQuery;--  , N'@ClmName VARCHAR(100), @TableName VARCHAR(100)', @ClmName, @TableName;
						COMMIT TRANSACTION;
						END

						IF @ATTRIBUTEFORMAT='F' or @ATTRIBUTEFORMAT='S'
						BEGIN
						SET @SQLQuery = N'UPDATE ' + @DBQNAME +'.' + @DBQSessUser + '.' + QUOTENAME(@clm) + ' SET ' + QUOTENAME(@Monatt) + ' = FLOOR((select random_value from random_val_view) *255)';
						PRINT @SQLQuery
						BEGIN TRANSACTION;
						EXECUTE sp_executesql @SQLQuery;--  , N'@ClmName VARCHAR(100), @TableName VARCHAR(100)', @ClmName, @TableName;
						COMMIT TRANSACTION;
						END

						IF @ATTRIBUTEFORMAT='X' 
						BEGIN
						SET @SQLQuery = N'UPDATE ' + @DBQNAME +'.' + @DBQSessUser + '.' + QUOTENAME(@clm) + ' SET ' + QUOTENAME(@Monatt) + ' = [dbo].lipsum(' + QUOTENAME(@Monatt) + ',' + @LCID + ')';
						PRINT @SQLQuery
						BEGIN TRANSACTION;
						EXECUTE sp_executesql @SQLQuery;--  , N'@ClmName VARCHAR(100), @TableName VARCHAR(100)', @ClmName, @TableName;
						COMMIT TRANSACTION;
						END
					
					END
					--


					-- This is executed as long as the previous fetch succeeds.  
					FETCH NEXT FROM METAATTRIBUTE_cursor INTO @AT_ATTRIBUTEIDABS, @AT_UNIQUE_CODE, @ATTRIBUTEFORMAT, @LCID, @AT_LENGTH;  

					IF @QMonatt is not null
					BEGIN
					SET @ConcatColumn = CONCAT(@ConcatColumn,NULL,','+ @QMonatt);
					--print @ConcatColumn
					END
					
				END  --


				-----------------------------------------------------------------------------------------------
				--
				-----------------------------------------------------------------------------------------------


			-- This is executed as long as the previous fetch succeeds.
			IF @Flag_METASTRUCTURE=0 
			BEGIN  
				FETCH NEXT FROM METASTRUCTURE_cursor INTO @IDMETASTRUCTURE, @ATTRIBUTEIDABS;  
			END;
			--for each Tables listed in dbo.A_METACLASSIFIER, we get the [ATTRIBUTEIDABS] it contains

			CLOSE METAATTRIBUTE_cursor;  
			DEALLOCATE METAATTRIBUTE_cursor; 
		
		
		 
		END  
		
	-- (metclassifier is not over)
	
		END

		ELSE -- table was not found, we go to fetch next of metaclassifier
		BEGIN
			PRINT @UNIQUE_CODE + ' : (warning) This table was not found'
			SET @FlagCursorTableNotFound = 0;
		END 
	
	 IF @Flag_METACLASSFIER=0 
	 BEGIN


		SET @ConcatColumn = RIGHT(@ConcatColumn, LEN(@ConcatColumn) - 1)
		PRINT @ConcatColumn

        FETCH NEXT FROM METACLASSFIER_cursor INTO @META_IDABS, @UNIQUE_CODE; 
     END;


	--only if table was found
	IF @FlagCursorTableNotFound=1 
	 BEGIN
		CLOSE METASTRUCTURE_cursor;  
		DEALLOCATE METASTRUCTURE_cursor;  
	 END

		-----------------------------------------------------------------------------------------------
		--
		-----------------------------------------------------------------------------------------------

	END  

	CLOSE METACLASSFIER_cursor;  
	DEALLOCATE METACLASSFIER_cursor;  


--   END

--END --else DBNAME ending by _ANONYME


PRINT 'alphanumerical items have been anonymized'
PRINT 'starting anonymization of BLOB items'
--WE AN0NYMIZE BLOBs
	 	 --select  [BLOB_INT_LENGTH], LEN([dbo].lipsum (convert(varchar(max), [BLOB_BIN_VALUE]),1033)),[dbo].lipsum (convert(varchar(max), [BLOB_BIN_VALUE]),1033)  FROM [EnvTestsLab_900_005_tst_5937_EA_ANONYME].[dbo].[A_BLOB] where [BLOB_STORE_FRMT] ='+' and [BLOB_BIN_VALUE] is not NULL and [BLOB_INT_LENGTH] < 8000


		 --select  [BLOB_INT_LENGTH], LEN([dbo].lipsum (convert(varchar(max), [BLOB_SMALL_VALUE]),1033)),[dbo].lipsum (convert(varchar(max), [BLOB_SMALL_VALUE]),1033)  FROM [EnvTestsLab_900_005_tst_5937_EA_ANONYME].[dbo].[A_BLOB] where [BLOB_STORE_FRMT] ='+' and [BLOB_SMALL_VALUE] is not NULL and [BLOB_INT_LENGTH] < 8000
		  --if blob was longer than 8000, we just put 8000 lipsum char
		DECLARE @MyLongChar VARCHAR(max)= REPLICATE('AAAAAAAAAAAAAAAAAAAA', 400);
		DECLARE @MySmallChar VARCHAR(max)= REPLICATE('AAAAAAAAAAAAAAAAAAAA', 3);




		--BIN BLOB over 8000
		SET @SQLQuery = N'UPDATE ' + @DBQNAME +'.' + @DBQSessUser + '.' + '[A_BLOB]' + ' SET ' + '[BLOB_BIN_VALUE]=convert(varbinary(max), convert(varchar(max),' + @DBQSessUser + '.lipsum(@MyLongChar,1033))), [BLOB_INT_LENGTH]=8000, [BLOB_EXT_LENGTH]=8000, [BLOB_COMPRESSED]=0 where [BLOB_STORE_FRMT] =' +@PlusSign +' and [BLOB_BIN_VALUE] is not NULL and [BLOB_EXT_LENGTH] > 7999 and [ATTRIBUTEIDABS] not in (select AttrId2 from ExclInc2 )';
		PRINT @SQLQuery
						
		BEGIN TRANSACTION;
		EXECUTE sp_executesql @SQLQuery, N'@MyLongChar VARCHAR(max)', @MyLongChar;
		COMMIT TRANSACTION;

		--BIN BLOB UNDER 8000
		SET @SQLQuery = N'UPDATE ' + @DBQNAME +'.' + @DBQSessUser + '.' + '[A_BLOB]' + ' SET ' + '[BLOB_BIN_VALUE]=convert(varbinary(max), convert(varchar(max),' + @DBQSessUser + '.lipsum(convert(varchar(max), [BLOB_BIN_VALUE]),1033))),[BLOB_INT_LENGTH]=LEN('+ @DBQSessUser +'.lipsum(convert(varchar(max), [BLOB_BIN_VALUE]),1033)) , [BLOB_EXT_LENGTH]=LEN('+ @DBQSessUser +'.lipsum(convert(varchar(max), [BLOB_BIN_VALUE]),1033)), [BLOB_COMPRESSED]=0 where [BLOB_STORE_FRMT] =' +@PlusSign +' and [BLOB_BIN_VALUE] is not NULL and [BLOB_EXT_LENGTH] < 8000 and [ATTRIBUTEIDABS] not in (select AttrId2 from ExclInc2 )';
		PRINT @SQLQuery
						
		BEGIN TRANSACTION;
		EXECUTE sp_executesql @SQLQuery;
		COMMIT TRANSACTION;


		--SMALL BLOB
		SET @SQLQuery = N'UPDATE ' + @DBQNAME +'.' + @DBQSessUser + '.' + '[A_BLOB]' + ' SET ' + '[BLOB_SMALL_VALUE]=convert(varbinary(max), convert(varchar(max),' + @DBQSessUser + '.lipsum(@MySmallChar,1033))), [BLOB_INT_LENGTH]=30, [BLOB_EXT_LENGTH]=30, [BLOB_COMPRESSED]=0 where [BLOB_STORE_FRMT] =' +@PlusSign +' and [BLOB_SMALL_VALUE] is not NULL and [ATTRIBUTEIDABS] not in (select AttrId2 from ExclInc2 )';--and [BLOB_EXT_LENGTH] > 7999'and [ATTRIBUTEIDABS] not in (select CAST(AttrId as bigint) from ExclInc where EorI=0 and AttrId not like' + @AttrX +')';
		PRINT @SQLQuery
						
		BEGIN TRANSACTION;
		EXECUTE sp_executesql @SQLQuery, N'@MySmallChar VARCHAR(max)', @MySmallChar;
		COMMIT TRANSACTION;






	  /*------------------------------------------------


		SET @SQLQuery = N'UPDATE ' + @DBQNAME +'.' + @DBQSessUser + '.' + '[A_BLOB]' + ' SET ' + '[BLOB_SMALL_VALUE]=convert(varbinary(max),' + @DBQSessUser + '.lipsum(convert(varchar(max), [BLOB_SMALL_VALUE]),1033)) where [BLOB_STORE_FRMT] =' +@PlusSign +' and [BLOB_SMALL_VALUE] is not NULL and [BLOB_EXT_LENGTH] < 8000';
		PRINT @SQLQuery
						
		BEGIN TRANSACTION;
		EXECUTE sp_executesql @SQLQuery;
		COMMIT TRANSACTION;

		---------------------------------------------*/

		
		------------------------
		-- ANONYMISATION SYSTEM
		------------------------


			--Scci Name
			IF COL_LENGTH(QUOTENAME(@SystemDbName) +'.'+ @DBQSessUser + '.[C_000000008000001D]','[A_2909294B388F0006]') IS NOT NULL 
			BEGIN
			SET @SQLQuery = N'UPDATE ' + QUOTENAME(@SystemDbName) +'.'+ @DBQSessUser + '.[C_000000008000001D]  SET [A_2909294B388F0006] = [dbo].lipsum([A_2909294B388F0006] ,1033)'
					BEGIN TRANSACTION;
					EXECUTE sp_executesql @SQLQuery 
					COMMIT TRANSACTION;
			END

			--GRCC User name
			IF COL_LENGTH(QUOTENAME(@SystemDbName) +'.'+ @DBQSessUser + '.[C_000000008000001D]','[A_E202E26B4A440099]') IS NOT NULL 
			BEGIN
			SET @SQLQuery = N'UPDATE ' + QUOTENAME(@SystemDbName) +'.'+ @DBQSessUser + '.[C_000000008000001D]  SET [A_E202E26B4A440099] = [dbo].lipsum([A_E202E26B4A440099] ,1033)'
					BEGIN TRANSACTION;
					EXECUTE sp_executesql @SQLQuery 
					COMMIT TRANSACTION;
			END

			--GRCC password
			IF COL_LENGTH(QUOTENAME(@SystemDbName) +'.'+ @DBQSessUser + '.[C_000000008000001D]','[A_E202E2724A4400E2]') IS NOT NULL 
			BEGIN
			SET @SQLQuery = N'UPDATE ' + QUOTENAME(@SystemDbName) +'.'+ @DBQSessUser + '.[C_000000008000001D]  SET [A_E202E2724A4400E2] = [dbo].lipsum([A_E202E2724A4400E2] ,1033)'
					BEGIN TRANSACTION;
					EXECUTE sp_executesql @SQLQuery 
					COMMIT TRANSACTION;
			END
			--phone
			IF COL_LENGTH(QUOTENAME(@SystemDbName) +'.'+ @DBQSessUser + '.[C_000000008000001D]','[A_59B1676A4BD006C3]') IS NOT NULL 
			BEGIN
			SET @SQLQuery = N'UPDATE ' + QUOTENAME(@SystemDbName) +'.'+ @DBQSessUser + '.[C_000000008000001D]  SET [A_59B1676A4BD006C3] = [dbo].lipsum([A_59B1676A4BD006C3] ,1033)'
					BEGIN TRANSACTION;
					EXECUTE sp_executesql @SQLQuery 
					COMMIT TRANSACTION;
			END

			--mail
			IF COL_LENGTH(QUOTENAME(@SystemDbName) +'.'+ @DBQSessUser + '.[C_000000008000001D]','[A_106F1C6C3CA31620]') IS NOT NULL 
			BEGIN
			SET @SQLQuery = N'UPDATE ' + QUOTENAME(@SystemDbName) +'.'+ @DBQSessUser + '.[C_000000008000001D]  SET [A_106F1C6C3CA31620] = [dbo].lipsum([A_106F1C6C3CA31620] ,1033)'
					BEGIN TRANSACTION;
					EXECUTE sp_executesql @SQLQuery 
					COMMIT TRANSACTION;
			END
			
			--phone
			IF COL_LENGTH(QUOTENAME(@SystemDbName) +'.'+ @DBQSessUser + '.[C_000000008000003C]','[A_59B1676A4BD006C3]') IS NOT NULL 
			BEGIN
			SET @SQLQuery = N'UPDATE ' + QUOTENAME(@SystemDbName) +'.'+ @DBQSessUser + '.[C_000000008000003C]  SET [A_59B1676A4BD006C3] = [dbo].lipsum([A_59B1676A4BD006C3] ,1033)'
					BEGIN TRANSACTION;
					EXECUTE sp_executesql @SQLQuery 
					COMMIT TRANSACTION;
			END

			--mail
			IF COL_LENGTH(QUOTENAME(@SystemDbName) +'.'+ @DBQSessUser + '.[C_000000008000003C]','[A_106F1C6C3CA31620]') IS NOT NULL 
			BEGIN
			SET @SQLQuery = N'UPDATE ' + QUOTENAME(@SystemDbName) +'.'+ @DBQSessUser + '.[C_000000008000003C]  SET [A_106F1C6C3CA31620] = [dbo].lipsum([A_106F1C6C3CA31620] ,1033)'
					BEGIN TRANSACTION;
					EXECUTE sp_executesql @SQLQuery 
					COMMIT TRANSACTION;
			END

								
			--mail
			SET @SQLQuery = N'UPDATE ' + QUOTENAME(@SystemDbName) +'.'+ @DBQSessUser + '.[C_000000008000001D]  SET [A_106F1C6C3CA31620] = [dbo].lipsum([A_106F1C6C3CA31620] ,1033)'
					BEGIN TRANSACTION;
					EXECUTE sp_executesql @SQLQuery 
					COMMIT TRANSACTION;


		


			
			SET @SQLQuery = N'UPDATE ' + QUOTENAME(@SystemDbName) +'.'+ @DBQSessUser + '.[C_000000008000001D]  SET [GBM_NAME] = [dbo].lipsum([GBM_NAME],1033)'
					BEGIN TRANSACTION;
					EXECUTE sp_executesql @SQLQuery 
					COMMIT TRANSACTION;
/*
			-- (gmb name => login infos)
			SET @SQLQuery = N'UPDATE ' + QUOTENAME(@SystemDbName) +'.'+ @DBQSessUser + '.[C_000000008000003C]  SET [GBM_NAME] = [dbo].lipsum([GBM_NAME] ,1033) where [IDABS]<>4919131751843889152 '
			print @SQLQuery
					BEGIN TRANSACTION;
					EXECUTE sp_executesql @SQLQuery 
					COMMIT TRANSACTION;
*/


		SET @SQLQuery = N'DELETE FROM ' + QUOTENAME(@SystemDbName) +'.'+ @DBQSessUser + '.[L_0000000000000049]   where [S_000000000C000049] in (633318697598976, 14144117579710464, 1594340939343335535, 487316543146449329) or [F_0000000008000049] in(633318697598976, 14144117579710464, 1594340939343335535, 487316543146449329)'
			print @SQLQuery
					BEGIN TRANSACTION;
					EXECUTE sp_executesql @SQLQuery 
					COMMIT TRANSACTION;



		------------------------
		-- ANONYMISATION SYSTEM
		------------------------

		DROP TABLE ExclInc
		DROP TABLE ExclInc2
		DROP TABLE LogDataToDel
   END

END --else DBNAME ending by _ANONYME
PRINT 'THE ANONYMISATION PROCESS IS OVER'

GO


