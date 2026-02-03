<script setup>
import { getRuleById } from '~/data/rules'

const ruleId = 160
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
              Exemples de boutons de fermeture visuellement rattachés à leur contenu
            </div>

            <!-- Modale avec bouton de fermeture bien positionné -->
            <div class="rounded-xl border border-zinc-800 bg-zinc-950 p-5">
              <div class="text-sm text-zinc-400 mb-3">✓ Bonne pratique : bouton dans la modale</div>
              <div class="relative rounded-lg border border-zinc-700 bg-zinc-900 p-6 max-w-md">
                <button class="absolute top-4 right-4 text-zinc-400 hover:text-zinc-100 transition">
                  <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                  </svg>
                </button>

                <h3 class="text-lg font-semibold text-zinc-100 mb-2 pr-8">Confirmation</h3>
                <p class="text-sm text-zinc-300">
                  Êtes-vous sûr de vouloir supprimer cet élément ? Cette action est irréversible.
                </p>
                <div class="mt-4 flex gap-2">
                  <button class="px-4 py-2 bg-red-600 hover:bg-red-700 text-white text-sm rounded transition">
                    Supprimer
                  </button>
                  <button class="px-4 py-2 bg-zinc-700 hover:bg-zinc-600 text-zinc-100 text-sm rounded transition">
                    Annuler
                  </button>
                </div>
              </div>
            </div>

            <!-- Notification avec bouton de fermeture -->
            <div class="rounded-xl border border-zinc-800 bg-zinc-950 p-5">
              <div class="text-sm text-zinc-400 mb-3">✓ Bonne pratique : bouton dans la notification</div>
              <div class="relative rounded-lg border border-green-800 bg-green-950/30 p-4 max-w-md">
                <button class="absolute top-3 right-3 text-green-400 hover:text-green-200 transition">
                  <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                  </svg>
                </button>
                <div class="flex gap-3 pr-6">
                  <div class="text-green-400 text-xl">✓</div>
                  <div>
                    <div class="text-sm font-medium text-green-100">Succès</div>
                    <div class="text-sm text-green-200">Vos modifications ont été enregistrées</div>
                  </div>
                </div>
              </div>
            </div>

            <!-- Mauvaise pratique -->
            <div class="rounded-xl border border-red-900/50 bg-zinc-950 p-5">
              <div class="text-sm text-red-400 mb-3">❌ Mauvaise pratique : bouton éloigné</div>
              <div class="space-y-3">
                <button class="px-3 py-1 bg-zinc-700 text-zinc-300 text-xs rounded">
                  × Fermer
                </button>
                <div class="rounded-lg border border-zinc-700 bg-zinc-900 p-6 max-w-md">
                  <h3 class="text-lg font-semibold text-zinc-100 mb-2">Message important</h3>
                  <p class="text-sm text-zinc-300">
                    Le bouton de fermeture n'est pas clairement associé à cette fenêtre.
                  </p>
                </div>
              </div>
            </div>

            <div class="mt-6 pt-6 border-t border-zinc-800 text-xs text-zinc-400 space-y-1">
              <div>✓ Le bouton de fermeture est placé dans le conteneur de la fenêtre/modale</div>
              <div>✓ Position cohérente (généralement en haut à droite)</div>
              <div>✓ Facilement identifiable visuellement</div>
              <div>✓ Accessible au clavier</div>
            </div>
          </div>

          <!-- CODE -->
          <div v-else>
            <pre class="rounded-xl bg-zinc-950 p-5 overflow-x-auto text-sm text-zinc-100"><code>&lt;!-- ✅ Bonne pratique : Modale avec bouton intégré --&gt;
&lt;div class=&quot;modal&quot; role=&quot;dialog&quot; aria-labelledby=&quot;modal-title&quot;&gt;
  &lt;!-- Bouton dans le conteneur de la modale --&gt;
  &lt;button
    class=&quot;modal-close&quot;
    aria-label=&quot;Fermer la fenêtre&quot;
  &gt;
    ×
  &lt;/button&gt;

  &lt;h2 id=&quot;modal-title&quot;&gt;Confirmation&lt;/h2&gt;
  &lt;p&gt;Êtes-vous sûr de vouloir continuer ?&lt;/p&gt;

  &lt;div class=&quot;modal-actions&quot;&gt;
    &lt;button&gt;Confirmer&lt;/button&gt;
    &lt;button&gt;Annuler&lt;/button&gt;
  &lt;/div&gt;
&lt;/div&gt;

&lt;!-- ✅ Bonne pratique : Notification avec bouton intégré --&gt;
&lt;div class=&quot;notification&quot; role=&quot;alert&quot;&gt;
  &lt;button
    class=&quot;notification-close&quot;
    aria-label=&quot;Fermer la notification&quot;
  &gt;
    ×
  &lt;/button&gt;
  &lt;p&gt;Votre action a été effectuée avec succès&lt;/p&gt;
&lt;/div&gt;

&lt;!-- ❌ Mauvaise pratique : Bouton séparé --&gt;
&lt;button class=&quot;close-button&quot;&gt;Fermer&lt;/button&gt;
&lt;div class=&quot;modal&quot;&gt;
  &lt;!-- Le bouton est en dehors, pas clair qu'il ferme cette modale --&gt;
  &lt;h2&gt;Message&lt;/h2&gt;
  &lt;p&gt;Contenu...&lt;/p&gt;
&lt;/div&gt;

&lt;style&gt;
.modal {
  position: relative;
  padding: 2rem;
  background: white;
  border-radius: 0.5rem;
}

.modal-close {
  position: absolute;
  top: 1rem;
  right: 1rem;
  /* Visuellement rattaché au contenu */
}

.notification {
  position: relative;
  padding: 1rem;
}

.notification-close {
  position: absolute;
  top: 0.75rem;
  right: 0.75rem;
}
&lt;/style&gt;</code></pre>

            <p class="mt-3 text-xs text-zinc-500">
              Les mécanismes de fermeture doivent être visuellement rattachés à leur contenu, généralement en les plaçant à l'intérieur du conteneur de la fenêtre ou de la modale, dans un coin (souvent en haut à droite).
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