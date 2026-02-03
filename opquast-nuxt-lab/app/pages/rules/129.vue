<script setup>
import { getRuleById } from '~/data/rules'

const ruleId = 129
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
              Exemple de page de gestion des cookies avec bannière de consentement
            </div>

            <div class="space-y-4">
              <!-- Bannière de consentement -->
              <div class="rounded-xl border border-zinc-800 bg-zinc-950 p-5">
                <div class="flex flex-col lg:flex-row gap-4 items-start lg:items-center justify-between">
                  <div class="flex items-start gap-3 flex-1">
                    <div class="rounded-lg bg-blue-400/10 p-2 shrink-0">
                      <svg class="w-5 h-5 text-blue-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                      </svg>
                    </div>
                    <div class="flex-1">
                      <h4 class="text-sm font-semibold text-zinc-100 mb-1">
                        🍪 Ce site utilise des cookies
                      </h4>
                      <p class="text-xs text-zinc-400 leading-relaxed">
                        Nous utilisons des cookies pour améliorer votre expérience de navigation, 
                        analyser le trafic du site et personnaliser le contenu. Vous pouvez accepter 
                        tous les cookies ou gérer vos préférences.
                      </p>
                    </div>
                  </div>
                  <div class="flex flex-wrap gap-2 shrink-0">
                    <button class="px-4 py-2 text-xs font-medium rounded-lg border border-zinc-700 text-zinc-300 hover:bg-zinc-800 transition">
                      Personnaliser
                    </button>
                    <button class="px-4 py-2 text-xs font-medium rounded-lg border border-zinc-700 text-zinc-300 hover:bg-zinc-800 transition">
                      Tout refuser
                    </button>
                    <button class="px-4 py-2 text-xs font-medium rounded-lg bg-blue-500 text-white hover:bg-blue-600 transition">
                      Tout accepter
                    </button>
                  </div>
                </div>
              </div>

              <!-- Page de gestion -->
              <div class="rounded-xl border border-zinc-800 bg-zinc-950 p-6 space-y-6">
                <div>
                  <h3 class="text-2xl font-semibold text-zinc-100 mb-2">
                    Gestion des cookies
                  </h3>
                  <p class="text-sm text-zinc-400">
                    Personnalisez vos préférences en matière de cookies
                  </p>
                </div>

                <!-- Qu'est-ce qu'un cookie -->
                <div class="space-y-3">
                  <h4 class="text-lg font-semibold text-zinc-100 flex items-center gap-2">
                    <svg class="w-5 h-5 text-blue-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                    </svg>
                    Qu'est-ce qu'un cookie ?
                  </h4>
                  
                  <div class="rounded-lg border border-zinc-800 bg-zinc-900/50 p-4 text-sm text-zinc-300">
                    <p class="leading-relaxed">
                      Un cookie est un petit fichier texte déposé sur votre appareil lors de votre visite 
                      sur notre site. Il permet de stocker des informations relatives à votre navigation 
                      et de vous proposer des services personnalisés.
                    </p>
                  </div>
                </div>

                <!-- Cookies essentiels -->
                <div class="space-y-3">
                  <div class="flex items-center justify-between">
                    <h4 class="text-lg font-semibold text-zinc-100 flex items-center gap-2">
                      <svg class="w-5 h-5 text-green-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z"/>
                      </svg>
                      Cookies essentiels
                    </h4>
                    <div class="flex items-center gap-2">
                      <span class="text-xs text-green-400 font-medium">Toujours activés</span>
                      <div class="w-10 h-5 rounded-full bg-green-500/20 border border-green-500 relative">
                        <div class="w-4 h-4 rounded-full bg-green-500 absolute right-0.5 top-0.5"></div>
                      </div>
                    </div>
                  </div>
                  
                  <div class="rounded-lg border border-zinc-800 bg-zinc-900/50 p-4 space-y-3">
                    <p class="text-sm text-zinc-300">
                      Ces cookies sont nécessaires au fonctionnement du site et ne peuvent pas être désactivés.
                    </p>
                    
                    <div class="space-y-2">
                      <div class="flex items-center justify-between p-2 rounded bg-zinc-950/50 text-xs">
                        <div>
                          <p class="font-medium text-zinc-100">session_id</p>
                          <p class="text-zinc-500">Gestion de la session utilisateur</p>
                        </div>
                        <span class="text-zinc-400">Session</span>
                      </div>
                      <div class="flex items-center justify-between p-2 rounded bg-zinc-950/50 text-xs">
                        <div>
                          <p class="font-medium text-zinc-100">csrf_token</p>
                          <p class="text-zinc-500">Protection contre les attaques CSRF</p>
                        </div>
                        <span class="text-zinc-400">Session</span>
                      </div>
                      <div class="flex items-center justify-between p-2 rounded bg-zinc-950/50 text-xs">
                        <div>
                          <p class="font-medium text-zinc-100">cookie_consent</p>
                          <p class="text-zinc-500">Mémorisation de vos choix de cookies</p>
                        </div>
                        <span class="text-zinc-400">12 mois</span>
                      </div>
                    </div>
                  </div>
                </div>

                <!-- Cookies analytiques -->
                <div class="space-y-3">
                  <div class="flex items-center justify-between">
                    <h4 class="text-lg font-semibold text-zinc-100 flex items-center gap-2">
                      <svg class="w-5 h-5 text-purple-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"/>
                      </svg>
                      Cookies analytiques
                    </h4>
                    <button class="w-10 h-5 rounded-full bg-zinc-700 border border-zinc-600 relative transition hover:bg-zinc-600">
                      <div class="w-4 h-4 rounded-full bg-zinc-400 absolute left-0.5 top-0.5 transition"></div>
                    </button>
                  </div>
                  
                  <div class="rounded-lg border border-zinc-800 bg-zinc-900/50 p-4 space-y-3">
                    <p class="text-sm text-zinc-300">
                      Ces cookies nous permettent de mesurer l'audience et d'améliorer notre site.
                    </p>
                    
                    <div class="space-y-2">
                      <div class="flex items-center justify-between p-2 rounded bg-zinc-950/50 text-xs">
                        <div>
                          <p class="font-medium text-zinc-100">_ga</p>
                          <p class="text-zinc-500">Google Analytics - Identification unique des visiteurs</p>
                        </div>
                        <span class="text-zinc-400">2 ans</span>
                      </div>
                      <div class="flex items-center justify-between p-2 rounded bg-zinc-950/50 text-xs">
                        <div>
                          <p class="font-medium text-zinc-100">_gid</p>
                          <p class="text-zinc-500">Google Analytics - Distinction des utilisateurs</p>
                        </div>
                        <span class="text-zinc-400">24 heures</span>
                      </div>
                      <div class="flex items-center justify-between p-2 rounded bg-zinc-950/50 text-xs">
                        <div>
                          <p class="font-medium text-zinc-100">_gat</p>
                          <p class="text-zinc-500">Google Analytics - Limitation du taux de requêtes</p>
                        </div>
                        <span class="text-zinc-400">1 minute</span>
                      </div>
                    </div>
                  </div>
                </div>

                <!-- Cookies publicitaires -->
                <div class="space-y-3">
                  <div class="flex items-center justify-between">
                    <h4 class="text-lg font-semibold text-zinc-100 flex items-center gap-2">
                      <svg class="w-5 h-5 text-amber-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11.049 2.927c.3-.921 1.603-.921 1.902 0l1.519 4.674a1 1 0 00.95.69h4.915c.969 0 1.371 1.24.588 1.81l-3.976 2.888a1 1 0 00-.363 1.118l1.518 4.674c.3.922-.755 1.688-1.538 1.118l-3.976-2.888a1 1 0 00-1.176 0l-3.976 2.888c-.783.57-1.838-.197-1.538-1.118l1.518-4.674a1 1 0 00-.363-1.118l-3.976-2.888c-.784-.57-.38-1.81.588-1.81h4.914a1 1 0 00.951-.69l1.519-4.674z"/>
                      </svg>
                      Cookies publicitaires
                    </h4>
                    <button class="w-10 h-5 rounded-full bg-zinc-700 border border-zinc-600 relative transition hover:bg-zinc-600">
                      <div class="w-4 h-4 rounded-full bg-zinc-400 absolute left-0.5 top-0.5 transition"></div>
                    </button>
                  </div>
                  
                  <div class="rounded-lg border border-zinc-800 bg-zinc-900/50 p-4 space-y-3">
                    <p class="text-sm text-zinc-300">
                      Ces cookies permettent d'afficher des publicités personnalisées en fonction de vos intérêts.
                    </p>
                    
                    <div class="space-y-2">
                      <div class="flex items-center justify-between p-2 rounded bg-zinc-950/50 text-xs">
                        <div>
                          <p class="font-medium text-zinc-100">_fbp</p>
                          <p class="text-zinc-500">Facebook Pixel - Publicités ciblées</p>
                        </div>
                        <span class="text-zinc-400">3 mois</span>
                      </div>
                      <div class="flex items-center justify-between p-2 rounded bg-zinc-950/50 text-xs">
                        <div>
                          <p class="font-medium text-zinc-100">IDE</p>
                          <p class="text-zinc-500">Google DoubleClick - Suivi publicitaire</p>
                        </div>
                        <span class="text-zinc-400">13 mois</span>
                      </div>
                    </div>
                  </div>
                </div>

                <!-- Cookies de réseaux sociaux -->
                <div class="space-y-3">
                  <div class="flex items-center justify-between">
                    <h4 class="text-lg font-semibold text-zinc-100 flex items-center gap-2">
                      <svg class="w-5 h-5 text-pink-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 8h2a2 2 0 012 2v6a2 2 0 01-2 2h-2v4l-4-4H9a1.994 1.994 0 01-1.414-.586m0 0L11 14h4a2 2 0 002-2V6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2v4l.586-.586z"/>
                      </svg>
                      Cookies de réseaux sociaux
                    </h4>
                    <button class="w-10 h-5 rounded-full bg-zinc-700 border border-zinc-600 relative transition hover:bg-zinc-600">
                      <div class="w-4 h-4 rounded-full bg-zinc-400 absolute left-0.5 top-0.5 transition"></div>
                    </button>
                  </div>
                  
                  <div class="rounded-lg border border-zinc-800 bg-zinc-900/50 p-4 space-y-3">
                    <p class="text-sm text-zinc-300">
                      Ces cookies permettent de partager du contenu sur les réseaux sociaux et d'afficher des boutons de partage.
                    </p>
                    
                    <div class="space-y-2">
                      <div class="flex items-center justify-between p-2 rounded bg-zinc-950/50 text-xs">
                        <div>
                          <p class="font-medium text-zinc-100">_twitter_sess</p>
                          <p class="text-zinc-500">Twitter - Boutons de partage</p>
                        </div>
                        <span class="text-zinc-400">Session</span>
                      </div>
                      <div class="flex items-center justify-between p-2 rounded bg-zinc-950/50 text-xs">
                        <div>
                          <p class="font-medium text-zinc-100">li_at</p>
                          <p class="text-zinc-500">LinkedIn - Boutons de partage</p>
                        </div>
                        <span class="text-zinc-400">2 ans</span>
                      </div>
                    </div>
                  </div>
                </div>

                <!-- Informations complémentaires -->
                <div class="space-y-3">
                  <h4 class="text-lg font-semibold text-zinc-100 flex items-center gap-2">
                    <svg class="w-5 h-5 text-cyan-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                    </svg>
                    Informations complémentaires
                  </h4>
                  
                  <div class="rounded-lg border border-zinc-800 bg-zinc-900/50 p-4 space-y-3 text-sm text-zinc-300">
                    <div>
                      <p class="font-medium text-zinc-100 mb-1">Comment gérer vos cookies ?</p>
                      <p>
                        Vous pouvez à tout moment modifier vos préférences en cliquant sur le lien 
                        "Gestion des cookies" présent dans le pied de page de notre site. Vous pouvez 
                        également configurer votre navigateur pour refuser tous les cookies ou être 
                        informé lorsqu'un cookie est déposé.
                      </p>
                    </div>
                    
                    <div>
                      <p class="font-medium text-zinc-100 mb-1">Configuration du navigateur</p>
                      <ul class="space-y-1 ml-4">
                        <li class="flex items-center gap-2">
                          <span class="text-cyan-400">→</span>
                          <a href="https://support.google.com/chrome/answer/95647" target="_blank" rel="noopener noreferrer" class="text-blue-400 hover:text-blue-300 underline underline-offset-2">
                            Google Chrome
                          </a>
                        </li>
                        <li class="flex items-center gap-2">
                          <span class="text-cyan-400">→</span>
                          <a href="https://support.mozilla.org/fr/kb/activer-desactiver-cookies" target="_blank" rel="noopener noreferrer" class="text-blue-400 hover:text-blue-300 underline underline-offset-2">
                            Mozilla Firefox
                          </a>
                        </li>
                        <li class="flex items-center gap-2">
                          <span class="text-cyan-400">→</span>
                          <a href="https://support.apple.com/fr-fr/HT201265" target="_blank" rel="noopener noreferrer" class="text-blue-400 hover:text-blue-300 underline underline-offset-2">
                            Safari
                          </a>
                        </li>
                        <li class="flex items-center gap-2">
                          <span class="text-cyan-400">→</span>
                          <a href="https://support.microsoft.com/fr-fr/microsoft-edge" target="_blank" rel="noopener noreferrer" class="text-blue-400 hover:text-blue-300 underline underline-offset-2">
                            Microsoft Edge
                          </a>
                        </li>
                      </ul>
                    </div>
                    
                    <div class="pt-3 border-t border-zinc-700">
                      <p class="font-medium text-zinc-100 mb-1">Plus d'informations</p>
                      <p>
                        Pour plus d'informations sur les cookies et la protection de vos données, 
                        consultez notre 
                        <a href="/politique-confidentialite" class="text-blue-400 hover:text-blue-300 underline underline-offset-2">
                          Politique de confidentialité
                        </a>
                        ou contactez-nous à 
                        <a href="mailto:dpo@exemple.fr" class="text-blue-400 hover:text-blue-300 underline underline-offset-2">
                          dpo@exemple.fr
                        </a>
                      </p>
                    </div>
                  </div>
                </div>

                <!-- Boutons d'action -->
                <div class="flex flex-wrap gap-3 pt-4 border-t border-zinc-800">
                  <button class="flex-1 min-w-[200px] px-4 py-3 rounded-lg border border-zinc-700 text-sm font-medium text-zinc-300 hover:bg-zinc-800 transition">
                    Tout refuser
                  </button>
                  <button class="flex-1 min-w-[200px] px-4 py-3 rounded-lg bg-blue-500 text-sm font-medium text-white hover:bg-blue-600 transition">
                    Enregistrer mes préférences
                  </button>
                </div>
              </div>
            </div>
          </div>

          <!-- CODE -->
          <div v-else>
            <pre
              class="rounded-xl bg-zinc-950 p-5 overflow-x-auto text-sm text-zinc-100"
            ><code>&lt;!-- Bannière de consentement --&gt;
&lt;div class=&quot;rounded-xl border border-zinc-800 bg-zinc-950 p-5&quot;&gt;
  &lt;div class=&quot;flex flex-col lg:flex-row gap-4 items-start 
              lg:items-center justify-between&quot;&gt;
    &lt;div class=&quot;flex items-start gap-3 flex-1&quot;&gt;
      &lt;div class=&quot;rounded-lg bg-blue-400/10 p-2 shrink-0&quot;&gt;
        &lt;svg class=&quot;w-5 h-5 text-blue-400&quot; fill=&quot;none&quot; 
             stroke=&quot;currentColor&quot; viewBox=&quot;0 0 24 24&quot;&gt;
          &lt;path stroke-linecap=&quot;round&quot; stroke-linejoin=&quot;round&quot; 
                stroke-width=&quot;2&quot; d=&quot;M13 16h-1v-4h-1m1-4h.01M21 12a9 
                9 0 11-18 0 9 9 0 0118 0z&quot;/&gt;
        &lt;/svg&gt;
      &lt;/div&gt;
      &lt;div class=&quot;flex-1&quot;&gt;
        &lt;h4 class=&quot;text-sm font-semibold text-zinc-100 mb-1&quot;&gt;
          🍪 Ce site utilise des cookies
        &lt;/h4&gt;
        &lt;p class=&quot;text-xs text-zinc-400 leading-relaxed&quot;&gt;
          Nous utilisons des cookies pour améliorer votre expérience 
          de navigation, analyser le trafic et personnaliser le contenu.
        &lt;/p&gt;
      &lt;/div&gt;
    &lt;/div&gt;
    &lt;div class=&quot;flex flex-wrap gap-2 shrink-0&quot;&gt;
      &lt;button class=&quot;px-4 py-2 text-xs font-medium rounded-lg 
                     border border-zinc-700 text-zinc-300 
                     hover:bg-zinc-800 transition&quot;&gt;
        Personnaliser
      &lt;/button&gt;
      &lt;button class=&quot;px-4 py-2 text-xs font-medium rounded-lg 
                     border border-zinc-700 text-zinc-300 
                     hover:bg-zinc-800 transition&quot;&gt;
        Tout refuser
      &lt;/button&gt;
      &lt;button class=&quot;px-4 py-2 text-xs font-medium rounded-lg 
                     bg-blue-500 text-white hover:bg-blue-600 
                     transition&quot;&gt;
        Tout accepter
      &lt;/button&gt;
    &lt;/div&gt;
  &lt;/div&gt;
&lt;/div&gt;

&lt;!-- Cookies essentiels --&gt;
&lt;div class=&quot;space-y-3&quot;&gt;
  &lt;div class=&quot;flex items-center justify-between&quot;&gt;
    &lt;h4 class=&quot;text-lg font-semibold text-zinc-100 
               flex items-center gap-2&quot;&gt;
      &lt;svg class=&quot;w-5 h-5 text-green-400&quot; fill=&quot;none&quot; 
           stroke=&quot;currentColor&quot; viewBox=&quot;0 0 24 24&quot;&gt;
        &lt;path stroke-linecap=&quot;round&quot; stroke-linejoin=&quot;round&quot; 
              stroke-width=&quot;2&quot; d=&quot;M9 12l2 2 4-4m5.618-4.016A11.955 
              11.955 0 0112 2.944a11.955 11.955 0 01-8.618 
              3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 
              11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z&quot;/&gt;
      &lt;/svg&gt;
      Cookies essentiels
    &lt;/h4&gt;
    &lt;div class=&quot;flex items-center gap-2&quot;&gt;
      &lt;span class=&quot;text-xs text-green-400 font-medium&quot;&gt;
        Toujours activés
      &lt;/span&gt;
      &lt;div class=&quot;w-10 h-5 rounded-full bg-green-500/20 
                  border border-green-500 relative&quot;&gt;
        &lt;div class=&quot;w-4 h-4 rounded-full bg-green-500 
                    absolute right-0.5 top-0.5&quot;&gt;&lt;/div&gt;
      &lt;/div&gt;
    &lt;/div&gt;
  &lt;/div&gt;
  
  &lt;div class=&quot;rounded-lg border border-zinc-800 bg-zinc-900/50 
              p-4 space-y-3&quot;&gt;
    &lt;p class=&quot;text-sm text-zinc-300&quot;&gt;
      Ces cookies sont nécessaires au fonctionnement du site.
    &lt;/p&gt;
    
    &lt;div class=&quot;space-y-2&quot;&gt;
      &lt;div class=&quot;flex items-center justify-between p-2 
                  rounded bg-zinc-950/50 text-xs&quot;&gt;
        &lt;div&gt;
          &lt;p class=&quot;font-medium text-zinc-100&quot;&gt;session_id&lt;/p&gt;
          &lt;p class=&quot;text-zinc-500&quot;&gt;Gestion de la session utilisateur&lt;/p&gt;
        &lt;/div&gt;
        &lt;span class=&quot;text-zinc-400&quot;&gt;Session&lt;/span&gt;
      &lt;/div&gt;
      &lt;div class=&quot;flex items-center justify-between p-2 
                  rounded bg-zinc-950/50 text-xs&quot;&gt;
        &lt;div&gt;
          &lt;p class=&quot;font-medium text-zinc-100&quot;&gt;cookie_consent&lt;/p&gt;
          &lt;p class=&quot;text-zinc-500&quot;&gt;Mémorisation de vos choix&lt;/p&gt;
        &lt;/div&gt;
        &lt;span class=&quot;text-zinc-400&quot;&gt;12 mois&lt;/span&gt;
      &lt;/div&gt;
    &lt;/div&gt;
  &lt;/div&gt;
&lt;/div&gt;

&lt;!-- Cookies analytiques --&gt;
&lt;div class=&quot;space-y-3&quot;&gt;
  &lt;div class=&quot;flex items-center justify-between&quot;&gt;
    &lt;h4 class=&quot;text-lg font-semibold text-zinc-100 
               flex items-center gap-2&quot;&gt;
      &lt;svg class=&quot;w-5 h-5 text-purple-400&quot; fill=&quot;none&quot; 
           stroke=&quot;currentColor&quot; viewBox=&quot;0 0 24 24&quot;&gt;
        &lt;path stroke-linecap=&quot;round&quot; stroke-linejoin=&quot;round&quot; 
              stroke-width=&quot;2&quot; d=&quot;M9 19v-6a2 2 0 00-2-2H5a2 2 0 
              00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 
              012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 
              002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 
              01-2 2h-2a2 2 0 01-2-2z&quot;/&gt;
      &lt;/svg&gt;
      Cookies analytiques
    &lt;/h4&gt;
    &lt;button class=&quot;w-10 h-5 rounded-full bg-zinc-700 
                   border border-zinc-600 relative transition 
                   hover:bg-zinc-600&quot;&gt;
      &lt;div class=&quot;w-4 h-4 rounded-full bg-zinc-400 
                  absolute left-0.5 top-0.5 transition&quot;&gt;&lt;/div&gt;
    &lt;/button&gt;
  &lt;/div&gt;
  
  &lt;div class=&quot;rounded-lg border border-zinc-800 bg-zinc-900/50 
              p-4 space-y-3&quot;&gt;
    &lt;p class=&quot;text-sm text-zinc-300&quot;&gt;
      Ces cookies mesurent l'audience et améliorent notre site.
    &lt;/p&gt;
    
    &lt;div class=&quot;space-y-2&quot;&gt;
      &lt;div class=&quot;flex items-center justify-between p-2 
                  rounded bg-zinc-950/50 text-xs&quot;&gt;
        &lt;div&gt;
          &lt;p class=&quot;font-medium text-zinc-100&quot;&gt;_ga&lt;/p&gt;
          &lt;p class=&quot;text-zinc-500&quot;&gt;Google Analytics&lt;/p&gt;
        &lt;/div&gt;
        &lt;span class=&quot;text-zinc-400&quot;&gt;2 ans&lt;/span&gt;
      &lt;/div&gt;
    &lt;/div&gt;
  &lt;/div&gt;
&lt;/div&gt;

&lt;!-- Boutons d'action --&gt;
&lt;div class=&quot;flex flex-wrap gap-3 pt-4 border-t border-zinc-800&quot;&gt;
  &lt;button class=&quot;flex-1 min-w-[200px] px-4 py-3 rounded-lg 
                 border border-zinc-700 text-sm font-medium 
                 text-zinc-300 hover:bg-zinc-800 transition&quot;&gt;
    Tout refuser
  &lt;/button&gt;
  &lt;button class=&quot;flex-1 min-w-[200px] px-4 py-3 rounded-lg 
                 bg-blue-500 text-sm font-medium text-white 
                 hover:bg-blue-600 transition&quot;&gt;
    Enregistrer mes préférences
  &lt;/button&gt;
&lt;/div&gt;</code></pre>

            <p class="mt-3 text-xs text-zinc-500">
              La page de gestion des cookies doit présenter de manière claire 
              et accessible les différentes catégories de cookies utilisés 
              (essentiels, analytiques, publicitaires, réseaux sociaux), leur 
              finalité, leur durée de conservation, et permettre aux utilisateurs 
              de personnaliser leurs préférences. Une bannière de consentement 
              doit être affichée lors de la première visite avec les options 
              "Tout accepter", "Tout refuser" et "Personnaliser".
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