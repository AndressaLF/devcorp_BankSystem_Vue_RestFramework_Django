from django.contrib import admin
from . models import Correntistas, Movimentacoes

# Register your models here.
class CorrentistasAdmin(admin.ModelAdmin):
    list_display = ('codigocorrentista','nomecorrentista','email','datacadastro', 'saldo')

class MovimentacoesAdmin(admin.ModelAdmin):
    list_display = ('codigomovimentacao','codigocorrentista','tipotransacao','valor', 'dataoperacao')


admin.site.register(Correntistas, CorrentistasAdmin)
admin.site.register(Movimentacoes, MovimentacoesAdmin)
