<script setup>
import { getRuleById } from '~/data/rules'

const ruleId = 5
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
              Exemple avec explications d'abréviations et acronymes
            </div>

            <div class="rounded-xl border border-zinc-800 bg-zinc-950 p-5">
              <div class="space-y-4 text-sm text-zinc-300">
                <p>
                  Le <abbr title="Hyper Text Markup Language" class="underline decoration-dotted cursor-help text-zinc-100">HTML</abbr> est le langage de base d'Internet. Utilisé avec <abbr title="Cascading Style Sheets" class="underline decoration-dotted cursor-help text-zinc-100">CSS</abbr> pour le style et JavaScript pour l'interactivité.
                </p>

                <p>
                  L'<abbr title="Agence pour l'Amélioration des Conditions de Travail" class="underline decoration-dotted cursor-help text-zinc-100">ANACT</abbr> propose des ressources pour améliorer la qualité du travail. De même, la <abbr title="Commission Nationale de l'Informatique et des Libertés" class="underline decoration-dotted cursor-help text-zinc-100">CNIL</abbr> régule les données personnelles.
                </p>

                <p>
                  Pour la <abbr title="Search Engine Optimization" class="underline decoration-dotted cursor-help text-zinc-100">SEO</abbr>, utilisez des métadonnées et un contenu pertinent.
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
&lt;div v-if=&quot;activeTab === 'preview'&quot; class=&quot;space-y-4&quot;&gt;
  &lt;div class=&quot;text-sm text-zinc-400&quot;&gt;
    Exemple avec explications d'abréviations et acronymes
  &lt;/div&gt;

  &lt;div class=&quot;rounded-xl border border-zinc-800 bg-zinc-950 p-5&quot;&gt;
    &lt;div class=&quot;space-y-4 text-sm text-zinc-300&quot;&gt;
      &lt;p&gt;
        Le &lt;abbr title=&quot;Hyper Text Markup Language&quot; class=&quot;underline decoration-dotted cursor-help text-zinc-100&quot;&gt;HTML&lt;/abbr&gt; est le langage de base d'Internet. Utilisé avec &lt;abbr title=&quot;Cascading Style Sheets&quot; class=&quot;underline decoration-dotted cursor-help text-zinc-100&quot;&gt;CSS&lt;/abbr&gt; pour le style.
      &lt;/p&gt;

      &lt;p&gt;
        L'&lt;abbr title=&quot;Commission Nationale de l'Informatique et des Libertés&quot; class=&quot;underline decoration-dotted cursor-help text-zinc-100&quot;&gt;CNIL&lt;/abbr&gt; régule les données personnelles.
      &lt;/p&gt;

      &lt;p&gt;
        Pour la &lt;abbr title=&quot;Search Engine Optimization&quot; class=&quot;underline decoration-dotted cursor-help text-zinc-100&quot;&gt;SEO&lt;/abbr&gt;, utilisez des métadonnées pertinentes.
      &lt;/p&gt;
    &lt;/div&gt;
  &lt;/div&gt;
&lt;/div&gt;
</code>
</pre>

            <p class="mt-3 text-xs text-zinc-500">
              La balise &lt;abbr&gt; avec attribut title permet aux lecteurs d'accéder à la signification en survolant l'abréviation.
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