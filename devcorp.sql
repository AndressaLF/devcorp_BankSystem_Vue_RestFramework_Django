USE [master]
GO
/****** Object:  Database [DEVCORP]    Script Date: 26/10/2022 13:20:46 ******/
CREATE DATABASE [DEVCORP]
GO
ALTER DATABASE [DEVCORP] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DEVCORP].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DEVCORP] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DEVCORP] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DEVCORP] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DEVCORP] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DEVCORP] SET ARITHABORT OFF 
GO
ALTER DATABASE [DEVCORP] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DEVCORP] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DEVCORP] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DEVCORP] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DEVCORP] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DEVCORP] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DEVCORP] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DEVCORP] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DEVCORP] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DEVCORP] SET  DISABLE_BROKER 
GO
ALTER DATABASE [DEVCORP] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DEVCORP] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DEVCORP] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DEVCORP] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DEVCORP] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DEVCORP] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DEVCORP] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DEVCORP] SET RECOVERY FULL 
GO
ALTER DATABASE [DEVCORP] SET  MULTI_USER 
GO
ALTER DATABASE [DEVCORP] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DEVCORP] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DEVCORP] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DEVCORP] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DEVCORP] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [DEVCORP] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'DEVCORP', N'ON'
GO
ALTER DATABASE [DEVCORP] SET QUERY_STORE = OFF
GO
USE [DEVCORP]
GO
/****** Object:  Table [dbo].[Correntistas]    Script Date: 26/10/2022 13:20:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Correntistas](
	[CodigoCorrentista] [int] IDENTITY(1,1) NOT NULL,
	[NomeCorrentista] [varchar](50) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[DataCadastro] [datetime] NOT NULL,
	[Saldo] [money] NOT NULL,
 CONSTRAINT [PK_Correntistas] PRIMARY KEY CLUSTERED 
(
	[CodigoCorrentista] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Movimentacoes]    Script Date: 26/10/2022 13:20:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Movimentacoes](
	[CodigoMovimentacao] [int] IDENTITY(1,1) NOT NULL,
	[CodigoCorrentista] [int] NOT NULL,
	[TipoTransacao] [char](2) NOT NULL,
	[Valor] [money] NOT NULL,
	[DataOperacao] [datetime] NOT NULL,
 CONSTRAINT [PK_Movimentacoes] PRIMARY KEY CLUSTERED 
(
	[CodigoMovimentacao] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vwExtratoCorrentista]    Script Date: 26/10/2022 13:20:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwExtratoCorrentista]
AS
	SELECT
		Correntistas.CodigoCorrentista,
		Correntistas.NomeCorrentista,
		Movimentacoes.DataOperacao,
		Movimentacoes.TipoTransacao,
		Movimentacoes.Valor,
		CASE Movimentacoes.TipoTransacao
			WHEN 'DP' THEN 'Deposito'
			WHEN 'SQ' THEN 'Saque'
			WHEN 'PG' THEN 'Pagamento'
			WHEN 'TC' THEN 'Transferencia de credido'
			WHEN 'TD' THEN 'Transferencia de debito'
		END AS TipoOperacaoDescricao
	FROM Correntistas INNER JOIN Movimentacoes
	  ON Correntistas.CodigoCorrentista = Movimentacoes.CodigoCorrentista
GO
ALTER TABLE [dbo].[Correntistas] ADD  CONSTRAINT [DF_Correntistas_DataCadastro]  DEFAULT (getdate()) FOR [DataCadastro]
GO
ALTER TABLE [dbo].[Correntistas] ADD  CONSTRAINT [DF_Correntistas_Saldo]  DEFAULT ((0)) FOR [Saldo]
GO
ALTER TABLE [dbo].[Movimentacoes] ADD  CONSTRAINT [DF_Movimentacoes_DataOperacao]  DEFAULT (getdate()) FOR [DataOperacao]
GO
ALTER TABLE [dbo].[Movimentacoes]  WITH CHECK ADD  CONSTRAINT [FK_Movimentacoes_Correntistas] FOREIGN KEY([CodigoCorrentista])
REFERENCES [dbo].[Correntistas] ([CodigoCorrentista])
GO
ALTER TABLE [dbo].[Movimentacoes] CHECK CONSTRAINT [FK_Movimentacoes_Correntistas]
GO
ALTER TABLE [dbo].[Correntistas]  WITH CHECK ADD  CONSTRAINT [CK_Correntista_DataCadastro] CHECK  (([DataCadastro]>=getdate()))
GO
ALTER TABLE [dbo].[Correntistas] CHECK CONSTRAINT [CK_Correntista_DataCadastro]
GO
ALTER TABLE [dbo].[Correntistas]  WITH CHECK ADD  CONSTRAINT [CK_Correntista_Saldo] CHECK  (([Saldo]>=(0)))
GO
ALTER TABLE [dbo].[Correntistas] CHECK CONSTRAINT [CK_Correntista_Saldo]
GO
ALTER TABLE [dbo].[Movimentacoes]  WITH CHECK ADD  CONSTRAINT [CK_Movimentacoes_DataOperacao] CHECK  (([DataOperacao]>=getdate()))
GO
ALTER TABLE [dbo].[Movimentacoes] CHECK CONSTRAINT [CK_Movimentacoes_DataOperacao]
GO
ALTER TABLE [dbo].[Movimentacoes]  WITH CHECK ADD  CONSTRAINT [CK_Movimentacoes_TipoTransacao] CHECK  (([TipoTransacao]='TC' OR [TipoTransacao]='TD' OR [TipoTransacao]='DP' OR [TipoTransacao]='SQ' OR [TipoTransacao]='PG'))
GO
ALTER TABLE [dbo].[Movimentacoes] CHECK CONSTRAINT [CK_Movimentacoes_TipoTransacao]
GO
ALTER TABLE [dbo].[Movimentacoes]  WITH CHECK ADD  CONSTRAINT [CK_Movimentacoes_Valor] CHECK  (([Valor]>(0)))
GO
ALTER TABLE [dbo].[Movimentacoes] CHECK CONSTRAINT [CK_Movimentacoes_Valor]
GO
/****** Object:  StoredProcedure [dbo].[spDeposito]    Script Date: 26/10/2022 13:20:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spDeposito]
	@CodigoCorrentista int,
	@Valor money
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO Movimentacoes(
		CodigoCorrentista,
		TipoTransacao,
		Valor,
		DataOperacao)
	VALUES (
		@CodigoCorrentista,
		'DP',
		@Valor,
		GETDATE());
END
GO
/****** Object:  StoredProcedure [dbo].[spExtratoCorrentista]    Script Date: 26/10/2022 13:20:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spExtratoCorrentista]
	@CodigoCorrentista int,
	@DataInicial datetime,
	@DataFinal datetime
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
		DataOperacao,
		TipoOperacaoDescricao,
		Valor
	FROM vwExtratoCorrentista
	WHERE CodigoCorrentista = @CodigoCorrentista
	  AND DataOperacao BETWEEN @DataInicial AND @DataFinal
	ORDER BY DataOperacao;
END
GO
/****** Object:  StoredProcedure [dbo].[spPagamento]    Script Date: 26/10/2022 13:20:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spPagamento]
	@CodigoCorrentista int,
	@Valor money
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO Movimentacoes(
		CodigoCorrentista,
		TipoTransacao,
		Valor,
		DataOperacao)
	VALUES (
		@CodigoCorrentista,
		'PG',
		@Valor,
		GETDATE());
END
GO
/****** Object:  StoredProcedure [dbo].[spSaque]    Script Date: 26/10/2022 13:20:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spSaque]
	@CodigoCorrentista int,
	@Valor money
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO Movimentacoes(
		TipoTransacao,
		CodigoCorrentista,
		Valor,
		DataOperacao)
	VALUES(
		'SQ',
		@CodigoCorrentista,
		@Valor,
		GETDATE());
END
GO
/****** Object:  StoredProcedure [dbo].[spTransferencia]    Script Date: 26/10/2022 13:20:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spTransferencia]
	@CodigoCorrentistaOrigem int,
	@CodigoCorrentistaDestino int,
	@Valor money
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO Movimentacoes(
		CodigoCorrentista,
		TipoTransacao,
		Valor,
		DataOperacao)
	VALUES (
		@CodigoCorrentistaOrigem,
		'TD',
		@Valor,
		GETDATE());

	IF (@@ERROR = 0)
	BEGIN
		INSERT INTO Movimentacoes(
			CodigoCorrentista,
			TipoTransacao,
			Valor,
			DataOperacao)
		VALUES (
			@CodigoCorrentistaDestino,
			'TC',
			@Valor,
			GETDATE());
	END
END
GO
USE [master]
GO
ALTER DATABASE [DEVCORP] SET  READ_WRITE 
GO