from django.db import models

from datetime import datetime    


class Correntistas(models.Model):
    codigocorrentista = models.AutoField(db_column='CodigoCorrentista', primary_key=True)  # Field name made lowercase.
    nomecorrentista = models.CharField(db_column='NomeCorrentista', max_length=50, db_collation='Latin1_General_CI_AI')  # Field name made lowercase.
    email = models.CharField(db_column='Email', max_length=50, db_collation='Latin1_General_CI_AI')  # Field name made lowercase.
    datacadastro = models.DateTimeField(db_column='DataCadastro', auto_now_add=True, blank=True)  # Field name made lowercase.
    saldo = models.DecimalField(db_column='Saldo', max_digits=19, decimal_places=4)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'Correntistas'
    
    def __str__(self):
        return str(self.codigocorrentista)


class Movimentacoes(models.Model):
    codigomovimentacao = models.AutoField(db_column='CodigoMovimentacao', primary_key=True)  # Field name made lowercase.
    codigocorrentista = models.ForeignKey(Correntistas, models.DO_NOTHING, db_column='CodigoCorrentista')  # Field name made lowercase.
    tipotransacao = models.CharField(db_column='TipoTransacao', max_length=2, db_collation='Latin1_General_CI_AI')  # Field name made lowercase.
    valor = models.DecimalField(db_column='Valor', max_digits=19, decimal_places=4)  # Field name made lowercase.
    dataoperacao = models.DateTimeField(db_column='DataOperacao', auto_now_add=True, blank=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'Movimentacoes'
    
    def __str__(self):
        return str(self.codigomovimentacao)
