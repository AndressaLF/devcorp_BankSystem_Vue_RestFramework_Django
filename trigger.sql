USE [DEVCORP]

GO



/****** Object:  Trigger [dbo].[tiMovimentacoes]    Script Date: 23/11/2022 14:40:23 ******/

SET ANSI_NULLS ON

GO



SET QUOTED_IDENTIFIER ON

GO



CREATE TRIGGER [dbo].[tiMovimentacoes] ON [dbo].[Movimentacoes]

AFTER INSERT

AS

BEGIN

   SET NOCOUNT ON;



   DECLARE

       @CodigoCorrentista int,

       @Valor money,

       @TipoTransacao char(2);



   SELECT

       @CodigoCorrentista = CodigoCorrentista,

       @Valor = Valor,

       @TipoTransacao = TipoTransacao

   FROM inserted;



   -- Tipos de transacao

   -- ===========================

   -- TC => Transferencia credito

   -- TD => Transferencia debito

   -- DP => Deposito

   -- SQ => Saque

   -- PG => Pagamento



   IF (@TipoTransacao IN ('TC', 'DP'))

   BEGIN

       UPDATE Correntistas SET Saldo = Saldo + @Valor

       WHERE CodigoCorrentista = @CodigoCorrentista;

   END

   ELSE

   BEGIN

       UPDATE Correntistas SET Saldo = Saldo - @Valor

       WHERE CodigoCorrentista = @CodigoCorrentista;

   END

END

GO



ALTER TABLE [dbo].[Movimentacoes] ENABLE TRIGGER [tiMovimentacoes]

GO