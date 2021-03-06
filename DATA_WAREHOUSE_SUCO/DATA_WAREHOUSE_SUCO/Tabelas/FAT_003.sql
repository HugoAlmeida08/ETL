CREATE TABLE [dbo].[FAT_003]
(
    [COD_FABRICA] NVARCHAR(50) NOT NULL, 
    [COD_DIA] NVARCHAR(50) NOT NULL, 
    [CST_FIXO] FLOAT NULL, 
    PRIMARY KEY ([COD_FABRICA], [COD_DIA]), 
    CONSTRAINT [FK_FAT_003_DIM_FABRICA] FOREIGN KEY ([COD_FABRICA]) REFERENCES [DIM_FABRICA]([COD_FABRICA]),
    CONSTRAINT [FK_FAT_003_DIM_TEMPO] FOREIGN KEY ([COD_DIA]) REFERENCES [DIM_TEMPO]([COD_DIA])
)
