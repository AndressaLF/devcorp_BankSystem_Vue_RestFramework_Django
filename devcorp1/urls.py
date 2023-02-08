
from django.contrib import admin
from django.urls import path, include

from rest_framework import routers

from cliente.views import CorrentistaViewSet, MovimentacaoViewSet

router = routers.DefaultRouter()
router.register(r"correntistas", CorrentistaViewSet)
router.register(r"movimentacoes", MovimentacaoViewSet)

urlpatterns = [
    path('admin/', admin.site.urls),
    path("", include(router.urls)),
]
