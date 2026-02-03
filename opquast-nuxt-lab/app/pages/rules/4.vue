<script setup>
import { getRuleById } from '~/data/rules'

const ruleId = 4
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
      <p v-if="rule.implementationConclusion" class="mt-3 text-sm text-zinc-400">
        {{ rule.implementationConclusion }}
      </p>
    </section>

    <!-- Contrôle -->
    <section class="rounded-2xl border border-zinc-800 bg-zinc-900/30 p-6">
      <h2 class="text-lg font-semibold tracking-tight text-zinc-100">
        Contrôle
      </h2>
      <p v-if="rule.controlIntro" class="mt-3 text-sm text-zinc-400">
        {{ rule.controlIntro }}
      </p>

      <ul class="mt-3 list-disc pl-5 space-y-2 text-sm text-zinc-300">
        <li v-for="c in rule.control" :key="c">{{ c }}</li>
      </ul>
      <p v-if="rule.controlConclusion" class="mt-3 text-sm text-zinc-400">
        {{ rule.controlConclusion }}
      </p>
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
              Exemple de formatage explicite des dates
            </div>

            <div class="rounded-xl border border-zinc-800 bg-zinc-950 p-5">
              <div class="space-y-4">
                <div class="flex items-start justify-between">
                  <div>
                    <h4 class="text-sm font-medium text-zinc-100">Article publié</h4>
                    <p class="text-sm text-zinc-400 mt-1">Guide complet du web accessible</p>
                  </div>
                  <span class="text-sm text-zinc-300 whitespace-nowrap">12 janvier 2026</span>
                </div>

                <div class="border-t border-zinc-800 pt-4 flex items-start justify-between">
                  <div>
                    <h4 class="text-sm font-medium text-zinc-100">Mise à jour</h4>
                    <p class="text-sm text-zinc-400 mt-1">Nouvelles règles de qualité web</p>
                  </div>
                  <span class="text-sm text-zinc-300 whitespace-nowrap">5 nov. 2025</span>
                </div>

                <div class="border-t border-zinc-800 pt-4">
                  <p class="text-xs text-red-400">Incorrect : 12/11/2025 (ambigu)</p>
                  <p class="text-xs text-green-400 mt-2">Correct : 12 novembre 2025 ou 12 nov. 2025</p>
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
&lt;div v-if=&quot;activeTab === 'preview'&quot; class=&quot;space-y-4&quot;&gt;
  &lt;div class=&quot;text-sm text-zinc-400&quot;&gt;
    Exemple de formatage explicite des dates
  &lt;/div&gt;

  &lt;div class=&quot;rounded-xl border border-zinc-800 bg-zinc-950 p-5&quot;&gt;
    &lt;div class=&quot;space-y-4&quot;&gt;
      &lt;div class=&quot;flex items-start justify-between&quot;&gt;
        &lt;div&gt;
          &lt;h4 class=&quot;text-sm font-medium text-zinc-100&quot;&gt;Article publié&lt;/h4&gt;
          &lt;p class=&quot;text-sm text-zinc-400 mt-1&quot;&gt;Guide complet du web accessible&lt;/p&gt;
        &lt;/div&gt;
        &lt;span class=&quot;text-sm text-zinc-300 whitespace-nowrap&quot;&gt;12 janvier 2026&lt;/span&gt;
      &lt;/div&gt;

      &lt;div class=&quot;border-t border-zinc-800 pt-4 flex items-start justify-between&quot;&gt;
        &lt;div&gt;
          &lt;h4 class=&quot;text-sm font-medium text-zinc-100&quot;&gt;Mise à jour&lt;/h4&gt;
          &lt;p class=&quot;text-sm text-zinc-400 mt-1&quot;&gt;Nouvelles règles de qualité web&lt;/p&gt;
        &lt;/div&gt;
        &lt;span class=&quot;text-sm text-zinc-300 whitespace-nowrap&quot;&gt;5 nov. 2025&lt;/span&gt;
      &lt;/div&gt;

      &lt;div class=&quot;border-t border-zinc-800 pt-4&quot;&gt;
        &lt;p class=&quot;text-xs text-red-400&quot;&gt;Incorrect : 12/11/2025 (ambigu)&lt;/p&gt;
        &lt;p class=&quot;text-xs text-green-400 mt-2&quot;&gt;Correct : 12 novembre 2025 ou 12 nov. 2025&lt;/p&gt;
      &lt;/div&gt;
    &lt;/div&gt;
  &lt;/div&gt;
&lt;/div&gt;
</code>
</pre>

            <p class="mt-3 text-xs text-zinc-500">
              Le mois doit être écrit en lettres (complet ou abrégé) et l'année sur 4 chiffres pour éviter toute ambiguïté.
            </p>
          </div>
        </div>
      </div>
    </section>
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