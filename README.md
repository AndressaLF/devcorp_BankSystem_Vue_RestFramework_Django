# Overview

Passo a passo descritivo para criação de um sistema utilizando django, rest framework, jwt e vue.

### Criando o ambiente virtual (venv)

- [ ] Criar o ambiente 
    ```python
    python -m venv venv
    ```
- [ ] Ativar o ambiente

    1. No Windows
    ```python
    venv\Scripts\activate 
    ```
    2. No linux
    ```python
    source venv/bin/activate
    ```
- [ ] Criar o arquivo _requirementes.txt ou in_ com as extensões necessárias
    ```txt
    django
    rest_framework
    djangorestframework-simplejwt
    django-cors-headers
    djoser 
    mssql-django
    ```
- [ ] Instalar as extensões
    ```python
    pip install -r requirements.txt 
    ```
- [ ] Verificar se os pacotes necessários estão instalados
    ```python
    pip list
    ```
### Criando o projeto no Django

#### Documentação: [Django documentation](https://docs.djangoproject.com/en/4.1/intro/tutorial01/)
#### Documentação: [Django documentation - How to integrate Django with a legacy database](https://docs.djangoproject.com/en/4.1/howto/legacy-databases/)


- [ ] Criando o projeto **Projeto1** via terminal
    ```
     django-admin startproject projeto1 .
    ```
- [ ] Testando a criação do projeto no navegador
    ```python
    python manage.py runserver
    ```
- [ ] Criando uma aplicação chamada **"cliente"**
    ```python
    python manage.py startapp cliente
    ```
- [ ] Cadastrando a aplicação no arquivo _settings.py do **Projeto1**
    ```txt
    INSTALLED_APPS = [
    'polls.apps.PollsConfig',
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'cliente',
    ]
    ```

-[ ] Realizando a conexão com o banco de dados **SQLServer** no arquivo _settings.py

```txt
    DATABASES = {
        "default": {
            "ENGINE": "mssql",
            "NAME": "DEVCORP",
            "USER": "sa",
            "PASSWORD": "and8812",
            "HOST": "ANDRESSA-ACER",
            "PORT": "1433",
            "OPTIONS": {"driver": "ODBC Driver 17 for SQL Server", 
        },
    }
```
-[ ] Testando a conexão com o banco de dados via terminal
```python
    python manage.py inspectdb
```

-[ ] Criando o arquivo _models.py da aplicação contendo as tabelas do banco de dados 
```python
    python manage.py inspectdb > cliente/models.py
```
Verifique se o arquivo _models_ foi criado dentro da pasta da aplicação

-[ ] Registrando as classes(correntistas, movimentaçoes) presentes no **models** no arquivo _admin.py da aplicação(cliente)
```python
from django.contrib import admin
from . models import Correntistas, Movimentacoes

class CorrentistasAdmin(admin.ModelAdmin):
    list_display = ('codigocorrentista','nomecorrentista','email','datacadastro', 'saldo')

class MovimentacoesAdmin(admin.ModelAdmin):
    list_display = ('codigomovimentacao','codigocorrentista','tipotransacao','valor', 'dataoperacao')

admin.site.register(Correntistas, CorrentistasAdmin)
admin.site.register(Movimentacoes, MovimentacoesAdmin)
```

-[ ] Criando as rotas no arquivo _urls.py

```
-[ ] Criando o super usuário via terminal
```python
    python manage.py createsuperuser
```
Adiciona as informações abaixo para finalizar o cadastro.
```txt
    Username: admin
    Email address: admin@example.com
    Password: **********
    Password (again): *********
    Superuser created successfully.
```
-[ ] Realize a migração das informações para o banco de dados
```python
    python manage.py migrate
```
-[ ] Com a aplicação rodando (_runserver_) acesse o **/admin** com o super usuário

Acesse o link via browser: [http://127.0.0.1:8000/admin](http://127.0.0.1:8000/admin)

### Criando a api via Django REST Framework

#### Documentação: [Django REST Framework documentation](https://www.django-rest-framework.org/tutorial/quickstart/)

- [ ] Modificando o **INSTALLED_APPS** para adicionar o REST Framework
    ```txt
    INSTALLED_APPS = [
    'polls.apps.PollsConfig',
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'cliente',
    'corsheaders'
    'rest_framework',
    ]
    ```
- [ ] Editando as informações do MIDDLEWARE no arquivo _settings.py
```txt
    MIDDLEWARE = [

    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'corsheaders.middleware.CorsMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
    'django.middleware.security.SecurityMiddleware',   
    ]
```
- [ ] Fornecendo permissãto total a API
    ```txt
    CORS_ALLOW_ALL_ORIGINS = True
    ```
-[ ] Para representação do dado é necessário criar o arquivo _serializer.py
```python
from rest_framework import serializers
from . models import Correntistas, Movimentacoes

class CorrentistaSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = Correntistas
        fields = ["codigocorrentista","nomecorrentista", "email", "datacadastro", "saldo"]

class MovimentacaoSerializer(serializers.HyperlinkedModelSerializer):
    codigocorrentista = CorrentistaSerializer()
    
    class Meta:
        model = Movimentacoes        
        fields = ["codigomovimentacao","codigocorrentista","tipotransacao", "valor", "dataoperacao"]
```
-[ ] Definição do ViewSet no arquivo _views.py
```python
from rest_framework import viewsets
from . models import Correntistas, Movimentacoes
from . serializers import CorrentistaSerializer, MovimentacaoSerializer

class CorrentistaViewSet(viewsets.ModelViewSet):
    queryset = Correntistas.objects.all()
    serializer_class = CorrentistaSerializer

class MovimentacaoViewSet(viewsets.ModelViewSet):
    queryset = Movimentacoes.objects.all()
    serializer_class = MovimentacaoSerializer
```
-[ ] Definindo as rotas via arquivo _urls.py do projeto
```python
from django.contrib import admin
from django.urls import path, include
from cliente.views import CorrentistaViewSet, MovimentacaoViewSet

from rest_framework import routers

router = routers.DefaultRouter()
router.register(r"correntistas", CorrentistaViewSet)
router.register(r"movimentacoes", MovimentacaoViewSet)

urlpatterns = [
    path("", include(router.urls)),
    path('admin/', admin.site.urls),
    path("api-auth/", include('rest_framework.urls')),
```
### Criando o front-end com VUE
-[ ] Instalando o VUE
```js
npm install -g @vue/cli
```
-[ ] Criando o projeto chamado **Front_app** (manually)
```js
vue create front_app
```
-[ ] Instalando o axios
```js
npm install axios
```
-[ ] Rodando o projeto no navegador
```js
npm run serve
```
-[ ] Abrindo o projeto no navegador 
Acesse o link: [http://localhost:8080](http://localhost:8080)

-[ ] Utilização dos componentes form, input e buttom do bootstrap
#### Documentação: [Bootstrap-Vue Documentation](https://bootstrap-vue.org/docs/)

