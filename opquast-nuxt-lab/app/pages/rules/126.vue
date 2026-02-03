<script setup>
import { getRuleById } from '~/data/rules'

const ruleId = 126
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
                :alt="`Exemple d'application de la règle ${rule.id}`"
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
          <div v-if="activeTab === 'preview'" class="space-y-4">
            <div class="text-sm text-zinc-400">
              Exemple de plan du site accessible depuis le pied de page
            </div>

            <div class="rounded-xl border border-zinc-800 bg-zinc-950 p-6">
              <div class="flex items-center justify-between mb-6">
                <h3 class="text-2xl font-semibold text-zinc-100">
                  Plan du site
                </h3>
                <span class="text-xs text-zinc-500">Toutes les pages</span>
              </div>

              <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
                <!-- Section 1 : Pages principales -->
                <div>
                  <h4 class="text-sm font-semibold text-zinc-100 mb-3 flex items-center gap-2">
                    <svg class="w-4 h-4 text-blue-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6"/>
                    </svg>
                    Pages principales
                  </h4>
                  <ul class="space-y-2">
                    <li>
                      <a href="/accueil" class="text-sm text-zinc-300 hover:text-zinc-100 transition flex items-center gap-2 group">
                        <span class="w-1.5 h-1.5 rounded-full bg-zinc-600 group-hover:bg-blue-400 transition"></span>
                        Accueil
                      </a>
                    </li>
                    <li>
                      <a href="/a-propos" class="text-sm text-zinc-300 hover:text-zinc-100 transition flex items-center gap-2 group">
                        <span class="w-1.5 h-1.5 rounded-full bg-zinc-600 group-hover:bg-blue-400 transition"></span>
                        À propos
                      </a>
                    </li>
                    <li>
                      <a href="/services" class="text-sm text-zinc-300 hover:text-zinc-100 transition flex items-center gap-2 group">
                        <span class="w-1.5 h-1.5 rounded-full bg-zinc-600 group-hover:bg-blue-400 transition"></span>
                        Services
                      </a>
                      <ul class="ml-6 mt-2 space-y-2">
                        <li>
                          <a href="/services/conseil" class="text-xs text-zinc-400 hover:text-zinc-200 transition flex items-center gap-2">
                            → Conseil
                          </a>
                        </li>
                        <li>
                          <a href="/services/formation" class="text-xs text-zinc-400 hover:text-zinc-200 transition flex items-center gap-2">
                            → Formation
                          </a>
                        </li>
                        <li>
                          <a href="/services/audit" class="text-xs text-zinc-400 hover:text-zinc-200 transition flex items-center gap-2">
                            → Audit
                          </a>
                        </li>
                      </ul>
                    </li>
                    <li>
                      <a href="/actualites" class="text-sm text-zinc-300 hover:text-zinc-100 transition flex items-center gap-2 group">
                        <span class="w-1.5 h-1.5 rounded-full bg-zinc-600 group-hover:bg-blue-400 transition"></span>
                        Actualités
                      </a>
                    </li>
                    <li>
                      <a href="/contact" class="text-sm text-zinc-300 hover:text-zinc-100 transition flex items-center gap-2 group">
                        <span class="w-1.5 h-1.5 rounded-full bg-zinc-600 group-hover:bg-blue-400 transition"></span>
                        Contact
                      </a>
                    </li>
                  </ul>
                </div>

                <!-- Section 2 : Ressources -->
                <div>
                  <h4 class="text-sm font-semibold text-zinc-100 mb-3 flex items-center gap-2">
                    <svg class="w-4 h-4 text-green-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"/>
                    </svg>
                    Ressources
                  </h4>
                  <ul class="space-y-2">
                    <li>
                      <a href="/documentation" class="text-sm text-zinc-300 hover:text-zinc-100 transition flex items-center gap-2 group">
                        <span class="w-1.5 h-1.5 rounded-full bg-zinc-600 group-hover:bg-green-400 transition"></span>
                        Documentation
                      </a>
                    </li>
                    <li>
                      <a href="/guides" class="text-sm text-zinc-300 hover:text-zinc-100 transition flex items-center gap-2 group">
                        <span class="w-1.5 h-1.5 rounded-full bg-zinc-600 group-hover:bg-green-400 transition"></span>
                        Guides pratiques
                      </a>
                    </li>
                    <li>
                      <a href="/telechargements" class="text-sm text-zinc-300 hover:text-zinc-100 transition flex items-center gap-2 group">
                        <span class="w-1.5 h-1.5 rounded-full bg-zinc-600 group-hover:bg-green-400 transition"></span>
                        Téléchargements
                      </a>
                    </li>
                    <li>
                      <a href="/faq" class="text-sm text-zinc-300 hover:text-zinc-100 transition flex items-center gap-2 group">
                        <span class="w-1.5 h-1.5 rounded-full bg-zinc-600 group-hover:bg-green-400 transition"></span>
                        FAQ
                      </a>
                    </li>
                    <li>
                      <a href="/glossaire" class="text-sm text-zinc-300 hover:text-zinc-100 transition flex items-center gap-2 group">
                        <span class="w-1.5 h-1.5 rounded-full bg-zinc-600 group-hover:bg-green-400 transition"></span>
                        Glossaire
                      </a>
                    </li>
                  </ul>
                </div>

                <!-- Section 3 : Informations légales -->
                <div>
                  <h4 class="text-sm font-semibold text-zinc-100 mb-3 flex items-center gap-2">
                    <svg class="w-4 h-4 text-amber-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                    </svg>
                    Informations légales
                  </h4>
                  <ul class="space-y-2">
                    <li>
                      <a href="/mentions-legales" class="text-sm text-zinc-300 hover:text-zinc-100 transition flex items-center gap-2 group">
                        <span class="w-1.5 h-1.5 rounded-full bg-zinc-600 group-hover:bg-amber-400 transition"></span>
                        Mentions légales
                      </a>
                    </li>
                    <li>
                      <a href="/politique-confidentialite" class="text-sm text-zinc-300 hover:text-zinc-100 transition flex items-center gap-2 group">
                        <span class="w-1.5 h-1.5 rounded-full bg-zinc-600 group-hover:bg-amber-400 transition"></span>
                        Politique de confidentialité
                      </a>
                    </li>
                    <li>
                      <a href="/cookies" class="text-sm text-zinc-300 hover:text-zinc-100 transition flex items-center gap-2 group">
                        <span class="w-1.5 h-1.5 rounded-full bg-zinc-600 group-hover:bg-amber-400 transition"></span>
                        Gestion des cookies
                      </a>
                    </li>
                    <li>
                      <a href="/accessibilite" class="text-sm text-zinc-300 hover:text-zinc-100 transition flex items-center gap-2 group">
                        <span class="w-1.5 h-1.5 rounded-full bg-zinc-600 group-hover:bg-amber-400 transition"></span>
                        Accessibilité
                      </a>
                    </li>
                    <li>
                      <a href="/plan-du-site" class="text-sm text-zinc-300 hover:text-zinc-100 transition flex items-center gap-2 group">
                        <span class="w-1.5 h-1.5 rounded-full bg-zinc-600 group-hover:bg-amber-400 transition"></span>
                        Plan du site
                      </a>
                    </li>
                  </ul>
                </div>
              </div>

              <!-- Footer du plan -->
              <div class="mt-8 pt-6 border-t border-zinc-800">
                <p class="text-xs text-zinc-500">
                  Dernière mise à jour : 29 janvier 2026 • 
                  <a href="#" class="text-zinc-400 hover:text-zinc-200 underline underline-offset-2">
                    Signaler un lien cassé
                  </a>
                </p>
              </div>
            </div>
          </div>

          <!-- CODE -->
          <div v-else>
            <pre
              class="rounded-xl bg-zinc-950 p-5 overflow-x-auto text-sm text-zinc-100"
            ><code>&lt;div class=&quot;rounded-xl border border-zinc-800 bg-zinc-950 p-6&quot;&gt;
  &lt;div class=&quot;flex items-center justify-between mb-6&quot;&gt;
    &lt;h3 class=&quot;text-2xl font-semibold text-zinc-100&quot;&gt;
      Plan du site
    &lt;/h3&gt;
    &lt;span class=&quot;text-xs text-zinc-500&quot;&gt;Toutes les pages&lt;/span&gt;
  &lt;/div&gt;

  &lt;div class=&quot;grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8&quot;&gt;
    &lt;!-- Section 1 : Pages principales --&gt;
    &lt;div&gt;
      &lt;h4 class=&quot;text-sm font-semibold text-zinc-100 mb-3 
                 flex items-center gap-2&quot;&gt;
        &lt;svg class=&quot;w-4 h-4 text-blue-400&quot; fill=&quot;none&quot; 
             stroke=&quot;currentColor&quot; viewBox=&quot;0 0 24 24&quot;&gt;
          &lt;path stroke-linecap=&quot;round&quot; stroke-linejoin=&quot;round&quot; 
                stroke-width=&quot;2&quot; d=&quot;M3 12l2-2m0 0l7-7 7 7M5 10v10a1 
                1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 
                0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 
                1 0 001 1m-6 0h6&quot;/&gt;
        &lt;/svg&gt;
        Pages principales
      &lt;/h4&gt;
      &lt;ul class=&quot;space-y-2&quot;&gt;
        &lt;li&gt;
          &lt;a href=&quot;/accueil&quot; 
             class=&quot;text-sm text-zinc-300 hover:text-zinc-100 
                    transition flex items-center gap-2 group&quot;&gt;
            &lt;span class=&quot;w-1.5 h-1.5 rounded-full bg-zinc-600 
                         group-hover:bg-blue-400 transition&quot;&gt;&lt;/span&gt;
            Accueil
          &lt;/a&gt;
        &lt;/li&gt;
        &lt;li&gt;
          &lt;a href=&quot;/services&quot; 
             class=&quot;text-sm text-zinc-300 hover:text-zinc-100 
                    transition flex items-center gap-2 group&quot;&gt;
            &lt;span class=&quot;w-1.5 h-1.5 rounded-full bg-zinc-600 
                         group-hover:bg-blue-400 transition&quot;&gt;&lt;/span&gt;
            Services
          &lt;/a&gt;
          &lt;ul class=&quot;ml-6 mt-2 space-y-2&quot;&gt;
            &lt;li&gt;
              &lt;a href=&quot;/services/conseil&quot; 
                 class=&quot;text-xs text-zinc-400 hover:text-zinc-200 
                        transition flex items-center gap-2&quot;&gt;
                → Conseil
              &lt;/a&gt;
            &lt;/li&gt;
            &lt;li&gt;
              &lt;a href=&quot;/services/formation&quot; 
                 class=&quot;text-xs text-zinc-400 hover:text-zinc-200 
                        transition flex items-center gap-2&quot;&gt;
                → Formation
              &lt;/a&gt;
            &lt;/li&gt;
          &lt;/ul&gt;
        &lt;/li&gt;
        &lt;li&gt;
          &lt;a href=&quot;/contact&quot; 
             class=&quot;text-sm text-zinc-300 hover:text-zinc-100 
                    transition flex items-center gap-2 group&quot;&gt;
            &lt;span class=&quot;w-1.5 h-1.5 rounded-full bg-zinc-600 
                         group-hover:bg-blue-400 transition&quot;&gt;&lt;/span&gt;
            Contact
          &lt;/a&gt;
        &lt;/li&gt;
      &lt;/ul&gt;
    &lt;/div&gt;

    &lt;!-- Section 2 : Ressources --&gt;
    &lt;div&gt;
      &lt;h4 class=&quot;text-sm font-semibold text-zinc-100 mb-3 
                 flex items-center gap-2&quot;&gt;
        &lt;svg class=&quot;w-4 h-4 text-green-400&quot; fill=&quot;none&quot; 
             stroke=&quot;currentColor&quot; viewBox=&quot;0 0 24 24&quot;&gt;
          &lt;path stroke-linecap=&quot;round&quot; stroke-linejoin=&quot;round&quot; 
                stroke-width=&quot;2&quot; d=&quot;M12 6.253v13m0-13C10.832 5.477 
                9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 
                5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 
                5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 
                1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 
                0-3.332.477-4.5 1.253&quot;/&gt;
        &lt;/svg&gt;
        Ressources
      &lt;/h4&gt;
      &lt;ul class=&quot;space-y-2&quot;&gt;
        &lt;li&gt;
          &lt;a href=&quot;/documentation&quot; 
             class=&quot;text-sm text-zinc-300 hover:text-zinc-100 
                    transition flex items-center gap-2 group&quot;&gt;
            &lt;span class=&quot;w-1.5 h-1.5 rounded-full bg-zinc-600 
                         group-hover:bg-green-400 transition&quot;&gt;&lt;/span&gt;
            Documentation
          &lt;/a&gt;
        &lt;/li&gt;
        &lt;li&gt;
          &lt;a href=&quot;/faq&quot; 
             class=&quot;text-sm text-zinc-300 hover:text-zinc-100 
                    transition flex items-center gap-2 group&quot;&gt;
            &lt;span class=&quot;w-1.5 h-1.5 rounded-full bg-zinc-600 
                         group-hover:bg-green-400 transition&quot;&gt;&lt;/span&gt;
            FAQ
          &lt;/a&gt;
        &lt;/li&gt;
      &lt;/ul&gt;
    &lt;/div&gt;

    &lt;!-- Section 3 : Informations légales --&gt;
    &lt;div&gt;
      &lt;h4 class=&quot;text-sm font-semibold text-zinc-100 mb-3 
                 flex items-center gap-2&quot;&gt;
        &lt;svg class=&quot;w-4 h-4 text-amber-400&quot; fill=&quot;none&quot; 
             stroke=&quot;currentColor&quot; viewBox=&quot;0 0 24 24&quot;&gt;
          &lt;path stroke-linecap=&quot;round&quot; stroke-linejoin=&quot;round&quot; 
                stroke-width=&quot;2&quot; d=&quot;M9 12h6m-6 4h6m2 5H7a2 2 0 
                01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 
                5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z&quot;/&gt;
        &lt;/svg&gt;
        Informations légales
      &lt;/h4&gt;
      &lt;ul class=&quot;space-y-2&quot;&gt;
        &lt;li&gt;
          &lt;a href=&quot;/mentions-legales&quot; 
             class=&quot;text-sm text-zinc-300 hover:text-zinc-100 
                    transition flex items-center gap-2 group&quot;&gt;
            &lt;span class=&quot;w-1.5 h-1.5 rounded-full bg-zinc-600 
                         group-hover:bg-amber-400 transition&quot;&gt;&lt;/span&gt;
            Mentions légales
          &lt;/a&gt;
        &lt;/li&gt;
        &lt;li&gt;
          &lt;a href=&quot;/accessibilite&quot; 
             class=&quot;text-sm text-zinc-300 hover:text-zinc-100 
                    transition flex items-center gap-2 group&quot;&gt;
            &lt;span class=&quot;w-1.5 h-1.5 rounded-full bg-zinc-600 
                         group-hover:bg-amber-400 transition&quot;&gt;&lt;/span&gt;
            Accessibilité
          &lt;/a&gt;
        &lt;/li&gt;
        &lt;li&gt;
          &lt;a href=&quot;/plan-du-site&quot; 
             class=&quot;text-sm text-zinc-300 hover:text-zinc-100 
                    transition flex items-center gap-2 group&quot;&gt;
            &lt;span class=&quot;w-1.5 h-1.5 rounded-full bg-zinc-600 
                         group-hover:bg-amber-400 transition&quot;&gt;&lt;/span&gt;
            Plan du site
          &lt;/a&gt;
        &lt;/li&gt;
      &lt;/ul&gt;
    &lt;/div&gt;
  &lt;/div&gt;

  &lt;!-- Footer du plan --&gt;
  &lt;div class=&quot;mt-8 pt-6 border-t border-zinc-800&quot;&gt;
    &lt;p class=&quot;text-xs text-zinc-500&quot;&gt;
      Dernière mise à jour : 29 janvier 2026 • 
      &lt;a href=&quot;#&quot; class=&quot;text-zinc-400 hover:text-zinc-200 
                       underline underline-offset-2&quot;&gt;
        Signaler un lien cassé
      &lt;/a&gt;
    &lt;/p&gt;
  &lt;/div&gt;
&lt;/div&gt;</code></pre>

            <p class="mt-3 text-xs text-zinc-500">
              Le plan du site doit présenter l'ensemble des pages du site de 
              manière structurée et hiérarchisée. Il doit être accessible 
              depuis toutes les pages (généralement via le pied de page) et 
              permettre aux utilisateurs de comprendre rapidement l'architecture 
              du site et d'accéder à n'importe quelle page en un clic.
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