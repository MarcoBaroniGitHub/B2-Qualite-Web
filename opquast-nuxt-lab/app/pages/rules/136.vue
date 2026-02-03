<script setup>
import { getRuleById } from '~/data/rules'

const ruleId = 136
const rule = getRuleById(ruleId)
const activeTab = ref('preview')
</script>

<template>
  <section v-if="rule" class="space-y-6">
    <header class="space-y-3">
      <button
        @click="$router.back()"
        class="inline-flex items-center gap-2 text-sm text-zinc-400 hover:text-zinc-200 transition"
      >
        ← Retour
      </button>
      <div class="text-sm text-zinc-400">Règle n° {{ rule.id }}</div>

      <h1
        class="text-2xl sm:text-3xl font-semibold tracking-tight text-zinc-100"
      >
        {{ rule.title }}
      </h1>

      <div class="text-base sm:text-sm tracking-tight text-zinc-300">
        {{ rule.description }}
      </div>

      <div class="flex flex-wrap gap-2">
        <span
          v-for="tag in rule.tags"
          :key="tag"
          class="text-xs rounded-full border border-zinc-800 bg-zinc-900/30 px-2.5 py-1 text-zinc-300"
        >
          {{ tag }}
        </span>
      </div>
      
      <div v-if="rule.authors && rule.authors.length" class="text-sm text-zinc-400">
        Écrit par <span class="text-zinc-300">{{ rule.authors.join(', ') }}</span>
      </div>
    </header>

    <section class="rounded-2xl border border-zinc-800 bg-zinc-900/30 p-6">
      <h2 class="text-lg font-semibold tracking-tight text-zinc-100">
        Objectif
      </h2>
      <ul class="mt-1 list-disc pl-5 space-y-2 text-sm text-zinc-300">
        <li v-for="o in rule.objectives" :key="o">{{ o }}</li>
      </ul>
    </section>

    <section class="rounded-2xl border border-zinc-800 bg-zinc-900/30 p-6">
      <h2 class="text-lg font-semibold tracking-tight text-zinc-100">
        Mise en œuvre
      </h2>
      <p v-if="rule.implementationIntro" class="mt-3 text-sm text-zinc-400">
        {{ rule.implementationIntro }}
      </p>
      <ul class="mt-1 list-disc pl-5 space-y-2 text-sm text-zinc-300">
        <li v-for="x in rule.implementation" :key="x">{{ x }}</li>
      </ul>
    </section>

    <section class="rounded-2xl border border-zinc-800 bg-zinc-900/30 p-6">
      <h2 class="text-lg font-semibold tracking-tight text-zinc-100">
        Contrôle
      </h2>
      <ul class="mt-3 list-disc pl-5 space-y-2 text-sm text-zinc-300">
        <li v-for="c in rule.control" :key="c">{{ c }}</li>
      </ul>
    </section>
    
    <section class="space-y-4">
      <h2 class="text-lg font-semibold tracking-tight text-zinc-100">Screenshots</h2>
      <div class="flex gap-4 overflow-x-auto pb-4 scrollbar-light">
        
        <div class="shrink-0 w-[280px] sm:w-[340px]">
          <div class="aspect-[16/10] rounded-2xl border border-green-900/30 bg-green-900/10 overflow-hidden flex items-center justify-center relative group">
            <a href="/screenshots/rule-136/SCREEN1.png" target="_blank" class="block cursor-zoom-in w-full h-full">
              <img src="/screenshots/rule-136/SCREEN1.png" alt="Bonne pratique" class="h-full w-full object-cover transition-transform group-hover:scale-105" />
            </a>
            <div class="absolute bottom-2 right-2 bg-green-600 text-white text-[10px] font-bold px-2 py-1 rounded shadow">BON EXEMPLE</div>
          </div>
          <div class="mt-2 text-xs text-zinc-400 font-medium">Capture : Bouton avec texte caché ou Aria</div>
        </div>

        <div class="shrink-0 w-[280px] sm:w-[340px]">
          <div class="aspect-[16/10] rounded-2xl border border-red-900/30 bg-red-900/10 overflow-hidden flex items-center justify-center relative group">
            <a href="/screenshots/rule-136/SCREEN2.png" target="_blank" class="block cursor-zoom-in w-full h-full">
              <img src="/screenshots/rule-136/SCREEN2.png" alt="Mauvaise pratique" class="h-full w-full object-cover transition-transform group-hover:scale-105" />
            </a>
            <div class="absolute bottom-2 right-2 bg-red-600 text-white text-[10px] font-bold px-2 py-1 rounded shadow">MAUVAIS EXEMPLE</div>
          </div>
          <div class="mt-2 text-xs text-zinc-400 font-medium">Capture : Lien vide (icône seule sans alt)</div>
        </div>

      </div>
    </section>

    <section class="space-y-4">
      <h2 class="text-lg font-semibold tracking-tight text-zinc-100">
        Exemples
      </h2>

      <div class="rounded-2xl border border-zinc-800 bg-zinc-900/30 overflow-hidden">
        <div class="flex border-b border-zinc-800">
          <button
            @click="activeTab = 'preview'"
            :class="['px-5 py-3 text-sm transition', activeTab === 'preview' ? 'text-zinc-100 border-b-2 border-zinc-100' : 'text-zinc-400 hover:text-zinc-200']"
          >
            Rendu
          </button>
          <button
            @click="activeTab = 'code'"
            :class="['px-5 py-3 text-sm transition', activeTab === 'code' ? 'text-zinc-100 border-b-2 border-zinc-100' : 'text-zinc-400 hover:text-zinc-200']"
          >
            Code
          </button>
        </div>

        <div class="p-6">
          <div v-if="activeTab === 'preview'" class="space-y-6">
            <div class="text-sm text-zinc-400">
              Cas classique des boutons d'action (icônes) dans une interface d'administration ou un dashboard Cyber.
            </div>

            <div class="grid gap-6 md:grid-cols-2">
              
              <div class="rounded-xl border border-red-900/30 bg-red-950/5 p-5">
                <div class="flex items-center gap-2 mb-3 text-red-400">
                  <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><line x1="15" y1="9" x2="9" y2="15"/><line x1="9" y1="9" x2="15" y2="15"/></svg>
                  <span class="text-xs font-bold uppercase tracking-wide">Lien vide</span>
                </div>
                
                <div class="flex gap-2">
                  <a href="#" class="flex items-center justify-center w-10 h-10 bg-zinc-800 rounded hover:bg-zinc-700 border border-red-500/30">
                     <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/><polyline points="7 10 12 15 17 10"/><line x1="12" y1="15" x2="12" y2="3"/></svg>
                  </a>
                </div>
                <div class="mt-3 bg-zinc-900 p-2 rounded text-xs font-mono text-zinc-500">
                   Code: &lt;a href="..."&gt;&lt;svg&gt;...&lt;/svg&gt;&lt;/a&gt;
                </div>
                <p class="mt-2 text-xs text-zinc-500 italic">
                  Lecteur d'écran : "Lien, lien, lien..." (ne dit pas ce que ça fait).
                </p>
              </div>

              <div class="rounded-xl border border-green-900/30 bg-green-950/5 p-5">
                <div class="flex items-center gap-2 mb-3 text-green-400">
                  <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/><polyline points="22 4 12 14.01 9 11.01"/></svg>
                  <span class="text-xs font-bold uppercase tracking-wide">Avec texte caché</span>
                </div>
                
                <div class="flex gap-2">
                  <a href="#" class="flex items-center justify-center w-10 h-10 bg-zinc-800 rounded hover:bg-zinc-700 border border-green-500/30 group relative">
                     <span class="sr-only">Télécharger le rapport d'incident</span>
                     <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/><polyline points="7 10 12 15 17 10"/><line x1="12" y1="15" x2="12" y2="3"/></svg>
                  </a>
                </div>
                <div class="mt-3 bg-zinc-900 p-2 rounded text-xs font-mono text-zinc-500">
                   Code: &lt;a&gt;&lt;span class="sr-only"&gt;Télécharger...&lt;/span&gt;&lt;svg&gt;...&lt;/a&gt;
                </div>
                <p class="mt-2 text-xs text-zinc-500 italic">
                  Lecteur d'écran : "Télécharger le rapport d'incident".
                </p>
              </div>

            </div>
          </div>

          <div v-else>
            <pre class="rounded-xl bg-zinc-950 p-5 overflow-x-auto text-sm text-zinc-100">
<code>&lt;!-- MAUVAIS : Lien vide (uniquement décoratif pour une machine) --&gt;
&lt;a href=&quot;delete.php?id=12&quot; class=&quot;btn-icon&quot;&gt;
  &lt;i class=&quot;fa fa-trash&quot;&gt;&lt;/i&gt;
&lt;/a&gt;

&lt;!-- BON : Texte accessible (masqué visuellement via CSS) --&gt;
&lt;a href=&quot;delete.php?id=12&quot; class=&quot;btn-icon&quot;&gt;
  &lt;span class=&quot;sr-only&quot;&gt;Supprimer l'incident&lt;/span&gt;
  &lt;i class=&quot;fa fa-trash&quot; aria-hidden=&quot;true&quot;&gt;&lt;/i&gt;
&lt;/a&gt;

&lt;!-- Alternative : Aria-label --&gt;
&lt;a href=&quot;settings&quot; aria-label=&quot;Paramètres du compte&quot;&gt;
  &lt;svg&gt;...&lt;/svg&gt;
&lt;/a&gt;

&lt;style&gt;
/* Classe standard pour cacher du texte tout en le laissant accessible */
.sr-only {
  position: absolute;
  width: 1px;
  height: 1px;
  padding: 0;
  overflow: hidden;
  clip: rect(0,0,0,0);
  white-space: nowrap;
  border: 0;
}
&lt;/style&gt;</code></pre>
          </div>
        </div>
      </div>
    </section>
  </section>

  <section v-else class="rounded-2xl border border-zinc-800 bg-zinc-900/30 p-6">
    <h1 class="text-lg font-semibold text-zinc-100">Règle introuvable</h1>
  </section>
</template>

<style scoped>
.scrollbar-light { scrollbar-color: transparent transparent; border-radius: 4px; }
.scrollbar-light:hover { scrollbar-color: #a3a3a3 transparent; }
.sr-only { position: absolute; width: 1px; height: 1px; padding: 0; margin: -1px; overflow: hidden; clip: rect(0, 0, 0, 0); white-space: nowrap; border-width: 0; }
</style>