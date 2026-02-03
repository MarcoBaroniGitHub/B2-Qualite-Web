<script setup>
import { ref } from 'vue'

const activeTab = ref('preview')

const rule = {
  id: 149,
  title: "La langue des fichiers en téléchargement est précisée si elle diffère",
  description: "Si votre site est en français mais que le document à télécharger est en anglais, il faut prévenir l'utilisateur avant le clic.",
  tags: ["Basics", "Accessibilité", "Editorial", "Liens"],
  authors: ["Gourrin Dimitri"],
  objective: "Éviter aux utilisateurs de télécharger inutilement des fichiers qu'ils ne pourront pas comprendre.",
  implementationIntro: "L'information doit être explicite :",
  implementation: [
    "Indiquer la langue dans le texte du lien (ex: 'Manuel (en anglais)').",
    "Utiliser l'attribut 'hreflang' dans la balise lien (pour les moteurs de recherche et aides techniques).",
    "Utiliser une icône de drapeau ou une mention textuelle (EN, ES, DE)."
  ],
  control: [
    "Repérer les fichiers dans une langue étrangère.",
    "Vérifier que la langue est indiquée dans le lien ou son contexte immédiat."
  ],
  screenshotsSources: [
    "Mauvais exemple (Langue non précisée)",
    "Bon exemple (Langue indiquée)",
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
              <div class="text-sm text-zinc-400 italic">Contexte : Site web en français 🇫🇷</div>
              
              <div>
                <p class="text-xs text-red-400 mb-1">❌ Mauvais (Surprise : c'est en anglais)</p>
                <a href="#" class="text-zinc-300 hover:text-white underline">Télécharger le manuel technique</a>
              </div>
              
              <div class="pt-4 border-t border-zinc-800">
                <p class="text-xs text-green-400 mb-1">✅ Bon (Langue précisée)</p>
                <a href="#" class="text-zinc-300 hover:text-white underline">
                  Manuel technique <span class="text-zinc-500 text-xs border border-zinc-700 rounded px-1 ml-1">Anglais</span>
                </a>
              </div>

               <div class="pt-4 border-t border-zinc-800">
                <p class="text-xs text-green-400 mb-1">✅ Bon (Avec code langue)</p>
                <a href="#" hreflang="en" class="text-zinc-300 hover:text-white underline">
                  Annual Report 2024 (EN)
                </a>
              </div>
            </div>
          </div>
          <div v-else>
            <pre class="rounded-xl bg-zinc-950 p-5 overflow-x-auto text-sm text-zinc-100">
<code>&lt;!-- Mauvais --&gt;
&lt;a href="manual-en.pdf"&gt;Manuel technique&lt;/a&gt;

&lt;!-- Bon : Mention explicite --&gt;
&lt;a href="manual-en.pdf"&gt;
  Manuel technique (en anglais)
&lt;/a&gt;

&lt;!-- Bon : Attribut hreflang + Texte --&gt;
&lt;a href="report.pdf" hreflang="en"&gt;
  Annual Report (EN)
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