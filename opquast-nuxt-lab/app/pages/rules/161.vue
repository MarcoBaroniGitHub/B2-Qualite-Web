<script setup>
import { getRuleById } from '~/data/rules'

const ruleId = 161
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
              Exemples de boutons de fermeture immédiatement disponibles
            </div>

            <!-- Bonne pratique : bouton visible dès l'ouverture -->
            <div class="rounded-xl border border-zinc-800 bg-zinc-950 p-5">
              <div class="text-sm text-zinc-400 mb-3">✓ Bonne pratique : bouton immédiatement visible</div>
              <div class="relative rounded-lg border border-zinc-700 bg-zinc-900 p-6 max-w-md">
                <button class="absolute top-4 right-4 w-8 h-8 flex items-center justify-center rounded hover:bg-zinc-800 text-zinc-400 hover:text-zinc-100 transition">
                  <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                  </svg>
                </button>

                <h3 class="text-lg font-semibold text-zinc-100 mb-2 pr-8">Alerte importante</h3>
                <p class="text-sm text-zinc-300 mb-4">
                  Le bouton de fermeture est visible dès l'apparition de la fenêtre, sans défilement nécessaire.
                </p>
                <button class="px-4 py-2 bg-blue-600 hover:bg-blue-700 text-white text-sm rounded transition">
                  Compris
                </button>
              </div>
            </div>

            <!-- Bonne pratique : notification avec X visible -->
            <div class="rounded-xl border border-zinc-800 bg-zinc-950 p-5">
              <div class="text-sm text-zinc-400 mb-3">✓ Bonne pratique : fermeture toujours accessible</div>
              <div class="relative rounded-lg border border-blue-800 bg-blue-950/30 p-4 max-w-md">
                <button class="absolute top-3 right-3 w-6 h-6 flex items-center justify-center rounded hover:bg-blue-900 text-blue-400 hover:text-blue-200 transition">
                  <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                  </svg>
                </button>
                <div class="pr-8">
                  <div class="text-sm font-medium text-blue-100 mb-1">Information</div>
                  <div class="text-sm text-blue-200">Une mise à jour est disponible pour votre application.</div>
                </div>
              </div>
            </div>

            <!-- Mauvaise pratique : bouton caché ou en bas -->
            <div class="rounded-xl border border-red-900/50 bg-zinc-950 p-5">
              <div class="text-sm text-red-400 mb-3">❌ Mauvaise pratique : bouton non immédiatement visible</div>
              <div class="relative rounded-lg border border-zinc-700 bg-zinc-900 p-6 max-w-md max-h-48 overflow-y-auto">
                <h3 class="text-lg font-semibold text-zinc-100 mb-2">Conditions d'utilisation</h3>
                <p class="text-sm text-zinc-300 mb-4">
                  Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.
                </p>
                <p class="text-sm text-zinc-300 mb-4">
                  Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.
                </p>
                <button class="px-4 py-2 bg-zinc-700 text-zinc-300 text-sm rounded">
                  Fermer (en bas après défilement)
                </button>
              </div>
              <div class="text-xs text-red-400 mt-2">
                ⚠️ L'utilisateur doit défiler pour trouver le bouton de fermeture
              </div>
            </div>

            <div class="mt-6 pt-6 border-t border-zinc-800 text-xs text-zinc-400 space-y-1">
              <div>✓ Le bouton de fermeture est visible dès l'ouverture</div>
              <div>✓ Pas besoin de défiler pour y accéder</div>
              <div>✓ Position fixe dans la fenêtre (généralement en haut)</div>
              <div>✓ Visible même si le contenu de la modale nécessite un défilement</div>
            </div>
          </div>

          <!-- CODE -->
          <div v-else>
            <pre class="rounded-xl bg-zinc-950 p-5 overflow-x-auto text-sm text-zinc-100"><code>&lt;!-- ✅ Bonne pratique : Bouton fixe et visible --&gt;
&lt;div class=&quot;modal&quot; role=&quot;dialog&quot;&gt;
  &lt;!-- Position fixe en haut, toujours visible --&gt;
  &lt;button
    class=&quot;modal-close-fixed&quot;
    aria-label=&quot;Fermer&quot;
  &gt;
    ×
  &lt;/button&gt;

  &lt;div class=&quot;modal-content&quot;&gt;
    &lt;h2&gt;Titre&lt;/h2&gt;
    &lt;!-- Contenu long qui peut défiler --&gt;
    &lt;div class=&quot;modal-body&quot;&gt;
      &lt;p&gt;Contenu...&lt;/p&gt;
    &lt;/div&gt;
  &lt;/div&gt;
&lt;/div&gt;

&lt;!-- ❌ Mauvaise pratique : Bouton après le contenu --&gt;
&lt;div class=&quot;modal&quot;&gt;
  &lt;div class=&quot;modal-content&quot;&gt;
    &lt;h2&gt;Titre&lt;/h2&gt;
    &lt;div class=&quot;modal-body&quot;&gt;
      &lt;!-- Beaucoup de contenu --&gt;
      &lt;p&gt;...&lt;/p&gt;
    &lt;/div&gt;
    &lt;!-- Bouton tout en bas, après défilement --&gt;
    &lt;button&gt;Fermer&lt;/button&gt;
  &lt;/div&gt;
&lt;/div&gt;

&lt;style&gt;
.modal {
  position: fixed;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  max-height: 90vh;
  overflow: hidden;
}

.modal-close-fixed {
  position: absolute;
  top: 1rem;
  right: 1rem;
  z-index: 10;
  /* Toujours visible, même si le contenu défile */
}

.modal-content {
  padding: 3rem 2rem 2rem;
}

.modal-body {
  max-height: 70vh;
  overflow-y: auto;
  /* Le contenu peut défiler */
  /* Mais le bouton reste fixe */
}
&lt;/style&gt;</code></pre>

            <p class="mt-3 text-xs text-zinc-500">
              Les mécanismes de fermeture de fenêtres doivent être immédiatement disponibles et visibles dès l'ouverture, sans nécessiter de défilement. Ils doivent rester accessibles même si le contenu de la fenêtre nécessite un défilement.
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