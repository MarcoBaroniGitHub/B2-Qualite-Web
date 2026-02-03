<script setup>
import { getRuleById } from '~/data/rules'

const ruleId = 169
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

      <p v-else class="mt-3 text-sm text-zinc-300">
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

      <ul class="mt-3 list-disc pl-5 space-y-2 text-sm text-zinc-300">
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

            <div class="hidden text-center px-4">
              <div class="text-sm text-zinc-300 font-medium">
                Screenshot à ajouter
              </div>
              <div class="mt-1 text-xs text-zinc-500">Exemple réel attendu</div>
            </div>
          </div>

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
              Exemple de page de résultats de recherche dont l’URL reflète la requête et peut être partagée.
            </div>

            <!-- Résultats avec URL partageable -->
            <div class="rounded-2xl border border-zinc-800 bg-zinc-950 p-5 space-y-4">
              <div class="text-sm text-zinc-400 mb-2">
                ✓ Bonne pratique : requête en méthode GET, paramètres visibles dans l’URL
              </div>

              <div class="text-xs font-mono bg-zinc-900 border border-zinc-800 rounded px-3 py-2 text-zinc-300 overflow-x-auto">
                https://exemple.com/recherche?q=chaussures+randonnée&amp;tri=prix-asc&amp;page=2
              </div>

              <div class="space-y-2 text-sm text-zinc-300">
                <p>
                  L’utilisateur peut copier cette adresse et l’envoyer à quelqu’un ou l’ajouter à ses favoris : il retrouvera exactement les mêmes résultats.
                </p>
                <button class="px-3 py-1.5 text-xs rounded border border-zinc-700 bg-zinc-900 hover:bg-zinc-800 text-zinc-100">
                  Copier le lien des résultats
                </button>
              </div>
            </div>

            <!-- Mauvaise pratique : URL générique -->
            <div class="rounded-2xl border border-red-900/50 bg-zinc-950 p-5 space-y-3">
              <div class="text-sm text-red-400 mb-1">
                 Mauvaise pratique : URL générique qui ne décrit pas la recherche
              </div>
              <div class="text-xs font-mono bg-zinc-900 border border-zinc-900 rounded px-3 py-2 text-zinc-500 overflow-x-auto">
                https://exemple.com/recherche/resultats
              </div>
              <p class="text-sm text-zinc-300">
                Impossible de retrouver la même liste de résultats : la requête est gérée côté serveur ou en JavaScript sans être reflétée dans l’URL.
              </p>
            </div>

            <div class="mt-6 pt-6 border-t border-zinc-800 text-xs text-zinc-400 space-y-1">
              <div>✓ Utiliser la méthode <code class="text-zinc-300">GET</code> pour le formulaire de recherche.</div>
              <div>✓ Inclure les paramètres significatifs de la recherche dans l’URL (mot‑clé, tri, pagination…).</div>
              <div>✓ Permettre à l’utilisateur de partager ou conserver cette URL.</div>
              <div>✓ Limiter les recherches répétitives, ce qui réduit aussi l’impact énergétique.</div>
            </div>
          </div>

          <!-- CODE -->
          <div v-else>
            <pre class="rounded-xl bg-zinc-950 p-5 overflow-x-auto text-sm text-zinc-100"><code>&lt;!-- ✅ Bonne pratique : recherche en GET avec URL partageable --&gt;
&lt;form
  method=&quot;get&quot;
  action=&quot;/recherche&quot;
  role=&quot;search&quot;
  aria-label=&quot;Recherche sur le site&quot;
&gt;
  &lt;label for=&quot;search-q&quot; class=&quot;sr-only&quot;&gt;Rechercher&lt;/label&gt;
  &lt;input
    id=&quot;search-q&quot;
    type=&quot;search&quot;
    name=&quot;q&quot;
    placeholder=&quot;Rechercher un produit…&quot;
  /&gt;

  &lt;label for=&quot;search-sort&quot; class=&quot;sr-only&quot;&gt;Trier par&lt;/label&gt;
  &lt;select id=&quot;search-sort&quot; name=&quot;tri&quot;&gt;
    &lt;option value=&quot;pertinence&quot;&gt;Pertinence&lt;/option&gt;
    &lt;option value=&quot;prix-asc&quot;&gt;Prix croissant&lt;/option&gt;
    &lt;option value=&quot;prix-desc&quot;&gt;Prix décroissant&lt;/option&gt;
  &lt;/select&gt;

  &lt;button type=&quot;submit&quot;&gt;Rechercher&lt;/button&gt;
&lt;/form&gt;

&lt;!-- Exemple d’URL générée --&gt;
&lt;!--
  https://exemple.com/recherche?q=chaussures+randonnée&amp;tri=prix-asc&amp;page=2
  Cette URL peut être copiée, partagée, ajoutée aux favoris.
--&gt;

&lt;!--  Mauvaise pratique : formulaire en POST avec URL fixe --&gt;
&lt;!--
  &lt;form method=&quot;post&quot; action=&quot;/recherche/resultats&quot;&gt;
    ...
  &lt;/form&gt;

  URL affichée : https://exemple.com/recherche/resultats
  - Aucun paramètre dans l’URL
  - Impossible de retrouver la même recherche
--&gt;

&lt;style&gt;
.sr-only {
  border: 0;
  clip: rect(0 0 0 0);
  height: 1px;
  margin: -1px;
  overflow: hidden;
  padding: 0;
  position: absolute;
  width: 1px;
}
&lt;/style&gt;</code></pre>

            <p class="mt-3 text-xs text-zinc-500">
              Chaque page de résultats de recherche doit être atteignable par une URL stable qui encode la requête (mot‑clé, filtres, tri, page). L’utilisateur peut ainsi la partager ou la garder en signet, évitant de relancer plusieurs fois la même recherche.
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
.scrollbar-light:hover {
  scrollbar-color: #a3a3a3 transparent;
  border-radius: 4px;
}
</style>
