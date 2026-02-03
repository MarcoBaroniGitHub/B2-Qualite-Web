<script setup>
import { getRuleById } from '~/data/rules'

const ruleId = 128
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
              Exemple de politique de confidentialité conforme au RGPD
            </div>

            <div class="rounded-xl border border-zinc-800 bg-zinc-950 p-6 space-y-6">
              <div>
                <h3 class="text-2xl font-semibold text-zinc-100 mb-2">
                  Politique de confidentialité
                </h3>
                <p class="text-sm text-zinc-400">
                  Dernière mise à jour : 29 janvier 2026
                </p>
              </div>

              <!-- Introduction -->
              <div class="rounded-lg border border-zinc-800 bg-zinc-900/50 p-4">
                <p class="text-sm text-zinc-300 leading-relaxed">
                  La protection de vos données personnelles est une priorité pour 
                  <strong class="text-zinc-100">Société Exemple SAS</strong>. 
                  Cette politique de confidentialité vous informe sur la manière dont nous collectons, 
                  utilisons et protégeons vos données personnelles conformément au 
                  <strong class="text-zinc-100">Règlement Général sur la Protection des Données (RGPD)</strong> 
                  et à la loi Informatique et Libertés.
                </p>
              </div>

              <!-- Responsable du traitement -->
              <div class="space-y-3">
                <h4 class="text-lg font-semibold text-zinc-100 flex items-center gap-2">
                  <svg class="w-5 h-5 text-blue-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 13.255A23.931 23.931 0 0112 15c-3.183 0-6.22-.62-9-1.745M16 6V4a2 2 0 00-2-2h-4a2 2 0 00-2 2v2m4 6h.01M5 20h14a2 2 0 002-2V8a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"/>
                  </svg>
                  1. Responsable du traitement des données
                </h4>
                
                <div class="rounded-lg border border-zinc-800 bg-zinc-900/50 p-4 space-y-2 text-sm text-zinc-300">
                  <p><strong class="text-zinc-100">Société Exemple SAS</strong></p>
                  <p>123 Avenue de la République<br>75011 Paris, France</p>
                  <p>Email : <a href="mailto:dpo@exemple.fr" class="text-blue-400 hover:text-blue-300 underline underline-offset-2">dpo@exemple.fr</a></p>
                  <p>Téléphone : +33 1 23 45 67 89</p>
                </div>
              </div>

              <!-- Données collectées -->
              <div class="space-y-3">
                <h4 class="text-lg font-semibold text-zinc-100 flex items-center gap-2">
                  <svg class="w-5 h-5 text-green-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                  </svg>
                  2. Données personnelles collectées
                </h4>
                
                <div class="rounded-lg border border-zinc-800 bg-zinc-900/50 p-4 space-y-3 text-sm text-zinc-300">
                  <p class="text-zinc-100 font-medium">Nous collectons les données suivantes :</p>
                  
                  <div class="space-y-3">
                    <div class="flex gap-3">
                      <div class="w-2 h-2 rounded-full bg-green-400 mt-1.5 shrink-0"></div>
                      <div>
                        <p class="font-medium text-zinc-100">Données d'identité</p>
                        <p>Nom, prénom, adresse email, numéro de téléphone</p>
                      </div>
                    </div>
                    
                    <div class="flex gap-3">
                      <div class="w-2 h-2 rounded-full bg-green-400 mt-1.5 shrink-0"></div>
                      <div>
                        <p class="font-medium text-zinc-100">Données de connexion</p>
                        <p>Adresse IP, type de navigateur, pages visitées, durée de visite</p>
                      </div>
                    </div>
                    
                    <div class="flex gap-3">
                      <div class="w-2 h-2 rounded-full bg-green-400 mt-1.5 shrink-0"></div>
                      <div>
                        <p class="font-medium text-zinc-100">Données de navigation</p>
                        <p>Cookies, historique de navigation, préférences utilisateur</p>
                      </div>
                    </div>
                  </div>
                </div>
              </div>

              <!-- Finalités -->
              <div class="space-y-3">
                <h4 class="text-lg font-semibold text-zinc-100 flex items-center gap-2">
                  <svg class="w-5 h-5 text-purple-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-6 9l2 2 4-4"/>
                  </svg>
                  3. Finalités du traitement
                </h4>
                
                <div class="rounded-lg border border-zinc-800 bg-zinc-900/50 p-4 space-y-2 text-sm text-zinc-300">
                  <p class="mb-2">Vos données sont utilisées pour :</p>
                  <ul class="space-y-2 ml-4">
                    <li class="flex items-start gap-2">
                      <span class="text-purple-400 mt-1">→</span>
                      <span>Gérer votre compte utilisateur et vous fournir nos services</span>
                    </li>
                    <li class="flex items-start gap-2">
                      <span class="text-purple-400 mt-1">→</span>
                      <span>Traiter vos demandes et répondre à vos questions</span>
                    </li>
                    <li class="flex items-start gap-2">
                      <span class="text-purple-400 mt-1">→</span>
                      <span>Améliorer nos services et votre expérience utilisateur</span>
                    </li>
                    <li class="flex items-start gap-2">
                      <span class="text-purple-400 mt-1">→</span>
                      <span>Vous envoyer des communications marketing (avec votre consentement)</span>
                    </li>
                    <li class="flex items-start gap-2">
                      <span class="text-purple-400 mt-1">→</span>
                      <span>Réaliser des analyses statistiques et des études</span>
                    </li>
                  </ul>
                </div>
              </div>

              <!-- Base légale -->
              <div class="space-y-3">
                <h4 class="text-lg font-semibold text-zinc-100 flex items-center gap-2">
                  <svg class="w-5 h-5 text-amber-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 6l3 1m0 0l-3 9a5.002 5.002 0 006.001 0M6 7l3 9M6 7l6-2m6 2l3-1m-3 1l-3 9a5.002 5.002 0 006.001 0M18 7l3 9m-3-9l-6-2m0-2v2m0 16V5m0 16H9m3 0h3"/>
                  </svg>
                  4. Base légale du traitement
                </h4>
                
                <div class="rounded-lg border border-zinc-800 bg-zinc-900/50 p-4 space-y-2 text-sm text-zinc-300">
                  <p>Le traitement de vos données repose sur :</p>
                  <ul class="space-y-2 ml-4 mt-2">
                    <li class="flex items-start gap-2">
                      <span class="text-amber-400 mt-1">•</span>
                      <span><strong class="text-zinc-100">Votre consentement</strong> pour les finalités nécessitant votre accord explicite</span>
                    </li>
                    <li class="flex items-start gap-2">
                      <span class="text-amber-400 mt-1">•</span>
                      <span><strong class="text-zinc-100">L'exécution d'un contrat</strong> pour la fourniture de nos services</span>
                    </li>
                    <li class="flex items-start gap-2">
                      <span class="text-amber-400 mt-1">•</span>
                      <span><strong class="text-zinc-100">Notre intérêt légitime</strong> pour l'amélioration de nos services</span>
                    </li>
                    <li class="flex items-start gap-2">
                      <span class="text-amber-400 mt-1">•</span>
                      <span><strong class="text-zinc-100">Une obligation légale</strong> pour respecter nos obligations réglementaires</span>
                    </li>
                  </ul>
                </div>
              </div>

              <!-- Conservation -->
              <div class="space-y-3">
                <h4 class="text-lg font-semibold text-zinc-100 flex items-center gap-2">
                  <svg class="w-5 h-5 text-red-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/>
                  </svg>
                  5. Durée de conservation
                </h4>
                
                <div class="rounded-lg border border-zinc-800 bg-zinc-900/50 p-4 text-sm text-zinc-300">
                  <p>Vos données sont conservées pendant la durée nécessaire aux finalités pour lesquelles elles ont été collectées :</p>
                  <div class="mt-3 space-y-2">
                    <div class="flex justify-between items-center p-2 rounded bg-zinc-950/50">
                      <span>Données de compte utilisateur</span>
                      <span class="text-red-400 font-medium">Durée du compte + 3 ans</span>
                    </div>
                    <div class="flex justify-between items-center p-2 rounded bg-zinc-950/50">
                      <span>Données de navigation</span>
                      <span class="text-red-400 font-medium">13 mois maximum</span>
                    </div>
                    <div class="flex justify-between items-center p-2 rounded bg-zinc-950/50">
                      <span>Données de facturation</span>
                      <span class="text-red-400 font-medium">10 ans (obligation légale)</span>
                    </div>
                  </div>
                </div>
              </div>

              <!-- Vos droits -->
              <div class="space-y-3">
                <h4 class="text-lg font-semibold text-zinc-100 flex items-center gap-2">
                  <svg class="w-5 h-5 text-pink-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"/>
                  </svg>
                  6. Vos droits
                </h4>
                
                <div class="rounded-lg border border-zinc-800 bg-zinc-900/50 p-4 space-y-3 text-sm text-zinc-300">
                  <p class="text-zinc-100 font-medium">Conformément au RGPD, vous disposez des droits suivants :</p>
                  
                  <div class="grid sm:grid-cols-2 gap-3">
                    <div class="rounded-lg border border-zinc-700 bg-zinc-950/50 p-3">
                      <p class="font-medium text-pink-400 mb-1">Droit d'accès</p>
                      <p class="text-xs">Obtenir une copie de vos données personnelles</p>
                    </div>
                    
                    <div class="rounded-lg border border-zinc-700 bg-zinc-950/50 p-3">
                      <p class="font-medium text-pink-400 mb-1">Droit de rectification</p>
                      <p class="text-xs">Corriger des données inexactes ou incomplètes</p>
                    </div>
                    
                    <div class="rounded-lg border border-zinc-700 bg-zinc-950/50 p-3">
                      <p class="font-medium text-pink-400 mb-1">Droit à l'effacement</p>
                      <p class="text-xs">Demander la suppression de vos données</p>
                    </div>
                    
                    <div class="rounded-lg border border-zinc-700 bg-zinc-950/50 p-3">
                      <p class="font-medium text-pink-400 mb-1">Droit à la portabilité</p>
                      <p class="text-xs">Recevoir vos données dans un format structuré</p>
                    </div>
                    
                    <div class="rounded-lg border border-zinc-700 bg-zinc-950/50 p-3">
                      <p class="font-medium text-pink-400 mb-1">Droit d'opposition</p>
                      <p class="text-xs">Vous opposer au traitement de vos données</p>
                    </div>
                    
                    <div class="rounded-lg border border-zinc-700 bg-zinc-950/50 p-3">
                      <p class="font-medium text-pink-400 mb-1">Droit à la limitation</p>
                      <p class="text-xs">Limiter le traitement de vos données</p>
                    </div>
                  </div>
                  
                  <div class="mt-4 pt-4 border-t border-zinc-700">
                    <p class="mb-2 font-medium text-zinc-100">Pour exercer vos droits :</p>
                    <div class="flex flex-wrap gap-2">
                      <a href="mailto:dpo@exemple.fr" 
                         class="inline-flex items-center gap-2 rounded-lg border border-zinc-700 bg-zinc-900 px-3 py-2 text-xs text-zinc-100 hover:bg-zinc-800 transition">
                        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"/>
                        </svg>
                        Contacter le DPO
                      </a>
                      <a href="/formulaire-droits" 
                         class="inline-flex items-center gap-2 rounded-lg border border-zinc-700 bg-zinc-900 px-3 py-2 text-xs text-zinc-100 hover:bg-zinc-800 transition">
                        <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                        </svg>
                        Formulaire de demande
                      </a>
                    </div>
                  </div>
                </div>
              </div>

              <!-- Sécurité -->
              <div class="space-y-3">
                <h4 class="text-lg font-semibold text-zinc-100 flex items-center gap-2">
                  <svg class="w-5 h-5 text-cyan-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z"/>
                  </svg>
                  7. Sécurité des données
                </h4>
                
                <div class="rounded-lg border border-zinc-800 bg-zinc-900/50 p-4 space-y-2 text-sm text-zinc-300">
                  <p>
                    Nous mettons en œuvre des mesures techniques et organisationnelles appropriées pour 
                    assurer la sécurité de vos données personnelles et empêcher leur altération, 
                    leur perte ou leur accès non autorisé :
                  </p>
                  <ul class="space-y-1 ml-4 mt-2">
                    <li class="flex items-center gap-2">
                      <svg class="w-4 h-4 text-cyan-400 shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"/>
                      </svg>
                      <span>Chiffrement des données sensibles (SSL/TLS)</span>
                    </li>
                    <li class="flex items-center gap-2">
                      <svg class="w-4 h-4 text-cyan-400 shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"/>
                      </svg>
                      <span>Accès restreint aux données personnelles</span>
                    </li>
                    <li class="flex items-center gap-2">
                      <svg class="w-4 h-4 text-cyan-400 shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"/>
                      </svg>
                      <span>Sauvegardes régulières et sécurisées</span>
                    </li>
                    <li class="flex items-center gap-2">
                      <svg class="w-4 h-4 text-cyan-400 shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"/>
                      </svg>
                      <span>Formation du personnel à la protection des données</span>
                    </li>
                  </ul>
                </div>
              </div>

              <!-- Réclamation -->
              <div class="space-y-3">
                <h4 class="text-lg font-semibold text-zinc-100 flex items-center gap-2">
                  <svg class="w-5 h-5 text-orange-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                  </svg>
                  8. Réclamation auprès de la CNIL
                </h4>
                
                <div class="rounded-lg border border-zinc-800 bg-zinc-900/50 p-4 text-sm text-zinc-300">
                  <p>
                    Si vous estimez que le traitement de vos données personnelles n'est pas conforme 
                    à la réglementation, vous avez le droit d'introduire une réclamation auprès de 
                    la Commission Nationale de l'Informatique et des Libertés (CNIL) :
                  </p>
                  <div class="mt-3 p-3 rounded bg-zinc-950/50 space-y-1">
                    <p class="font-medium text-zinc-100">CNIL</p>
                    <p>3 Place de Fontenoy - TSA 80715</p>
                    <p>75334 Paris Cedex 07</p>
                    <p>Téléphone : +33 1 53 73 22 22</p>
                    <p>
                      Site web : 
                      <a href="https://www.cnil.fr" target="_blank" rel="noopener noreferrer" 
                         class="text-blue-400 hover:text-blue-300 underline underline-offset-2">
                        www.cnil.fr
                      </a>
                    </p>
                  </div>
                </div>
              </div>

              <!-- Modifications -->
              <div class="space-y-3">
                <h4 class="text-lg font-semibold text-zinc-100 flex items-center gap-2">
                  <svg class="w-5 h-5 text-indigo-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15"/>
                  </svg>
                  9. Modifications de la politique
                </h4>
                
                <div class="rounded-lg border border-zinc-800 bg-zinc-900/50 p-4 text-sm text-zinc-300">
                  <p>
                    Nous nous réservons le droit de modifier cette politique de confidentialité à tout moment. 
                    Toute modification sera publiée sur cette page avec une date de mise à jour actualisée. 
                    Nous vous encourageons à consulter régulièrement cette page pour rester informé de nos 
                    pratiques en matière de protection des données.
                  </p>
                </div>
              </div>

              <!-- Footer -->
              <div class="pt-6 border-t border-zinc-800">
                <div class="flex flex-wrap gap-3 text-xs text-zinc-400">
                  <a href="/mentions-legales" class="hover:text-zinc-200 underline underline-offset-2 transition">
                    Mentions légales
                  </a>
                  <span class="text-zinc-700">•</span>
                  <a href="/cookies" class="hover:text-zinc-200 underline underline-offset-2 transition">
                    Gestion des cookies
                  </a>
                  <span class="text-zinc-700">•</span>
                  <a href="/accessibilite" class="hover:text-zinc-200 underline underline-offset-2 transition">
                    Accessibilité
                  </a>
                  <span class="text-zinc-700">•</span>
                  <a href="/contact" class="hover:text-zinc-200 underline underline-offset-2 transition">
                    Nous contacter
                  </a>
                </div>
              </div>
            </div>
          </div>

          <!-- CODE -->
          <div v-else>
            <pre
              class="rounded-xl bg-zinc-950 p-5 overflow-x-auto text-sm text-zinc-100"
            ><code>&lt;div class=&quot;rounded-xl border border-zinc-800 bg-zinc-950 p-6 space-y-6&quot;&gt;
  &lt;div&gt;
    &lt;h3 class=&quot;text-2xl font-semibold text-zinc-100 mb-2&quot;&gt;
      Politique de confidentialité
    &lt;/h3&gt;
    &lt;p class=&quot;text-sm text-zinc-400&quot;&gt;
      Dernière mise à jour : 29 janvier 2026
    &lt;/p&gt;
  &lt;/div&gt;

  &lt;!-- Introduction --&gt;
  &lt;div class=&quot;rounded-lg border border-zinc-800 bg-zinc-900/50 p-4&quot;&gt;
    &lt;p class=&quot;text-sm text-zinc-300 leading-relaxed&quot;&gt;
      La protection de vos données personnelles est une priorité pour 
      &lt;strong class=&quot;text-zinc-100&quot;&gt;Société Exemple SAS&lt;/strong&gt;. 
      Cette politique vous informe sur la manière dont nous collectons, 
      utilisons et protégeons vos données conformément au 
      &lt;strong class=&quot;text-zinc-100&quot;&gt;RGPD&lt;/strong&gt;.
    &lt;/p&gt;
  &lt;/div&gt;

  &lt;!-- Responsable du traitement --&gt;
  &lt;div class=&quot;space-y-3&quot;&gt;
    &lt;h4 class=&quot;text-lg font-semibold text-zinc-100 flex items-center gap-2&quot;&gt;
      &lt;svg class=&quot;w-5 h-5 text-blue-400&quot; fill=&quot;none&quot; 
           stroke=&quot;currentColor&quot; viewBox=&quot;0 0 24 24&quot;&gt;
        &lt;path stroke-linecap=&quot;round&quot; stroke-linejoin=&quot;round&quot; 
              stroke-width=&quot;2&quot; d=&quot;M21 13.255A23.931 23.931 0 0112 
              15c-3.183 0-6.22-.62-9-1.745M16 6V4a2 2 0 00-2-2h-4a2 
              2 0 00-2 2v2m4 6h.01M5 20h14a2 2 0 002-2V8a2 2 0 
              00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z&quot;/&gt;
      &lt;/svg&gt;
      1. Responsable du traitement des données
    &lt;/h4&gt;
    
    &lt;div class=&quot;rounded-lg border border-zinc-800 bg-zinc-900/50 
                p-4 space-y-2 text-sm text-zinc-300&quot;&gt;
      &lt;p&gt;&lt;strong class=&quot;text-zinc-100&quot;&gt;Société Exemple SAS&lt;/strong&gt;&lt;/p&gt;
      &lt;p&gt;123 Avenue de la République&lt;br&gt;75011 Paris, France&lt;/p&gt;
      &lt;p&gt;Email : &lt;a href=&quot;mailto:dpo@exemple.fr&quot; 
                     class=&quot;text-blue-400 hover:text-blue-300 
                            underline underline-offset-2&quot;&gt;
                     dpo@exemple.fr
                   &lt;/a&gt;
      &lt;/p&gt;
    &lt;/div&gt;
  &lt;/div&gt;

  &lt;!-- Données collectées --&gt;
  &lt;div class=&quot;space-y-3&quot;&gt;
    &lt;h4 class=&quot;text-lg font-semibold text-zinc-100 flex items-center gap-2&quot;&gt;
      &lt;svg class=&quot;w-5 h-5 text-green-400&quot; fill=&quot;none&quot; 
           stroke=&quot;currentColor&quot; viewBox=&quot;0 0 24 24&quot;&gt;
        &lt;path stroke-linecap=&quot;round&quot; stroke-linejoin=&quot;round&quot; 
              stroke-width=&quot;2&quot; d=&quot;M9 12h6m-6 4h6m2 5H7a2 2 0 
              01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 
              5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z&quot;/&gt;
      &lt;/svg&gt;
      2. Données personnelles collectées
    &lt;/h4&gt;
    
    &lt;div class=&quot;rounded-lg border border-zinc-800 bg-zinc-900/50 
                p-4 space-y-3 text-sm text-zinc-300&quot;&gt;
      &lt;p class=&quot;text-zinc-100 font-medium&quot;&gt;Nous collectons :&lt;/p&gt;
      
      &lt;div class=&quot;space-y-3&quot;&gt;
        &lt;div class=&quot;flex gap-3&quot;&gt;
          &lt;div class=&quot;w-2 h-2 rounded-full bg-green-400 
                      mt-1.5 shrink-0&quot;&gt;&lt;/div&gt;
          &lt;div&gt;
            &lt;p class=&quot;font-medium text-zinc-100&quot;&gt;Données d'identité&lt;/p&gt;
            &lt;p&gt;Nom, prénom, adresse email, numéro de téléphone&lt;/p&gt;
          &lt;/div&gt;
        &lt;/div&gt;
        
        &lt;div class=&quot;flex gap-3&quot;&gt;
          &lt;div class=&quot;w-2 h-2 rounded-full bg-green-400 
                      mt-1.5 shrink-0&quot;&gt;&lt;/div&gt;
          &lt;div&gt;
            &lt;p class=&quot;font-medium text-zinc-100&quot;&gt;Données de connexion&lt;/p&gt;
            &lt;p&gt;Adresse IP, type de navigateur, pages visitées&lt;/p&gt;
          &lt;/div&gt;
        &lt;/div&gt;
      &lt;/div&gt;
    &lt;/div&gt;
  &lt;/div&gt;

  &lt;!-- Vos droits --&gt;
  &lt;div class=&quot;space-y-3&quot;&gt;
    &lt;h4 class=&quot;text-lg font-semibold text-zinc-100 flex items-center gap-2&quot;&gt;
      &lt;svg class=&quot;w-5 h-5 text-pink-400&quot; fill=&quot;none&quot; 
           stroke=&quot;currentColor&quot; viewBox=&quot;0 0 24 24&quot;&gt;
        &lt;path stroke-linecap=&quot;round&quot; stroke-linejoin=&quot;round&quot; 
              stroke-width=&quot;2&quot; d=&quot;M12 15v2m-6 4h12a2 2 0 002-2v-6a2 
              2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 
              4 0 00-8 0v4h8z&quot;/&gt;
      &lt;/svg&gt;
      6. Vos droits
    &lt;/h4&gt;
    
    &lt;div class=&quot;rounded-lg border border-zinc-800 bg-zinc-900/50 
                p-4 space-y-3 text-sm text-zinc-300&quot;&gt;
      &lt;p class=&quot;text-zinc-100 font-medium&quot;&gt;
        Vous disposez des droits suivants :
      &lt;/p&gt;
      
      &lt;div class=&quot;grid sm:grid-cols-2 gap-3&quot;&gt;
        &lt;div class=&quot;rounded-lg border border-zinc-700 
                    bg-zinc-950/50 p-3&quot;&gt;
          &lt;p class=&quot;font-medium text-pink-400 mb-1&quot;&gt;Droit d'accès&lt;/p&gt;
          &lt;p class=&quot;text-xs&quot;&gt;Obtenir une copie de vos données&lt;/p&gt;
        &lt;/div&gt;
        
        &lt;div class=&quot;rounded-lg border border-zinc-700 
                    bg-zinc-950/50 p-3&quot;&gt;
          &lt;p class=&quot;font-medium text-pink-400 mb-1&quot;&gt;
            Droit de rectification
          &lt;/p&gt;
          &lt;p class=&quot;text-xs&quot;&gt;Corriger vos données&lt;/p&gt;
        &lt;/div&gt;
        
        &lt;div class=&quot;rounded-lg border border-zinc-700 
                    bg-zinc-950/50 p-3&quot;&gt;
          &lt;p class=&quot;font-medium text-pink-400 mb-1&quot;&gt;
            Droit à l'effacement
          &lt;/p&gt;
          &lt;p class=&quot;text-xs&quot;&gt;Demander la suppression&lt;/p&gt;
        &lt;/div&gt;
        
        &lt;div class=&quot;rounded-lg border border-zinc-700 
                    bg-zinc-950/50 p-3&quot;&gt;
          &lt;p class=&quot;font-medium text-pink-400 mb-1&quot;&gt;
            Droit d'opposition
          &lt;/p&gt;
          &lt;p class=&quot;text-xs&quot;&gt;S'opposer au traitement&lt;/p&gt;
        &lt;/div&gt;
      &lt;/div&gt;
      
      &lt;div class=&quot;mt-4 pt-4 border-t border-zinc-700&quot;&gt;
        &lt;p class=&quot;mb-2 font-medium text-zinc-100&quot;&gt;
          Pour exercer vos droits :
        &lt;/p&gt;
        &lt;a href=&quot;mailto:dpo@exemple.fr&quot; 
           class=&quot;inline-flex items-center gap-2 rounded-lg 
                  border border-zinc-700 bg-zinc-900 px-3 py-2 
                  text-xs text-zinc-100 hover:bg-zinc-800 transition&quot;&gt;
          Contacter le DPO
        &lt;/a&gt;
      &lt;/div&gt;
    &lt;/div&gt;
  &lt;/div&gt;
&lt;/div&gt;</code></pre>

            <p class="mt-3 text-xs text-zinc-500">
              La politique de confidentialité doit être claire, complète et 
              accessible depuis toutes les pages du site. Elle doit informer 
              les utilisateurs de manière transparente sur le traitement de 
              leurs données personnelles conformément au RGPD : quelles données 
              sont collectées, pourquoi, combien de temps elles sont conservées, 
              et comment exercer leurs droits.
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