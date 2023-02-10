from rest_framework import serializers
from . models import Correntistas, Movimentacoes

import datetime

class CorrentistaSerializer(serializers.HyperlinkedModelSerializer):
    saldo = serializers.DecimalField(max_digits=8, decimal_places=2)
    datacadastro = serializers.DateTimeField(format="%Y-%m-%dT%H:%M:%S", required=False, read_only=True)
    
    class Meta:
        model = Correntistas
        fields = ["codigocorrentista","nomecorrentista", "email", "datacadastro", "saldo"]

        #read_only_fields = ["datacadastro"]



class MovimentacaoSerializer(serializers.ModelSerializer):
    datacadastro = serializers.SerializerMethodField()
    nomecorrentista = serializers.SerializerMethodField()
    valor = serializers.DecimalField(max_digits=8, decimal_places=2)


    class Meta:
        model = Movimentacoes        
        fields = ["codigomovimentacao","codigocorrentista","datacadastro","nomecorrentista","tipotransacao","valor"]
            
    def get_nomecorrentista(self, obj):
        return obj.codigocorrentista.nomecorrentista
    
    def get_datacadastro(self, obj):
        data_recebida = obj.codigocorrentista.datacadastro
        data = datetime.datetime.strftime(data_recebida, '%Y-%m-%d %H:%M:%S')
        return data
    

    
