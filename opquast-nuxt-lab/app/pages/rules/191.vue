<script setup>
import { getRuleById } from '~/data/rules'

const ruleId = 191
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
             <div class="p-4 bg-zinc-950 rounded-lg">
                <h3 class="text-zinc-100 font-semibold mb-2">Alignement à gauche (Correct)</h3>
                <p class="text-zinc-300 text-left">
                   Ceci est un exemple de paragraphe aligné à gauche. Les espaces entre les mots sont réguliers, ce qui facilite la lecture pour tout le monde, en particulier pour les personnes ayant des troubles de la lecture comme la dyslexie. Il n'y a pas de grands espaces blancs disgracieux (lézardes) qui traversent le texte.
                </p>
             </div>
             <div class="p-4 bg-zinc-950 rounded-lg opacity-70">
                <h3 class="text-zinc-400 font-semibold mb-2">Alignement justifié (Incorrect)</h3>
                <p class="text-zinc-500 text-justify">
                   Ceci est un exemple de paragraphe justifié. Remarquez comment les espaces entre les mots peuvent varier considérablement pour forcer le texte à s'aligner sur les deux bords. Cela crée souvent des "rivières de blanc" qui distraient l'œil et rendent le suivi de la ligne plus difficile.
                </p>
             </div>
          </div>
          <div v-else>
            <pre class="rounded-xl bg-zinc-950 p-5 overflow-x-auto text-sm text-zinc-100">
<code>
/* Correct : alignement à gauche (par défaut) */
.text-lecture {
  text-align: left;
}

/* Incorrect : texte justifié */
.text-justifie-a-eviter {
  text-align: justify;
}
</code>
</pre>
          </div>
        </div>
      </div>
    </section>
  </section>
  <section v-else class="rounded-2xl border border-zinc-800 bg-zinc-900/30 p-6">
    <h1 class="text-lg font-semibold text-zinc-100">Règle introuvable</h1>
  </section>
</template>
