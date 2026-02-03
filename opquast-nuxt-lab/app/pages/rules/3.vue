<script setup>
import { getRuleById } from '~/data/rules'

const ruleId = 3
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

      <p v-if="rule.implementationIntro" class="mt-3 text-sm text-zinc-300">
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
              Exemple de métadonnée description dans le code source
            </div>

            <div class="rounded-xl border border-zinc-800 bg-zinc-950 p-5">
              <div class="space-y-3 font-mono text-xs">
                <div class="text-zinc-500">&lt;head&gt;</div>
                
                <div class="pl-4 space-y-2">
                  <div class="text-zinc-400">
                    &lt;title&gt;<span class="text-zinc-200">Guide complet SEO et accessibilité web</span>&lt;/title&gt;
                  </div>

                  <div class="text-zinc-400">
                    &lt;meta name=<span class="text-yellow-300">"description"</span> content=<span class="text-green-300">"Découvrez les meilleures pratiques pour améliorer la qualité, l'accessibilité et le SEO de votre site web. Guide complet avec 7 règles essentielles."</span>/&gt;
                  </div>

                  <div class="text-zinc-400">
                    &lt;meta name=<span class="text-yellow-300">"viewport"</span> content=<span class="text-green-300">"width=device-width, initial-scale=1"</span>/&gt;
                  </div>
                </div>

                <div class="text-zinc-500">&lt;/head&gt;</div>
              </div>
            </div>

            <div class="rounded-lg bg-zinc-900/50 p-3 border border-zinc-800">
              <p class="text-xs text-zinc-400">
                Cette description apparaît dans les résultats de recherche Google et aide les moteurs de recherche à comprendre le contenu de la page.
              </p>
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
    Exemple de métadonnée description dans le code source
  &lt;/div&gt;

  &lt;div class=&quot;rounded-xl border border-zinc-800 bg-zinc-950 p-5&quot;&gt;
    &lt;div class=&quot;space-y-3 font-mono text-xs&quot;&gt;
      &lt;div class=&quot;text-zinc-500&quot;&gt;&amp;lt;head&amp;gt;&lt;/div&gt;
      
      &lt;div class=&quot;pl-4 space-y-2&quot;&gt;
        &lt;div class=&quot;text-zinc-400&quot;&gt;
          &amp;lt;title&amp;gt;&lt;span class=&quot;text-zinc-200&quot;&gt;Guide complet SEO et accessibilité web&lt;/span&gt;&amp;lt;/title&amp;gt;
        &lt;/div&gt;

        &lt;div class=&quot;text-zinc-400&quot;&gt;
          &amp;lt;meta name=&lt;span class=&quot;text-yellow-300&quot;&gt;&quot;description&quot;&lt;/span&gt; content=&lt;span class=&quot;text-green-300&quot;&gt;&quot;Découvrez les meilleures pratiques pour améliorer la qualité, l'accessibilité et le SEO de votre site web. Guide complet avec 7 règles essentielles.&quot;&lt;/span&gt;/&amp;gt;
        &lt;/div&gt;

        &lt;div class=&quot;text-zinc-400&quot;&gt;
          &amp;lt;meta name=&lt;span class=&quot;text-yellow-300&quot;&gt;&quot;viewport&quot;&lt;/span&gt; content=&lt;span class=&quot;text-green-300&quot;&gt;&quot;width=device-width, initial-scale=1&quot;&lt;/span&gt;/&amp;gt;
        &lt;/div&gt;
      &lt;/div&gt;

      &lt;div class=&quot;text-zinc-500&quot;&gt;&amp;lt;/head&amp;gt;&lt;/div&gt;
    &lt;/div&gt;
  &lt;/div&gt;

  &lt;div class=&quot;rounded-lg bg-zinc-900/50 p-3 border border-zinc-800&quot;&gt;
    &lt;p class=&quot;text-xs text-zinc-400&quot;&gt;
      Cette description apparaît dans les résultats de recherche Google et aide les moteurs de recherche à comprendre le contenu de la page.
    &lt;/p&gt;
  &lt;/div&gt;
&lt;/div&gt;
</code>
</pre>

            <p class="mt-3 text-xs text-zinc-500">
              La métadonnée description doit être concise (155 caractères max) et décrire précisément le contenu de la page.
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