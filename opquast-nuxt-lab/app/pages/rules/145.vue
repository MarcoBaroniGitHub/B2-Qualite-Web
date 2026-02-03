<script setup>
import { ref } from 'vue'

const activeTab = ref('preview')

const rule = {
  id: 145,
  title: "Les numéros de téléphone sont activables via le protocole approprié",
  description: "Sur mobile, cliquer sur un numéro doit lancer l'appel directement, sans avoir à copier-coller.",
  tags: ["Mobile", "Dev", "Liens"],
  authors: ["Gourrin Dimitri"],
  objective: "Faciliter la prise de contact sur smartphone et éviter les erreurs de numérotation.",
  implementationIntro: "Utilisez le protocole 'tel:' dans vos liens HTML.",
  implementation: [
    "Baliser le numéro avec la balise &lt;a href='tel:...'&gt;.",
    "Utiliser le format international (+33 pour la France).",
    "Enlever les espaces dans l'attribut href (ex: tel:+33123...)."
  ],
  control: [
    "Inspecter le code HTML.",
    "Vérifier la présence de l'attribut href='tel:...' sur les numéros de téléphone."
  ],
  screenshotsSources: [
    "Mauvais exemple (Texte simple)",
    "Bon exemple (Bouton d'appel)",
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
        <li v-for="x in rule.implementation" :key="x" v-html="x"></li>
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
            <div class="rounded-xl border border-zinc-800 bg-zinc-950 p-5 flex flex-col gap-4">
              <div>
                <p class="text-xs text-red-400 mb-1">❌ Mauvais (Texte simple)</p>
                <p class="text-zinc-300">Notre service client : 01 23 45 67 89</p>
              </div>
              
              <div class="border-t border-zinc-800 pt-4">
                <p class="text-xs text-green-400 mb-2">✅ Bon (Lien cliquable)</p>
                <a href="#" class="inline-flex items-center gap-2 bg-green-600 text-white px-4 py-2 rounded-full font-bold hover:bg-green-500 transition shadow-lg">
                  <span>📞</span> Appeler le 01 23 45 67 89
                </a>
              </div>
            </div>
          </div>
          <div v-else>
            <pre class="rounded-xl bg-zinc-950 p-5 overflow-x-auto text-sm text-zinc-100">
<code>&lt;!-- Mauvais : Juste du texte --&gt;
&lt;p&gt;Tel : 01 23 45 67 89&lt;/p&gt;

&lt;!-- Bon : Format international recommandé --&gt;
&lt;a href="tel:+33123456789" class="btn-call"&gt;
  Appeler le 01 23 45 67 89
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