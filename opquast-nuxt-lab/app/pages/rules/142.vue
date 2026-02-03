<script setup>
import { ref } from 'vue'

const activeTab = ref('preview')

// DONNÉES DE LA RÈGLE 142
const rule = {
  id: 142,
  title: "Les liens internes et externes sont différenciés",
  description: "Avertir l’internaute qu'il va quitter le site actuel pour aller ailleurs.",
  tags: ["Accessibilité", "UX", "Navigation"],
  authors: ["Ton Groupe"],
  objective: "Éviter que l'utilisateur soit surpris en changeant de site sans prévenir. Cela renforce la confiance.",
  implementationIntro: "Distinguer visuellement les liens sortants (externes) de ceux qui restent sur le site (internes).",
  implementation: [
    "Ajouter une icône (ex: flèche ↗) pour les liens externes.",
    "Utiliser une classe CSS spécifique.",
    "Ajouter une infobulle (title) si nécessaire."
  ],
  control: [
    "Vérifier visuellement que les liens externes ont une icône distinctive.",
    "Contrôler que les liens internes n'ont pas cette icône."
  ],
  // Le code cherchera les images : /public/screenshots/rule-142/screenshot-1.png, etc.
  screenshotsSources: [
    "Mauvais exemple (Aucune distinction)",
    "Bon exemple (Wikipédia)",
    "Code Source"
  ]
}
</script>

<template>
  <section class="space-y-6">
    <header class="space-y-3">
      <button @click="$router.back()" class="inline-flex items-center gap-2 text-sm text-zinc-400 hover:text-zinc-200 transition">
        ← Retour
      </button>
      <div class="text-sm text-zinc-400">Règle n° {{ rule.id }}</div>
      <h1 class="text-2xl sm:text-3xl font-semibold tracking-tight text-zinc-100">{{ rule.title }}</h1>
      <div class="text-base sm:text-sm tracking-tight text-zinc-300">{{ rule.description }}</div>
      <div class="flex flex-wrap gap-2">
        <span v-for="tag in rule.tags" :key="tag" class="text-xs rounded-full border border-zinc-800 bg-zinc-900/30 px-2.5 py-1 text-zinc-300">
          {{ tag }}
        </span>
      </div>
      <div class="text-sm text-zinc-400">
        Écrit par <span class="text-zinc-300">{{ rule.authors.join(', ') }}</span>
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

    <section class="rounded-2xl border border-zinc-800 bg-zinc-900/30 p-6">
      <h2 class="text-lg font-semibold tracking-tight text-zinc-100">Contrôle</h2>
      <ul class="mt-3 list-disc pl-5 space-y-2 text-sm text-zinc-300">
        <li v-for="c in rule.control" :key="c">{{ c }}</li>
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
              <div class="hidden text-center px-4">
                 <div class="text-sm text-zinc-300">Image manquante</div>
                 <div class="text-xs text-zinc-500">Mettre screenshot-{{index+1}}.png dans /public/screenshots/rule-{{rule.id}}/</div>
              </div>
            </a>
          </div>
          <div class="mt-2 text-xs text-zinc-500">Source : {{ source }}</div>
        </div>
      </div>
    </section>

    <section class="space-y-4">
      <h2 class="text-lg font-semibold tracking-tight text-zinc-100">Exemples</h2>
      <div class="rounded-2xl border border-zinc-800 bg-zinc-900/30 overflow-hidden">
        <div class="flex border-b border-zinc-800">
          <button @click="activeTab = 'preview'" :class="['px-5 py-3 text-sm transition', activeTab === 'preview' ? 'text-zinc-100 border-b-2 border-zinc-100' : 'text-zinc-400 hover:text-zinc-200']">Rendu</button>
          <button @click="activeTab = 'code'" :class="['px-5 py-3 text-sm transition', activeTab === 'code' ? 'text-zinc-100 border-b-2 border-zinc-100' : 'text-zinc-400 hover:text-zinc-200']">Code</button>
        </div>

        <div class="p-6">
          <div v-if="activeTab === 'preview'" class="space-y-4">
            <div class="text-sm text-zinc-400">Comparaison des liens :</div>
            <div class="rounded-xl border border-zinc-800 bg-zinc-950 p-5 space-y-4">
              <div>
                <span class="text-xs text-zinc-500 block mb-1">Lien interne (reste sur le site)</span>
                <a href="#" class="text-blue-400 hover:underline">Page Contact</a>
              </div>
              <div>
                <span class="text-xs text-zinc-500 block mb-1">Lien externe (part ailleurs)</span>
                <a href="#" class="text-blue-400 hover:underline inline-flex items-center gap-1">
                  Wikipédia <span class="text-[10px] text-zinc-400">↗</span>
                </a>
              </div>
            </div>
          </div>

          <div v-else>
            <pre class="rounded-xl bg-zinc-950 p-5 overflow-x-auto text-sm text-zinc-100">
<code>&lt;!-- Lien interne --&gt;
&lt;a href="/contact"&gt;Contact&lt;/a&gt;

&lt;!-- Lien externe avec icône --&gt;
&lt;a href="https://wikipedia.org" class="external"&gt;
  Wikipédia &lt;span&gt;↗&lt;/span&gt;
&lt;/a&gt;</code></pre>
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