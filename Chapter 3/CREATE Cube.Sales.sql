USE [WideWorldImportersDW]
GO
CREATE OR ALTER VIEW [Cube].[Sales]
AS
SELECT fs.[Sale Key]
      ,fs.[City Key]
	  ,dc.[WWI City ID]
      ,fs.[Customer Key]
	  ,dcu.[WWI Customer ID]
      ,fs.[Bill To Customer Key]
	  ,dbc.[WWI Customer ID] as [WWI Bill To Customer ID]
      ,fs.[Stock Item Key]
	  ,dsi.[WWI Stock Item ID]
      ,fs.[Invoice Date Key]
      ,fs.[Delivery Date Key]
      ,fs.[Salesperson Key]
	  ,de.[WWI Employee ID]
      ,fs.[WWI Invoice ID]
      ,fs.[Description]
      ,fs.[Package]
      ,fs.[Quantity]
      ,fs.[Unit Price]
      ,fs.[Tax Rate]
      ,fs.[Total Excluding Tax]
      ,fs.[Tax Amount]
      ,fs.[Profit]
      ,fs.[Total Including Tax]
      ,fs.[Total Dry Items]
      ,fs.[Total Chiller Items]
	  ,1 as [Sales Count]
      ,fs.[Lineage Key]
  FROM [Fact].[Sale] fs
  INNER JOIN [Dimension].[City] dc ON dc.[City Key] = fs.[City Key]
  INNER JOIN [Dimension].[Customer] dcu ON dcu.[Customer Key] = fs.[Customer Key]
  INNER JOIN [Dimension].[Customer] dbc ON dbc.[Customer Key] = fs.[Bill To Customer Key]
  INNER JOIN [Dimension].[Stock Item] dsi ON dsi.[Stock Item Key] = fs.[Stock Item Key]
  INNER JOIN [Dimension].[Employee] de ON de.[Employee Key] = fs.[Salesperson Key]
  ;
GO
CREATE OR ALTER VIEW [Cube].[Invoice Sales]
AS
SELECT fs.[WWI Invoice ID]
      ,fs.[City Key]
	  ,dc.[WWI City ID]
      ,fs.[Customer Key]
	  ,dcu.[WWI Customer ID]
      ,fs.[Bill To Customer Key]
	  ,dbc.[WWI Customer ID] AS [WWI Bill To Customer ID]
      ,fs.[Invoice Date Key]
      ,fs.[Salesperson Key]
	  ,de.[WWI Employee ID]
      ,SUM(fs.[Total Excluding Tax]) AS [Invoice Total Excluding Tax]
      ,SUM(fs.[Tax Amount]) AS [Invoice Tax Amount]
      ,SUM(fs.[Profit]) AS [Invoice Profit]
      ,SUM(fs.[Total Including Tax]) AS [Invoice Total Including Tax]
      ,SUM(fs.[Total Dry Items]) AS [Invoice Total Dry Items]
      ,SUM(fs.[Total Chiller Items]) AS [Invoice Total Chiller Items]
	  ,1 AS [Invoice Count]
	  ,COUNT([Sale Key]) AS [Sales Count]
  FROM [Fact].[Sale] fs
  INNER JOIN [Dimension].[City] dc ON dc.[City Key] = fs.[City Key]
  INNER JOIN [Dimension].[Customer] dcu ON dcu.[Customer Key] = fs.[Customer Key]
  INNER JOIN [Dimension].[Customer] dbc ON dbc.[Customer Key] = fs.[Bill To Customer Key]
  INNER JOIN [Dimension].[Employee] de ON de.[Employee Key] = fs.[Salesperson Key]
  GROUP BY
  fs.[WWI Invoice ID]
      ,fs.[City Key]
	  ,dc.[WWI City ID]
      ,fs.[Customer Key]
	  ,dcu.[WWI Customer ID]
      ,fs.[Bill To Customer Key]
	  ,dbc.[WWI Customer ID]
      ,fs.[Invoice Date Key]
      ,fs.[Salesperson Key]
	  ,de.[WWI Employee ID]

GO
CREATE OR ALTER VIEW [Cube].[Invoice]
AS
SELECT fs.[WWI Invoice ID]
      ,fs.[Invoice Date Key]
  FROM [Fact].[Sale] fs
  GROUP BY
  fs.[WWI Invoice ID]
      ,fs.[Invoice Date Key]
; 
GO
