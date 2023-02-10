from rest_framework import viewsets
from . models import Correntistas, Movimentacoes
from . serializers import CorrentistaSerializer, MovimentacaoSerializer

# Create your views here.

class CorrentistaViewSet(viewsets.ModelViewSet):
    queryset = Correntistas.objects.all()
    serializer_class = CorrentistaSerializer


class MovimentacaoViewSet(viewsets.ModelViewSet):
    queryset = Movimentacoes.objects.all()
    serializer_class = MovimentacaoSerializer

    

        