/*
Deployment script for DATA_WAREHOUSE_SUCO

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "DATA_WAREHOUSE_SUCO"
:setvar DefaultFilePrefix "DATA_WAREHOUSE_SUCO"
:setvar DefaultDataPath ""
:setvar DefaultLogPath ""

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [master];


GO

IF (DB_ID(N'$(DatabaseName)') IS NOT NULL) 
BEGIN
    ALTER DATABASE [$(DatabaseName)]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$(DatabaseName)];
END

GO
PRINT N'Creating $(DatabaseName)...'
GO
CREATE DATABASE [$(DatabaseName)] COLLATE SQL_Latin1_General_CP1_CI_AS
GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                RECOVERY FULL,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET READ_COMMITTED_SNAPSHOT OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                PAGE_VERIFY NONE,
                DATE_CORRELATION_OPTIMIZATION OFF,
                DISABLE_BROKER,
                PARAMETERIZATION SIMPLE,
                SUPPLEMENTAL_LOGGING OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET TRUSTWORTHY OFF,
        DB_CHAINING OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'The database settings cannot be modified. You must be a SysAdmin to apply these settings.';
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET HONOR_BROKER_PRIORITY OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'The database settings cannot be modified. You must be a SysAdmin to apply these settings.';
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET FILESTREAM(NON_TRANSACTED_ACCESS = OFF),
                CONTAINMENT = NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF),
                MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT = OFF,
                DELAYED_DURABILITY = DISABLED 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = ALL, DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_PLANS_PER_QUERY = 200, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE = OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET TEMPORAL_HISTORY_RETENTION ON 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF fulltextserviceproperty(N'IsFulltextInstalled') = 1
    EXECUTE sp_fulltext_database 'enable';


GO
PRINT N'Creating [dbo].[DIM_ORGANIZACIONAL]...';


GO
CREATE TABLE [dbo].[DIM_ORGANIZACIONAL] (
    [COD_FILHO] NVARCHAR (50)  NOT NULL,
    [DES_FILHO] NVARCHAR (200) NULL,
    [COD_PAI]   NVARCHAR (50)  NULL,
    [ESQUERDA]  INT            NULL,
    [DIREITA]   INT            NULL,
    [NIVEL]     INT            NULL,
    PRIMARY KEY CLUSTERED ([COD_FILHO] ASC)
);


GO
PRINT N'Creating [dbo].[DIM_PRODUTO]...';


GO
CREATE TABLE [dbo].[DIM_PRODUTO] (
    [COD_PRODUTO] NVARCHAR (50)  NOT NULL,
    [DES_PRODUTO] NVARCHAR (200) NULL,
    [ATR_TAMANHO] NVARCHAR (200) NULL,
    [ATR_SABOR]   NVARCHAR (200) NULL,
    [COD_MARCA]   NVARCHAR (50)  NULL,
    PRIMARY KEY CLUSTERED ([COD_PRODUTO] ASC)
);


GO
PRINT N'Creating [dbo].[DIM_MARCA]...';


GO
CREATE TABLE [dbo].[DIM_MARCA] (
    [COD_MARCA]     NVARCHAR (50)  NOT NULL,
    [DES_MARCA]     NVARCHAR (200) NULL,
    [COD_CATEGORIA] NVARCHAR (50)  NULL,
    PRIMARY KEY CLUSTERED ([COD_MARCA] ASC)
);


GO
PRINT N'Creating [dbo].[DIM_CATEGORIA]...';


GO
CREATE TABLE [dbo].[DIM_CATEGORIA] (
    [COD_CATEGORIA] NVARCHAR (50)  NOT NULL,
    [DES_CATEGORIA] NVARCHAR (200) NULL,
    PRIMARY KEY CLUSTERED ([COD_CATEGORIA] ASC)
);


GO
PRINT N'Creating [dbo].[DIM_CLIENTE]...';


GO
CREATE TABLE [dbo].[DIM_CLIENTE] (
    [COD_CLIENTE]  NVARCHAR (50)  NOT NULL,
    [DES_CLIENTE]  NVARCHAR (200) NULL,
    [COD_CIDADE]   NVARCHAR (50)  NULL,
    [DES_CIDADE]   NVARCHAR (200) NULL,
    [COD_ESTADO]   NVARCHAR (50)  NULL,
    [DES_ESTADO]   NVARCHAR (200) NULL,
    [COD_REGIAO]   NVARCHAR (50)  NULL,
    [DES_REGIAO]   NVARCHAR (200) NULL,
    [COD_SEGMENTO] NVARCHAR (50)  NULL,
    [DES_SEGMENTO] NVARCHAR (200) NULL,
    PRIMARY KEY CLUSTERED ([COD_CLIENTE] ASC)
);


GO
PRINT N'Creating [dbo].[DIM_FABRICA]...';


GO
CREATE TABLE [dbo].[DIM_FABRICA] (
    [COD_FABRICA] NVARCHAR (50)  NOT NULL,
    [DES_FABRICA] NVARCHAR (200) NULL,
    PRIMARY KEY CLUSTERED ([COD_FABRICA] ASC)
);


GO
PRINT N'Creating [dbo].[FK_DIM_ORGANIZACIONAL_DIM_ORGANIZACIONAL]...';


GO
ALTER TABLE [dbo].[DIM_ORGANIZACIONAL]
    ADD CONSTRAINT [FK_DIM_ORGANIZACIONAL_DIM_ORGANIZACIONAL] FOREIGN KEY ([COD_PAI]) REFERENCES [dbo].[DIM_ORGANIZACIONAL] ([COD_FILHO]);


GO
PRINT N'Creating [dbo].[FK_DIM_PRODUTO_DIM_MARCA]...';


GO
ALTER TABLE [dbo].[DIM_PRODUTO]
    ADD CONSTRAINT [FK_DIM_PRODUTO_DIM_MARCA] FOREIGN KEY ([COD_MARCA]) REFERENCES [dbo].[DIM_MARCA] ([COD_MARCA]);


GO
PRINT N'Creating [dbo].[FK_DIM_MARCA_DIM_CATEGORIA]...';


GO
ALTER TABLE [dbo].[DIM_MARCA]
    ADD CONSTRAINT [FK_DIM_MARCA_DIM_CATEGORIA] FOREIGN KEY ([COD_CATEGORIA]) REFERENCES [dbo].[DIM_CATEGORIA] ([COD_CATEGORIA]);


GO
-- Refactoring step to update target server with deployed transaction logs

IF OBJECT_ID(N'dbo.__RefactorLog') IS NULL
BEGIN
    CREATE TABLE [dbo].[__RefactorLog] (OperationKey UNIQUEIDENTIFIER NOT NULL PRIMARY KEY)
    EXEC sp_addextendedproperty N'microsoft_database_tools_support', N'refactoring log', N'schema', N'dbo', N'table', N'__RefactorLog'
END
GO
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'af46fcd9-e1cd-458a-b15e-b404d83a357e')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('af46fcd9-e1cd-458a-b15e-b404d83a357e')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '002c4bfb-165f-4ed8-bc3e-f32ad3fd44f0')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('002c4bfb-165f-4ed8-bc3e-f32ad3fd44f0')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'a8203a0e-f3d8-41f4-8712-03118b154868')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('a8203a0e-f3d8-41f4-8712-03118b154868')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '641c7a30-cdf2-4640-9dfb-7d91d19c0fac')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('641c7a30-cdf2-4640-9dfb-7d91d19c0fac')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '08e253f6-fc42-4b04-9630-92af65f79cd1')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('08e253f6-fc42-4b04-9630-92af65f79cd1')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'ed969f95-0793-4977-b167-d87f3ee0f2f7')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('ed969f95-0793-4977-b167-d87f3ee0f2f7')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '207f1364-4ee3-41dc-859b-b403a83d269c')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('207f1364-4ee3-41dc-859b-b403a83d269c')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '354cd9d1-1870-48b7-aa91-c66e689362d1')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('354cd9d1-1870-48b7-aa91-c66e689362d1')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'b37c85c7-f452-4a17-add5-a04d3dc19810')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('b37c85c7-f452-4a17-add5-a04d3dc19810')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'ca99d4fa-0a37-448d-a7ed-49c13689ebca')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('ca99d4fa-0a37-448d-a7ed-49c13689ebca')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '077cb067-a3d6-4a5f-9db3-f6b46baf2acb')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('077cb067-a3d6-4a5f-9db3-f6b46baf2acb')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '189e2dd4-eb0a-4023-abcc-0329dec690f5')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('189e2dd4-eb0a-4023-abcc-0329dec690f5')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'a2f15ebb-65ac-4ba6-a60d-fbe6ceeda620')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('a2f15ebb-65ac-4ba6-a60d-fbe6ceeda620')

GO

GO
DECLARE @VarDecimalSupported AS BIT;

SELECT @VarDecimalSupported = 0;

IF ((ServerProperty(N'EngineEdition') = 3)
    AND (((@@microsoftversion / power(2, 24) = 9)
          AND (@@microsoftversion & 0xffff >= 3024))
         OR ((@@microsoftversion / power(2, 24) = 10)
             AND (@@microsoftversion & 0xffff >= 1600))))
    SELECT @VarDecimalSupported = 1;

IF (@VarDecimalSupported > 0)
    BEGIN
        EXECUTE sp_db_vardecimal_storage_format N'$(DatabaseName)', 'ON';
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET MULTI_USER 
    WITH ROLLBACK IMMEDIATE;


GO
PRINT N'Update complete.';


GO
