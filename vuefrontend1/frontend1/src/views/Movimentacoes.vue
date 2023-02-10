<template>
    <div class="movimentacoes">
        <div class="album py-5 bg-light">
            <div class="d-flex justify-content-center">
                <h1>Pagina das Movimentações</h1>
            </div>
        </div>
        <div class="album py-5 bg-light">
            <div class="d-flex justify-content-center">
                <div class="field is-horizontal">
                    <form @submit.prevent="submitForm">
                        <div class="field-body">
                            <div class="field">
                                <p class="control is-expanded has-icons-left">
                                    <input class="input" type="number" placeholder="Cód. do Correntista"
                                        v-model="movimentacao.codigocorrentista">
                                    <span class="icon is-small is-left">
                                        <i class="fas fa-user"></i>
                                    </span>
                                </p>
                            </div>


                            <div class="field">
                                <div class="select is-primary">
                                    <div class="control has-icons-left">
                                        <span class="select">
                                            <select v-model="movimentacao.tipotransacao">
                                                <option value="" disabled selected>Escolha a transação:</option>
                                                <option>TD</option>
                                                <option>DP</option>
                                                <option>SQ</option>
                                                <option>PG</option>
                                                <option>TC</option>
                                            </select>
                                        </span>
                                        <div class="icon is-small is-left">
                                            <i class="fas fa-envelope-open-text"></i>
                                        </div>
                                    </div>

                                </div>
                            </div>





                            <div class="field">
                                <div class="field has-addons">
                                    <p class="control">
                                        </p>
                                    <p class="control">
                                        <input class="input" type="number" placeholder="$ Valor"
                                            v-model="movimentacao.valor">
                                    </p>
                                </div>
                            </div>


                            <div class="control">
                                <button class="button is-success">Enviar</button>
                            </div>

                        </div>
                    </form>
                </div>
            </div>
        </div>



        <section class="section">
            <div class="columns is-centered">
                <div class="column is-narrow">
                    <table class="table">
                        <thead>
                            <tr>
                                <th class="has-text-centered" scope="col">Cod. da Movimentação</th>
                                <th class="has-text-centered" scope="col">Nome do Correntista</th>
                                <th class="has-text-centered" scope="col">Tipo da Transação</th>
                                <th class="has-text-centered" scope="col">Valor</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="movimentacao in movimentacoes" :key="movimentacao.codigocorrentista">
                                <td class="has-text-centered">{{ movimentacao.codigocorrentista }}</td>
                                <td class="has-text-centered">{{ movimentacao.nomecorrentista }}</td>
                                <td class="has-text-centered">{{ movimentacao.tipotransacao }}</td>
                                <td class="has-text-centered">{{ movimentacao.valor }}</td>
                                <td>
                                    <button type="edit" class="btn btn-warning mb-2"
                                        @click="$data.movimentacao = movimentacao">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                            fill="currentColor" class="bi bi-pencil" viewBox="0 0 16 16">
                                            <path
                                                d="M12.146.146a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1 0 .708l-10 10a.5.5 0 0 1-.168.11l-5 2a.5.5 0 0 1-.65-.65l2-5a.5.5 0 0 1 .11-.168l10-10zM11.207 2.5 13.5 4.793 14.793 3.5 12.5 1.207 11.207 2.5zm1.586 3L10.5 3.207 4 9.707V10h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.293l6.5-6.5zm-9.761 5.175-.106.106-1.528 3.821 3.821-1.528.106-.106A.5.5 0 0 1 5 12.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.468-.325z" />
                                        </svg>
                                    </button>
                                </td>

                                <td>
                                    <div class="col-auto">
                                        <button type="submit" class="btn btn-danger mb-2"
                                            @click="deleteMovimentacao(movimentacao)">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                                fill="currentColor" class="bi bi-trash" viewBox="0 0 16 16">
                                                <path
                                                    d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z" />
                                                <path fill-rule="evenodd"
                                                    d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z" />
                                            </svg>
                                        </button>
                                    </div>
                                </td>


                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </section>
    </div>
</template>

<script>
import axios from 'axios'

export default {
    name: 'Movimentacoes',
    data() {
        return {
            movimentacao: {},
            movimentacoes: []

        }
    },
    mounted() {

        this.getMovimentacoes();
    },
    methods: {
        submitForm() {
            if (this.movimentacao.codigomovimentacao === undefined) {
                this.createMovimentacao();
            } else {
                this.editMovimentacao();
            }
        },

        getMovimentacoes() {
            axios.get('/movimentacoes').then(response => {
                this.movimentacoes = response.data;
            });
        },

        createMovimentacao() {
            this.getMovimentacoes();

            axios.post('/movimentacoes/', { codigocorrentista: parseInt(this.movimentacao.codigocorrentista), tipotransacao: this.movimentacao.tipotransacao, valor: parseFloat(this.movimentacao.valor) }).then(() => {
                console.log('Movimentacao cadastrada com sucesso')
            })
                .catch((error) => {
                    console.log(error);
                });
            this.getMovimentacoes();

            this.movimentacao = {};
        },

        editMovimentacao() {

            this.getMovimentacoes();

            axios.put(`/movimentacoes/${this.movimentacao.codigomovimentacao}/`, { codigocorrentista: this.movimentacao.codigocorrentista, tipotransacao: this.movimentacao.tipotransacao, valor: parseFloat(this.movimentacao.valor) }).then(() => {
                console.log('Movimentação modificado com sucesso')
            })
                .catch((error) => {
                    console.log(error);
                });
            this.getMovimentacoes();

            this.movimentacao = {};
        },

        deleteMovimentacao(movimentacao) {

            this.getMovimentacoes();

            axios.delete(`/movimentacoes/${movimentacao.codigomovimentacao}/`, { codigocorrentista: this.movimentacao.codigocorrentista, tipotransacao: this.movimentacao.tipotransacao, valor: parseFloat(this.movimentacao.valor) }).then(() => {
                console.log('Movimentação modificado com sucesso')
            })
                .catch((error) => {
                    console.log(error);
                });
            this.getMovimentacoes();
        },

    }
}

</script>

