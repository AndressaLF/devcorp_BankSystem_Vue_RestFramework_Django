from rest_framework import serializers
from . models import Correntistas, Movimentacoes

class CorrentistaSerializer(serializers.HyperlinkedModelSerializer):
    saldo = serializers.DecimalField(max_digits=8, decimal_places=2)
    datacadastro = serializers.DateTimeField(format="%Y-%m-%dT%H:%M:%S", required=False, read_only=True)
    
    class Meta:
        model = Correntistas
        fields = ["codigocorrentista","nomecorrentista", "email", "datacadastro", "saldo"]


class MovimentacaoSerializer(serializers.HyperlinkedModelSerializer):
    #codigocorrentista = CorrentistaSerializer()
    valor = serializers.DecimalField(max_digits=8, decimal_places=2)
    dataoperacao = serializers.DateTimeField(format="%Y-%m-%dT%H:%M:%S", required=False, read_only=True)

    class Meta:
        model = Movimentacoes        
        fields = ["codigomovimentacao","codigocorrentista","tipotransacao", "valor", "dataoperacao"]
