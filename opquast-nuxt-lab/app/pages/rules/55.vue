<script setup>
import { getRuleById } from '~/data/rules'

const ruleId = 55
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
          <div v-if="activeTab === 'preview'" class="space-y-4">
            <div class="text-sm text-zinc-400">
              Exemple de décomposition du prix affichée avant le paiement (B2B
              ou B2C).
            </div>

            <div
              class="mx-auto max-w-sm rounded-xl border border-zinc-800 bg-zinc-950 p-6"
            >
              <div class="flex items-center gap-3 mb-6">
                <div
                  class="h-10 w-10 flex items-center justify-center rounded-full bg-zinc-900 border border-zinc-800"
                >
                  <svg
                    width="20"
                    height="20"
                    class="h-5 w-5 text-zinc-400"
                    fill="none"
                    viewBox="0 0 24 24"
                    stroke="currentColor"
                  >
                    <path
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      stroke-width="2"
                      d="M9 7h6m0 10v-3m-3 3h.01M9 17h.01M9 14h.01M12 14h.01M15 11h.01M12 11h.01M9 11h.01M7 21h10a2 2 0 002-2V5a2 2 0 00-2-2H7a2 2 0 00-2 2v14a2 2 0 002 2z"
                    />
                  </svg>
                </div>
                <div>
                  <h3 class="text-sm font-semibold text-zinc-100">
                    Détail de la facturation
                  </h3>
                  <p class="text-xs text-zinc-500">Commande #FR-2024-889</p>
                </div>
              </div>

              <div class="space-y-3 text-sm">
                <div class="flex justify-between items-center">
                  <span class="text-zinc-400">Total Hors Taxes (HT)</span>
                  <span class="font-medium text-zinc-200">416,67 €</span>
                </div>

                <div class="flex justify-between items-center">
                  <div class="flex items-center gap-1.5 text-zinc-400">
                    <span>TVA (20%)</span>
                    <svg
                      width="14"
                      height="14"
                      class="h-3.5 w-3.5 text-zinc-600 cursor-help"
                      fill="none"
                      viewBox="0 0 24 24"
                      stroke="currentColor"
                    >
                      <path
                        stroke-linecap="round"
                        stroke-linejoin="round"
                        stroke-width="2"
                        d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"
                      />
                    </svg>
                  </div>
                  <span class="text-zinc-200">83,33 €</span>
                </div>

                <div
                  class="flex justify-between items-center py-2 border-t border-zinc-800/50 border-dashed"
                >
                  <span class="text-zinc-500 text-xs"
                    >Dont éco-participation</span
                  >
                  <span class="text-zinc-500 text-xs">2,50 €</span>
                </div>

                <div
                  class="flex justify-between items-center pt-3 border-t border-zinc-800"
                >
                  <span class="font-semibold text-zinc-100">Total TTC</span>
                  <span class="text-xl font-bold text-emerald-400"
                    >500,00 €</span
                  >
                </div>
              </div>

              <div class="mt-6 rounded bg-zinc-900/50 p-3">
                <p class="text-xs text-center text-zinc-500">
                  Une facture détaillée incluant la TVA déductible vous sera
                  envoyée par email.
                </p>
              </div>
            </div>
          </div>

          <!-- CODE -->
          <div v-else>
            <pre
              class="rounded-xl bg-zinc-950 p-5 overflow-x-auto text-sm text-zinc-100"
            >
<code>
&lt;div class=&quot;mx-auto max-w-sm rounded-xl border border-zinc-800 bg-zinc-950 p-6&quot;&gt;
  &lt;h3 class=&quot;mb-6 text-sm font-semibold text-zinc-100&quot;&gt;
    Détail de la facturation
  &lt;/h3&gt;

  &lt;div class=&quot;space-y-3 text-sm&quot;&gt;
    &lt;!-- Ligne HT --&gt;
    &lt;div class=&quot;flex justify-between&quot;&gt;
      &lt;span class=&quot;text-zinc-400&quot;&gt;Total Hors Taxes (HT)&lt;/span&gt;
      &lt;span class=&quot;font-medium text-zinc-200&quot;&gt;416,67 €&lt;/span&gt;
    &lt;/div&gt;

    &lt;!-- Ligne TVA --&gt;
    &lt;div class=&quot;flex justify-between&quot;&gt;
      &lt;span class=&quot;text-zinc-400&quot;&gt;TVA (20%)&lt;/span&gt;
      &lt;span class=&quot;text-zinc-200&quot;&gt;83,33 €&lt;/span&gt;
    &lt;/div&gt;

    &lt;!-- Supplément explicite --&gt;
    &lt;div class=&quot;flex justify-between py-2 border-t border-dashed border-zinc-800&quot;&gt;
      &lt;span class=&quot;text-xs text-zinc-500&quot;&gt;Dont éco-participation&lt;/span&gt;
      &lt;span class=&quot;text-xs text-zinc-500&quot;&gt;2,50 €&lt;/span&gt;
    &lt;/div&gt;

    &lt;!-- Total TTC --&gt;
    &lt;div class=&quot;flex justify-between pt-3 border-t border-zinc-800&quot;&gt;
      &lt;span class=&quot;font-semibold text-zinc-100&quot;&gt;Total TTC&lt;/span&gt;
      &lt;span class=&quot;text-xl font-bold text-emerald-400&quot;&gt;500,00 €&lt;/span&gt;
    &lt;/div&gt;
  &lt;/div&gt;
&lt;/div&gt;
</code>
  </pre>

            <p class="mt-3 text-xs text-zinc-500">
              Cette transparence est indispensable pour les professionnels
              (récupération de TVA) et rassurante pour les particuliers
              (compréhension du prix final).
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
