use NYCTaxi_Sample
GO

DROP PROCEDURE IF EXISTS [sp_train_test_split]
GO

CREATE PROCEDURE [dbo].[sp_train_test_split] (@pct int)
AS

DROP TABLE IF EXISTS dbo.[nyc_features_train]
SELECT * into [nyc_features_train] FROM [nyc_features_prep] 
WHERE (ABS(CAST(BINARY_CHECKSUM(medallion,hack_license)  as int)) % 100) < @pct

DROP TABLE IF EXISTS dbo.[nyc_features_test]
SELECT * into [nyc_features_test] FROM [nyc_features_prep]
WHERE (ABS(CAST(BINARY_CHECKSUM(medallion,hack_license)  as int)) % 100) > @pct
GO