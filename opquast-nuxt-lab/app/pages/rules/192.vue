<script setup>
import { getRuleById } from '~/data/rules'

const ruleId = 192
const rule = getRuleById(ruleId)
const activeTab = ref('preview')
</script>

<template>
  <section v-if="rule" class="space-y-6">
    <header class="space-y-3">
      <button @click="$router.back()" class="inline-flex items-center gap-2 text-sm text-zinc-400 hover:text-zinc-200 transition">← Retour</button>
      <div class="text-sm text-zinc-400">Règle n° {{ rule.id }}</div>
      <h1 class="text-2xl sm:text-3xl font-semibold tracking-tight text-zinc-100">{{ rule.title }}</h1>
      <div class="text-base sm:text-sm tracking-tight text-zinc-300">{{ rule.description }}</div>
      <div class="flex flex-wrap gap-2">
        <span v-for="tag in rule.tags" :key="tag" class="text-xs rounded-full border border-zinc-800 bg-zinc-900/30 px-2.5 py-1 text-zinc-300">{{ tag }}</span>
      </div>
      <div v-if="rule.authors && rule.authors.length" class="text-sm text-zinc-400">Écrit par <span class="text-zinc-300">{{ rule.authors.join(', ') }}</span></div>
    </header>

    <section class="rounded-2xl border border-zinc-800 bg-zinc-900/30 p-6">
      <h2 class="text-lg font-semibold tracking-tight text-zinc-100">Objectif</h2>
      <ul class="mt-1 list-disc pl-5 space-y-2 text-sm text-zinc-300">
        <li v-for="o in rule.objectives" :key="o">{{ o }}</li>
      </ul>
    </section>

    <section class="rounded-2xl border border-zinc-800 bg-zinc-900/30 p-6">
      <h2 class="text-lg font-semibold tracking-tight text-zinc-100">Mise en œuvre</h2>
      <p v-if="rule.implementationIntro" class="mt-3 text-sm text-zinc-400">{{ rule.implementationIntro }}</p>
      <ul class="mt-1 list-disc pl-5 space-y-2 text-sm text-zinc-300">
        <li v-for="x in rule.implementation" :key="x">{{ x }}</li>
      </ul>
    </section>

    <section class="rounded-2xl border border-zinc-800 bg-zinc-900/30 p-6">
      <h2 class="text-lg font-semibold tracking-tight text-zinc-100">Contrôle</h2>
      <ul class="mt-3 list-disc pl-5 space-y-2 text-sm text-zinc-300">
        <li v-for="c in rule.control" :key="c">{{ c }}</li>
      </ul>
    </section>

    <!-- Exemples -->
    <section class="space-y-4">
      <h2 class="text-lg font-semibold tracking-tight text-zinc-100">Exemples</h2>
      <div class="rounded-2xl border border-zinc-800 bg-zinc-900/30 overflow-hidden">
        <div class="flex border-b border-zinc-800">
          <button @click="activeTab = 'preview'" :class="['px-5 py-3 text-sm transition', activeTab === 'preview' ? 'text-zinc-100 border-b-2 border-zinc-100' : 'text-zinc-400 hover:text-zinc-200']">Rendu</button>
          <button @click="activeTab = 'code'" :class="['px-5 py-3 text-sm transition', activeTab === 'code' ? 'text-zinc-100 border-b-2 border-zinc-100' : 'text-zinc-400 hover:text-zinc-200']">Code</button>
        </div>

        <div class="p-6">
          <div v-if="activeTab === 'preview'" class="space-y-4">
            <h3 class="text-xl font-bold uppercase text-zinc-100">
              TITRE VISIBLEMENT EN MAJUSCULES
            </h3>
            <p class="text-zinc-300">
              Le titre ci-dessus est écrit en minuscules dans le code HTML, mais une classe CSS le transforme en majuscules. Copiez-collez le titre pour vérifier.
            </p>
          </div>
          <div v-else>
            <pre class="rounded-xl bg-zinc-950 p-5 overflow-x-auto text-sm text-zinc-100">
<code>
&lt;h3 class="title-uppercase"&gt;
  Titre visiblement en majuscules
&lt;/h3&gt;

&lt;style&gt;
.title-uppercase {
  text-transform: uppercase;
}
&lt;/style&gt;
</code>
</pre>
            <p class="mt-3 text-xs text-zinc-500">
              Cela préserve la sémantique et permet aux lecteurs d'écran (et aux moteurs de recherche) de lire le texte correctement, sans épeler chaque lettre ou penser que c'est un acronyme.
            </p>
          </div>
        </div>
      </div>
    </section>
  </section>
  <section v-else class="rounded-2xl border border-zinc-800 bg-zinc-900/30 p-6">
    <h1 class="text-lg font-semibold text-zinc-100">Règle introuvable</h1>
  </section>
</template>
