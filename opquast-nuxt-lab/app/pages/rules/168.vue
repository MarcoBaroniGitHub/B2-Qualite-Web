<script setup>
import { getRuleById } from '~/data/rules'

const ruleId = 168
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
              Exemple de moteur de recherche interne accessible et bien positionné dans l’interface.
            </div>

            <!-- Barre de recherche en en-tête -->
            <div class="rounded-2xl border border-zinc-800 bg-zinc-950 p-5 space-y-4">
              <div class="text-sm text-zinc-400 mb-2">✓ Bonne pratique : moteur de recherche présent sur toutes les pages principales</div>

              <header class="flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
                <div>
                  <div class="text-xs uppercase tracking-wide text-zinc-500">
                    Exemple de site
                  </div>
                  <h2 class="text-lg font-semibold text-zinc-100">
                    En‑tête avec moteur de recherche
                  </h2>
                </div>

                <form class="w-full sm:w-80" role="search" aria-label="Recherche sur le site">
                  <label class="sr-only" for="site-search">Rechercher</label>
                  <div class="relative">
                    <span class="absolute inset-y-0 left-3 flex items-center text-zinc-500">
                      
                    </span>
                    <input
                        id="site-search"
                        type="search"
                        name="q"
                        placeholder="Rechercher un contenu, un service…"
                        class="w-full bg-zinc-950 border border-zinc-700 rounded-full pl-9 pr-28 py-2 text-sm text-zinc-100 placeholder-zinc-500 focus:outline-none focus:border-blue-500"
                    />
                    <button
                        type="submit"
                        class="absolute inset-y-1.5 right-1.5 px-3 rounded-full bg-blue-600 hover:bg-blue-700 text-xs font-medium text-white transition"
                    >
                      Rechercher
                    </button>
                  </div>
                  <p class="mt-1 text-xs text-zinc-500">
                    Astuce : proposez le moteur de recherche dès l’en‑tête pour faciliter la réorientation.
                  </p>
                </form>
              </header>
            </div>

            <!-- Mauvaise pratique : pas de moteur de recherche -->
            <div class="rounded-2xl border border-red-900/50 bg-zinc-950 p-5 space-y-3">
              <div class="text-sm text-red-400 mb-1"> Mauvaise pratique : aucune solution de recherche interne</div>
              <p class="text-sm text-zinc-300">
                Le site ne propose ni moteur de recherche interne ni autre solution de recherche claire. Les utilisateurs doivent parcourir de nombreux menus pour trouver une information simple.
              </p>
            </div>

            <div class="mt-6 pt-6 border-t border-zinc-800 text-xs text-zinc-400 space-y-1">
              <div>✓ Le moteur de recherche est présent de manière cohérente sur les pages clés.</div>
              <div>✓ Le formulaire utilise un champ de type <code class="text-zinc-300">search</code> et un bouton clairement identifiable.</div>
              <div>✓ Le formulaire est accessible au clavier et aux technologies d’assistance (attributs ARIA, label explicite).</div>
              <div>✓ Le moteur de recherche limite les allers‑retours inutiles et réduit le nombre de pages consultées.</div>
            </div>
          </div>

          <!-- CODE -->
          <div v-else>
            <pre class="rounded-xl bg-zinc-950 p-5 overflow-x-auto text-sm text-zinc-100"><code>&lt;!-- ✅ Bonne pratique : moteur de recherche interne --&gt;
&lt;header class=&quot;site-header&quot;&gt;
  &lt;div class=&quot;brand&quot;&gt;
    &lt;p class=&quot;site-title&quot;&gt;Exemple de site&lt;/p&gt;
  &lt;/div&gt;

  &lt;form role=&quot;search&quot; aria-label=&quot;Recherche sur le site&quot;&gt;
    &lt;label class=&quot;sr-only&quot; for=&quot;site-search&quot;&gt;Rechercher&lt;/label&gt;
    &lt;div class=&quot;search-wrapper&quot;&gt;
      &lt;input
        id=&quot;site-search&quot;
        type=&quot;search&quot;
        name=&quot;q&quot;
        placeholder=&quot;Rechercher un contenu, un service…&quot;
        autocomplete=&quot;off&quot;
      /&gt;
      &lt;button type=&quot;submit&quot;&gt;Rechercher&lt;/button&gt;
    &lt;/div&gt;
  &lt;/form&gt;
&lt;/header&gt;

&lt;!--  Mauvaise pratique : aucune recherche --&gt;
&lt;!--
  Le site ne propose pas de moteur de recherche :
  - navigation obligatoire via les menus
  - perte de temps pour les utilisateurs
  - difficultés accrues pour les personnes handicapées
--&gt;

&lt;style&gt;
.site-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 1rem;
}

.search-wrapper {
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.search-wrapper input[type=&quot;search&quot;] {
  min-width: 14rem;
}

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
              Un moteur de recherche interne bien placé complète le plan du site, les menus et les liens de retour à l’accueil. Il permet un accès rapide à l’information, améliore l’accessibilité et limite le nombre de pages à parcourir, ce qui réduit également l’impact environnemental.
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
