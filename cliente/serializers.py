from rest_framework import serializers
from . models import Correntistas, Movimentacoes

class CorrentistaSerializer(serializers.HyperlinkedModelSerializer):
    saldo = serializers.DecimalField(max_digits=8, decimal_places=2)
    datacadastro = serializers.DateTimeField(format="%Y-%m-%dT%H:%M:%S", required=False, read_only=True)
    
    class Meta:
        model = Correntistas
        fields = ["codigocorrentista","nomecorrentista", "email", "datacadastro", "saldo"]

        read_only_fields = ["datacadastro"]



class MovimentacaoSerializer(serializers.ModelSerializer):
    nomecorrentista = serializers.SerializerMethodField()
    valor = serializers.DecimalField(max_digits=8, decimal_places=2)


    class Meta:
        model = Movimentacoes        
        fields = ["codigomovimentacao","codigocorrentista","nomecorrentista","tipotransacao", "valor"]
            
    def get_nomecorrentista(self, obj):
        return obj.codigocorrentista.nomecorrentista
    
