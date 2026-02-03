<script setup>
import { ref } from 'vue'

const activeTab = ref('preview')

const rule = {
  id: 152,
  title: "Tous les liens internes sont valides",
  description: "Rien de pire pour un utilisateur que de cliquer sur un lien du menu ou du texte et de tomber sur une erreur 'Page introuvable'.",
  tags: ["Développement", "Editorial", "Liens", "SEO"],
  authors: ["Gourrin Dimitri"],
  objective: "Éviter les erreurs 404 qui bloquent la navigation, déçoivent l'utilisateur et pénalisent le référencement (SEO).",
  implementationIntro: "Il faut une hygiène rigoureuse des liens :",
  implementation: [
    "Vérifier les liens après chaque modification d'URL.",
    "Utiliser des outils automatiques (crawlers) pour détecter les liens cassés.",
    "Configurer des redirections (301) si une page change d'adresse."
  ],
  control: [
    "Utiliser un logiciel comme 'Screaming Frog' ou 'W3C Link Checker'.",
    "Naviguer sur le site et vérifier qu'aucun lien interne ne mène à une 404."
  ],
  screenshotsSources: [
    "Mauvais exemple (Erreur 404)",
    "Bon exemple (Page fonctionnelle)",
    "Code Source (Status 200 vs 404)"
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
              <div>
                <p class="text-xs text-red-400 mb-1">❌ Mauvais (Lien cassé)</p>
                <div class="text-zinc-300">
                  <a href="#" class="underline text-red-300 decoration-red-500">Page introuvable</a>
                  <span class="block text-xs text-red-400 mt-1 font-mono">Erreur 404 - Not Found</span>
                </div>
              </div>
              
              <div class="pt-4 border-t border-zinc-800">
                <p class="text-xs text-green-400 mb-1">✅ Bon (Lien valide)</p>
                <div class="text-zinc-300">
                  <a href="#" class="underline text-green-300 decoration-green-500">Page Contact</a>
                  <span class="block text-xs text-green-400 mt-1 font-mono">Status 200 - OK</span>
                </div>
              </div>
            </div>
          </div>
          <div v-else>
            <pre class="rounded-xl bg-zinc-950 p-5 overflow-x-auto text-sm text-zinc-100">
<code>&lt;!-- Résultat HTTP d'un lien cassé --&gt;
HTTP/1.1 404 Not Found

&lt;!-- Résultat HTTP d'un lien valide --&gt;
HTTP/1.1 200 OK</code></pre>
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