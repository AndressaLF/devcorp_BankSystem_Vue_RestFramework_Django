<template>
  <div id="wrapper">
    <nav class="navbar is-dark">
      <div class="navbar-brand">
        <router-link to="/" class="navbar-item">
          <div class="control">
            <img src="../src/assets/brand-name.png" alt="Santasil-logo">
          </div>
        </router-link>
      </div>

      <div class="navbar-menu" id="navbar-menu">
        <div class="navbar-end">
          <router-link to="/correntistas" class="navbar-item">Correntistas</router-link>
          <router-link to="/movimentacoes" class="navbar-item">Movimentações</router-link>

          <div class="navbar-item">
            <div class="buttons">
              <template v-if="$store.state.isAuthenticated">
                <router-link to="/sing-up" class="button is-light">Sair</router-link>
              </template>

              <template v-else>
                <router-link to="/log-in" class="button is-light">Entrar</router-link>
                <router-link to="/sing-up" class="button is-light">Sair</router-link>
              </template>
            </div>
          </div>
        </div>
      </div>
    </nav>

    <div class="is-loading-bar has-text-centered" v-bind:class="{ 'is-loading': $store.state.isLoading }">
      <div class="lds-dual-ring"></div>
    </div>

    <section class="section">
      <router-view />
    </section>

    <footer class="footer">
      <p class="has-text-centered">Criado por Andressa em 2023</p>
    </footer>
  </div>
</template>



<script>
import axios from 'axios'

export default {
  name: 'App',

  beforeCreate() {
    this.$store.commit('initializeStore')
    const token = this.$store.state.token

    if (token) {
      axios.defaults.headers.common['Authorization'] = "JWT " + access
    } else {
      axios.defaults.headers.common['Authorization'] = ""
    }
  }
}
</script>


<style lang="scss">
@import '../node_modules/bulma';

h1 {
  font-size: 20px;
  color: black;
  text-align: center;
  font-family: "Open Sans", sans-serif;
  font-weight: bold;
}

</style>
