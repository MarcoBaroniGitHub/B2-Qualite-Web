<script setup>
import { getRuleById } from '~/data/rules'

const ruleId = 127
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
              Exemple de page de mentions légales complète et accessible
            </div>

            <div class="rounded-xl border border-zinc-800 bg-zinc-950 p-6 space-y-6">
              <div>
                <h3 class="text-2xl font-semibold text-zinc-100 mb-2">
                  Mentions légales
                </h3>
                <p class="text-sm text-zinc-400">
                  Dernière mise à jour : 29 janvier 2026
                </p>
              </div>

              <!-- Éditeur du site -->
              <div class="space-y-3">
                <h4 class="text-lg font-semibold text-zinc-100 flex items-center gap-2">
                  <svg class="w-5 h-5 text-blue-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4"/>
                  </svg>
                  Éditeur du site
                </h4>
                
                <div class="rounded-lg border border-zinc-800 bg-zinc-900/50 p-4 space-y-2 text-sm text-zinc-300">
                  <div class="flex flex-col sm:flex-row sm:gap-2">
                    <span class="font-medium text-zinc-100 min-w-[140px]">Raison sociale :</span>
                    <span>Société Exemple SAS</span>
                  </div>
                  <div class="flex flex-col sm:flex-row sm:gap-2">
                    <span class="font-medium text-zinc-100 min-w-[140px]">Capital social :</span>
                    <span>50 000 €</span>
                  </div>
                  <div class="flex flex-col sm:flex-row sm:gap-2">
                    <span class="font-medium text-zinc-100 min-w-[140px]">Adresse :</span>
                    <span>123 Avenue de la République<br>75011 Paris, France</span>
                  </div>
                  <div class="flex flex-col sm:flex-row sm:gap-2">
                    <span class="font-medium text-zinc-100 min-w-[140px]">SIRET :</span>
                    <span>123 456 789 00012</span>
                  </div>
                  <div class="flex flex-col sm:flex-row sm:gap-2">
                    <span class="font-medium text-zinc-100 min-w-[140px]">RCS :</span>
                    <span>Paris B 123 456 789</span>
                  </div>
                  <div class="flex flex-col sm:flex-row sm:gap-2">
                    <span class="font-medium text-zinc-100 min-w-[140px]">TVA :</span>
                    <span>FR 12 345678901</span>
                  </div>
                  <div class="flex flex-col sm:flex-row sm:gap-2">
                    <span class="font-medium text-zinc-100 min-w-[140px]">Téléphone :</span>
                    <span>+33 1 23 45 67 89</span>
                  </div>
                  <div class="flex flex-col sm:flex-row sm:gap-2">
                    <span class="font-medium text-zinc-100 min-w-[140px]">Email :</span>
                    <a href="mailto:contact@exemple.fr" class="text-blue-400 hover:text-blue-300 underline underline-offset-2">
                      contact@exemple.fr
                    </a>
                  </div>
                </div>
              </div>

              <!-- Directeur de publication -->
              <div class="space-y-3">
                <h4 class="text-lg font-semibold text-zinc-100 flex items-center gap-2">
                  <svg class="w-5 h-5 text-green-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/>
                  </svg>
                  Directeur de publication
                </h4>
                
                <div class="rounded-lg border border-zinc-800 bg-zinc-900/50 p-4 text-sm text-zinc-300">
                  <p>Monsieur Jean Dupont, Président de la société Exemple SAS</p>
                </div>
              </div>

              <!-- Hébergeur -->
              <div class="space-y-3">
                <h4 class="text-lg font-semibold text-zinc-100 flex items-center gap-2">
                  <svg class="w-5 h-5 text-purple-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 12h14M5 12a2 2 0 01-2-2V6a2 2 0 012-2h14a2 2 0 012 2v4a2 2 0 01-2 2M5 12a2 2 0 00-2 2v4a2 2 0 002 2h14a2 2 0 002-2v-4a2 2 0 00-2-2m-2-4h.01M17 16h.01"/>
                  </svg>
                  Hébergeur du site
                </h4>
                
                <div class="rounded-lg border border-zinc-800 bg-zinc-900/50 p-4 space-y-2 text-sm text-zinc-300">
                  <div class="flex flex-col sm:flex-row sm:gap-2">
                    <span class="font-medium text-zinc-100 min-w-[140px]">Raison sociale :</span>
                    <span>OVH SAS</span>
                  </div>
                  <div class="flex flex-col sm:flex-row sm:gap-2">
                    <span class="font-medium text-zinc-100 min-w-[140px]">Adresse :</span>
                    <span>2 rue Kellermann<br>59100 Roubaix, France</span>
                  </div>
                  <div class="flex flex-col sm:flex-row sm:gap-2">
                    <span class="font-medium text-zinc-100 min-w-[140px]">Téléphone :</span>
                    <span>+33 9 72 10 10 07</span>
                  </div>
                  <div class="flex flex-col sm:flex-row sm:gap-2">
                    <span class="font-medium text-zinc-100 min-w-[140px]">Site web :</span>
                    <a href="https://www.ovh.com" target="_blank" rel="noopener noreferrer" class="text-blue-400 hover:text-blue-300 underline underline-offset-2">
                      www.ovh.com
                    </a>
                  </div>
                </div>
              </div>

              <!-- Propriété intellectuelle -->
              <div class="space-y-3">
                <h4 class="text-lg font-semibold text-zinc-100 flex items-center gap-2">
                  <svg class="w-5 h-5 text-amber-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"/>
                  </svg>
                  Propriété intellectuelle
                </h4>
                
                <div class="rounded-lg border border-zinc-800 bg-zinc-900/50 p-4 space-y-2 text-sm text-zinc-300">
                  <p>
                    L'ensemble de ce site relève de la législation française et internationale sur le droit d'auteur et la propriété intellectuelle. Tous les droits de reproduction sont réservés, y compris pour les documents téléchargeables et les représentations iconographiques et photographiques.
                  </p>
                  <p>
                    La reproduction de tout ou partie de ce site sur un support électronique quel qu'il soit est formellement interdite sauf autorisation expresse du directeur de la publication.
                  </p>
                </div>
              </div>

              <!-- Protection des données -->
              <div class="space-y-3">
                <h4 class="text-lg font-semibold text-zinc-100 flex items-center gap-2">
                  <svg class="w-5 h-5 text-red-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z"/>
                  </svg>
                  Protection des données personnelles
                </h4>
                
                <div class="rounded-lg border border-zinc-800 bg-zinc-900/50 p-4 space-y-2 text-sm text-zinc-300">
                  <p>
                    Conformément au Règlement Général sur la Protection des Données (RGPD) et à la loi Informatique et Libertés, vous disposez d'un droit d'accès, de rectification, de suppression et d'opposition aux données personnelles vous concernant.
                  </p>
                  <p>
                    Pour exercer ces droits, vous pouvez nous contacter à l'adresse : 
                    <a href="mailto:dpo@exemple.fr" class="text-blue-400 hover:text-blue-300 underline underline-offset-2">
                      dpo@exemple.fr
                    </a>
                  </p>
                  <p class="pt-2 border-t border-zinc-700">
                    Pour en savoir plus, consultez notre 
                    <a href="/politique-confidentialite" class="text-blue-400 hover:text-blue-300 underline underline-offset-2">
                      Politique de confidentialité
                    </a>
                  </p>
                </div>
              </div>

              <!-- Cookies -->
              <div class="space-y-3">
                <h4 class="text-lg font-semibold text-zinc-100 flex items-center gap-2">
                  <svg class="w-5 h-5 text-orange-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"/>
                  </svg>
                  Cookies
                </h4>
                
                <div class="rounded-lg border border-zinc-800 bg-zinc-900/50 p-4 space-y-2 text-sm text-zinc-300">
                  <p>
                    Ce site utilise des cookies pour améliorer votre expérience de navigation et réaliser des statistiques de visites. Vous pouvez paramétrer l'utilisation des cookies ou refuser leur utilisation.
                  </p>
                  <div class="pt-2">
                    <a href="/cookies" class="inline-flex items-center gap-2 rounded-lg border border-zinc-700 bg-zinc-900 px-3 py-2 text-xs text-zinc-100 hover:bg-zinc-800 transition">
                      <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z"/>
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/>
                      </svg>
                      Gérer les cookies
                    </a>
                  </div>
                </div>
              </div>

              <!-- Crédits -->
              <div class="space-y-3">
                <h4 class="text-lg font-semibold text-zinc-100 flex items-center gap-2">
                  <svg class="w-5 h-5 text-pink-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 21a4 4 0 01-4-4V5a2 2 0 012-2h4a2 2 0 012 2v12a4 4 0 01-4 4zm0 0h12a2 2 0 002-2v-4a2 2 0 00-2-2h-2.343M11 7.343l1.657-1.657a2 2 0 012.828 0l2.829 2.829a2 2 0 010 2.828l-8.486 8.485M7 17h.01"/>
                  </svg>
                  Crédits
                </h4>
                
                <div class="rounded-lg border border-zinc-800 bg-zinc-900/50 p-4 space-y-2 text-sm text-zinc-300">
                  <div class="flex flex-col sm:flex-row sm:gap-2">
                    <span class="font-medium text-zinc-100 min-w-[140px]">Conception :</span>
                    <span>Agence Web Design</span>
                  </div>
                  <div class="flex flex-col sm:flex-row sm:gap-2">
                    <span class="font-medium text-zinc-100 min-w-[140px]">Développement :</span>
                    <span>Studio Dev</span>
                  </div>
                  <div class="flex flex-col sm:flex-row sm:gap-2">
                    <span class="font-medium text-zinc-100 min-w-[140px]">Photographies :</span>
                    <span>Unsplash, Pexels (licences libres de droits)</span>
                  </div>
                </div>
              </div>

              <!-- Footer -->
              <div class="pt-6 border-t border-zinc-800 flex flex-wrap gap-3">
                <a href="/accessibilite" class="text-xs text-zinc-400 hover:text-zinc-200 underline underline-offset-2 transition">
                  Déclaration d'accessibilité
                </a>
                <span class="text-zinc-700">•</span>
                <a href="/politique-confidentialite" class="text-xs text-zinc-400 hover:text-zinc-200 underline underline-offset-2 transition">
                  Politique de confidentialité
                </a>
                <span class="text-zinc-700">•</span>
                <a href="/cookies" class="text-xs text-zinc-400 hover:text-zinc-200 underline underline-offset-2 transition">
                  Gestion des cookies
                </a>
                <span class="text-zinc-700">•</span>
                <a href="/plan-du-site" class="text-xs text-zinc-400 hover:text-zinc-200 underline underline-offset-2 transition">
                  Plan du site
                </a>
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
      Mentions légales
    &lt;/h3&gt;
    &lt;p class=&quot;text-sm text-zinc-400&quot;&gt;
      Dernière mise à jour : 29 janvier 2026
    &lt;/p&gt;
  &lt;/div&gt;

  &lt;!-- Éditeur du site --&gt;
  &lt;div class=&quot;space-y-3&quot;&gt;
    &lt;h4 class=&quot;text-lg font-semibold text-zinc-100 flex items-center gap-2&quot;&gt;
      &lt;svg class=&quot;w-5 h-5 text-blue-400&quot; fill=&quot;none&quot; 
           stroke=&quot;currentColor&quot; viewBox=&quot;0 0 24 24&quot;&gt;
        &lt;path stroke-linecap=&quot;round&quot; stroke-linejoin=&quot;round&quot; 
              stroke-width=&quot;2&quot; d=&quot;M19 21V5a2 2 0 00-2-2H7a2 2 0 
              00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 
              4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4&quot;/&gt;
      &lt;/svg&gt;
      Éditeur du site
    &lt;/h4&gt;
    
    &lt;div class=&quot;rounded-lg border border-zinc-800 bg-zinc-900/50 
                p-4 space-y-2 text-sm text-zinc-300&quot;&gt;
      &lt;div class=&quot;flex flex-col sm:flex-row sm:gap-2&quot;&gt;
        &lt;span class=&quot;font-medium text-zinc-100 min-w-[140px]&quot;&gt;
          Raison sociale :
        &lt;/span&gt;
        &lt;span&gt;Société Exemple SAS&lt;/span&gt;
      &lt;/div&gt;
      &lt;div class=&quot;flex flex-col sm:flex-row sm:gap-2&quot;&gt;
        &lt;span class=&quot;font-medium text-zinc-100 min-w-[140px]&quot;&gt;
          Capital social :
        &lt;/span&gt;
        &lt;span&gt;50 000 €&lt;/span&gt;
      &lt;/div&gt;
      &lt;div class=&quot;flex flex-col sm:flex-row sm:gap-2&quot;&gt;
        &lt;span class=&quot;font-medium text-zinc-100 min-w-[140px]&quot;&gt;
          Adresse :
        &lt;/span&gt;
        &lt;span&gt;123 Avenue de la République&lt;br&gt;75011 Paris, France&lt;/span&gt;
      &lt;/div&gt;
      &lt;div class=&quot;flex flex-col sm:flex-row sm:gap-2&quot;&gt;
        &lt;span class=&quot;font-medium text-zinc-100 min-w-[140px]&quot;&gt;
          SIRET :
        &lt;/span&gt;
        &lt;span&gt;123 456 789 00012&lt;/span&gt;
      &lt;/div&gt;
      &lt;div class=&quot;flex flex-col sm:flex-row sm:gap-2&quot;&gt;
        &lt;span class=&quot;font-medium text-zinc-100 min-w-[140px]&quot;&gt;
          Email :
        &lt;/span&gt;
        &lt;a href=&quot;mailto:contact@exemple.fr&quot; 
           class=&quot;text-blue-400 hover:text-blue-300 
                  underline underline-offset-2&quot;&gt;
          contact@exemple.fr
        &lt;/a&gt;
      &lt;/div&gt;
    &lt;/div&gt;
  &lt;/div&gt;

  &lt;!-- Directeur de publication --&gt;
  &lt;div class=&quot;space-y-3&quot;&gt;
    &lt;h4 class=&quot;text-lg font-semibold text-zinc-100 flex items-center gap-2&quot;&gt;
      &lt;svg class=&quot;w-5 h-5 text-green-400&quot; fill=&quot;none&quot; 
           stroke=&quot;currentColor&quot; viewBox=&quot;0 0 24 24&quot;&gt;
        &lt;path stroke-linecap=&quot;round&quot; stroke-linejoin=&quot;round&quot; 
              stroke-width=&quot;2&quot; d=&quot;M16 7a4 4 0 11-8 0 4 4 0 018 
              0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z&quot;/&gt;
      &lt;/svg&gt;
      Directeur de publication
    &lt;/h4&gt;
    
    &lt;div class=&quot;rounded-lg border border-zinc-800 bg-zinc-900/50 
                p-4 text-sm text-zinc-300&quot;&gt;
      &lt;p&gt;Monsieur Jean Dupont, Président de la société Exemple SAS&lt;/p&gt;
    &lt;/div&gt;
  &lt;/div&gt;

  &lt;!-- Hébergeur --&gt;
  &lt;div class=&quot;space-y-3&quot;&gt;
    &lt;h4 class=&quot;text-lg font-semibold text-zinc-100 flex items-center gap-2&quot;&gt;
      &lt;svg class=&quot;w-5 h-5 text-purple-400&quot; fill=&quot;none&quot; 
           stroke=&quot;currentColor&quot; viewBox=&quot;0 0 24 24&quot;&gt;
        &lt;path stroke-linecap=&quot;round&quot; stroke-linejoin=&quot;round&quot; 
              stroke-width=&quot;2&quot; d=&quot;M5 12h14M5 12a2 2 0 01-2-2V6a2 
              2 0 012-2h14a2 2 0 012 2v4a2 2 0 01-2 2M5 12a2 2 0 
              00-2 2v4a2 2 0 002 2h14a2 2 0 002-2v-4a2 2 0 
              00-2-2m-2-4h.01M17 16h.01&quot;/&gt;
      &lt;/svg&gt;
      Hébergeur du site
    &lt;/h4&gt;
    
    &lt;div class=&quot;rounded-lg border border-zinc-800 bg-zinc-900/50 
                p-4 space-y-2 text-sm text-zinc-300&quot;&gt;
      &lt;div class=&quot;flex flex-col sm:flex-row sm:gap-2&quot;&gt;
        &lt;span class=&quot;font-medium text-zinc-100 min-w-[140px]&quot;&gt;
          Raison sociale :
        &lt;/span&gt;
        &lt;span&gt;OVH SAS&lt;/span&gt;
      &lt;/div&gt;
      &lt;div class=&quot;flex flex-col sm:flex-row sm:gap-2&quot;&gt;
        &lt;span class=&quot;font-medium text-zinc-100 min-w-[140px]&quot;&gt;
          Site web :
        &lt;/span&gt;
        &lt;a href=&quot;https://www.ovh.com&quot; target=&quot;_blank&quot; 
           rel=&quot;noopener noreferrer&quot; 
           class=&quot;text-blue-400 hover:text-blue-300 
                  underline underline-offset-2&quot;&gt;
          www.ovh.com
        &lt;/a&gt;
      &lt;/div&gt;
    &lt;/div&gt;
  &lt;/div&gt;

  &lt;!-- Protection des données --&gt;
  &lt;div class=&quot;space-y-3&quot;&gt;
    &lt;h4 class=&quot;text-lg font-semibold text-zinc-100 flex items-center gap-2&quot;&gt;
      &lt;svg class=&quot;w-5 h-5 text-red-400&quot; fill=&quot;none&quot; 
           stroke=&quot;currentColor&quot; viewBox=&quot;0 0 24 24&quot;&gt;
        &lt;path stroke-linecap=&quot;round&quot; stroke-linejoin=&quot;round&quot; 
              stroke-width=&quot;2&quot; d=&quot;M9 12l2 2 4-4m5.618-4.016A11.955 
              11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 
              12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 
              9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z&quot;/&gt;
      &lt;/svg&gt;
      Protection des données personnelles
    &lt;/h4&gt;
    
    &lt;div class=&quot;rounded-lg border border-zinc-800 bg-zinc-900/50 
                p-4 space-y-2 text-sm text-zinc-300&quot;&gt;
      &lt;p&gt;
        Conformément au RGPD, vous disposez d'un droit d'accès, 
        de rectification, de suppression et d'opposition aux données 
        personnelles vous concernant.
      &lt;/p&gt;
      &lt;p&gt;
        Pour exercer ces droits : 
        &lt;a href=&quot;mailto:dpo@exemple.fr&quot; 
           class=&quot;text-blue-400 hover:text-blue-300 
                  underline underline-offset-2&quot;&gt;
          dpo@exemple.fr
        &lt;/a&gt;
      &lt;/p&gt;
    &lt;/div&gt;
  &lt;/div&gt;

  &lt;!-- Footer --&gt;
  &lt;div class=&quot;pt-6 border-t border-zinc-800 flex flex-wrap gap-3&quot;&gt;
    &lt;a href=&quot;/accessibilite&quot; 
       class=&quot;text-xs text-zinc-400 hover:text-zinc-200 
              underline underline-offset-2 transition&quot;&gt;
      Déclaration d'accessibilité
    &lt;/a&gt;
    &lt;span class=&quot;text-zinc-700&quot;&gt;•&lt;/span&gt;
    &lt;a href=&quot;/politique-confidentialite&quot; 
       class=&quot;text-xs text-zinc-400 hover:text-zinc-200 
              underline underline-offset-2 transition&quot;&gt;
      Politique de confidentialité
    &lt;/a&gt;
    &lt;span class=&quot;text-zinc-700&quot;&gt;•&lt;/span&gt;
    &lt;a href=&quot;/plan-du-site&quot; 
       class=&quot;text-xs text-zinc-400 hover:text-zinc-200 
              underline underline-offset-2 transition&quot;&gt;
      Plan du site
    &lt;/a&gt;
  &lt;/div&gt;
&lt;/div&gt;</code></pre>

            <p class="mt-3 text-xs text-zinc-500">
              Les mentions légales doivent être facilement accessibles depuis 
              toutes les pages du site (généralement via un lien dans le pied 
              de page). Elles doivent contenir les informations obligatoires : 
              éditeur du site (raison sociale, adresse, SIRET, etc.), directeur 
              de publication, hébergeur, et informations sur la protection des 
              données personnelles conformément au RGPD.
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