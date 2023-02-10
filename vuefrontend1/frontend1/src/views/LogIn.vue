<template>
    <div class="page-log-in">
        <div class="columns">
            <div class="column is-4 is-offset-4">
                <h1 class="title">Log in</h1>

                <form @submit.prevent="">
                    <div class="field">
                        <label>Username</label>
                        <div class="control">
                            <input type="text" class="input">
                        </div>
                    </div>

                    <div class="field">
                        <label>Password</label>
                        <div class="control">
                            <input type="password" class="input">
                        </div>
                    </div>

                    <div class="notification is-warning">

                    </div>

                    <div class="field">
                        <div class="control">
                            <button class="button is-dark">Log in</button>
                        </div>
                    </div>

                    <hr>

                    Or <router-link to="/">click here</router-link> to sign up!
                </form>
            </div>
        </div>
    </div>
</template>


<script>

export default {
    name: 'LogIn',

}

</script>