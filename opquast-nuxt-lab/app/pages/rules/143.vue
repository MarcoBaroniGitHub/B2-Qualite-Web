<script setup>
import { ref } from 'vue'

const activeTab = ref('preview')

const rule = {
  id: 143,
  title: "Les liens internes vers les contenus à accès limité sont différenciés",
  description: "Si un lien mène vers une page réservée (abonnés, membres), l'utilisateur doit le savoir avant de cliquer.",
  tags: ["Accessibilité", "Ergonomie", "Commerce"],
  authors: ["Gourrin Dimitri"],
  objective: "Éviter la frustration de l'utilisateur qui clique et se heurte à un mur de paiement (paywall).",
  implementationIntro: "Ajoutez un indicateur visuel clair sur les liens restreints.",
  implementation: [
    "Ajouter une icône de cadenas (🔒).",
    "Ajouter une mention textuelle ou un badge 'Abonnés'.",
    "Utiliser une couleur différente pour les liens payants."
  ],
  control: [
    "Identifier les liens nécessitant une connexion.",
    "Vérifier qu'ils sont visuellement distincts des liens gratuits."
  ],
  screenshotsSources: [
    "Mauvais exemple",
    "Bon exemple",
    "Code Source"
  ]
}
</script>

<template>
  <section class="space-y-6">
    <header class="space-y-3">
      <button @click="$router.back()" class="inline-flex items-center gap-2 text-sm text-zinc-400 hover:text-zinc-200 transition">← Retour</button>
      <div class="text-sm text-zinc-400">Règle n° {{ rule.id }}</div>
      <h1 class="text-2xl sm:text-3xl font-semibold tracking-tight text-zinc-100">{{ rule.title }}</h1>
      <div class="text-base sm:text-sm tracking-tight text-zinc-300">{{ rule.description }}</div>
      <div class="text-sm text-zinc-400">Écrit par <span class="text-zinc-300">{{ rule.authors.join(', ') }}</span></div>
    </header>

    <section class="rounded-2xl border border-zinc-800 bg-zinc-900/30 p-6">
      <h2 class="text-lg font-semibold tracking-tight text-zinc-100">Objectif</h2>
      <p class="mt-1 text-sm text-zinc-300">{{ rule.objective }}</p>
    </section>

    <section class="rounded-2xl border border-zinc-800 bg-zinc-900/30 p-6">
      <h2 class="text-lg font-semibold tracking-tight text-zinc-100">Mise en œuvre</h2>
      <ul class="mt-1 list-disc pl-5 space-y-2 text-sm text-zinc-300">
        <li v-for="x in rule.implementation" :key="x">{{ x }}</li>
      </ul>
    </section>

    <section class="space-y-4">
      <h2 class="text-lg font-semibold tracking-tight text-zinc-100">Screenshots</h2>
      <div class="flex gap-4 overflow-x-auto pb-4 scrollbar-light">
        <div v-for="(source, index) in rule.screenshotsSources" :key="index" class="shrink-0 w-[280px] sm:w-[340px]">
          <div class="aspect-[16/10] rounded-2xl border border-zinc-800 bg-zinc-900/20 overflow-hidden flex items-center justify-center">
            <a :href="`/screenshots/rule-${rule.id}/screenshot-${index + 1}.png`" target="_blank" class="block cursor-zoom-in h-full w-full">
              <img :src="`/screenshots/rule-${rule.id}/screenshot-${index + 1}.png`" class="h-full w-full object-cover" 
              onerror="this.style.display='none'; this.nextElementSibling.style.display='block'" />
              <div class="hidden text-center px-4 pt-10">
                 <div class="text-sm text-zinc-300">Image manquante</div>
                 <div class="text-xs text-zinc-500 mt-2">Mettre dans public/screenshots/rule-{{rule.id}}/</div>
              </div>
            </a>
          </div>
          <div class="mt-2 text-xs text-zinc-500">{{ source }}</div>
        </div>
      </div>
    </section>

    <section class="space-y-4">
      <h2 class="text-lg font-semibold tracking-tight text-zinc-100">Exemples</h2>
      <div class="rounded-2xl border border-zinc-800 bg-zinc-900/30 overflow-hidden">
        <div class="flex border-b border-zinc-800">
          <button @click="activeTab = 'preview'" :class="['px-5 py-3 text-sm transition', activeTab === 'preview' ? 'text-zinc-100 border-b-2 border-zinc-100' : 'text-zinc-400']">Rendu</button>
          <button @click="activeTab = 'code'" :class="['px-5 py-3 text-sm transition', activeTab === 'code' ? 'text-zinc-100 border-b-2 border-zinc-100' : 'text-zinc-400']">Code</button>
        </div>
        <div class="p-6">
          <div v-if="activeTab === 'preview'" class="space-y-4">
            <div class="rounded-xl border border-zinc-800 bg-zinc-950 p-5 space-y-4">
              <div><a href="#" class="text-blue-400 hover:underline">Article Gratuit</a></div>
              <div><a href="#" class="text-yellow-500 font-bold hover:underline flex items-center gap-2"><span>🔒</span> Article Abonné</a></div>
              <div><a href="#" class="text-zinc-200 hover:underline font-bold">Dossier Spécial <span class="bg-yellow-500 text-black text-[10px] px-1 rounded font-bold uppercase">Abonnés</span></a></div>
            </div>
          </div>
          <div v-else>
            <pre class="rounded-xl bg-zinc-950 p-5 overflow-x-auto text-sm text-zinc-100">
<code>&lt;!-- Avec icône --&gt;
&lt;a href="..." class="paid"&gt;🔒 Article Payant&lt;/a&gt;

&lt;!-- Avec badge --&gt;
&lt;a href="..."&gt;Dossier &lt;span class="badge"&gt;ABONNÉS&lt;/span&gt;&lt;/a&gt;</code></pre>
          </div>
        </div>
      </div>
    </section>
  </section>
</template>

<style scoped>
.scrollbar-light { scrollbar-color: transparent transparent; }
.scrollbar-light:hover { scrollbar-color: #a3a3a3 transparent; }
</style>