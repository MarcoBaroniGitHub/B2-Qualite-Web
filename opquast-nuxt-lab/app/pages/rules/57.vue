<script setup>
import { getRuleById } from '~/data/rules'

const ruleId = 57
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
              Exemple de choix de paiement offrant une alternative à la carte
              bancaire.
            </div>

            <div class="rounded-xl border border-zinc-800 bg-zinc-950 p-6">
              <h3
                class="mb-5 flex items-center gap-2 text-base font-semibold text-zinc-100"
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
                    d="M3 10h18M7 15h1m4 0h1m-7 4h12a3 3 0 003-3V8a3 3 0 00-3-3H6a3 3 0 00-3 3v8a3 3 0 003 3z"
                  />
                </svg>
                Moyen de paiement
              </h3>

              <div class="space-y-3">
                <label
                  class="relative flex cursor-pointer items-center justify-between rounded-lg border border-emerald-500/50 bg-emerald-500/5 p-4 transition hover:bg-emerald-500/10"
                >
                  <div class="flex items-center gap-3">
                    <div
                      class="flex h-5 w-5 items-center justify-center rounded-full border border-emerald-500"
                    >
                      <div
                        class="h-2.5 w-2.5 rounded-full bg-emerald-500"
                      ></div>
                    </div>
                    <span class="font-medium text-zinc-200"
                      >Carte Bancaire</span
                    >
                  </div>
                  <div class="flex gap-2 opacity-75">
                    <svg
                      width="24"
                      height="16"
                      class="rounded bg-zinc-100 text-zinc-800 p-0.5"
                      viewBox="0 0 24 16"
                      fill="currentColor"
                    >
                      <path d="M2 2h20v12H2z" fill-opacity="0.1" />
                      <text
                        x="50%"
                        y="50%"
                        dominant-baseline="middle"
                        text-anchor="middle"
                        font-size="8"
                        font-weight="bold"
                      >
                        CB
                      </text>
                    </svg>
                  </div>
                </label>

                <label
                  class="relative flex cursor-pointer items-center justify-between rounded-lg border border-zinc-800 bg-zinc-900/40 p-4 transition hover:border-zinc-700 hover:bg-zinc-900"
                >
                  <div class="flex items-center gap-3">
                    <div
                      class="h-5 w-5 rounded-full border border-zinc-600"
                    ></div>
                    <span class="font-medium text-zinc-300">PayPal</span>
                  </div>
                  <svg
                    width="20"
                    height="20"
                    class="h-5 w-5 text-blue-400"
                    fill="currentColor"
                    viewBox="0 0 24 24"
                  >
                    <path
                      d="M7.076 21.337H2.47a.641.641 0 0 1-.633-.74L4.944.901C5.026.382 5.474 0 5.998 0h7.46c2.57 0 4.578.543 5.69 1.81 1.01 1.15 1.304 2.42 0.467 4.21-0.273 0.59-0.584 1.16-0.933 1.7-1.285 2.01-3.267 2.82-5.717 2.82h-1.63v4.61h-0.032l-0.784 4.88c-0.03.18-0.18.31-0.37.31h-3.07z"
                    />
                  </svg>
                </label>

                <label
                  class="relative flex cursor-pointer items-center justify-between rounded-lg border border-zinc-800 bg-zinc-900/40 p-4 transition hover:border-zinc-700 hover:bg-zinc-900"
                >
                  <div class="flex items-center gap-3">
                    <div
                      class="h-5 w-5 rounded-full border border-zinc-600"
                    ></div>
                    <span class="font-medium text-zinc-300"
                      >Virement Bancaire</span
                    >
                  </div>
                  <svg
                    width="20"
                    height="20"
                    class="h-5 w-5 text-zinc-500"
                    fill="none"
                    viewBox="0 0 24 24"
                    stroke="currentColor"
                  >
                    <path
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      stroke-width="2"
                      d="M8 14v3m4-3v3m4-3v3M3 21h18M3 10h18M3 7l9-4 9 4M4 10h16v11H4V10z"
                    />
                  </svg>
                </label>
              </div>
            </div>
          </div>

          <!-- CODE -->
          <div v-else>
            <pre
              class="rounded-xl bg-zinc-950 p-5 overflow-x-auto text-sm text-zinc-100"
            >
<code>
&lt;div class=&quot;space-y-3&quot;&gt;
  &lt;!-- Option 1 : Carte Bancaire (Active) --&gt;
  &lt;label class=&quot;flex items-center justify-between rounded-lg border border-emerald-500 bg-emerald-500/5 p-4&quot;&gt;
    &lt;div class=&quot;flex items-center gap-3&quot;&gt;
      &lt;input type=&quot;radio&quot; name=&quot;payment&quot; checked class=&quot;accent-emerald-500&quot; /&gt;
      &lt;span class=&quot;font-medium text-zinc-200&quot;&gt;Carte Bancaire&lt;/span&gt;
    &lt;/div&gt;
    &lt;!-- Logos CB/Visa/Mastercard --&gt;
    &lt;div class=&quot;flex gap-2&quot;&gt;...&lt;/div&gt;
  &lt;/label&gt;

  &lt;!-- Option 2 : PayPal --&gt;
  &lt;label class=&quot;flex items-center justify-between rounded-lg border border-zinc-800 bg-zinc-900/40 p-4 hover:bg-zinc-900&quot;&gt;
    &lt;div class=&quot;flex items-center gap-3&quot;&gt;
      &lt;input type=&quot;radio&quot; name=&quot;payment&quot; class=&quot;accent-emerald-500&quot; /&gt;
      &lt;span class=&quot;font-medium text-zinc-300&quot;&gt;PayPal&lt;/span&gt;
    &lt;/div&gt;
    &lt;!-- Logo PayPal --&gt;
  &lt;/label&gt;

  &lt;!-- Option 3 : Virement --&gt;
  &lt;label class=&quot;flex items-center justify-between rounded-lg border border-zinc-800 bg-zinc-900/40 p-4 hover:bg-zinc-900&quot;&gt;
    &lt;div class=&quot;flex items-center gap-3&quot;&gt;
      &lt;input type=&quot;radio&quot; name=&quot;payment&quot; class=&quot;accent-emerald-500&quot; /&gt;
      &lt;span class=&quot;font-medium text-zinc-300&quot;&gt;Virement Bancaire&lt;/span&gt;
    &lt;/div&gt;
  &lt;/label&gt;
&lt;/div&gt;
</code>
  </pre>

            <p class="mt-3 text-xs text-zinc-500">
              Proposer une alternative à la carte bancaire permet de ne pas
              perdre les clients qui ne peuvent pas ou ne veulent pas l'utiliser
              en ligne.
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
