<script setup>
import { ref } from 'vue'

const activeTab = ref('preview')

const rule = {
  id: 151,
  title: "La mise en place de liens entrants n’est ni interdite ni restreinte",
  description: "Le 'backlink' (lien entrant) est le carburant du référencement (SEO). Interdire aux autres sites de faire un lien vers le vôtre est une erreur stratégique majeure.",
  tags: ["Editorial", "Liens", "SEO"],
  authors: ["Gourrin Dimitri"],
  objective: "Faciliter le référencement naturel (SEO) et augmenter la visibilité du site.",
  implementationIntro: "Vérifiez vos 'Mentions Légales' ou 'CGU' :",
  implementation: [
    "Supprimer toute clause interdisant la création de liens vers votre site.",
    "Supprimer les clauses interdisant le 'Deep Linking' (lien profond vers une page interne).",
    "Indiquer explicitement que la mise en place de liens est autorisée (et encouragée !)."
  ],
  control: [
    "Lire les Mentions Légales et les CGU.",
    "Chercher les mots clés 'lien', 'hypertexte', 'autorisation'.",
    "Vérifier l'absence de restrictions juridiques bloquantes."
  ],
  screenshotsSources: [
    "Mauvais exemple (Clause restrictive)",
    "Bon exemple (Autorisation explicite)",
    "Code Source (Mentions légales)"
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
      <div class="flex flex-wrap gap-2 mt-2">
        <span v-for="tag in rule.tags" :key="tag" class="text-xs rounded-full border border-zinc-800 bg-zinc-900/30 px-2.5 py-1 text-zinc-300">
          {{ tag }}
        </span>
      </div>
    </header>

    <section class="rounded-2xl border border-zinc-800 bg-zinc-900/30 p-6">
      <h2 class="text-lg font-semibold tracking-tight text-zinc-100">Objectif</h2>
      <p class="mt-1 text-sm text-zinc-300">{{ rule.objective }}</p>
    </section>

    <section class="rounded-2xl border border-zinc-800 bg-zinc-900/30 p-6">
      <h2 class="text-lg font-semibold tracking-tight text-zinc-100">Mise en œuvre</h2>
      <p class="mt-3 text-sm text-zinc-400">{{ rule.implementationIntro }}</p>
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
              <div class="text-sm text-zinc-400 italic">Extrait des Mentions Légales</div>
              
              <div class="bg-red-900/20 p-4 rounded border border-red-900/50">
                <p class="text-xs text-red-400 mb-1 font-bold">❌ Clause interdite (Tueur de SEO)</p>
                <p class="text-zinc-300 text-sm font-serif">
                  "Toute mise en place de lien hypertexte vers le site nécessite une autorisation préalable et écrite de la direction."
                </p>
              </div>
              
              <div class="bg-green-900/20 p-4 rounded border border-green-900/50">
                <p class="text-xs text-green-400 mb-1 font-bold">✅ Clause recommandée</p>
                <p class="text-zinc-300 text-sm font-serif">
                  "La mise en place de liens vers le site est autorisée, à condition de mentionner la source. Les liens profonds sont autorisés."
                </p>
              </div>
            </div>
          </div>
          <div v-else>
            <pre class="rounded-xl bg-zinc-950 p-5 overflow-x-auto text-sm text-zinc-100">
<code>&lt;!-- Ce qu'on trouve dans les mentions légales --&gt;

&lt;!-- MAUVAIS (Ne faites pas ça) --&gt;
&lt;p&gt;
  Interdiction de créer des liens vers ce site sans accord écrit.
&lt;/p&gt;

&lt;!-- BON --&gt;
&lt;p&gt;
  La mise en place de liens vers le site est libre 
  et encouragée.
&lt;/p&gt;</code></pre>
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