<script setup>
import { getRuleById } from '~/data/rules'

const ruleId = 1
const rule = getRuleById(ruleId)
const activeTab = ref('preview')
</script>

<template>
  <section v-if="rule" class="space-y-6">
    <!-- Header -->
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

      <div
        v-if="rule.authors && rule.authors.length"
        class="text-sm text-zinc-400"
      >
        Écrit par
        <span class="text-zinc-300">
          {{ rule.authors.join(', ') }}
        </span>
      </div>
    </header>

    <!-- Objectif -->
    <section class="rounded-2xl border border-zinc-800 bg-zinc-900/30 p-6">
      <h2 class="text-lg font-semibold tracking-tight text-zinc-100">
        Objectif
      </h2>

      <ul class="mt-1 list-disc pl-5 space-y-2 text-sm text-zinc-300">
        <li v-for="o in rule.objectives" :key="o">{{ o }}</li>
      </ul>
      <ul
        v-if="Array.isArray(rule.objectives)"
        class="mt-3 list-disc pl-5 space-y-2 text-sm text-zinc-300"
      >
        <li v-for="o in rule.objectives" :key="o">{{ o }}</li>
      </ul>

      <p v-else class="mt-1 list-disc pl-5 space-y-2 text-sm text-zinc-300">
        {{ rule.objective }}
      </p>
    </section>

    <!-- Mise en œuvre -->
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

    <!-- Contrôle -->
    <section class="rounded-2xl border border-zinc-800 bg-zinc-900/30 p-6">
      <h2 class="text-lg font-semibold tracking-tight text-zinc-100">
        Contrôle
      </h2>

      <ul class="mt-3 list-disc pl-5 space-y-2 text-sm text-zinc-300">
        <li v-for="c in rule.control" :key="c">{{ c }}</li>
      </ul>
    </section>

    <!-- Screenshots -->
    <section class="space-y-4">
      <h2 class="text-lg font-semibold tracking-tight text-zinc-100">
        Screenshots
      </h2>

      <div class="flex gap-4 overflow-x-auto pb-4 scrollbar-light">
        <div
          v-for="(source, index) in rule.screenshotsSources"
          :key="source + index"
          class="shrink-0 w-[280px] sm:w-[340px]"
        >
          <div
            class="aspect-[16/10] rounded-2xl border border-zinc-800 bg-zinc-900/20 overflow-hidden flex items-center justify-center"
          >
            <!-- Image -->
            <a
              :href="`/screenshots/rule-${rule.id}/screenshot-${index + 1}.png`"
              target="_blank"
              rel="noreferrer"
              class="block cursor-zoom-in"
            >
              <img
                :src="`/screenshots/rule-${rule.id}/screenshot-${
                  index + 1
                }.png`"
                :alt="`Exemple d’application de la règle ${rule.id}`"
                class="h-full w-full object-cover"
                onerror="
                  this.style.display = 'none'
                  this.nextElementSibling.style.display = 'block'
                "
              />
            </a>

            <!-- Placeholder -->
            <div class="hidden text-center px-4">
              <div class="text-sm text-zinc-300 font-medium">
                Screenshot à ajouter
              </div>
              <div class="mt-1 text-xs text-zinc-500">Exemple réel attendu</div>
            </div>
          </div>

          <!-- Source associée -->
          <div class="mt-2 text-xs text-zinc-500">
            Source :
            <a
              :href="source"
              target="_blank"
              rel="noreferrer"
              class="underline underline-offset-4 hover:text-zinc-300"
            >
              {{ source }}
            </a>
          </div>
        </div>
      </div>
    </section>

    <!-- Exemples -->
    <section class="space-y-4">
      <h2 class="text-lg font-semibold tracking-tight text-zinc-100">
        Exemples
      </h2>

      <div
        class="rounded-2xl border border-zinc-800 bg-zinc-900/30 overflow-hidden"
      >
        <!-- Tabs -->
        <div class="flex border-b border-zinc-800">
          <button
            @click="activeTab = 'preview'"
            :class="[
              'px-5 py-3 text-sm transition',
              activeTab === 'preview'
                ? 'text-zinc-100 border-b-2 border-zinc-100'
                : 'text-zinc-400 hover:text-zinc-200',
            ]"
          >
            Rendu
          </button>

          <button
            @click="activeTab = 'code'"
            :class="[
              'px-5 py-3 text-sm transition',
              activeTab === 'code'
                ? 'text-zinc-100 border-b-2 border-zinc-100'
                : 'text-zinc-400 hover:text-zinc-200',
            ]"
          >
            Code
          </button>
        </div>

        <!-- Content -->
        <div class="p-6">
          <!-- RENDU -->
          <!-- RENDU -->
<div v-if="activeTab === 'preview'" class="space-y-4">
  <div class="text-sm text-zinc-400">
    Exemple de déclaration d'accessibilité accessible depuis le pied de page
  </div>

  <div class="rounded-xl border border-zinc-800 bg-zinc-950 p-6">
    <h3 class="text-xl font-semibold text-zinc-100">
      Déclaration d'accessibilité
    </h3>
    
    <div class="mt-4 space-y-4 text-sm text-zinc-300">
      <p>
        <strong class="text-zinc-100">[Nom de l'organisation]</strong> s'engage à rendre son site internet accessible conformément à l'article 47 de la loi n° 2005-102 du 11 février 2005.
      </p>
      
      <div>
        <h4 class="font-semibold text-zinc-100 mb-2">État de conformité</h4>
        <p>
          Ce site est <span class="inline-flex items-center gap-1.5 rounded-full border border-amber-700/50 bg-amber-900/20 px-2.5 py-0.5 text-xs text-amber-200">
            <svg class="w-3 h-3" fill="currentColor" viewBox="0 0 20 20">
              <path fill-rule="evenodd" d="M8.257 3.099c.765-1.36 2.722-1.36 3.486 0l5.58 9.92c.75 1.334-.213 2.98-1.742 2.98H4.42c-1.53 0-2.493-1.646-1.743-2.98l5.58-9.92zM11 13a1 1 0 11-2 0 1 1 0 012 0zm-1-8a1 1 0 00-1 1v3a1 1 0 002 0V6a1 1 0 00-1-1z" clip-rule="evenodd"/>
            </svg>
            partiellement conforme
          </span> avec le référentiel général d'amélioration de l'accessibilité (RGAA) version 4.1.
        </p>
      </div>
      
      <div>
        <h4 class="font-semibold text-zinc-100 mb-2">Résultats des tests</h4>
        <p>L'audit de conformité réalisé le <strong class="text-zinc-100">15 janvier 2026</strong> révèle que :</p>
        <ul class="mt-2 list-disc pl-5 space-y-1">
          <li><strong class="text-zinc-100">68%</strong> des critères RGAA sont respectés</li>
          <li><strong class="text-zinc-100">32 critères</strong> sur 106 sont non conformes</li>
        </ul>
      </div>
      
      <div>
        <h4 class="font-semibold text-zinc-100 mb-2">Contenus non accessibles</h4>
        <ul class="list-disc pl-5 space-y-1">
          <li>Certaines images ne possèdent pas d'alternative textuelle</li>
          <li>Certains contrastes de couleurs sont insuffisants</li>
          <li>Quelques formulaires manquent d'étiquettes explicites</li>
        </ul>
      </div>
      
      <div>
        <h4 class="font-semibold text-zinc-100 mb-2">Établissement de cette déclaration</h4>
        <p>Cette déclaration a été établie le <strong class="text-zinc-100">20 janvier 2026</strong>.</p>
      </div>
      
      <div class="pt-4 border-t border-zinc-800">
        <h4 class="font-semibold text-zinc-100 mb-2">Retour d'information et contact</h4>
        <p class="mb-2">
          Si vous n'arrivez pas à accéder à un contenu ou à un service, vous pouvez contacter le responsable du site pour être orienté vers une alternative accessible ou obtenir le contenu sous une autre forme.
        </p>
        <div class="flex flex-wrap gap-2">
          <a href="mailto:accessibilite@exemple.fr" 
             class="inline-flex items-center gap-2 rounded-lg border border-zinc-700 bg-zinc-900 px-3 py-2 text-xs text-zinc-100 hover:bg-zinc-800 transition">
            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"/>
            </svg>
            accessibilite@exemple.fr
          </a>
          <a href="tel:+33123456789" 
             class="inline-flex items-center gap-2 rounded-lg border border-zinc-700 bg-zinc-900 px-3 py-2 text-xs text-zinc-100 hover:bg-zinc-800 transition">
            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z"/>
            </svg>
            01 23 45 67 89
          </a>
        </div>
      </div>
      
      <div class="pt-4 border-t border-zinc-800">
        <h4 class="font-semibold text-zinc-100 mb-2">Voies de recours</h4>
        <p>
          Si vous constatez un défaut d'accessibilité vous empêchant d'accéder à un contenu ou une fonctionnalité du site, que vous nous le signalez et que vous ne parvenez pas à obtenir une réponse rapide de notre part, vous êtes en droit de faire parvenir vos doléances ou une demande de saisine au 
          <a href="https://www.defenseurdesdroits.fr/" target="_blank" rel="noopener noreferrer" class="text-blue-400 hover:text-blue-300 underline underline-offset-2">
            Défenseur des droits
          </a>.
        </p>
      </div>
    </div>
  </div>
</div>

          <!-- CODE -->
<!-- CODE -->
<div v-else>
  <pre class="rounded-xl bg-zinc-950 p-5 overflow-x-auto text-sm text-zinc-100"><code>&lt;div class=&quot;rounded-xl border border-zinc-800 bg-zinc-950 p-6&quot;&gt;
  &lt;h3 class=&quot;text-xl font-semibold text-zinc-100&quot;&gt;
    Déclaration d'accessibilité
  &lt;/h3&gt;
  
  &lt;div class=&quot;mt-4 space-y-4 text-sm text-zinc-300&quot;&gt;
    &lt;p&gt;
      &lt;strong class=&quot;text-zinc-100&quot;&gt;[Nom de l'organisation]&lt;/strong&gt; 
      s'engage à rendre son site internet accessible conformément à 
      l'article 47 de la loi n° 2005-102 du 11 février 2005.
    &lt;/p&gt;
    
    &lt;div&gt;
      &lt;h4 class=&quot;font-semibold text-zinc-100 mb-2&quot;&gt;
        État de conformité
      &lt;/h4&gt;
      &lt;p&gt;
        Ce site est 
        &lt;span class=&quot;inline-flex items-center gap-1.5 rounded-full 
                       border border-amber-700/50 bg-amber-900/20 
                       px-2.5 py-0.5 text-xs text-amber-200&quot;&gt;
          partiellement conforme
        &lt;/span&gt; 
        avec le référentiel général d'amélioration de l'accessibilité 
        (RGAA) version 4.1.
      &lt;/p&gt;
    &lt;/div&gt;
    
    &lt;div&gt;
      &lt;h4 class=&quot;font-semibold text-zinc-100 mb-2&quot;&gt;
        Résultats des tests
      &lt;/h4&gt;
      &lt;p&gt;
        L'audit de conformité réalisé le 
        &lt;strong class=&quot;text-zinc-100&quot;&gt;15 janvier 2026&lt;/strong&gt; 
        révèle que :
      &lt;/p&gt;
      &lt;ul class=&quot;mt-2 list-disc pl-5 space-y-1&quot;&gt;
        &lt;li&gt;&lt;strong&gt;68%&lt;/strong&gt; des critères RGAA sont respectés&lt;/li&gt;
        &lt;li&gt;&lt;strong&gt;32 critères&lt;/strong&gt; sur 106 sont non conformes&lt;/li&gt;
      &lt;/ul&gt;
    &lt;/div&gt;
    
    &lt;div class=&quot;pt-4 border-t border-zinc-800&quot;&gt;
      &lt;h4 class=&quot;font-semibold text-zinc-100 mb-2&quot;&gt;
        Retour d'information et contact
      &lt;/h4&gt;
      &lt;div class=&quot;flex flex-wrap gap-2&quot;&gt;
        &lt;a href=&quot;mailto:accessibilite@exemple.fr&quot; 
           class=&quot;inline-flex items-center gap-2 rounded-lg 
                  border border-zinc-700 bg-zinc-900 px-3 py-2 
                  text-xs text-zinc-100 hover:bg-zinc-800 transition&quot;&gt;
          accessibilite@exemple.fr
        &lt;/a&gt;
      &lt;/div&gt;
    &lt;/div&gt;
  &lt;/div&gt;
&lt;/div&gt;</code></pre>

  <p class="mt-3 text-xs text-zinc-500">
    La déclaration d'accessibilité doit être accessible depuis toutes les pages 
    du site (généralement via le pied de page) et contenir les informations 
    obligatoires : état de conformité, résultats des tests, contenus non 
    accessibles, moyens de contact et voies de recours.
  </p>
</div>
        </div>
      </div>
    </section>
  </section>

  <section v-else class="rounded-2xl border border-zinc-800 bg-zinc-900/30 p-6">
    <h1 class="text-lg font-semibold text-zinc-100">Règle introuvable</h1>
    <p class="mt-2 text-sm text-zinc-400">
      Vérifiez que la règle existe dans
      <code class="text-zinc-300">rules.json</code>.
    </p>
  </section>
</template>

<style scoped>
.scrollbar-light {
  scrollbar-color: transparent transparent;
  border-radius: 4px;
}
.scrollbar-dark {
  scrollbar-color: transparent transparent;
  border-radius: 4px;
}
.scrollbar-light:hover {
  scrollbar-color: #a3a3a3 transparent;
  border-radius: 4px;
}
.scrollbar-dark:hover {
  scrollbar-color: #4d4d4d transparent;
  border-radius: 4px;
}
</style>
