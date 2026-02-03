<script setup>
import { getRuleById } from '~/data/rules'

const ruleId = 56
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
              Exemple de formulaire permettant de dissocier la livraison de la
              facturation.
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
                    d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z"
                  />
                  <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    stroke-width="2"
                    d="M15 11a3 3 0 11-6 0 3 3 0 016 0z"
                  />
                </svg>
                Adresse de facturation
              </h3>

              <div class="grid gap-3 sm:grid-cols-2">
                <div class="space-y-1">
                  <label class="text-xs text-zinc-500">Prénom & Nom</label>
                  <div
                    class="h-9 w-full rounded border border-zinc-700 bg-zinc-900 px-3 py-2 text-sm text-zinc-300"
                  >
                    Jean Dupont
                  </div>
                </div>
                <div class="space-y-1">
                  <label class="text-xs text-zinc-500"
                    >Société (Optionnel)</label
                  >
                  <div
                    class="h-9 w-full rounded border border-zinc-700 bg-zinc-900 px-3 py-2 text-sm text-zinc-300"
                  >
                    Dupont & Co
                  </div>
                </div>
                <div class="sm:col-span-2 space-y-1">
                  <label class="text-xs text-zinc-500">Adresse</label>
                  <div
                    class="h-9 w-full rounded border border-zinc-700 bg-zinc-900 px-3 py-2 text-sm text-zinc-300"
                  >
                    12 Rue de la République
                  </div>
                </div>
              </div>

              <div
                class="my-6 flex items-center gap-3 rounded bg-zinc-900/40 p-3 border border-zinc-800"
              >
                <div
                  class="flex h-5 w-5 items-center justify-center rounded border border-zinc-600 bg-zinc-900"
                ></div>
                <span class="text-sm text-zinc-300"
                  >Utiliser comme adresse de livraison</span
                >
                <span class="ml-auto text-xs text-emerald-400 font-medium"
                  >Décoché</span
                >
              </div>

              <div class="border-l-2 border-emerald-500/50 pl-4">
                <h3
                  class="mb-4 flex items-center gap-2 text-base font-semibold text-emerald-400"
                >
                  <svg
                    width="20"
                    height="20"
                    class="h-5 w-5"
                    fill="none"
                    viewBox="0 0 24 24"
                    stroke="currentColor"
                  >
                    <path
                      d="M9 17a2 2 0 11-4 0 2 2 0 014 0zM19 17a2 2 0 11-4 0 2 2 0 014 0z"
                    />
                    <path
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      stroke-width="2"
                      d="M13 16V6a1 1 0 00-1-1H4a1 1 0 00-1 1v10a1 1 0 001 1h1m8-1a1 1 0 01-1 1H9m4-1V8a1 1 0 011-1h2.586a1 1 0 01.707.293l3.414 3.414a1 1 0 01.293.707V16a1 1 0 01-1 1h-1m-6-1a1 1 0 001 1h12a1 1 0 001-1v-3a1 1 0 00-1-1H9z"
                    />
                  </svg>
                  Adresse de livraison
                </h3>

                <div class="grid gap-3 sm:grid-cols-2">
                  <div class="space-y-1">
                    <label class="text-xs text-zinc-500">Prénom & Nom</label>
                    <div
                      class="h-9 w-full rounded border border-zinc-700 bg-zinc-900 px-3 py-2 text-sm text-zinc-300"
                    >
                      Marie Martin
                    </div>
                  </div>
                  <div class="sm:col-span-2 space-y-1">
                    <label class="text-xs text-zinc-500">Adresse</label>
                    <div
                      class="h-9 w-full rounded border border-zinc-700 bg-zinc-900 px-3 py-2 text-sm text-zinc-300"
                    >
                      45 Avenue des Ternes, 75017 Paris
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <!-- CODE -->
          <div v-else>
            <pre
              class="rounded-xl bg-zinc-950 p-5 overflow-x-auto text-sm text-zinc-100"
            >
<code>
&lt;form class=&quot;p-6&quot;&gt;
  &lt;!-- Bloc Facturation --&gt;
  &lt;h3 class=&quot;mb-4 font-semibold text-zinc-100&quot;&gt;Adresse de facturation&lt;/h3&gt;
  &lt;div class=&quot;grid gap-3 sm:grid-cols-2&quot;&gt;
    &lt;input type=&quot;text&quot; placeholder=&quot;Jean Dupont&quot; class=&quot;bg-zinc-900 border-zinc-700&quot; /&gt;
    &lt;input type=&quot;text&quot; placeholder=&quot;12 Rue de la République&quot; class=&quot;bg-zinc-900 border-zinc-700&quot; /&gt;
  &lt;/div&gt;

  &lt;!-- Checkbox de dissociation --&gt;
  &lt;div class=&quot;my-6 flex items-center gap-3&quot;&gt;
    &lt;input type=&quot;checkbox&quot; id=&quot;sameAddress&quot; class=&quot;accent-emerald-500&quot; /&gt;
    &lt;label for=&quot;sameAddress&quot; class=&quot;text-sm text-zinc-300&quot;&gt;
      L'adresse de livraison est identique à l'adresse de facturation
    &lt;/label&gt;
  &lt;/div&gt;

  &lt;!-- Bloc Livraison (Affiché conditionnellement via JS/Vue) --&gt;
  &lt;div id=&quot;shippingAddress&quot; class=&quot;border-l-2 border-emerald-500 pl-4&quot;&gt;
    &lt;h3 class=&quot;mb-4 font-semibold text-emerald-400&quot;&gt;Adresse de livraison&lt;/h3&gt;
    &lt;div class=&quot;grid gap-3 sm:grid-cols-2&quot;&gt;
      &lt;input type=&quot;text&quot; placeholder=&quot;Marie Martin&quot; class=&quot;bg-zinc-900 border-zinc-700&quot; /&gt;
      &lt;input type=&quot;text&quot; placeholder=&quot;45 Avenue des Ternes&quot; class=&quot;bg-zinc-900 border-zinc-700&quot; /&gt;
    &lt;/div&gt;
  &lt;/div&gt;
&lt;/form&gt;
</code>
  </pre>

            <p class="mt-3 text-xs text-zinc-500">
              Cette fonctionnalité est essentielle pour le B2B (livraison sur
              chantier ou filiale) et pour les cadeaux (livraison à un tiers
              sans la facture).
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
