<script setup>
import { getRuleById } from '~/data/rules'

const ruleId = 163
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
              Position cohérente des boutons de fermeture sur différentes pages
            </div>

            <!-- Page 1 : modale -->
            <div class="rounded-xl border border-zinc-800 bg-zinc-950 p-5">
              <div class="text-sm text-zinc-400 mb-3">Page 1 : Modale de confirmation</div>
              <div class="relative rounded-lg border border-zinc-700 bg-zinc-900 p-6 max-w-md">
                <button class="absolute top-4 right-4 w-8 h-8 flex items-center justify-center rounded hover:bg-zinc-800 text-zinc-400 hover:text-zinc-100 transition">
                  <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                  </svg>
                </button>
                <h3 class="text-lg font-semibold text-zinc-100 mb-2 pr-8">Supprimer le fichier ?</h3>
                <p class="text-sm text-zinc-300 mb-4">Cette action est irréversible.</p>
                <div class="flex gap-2">
                  <button class="px-4 py-2 bg-red-600 text-white text-sm rounded">Supprimer</button>
                  <button class="px-4 py-2 bg-zinc-700 text-zinc-100 text-sm rounded">Annuler</button>
                </div>
              </div>
              <div class="text-xs text-green-400 mt-2">✓ Bouton en haut à droite</div>
            </div>

            <!-- Page 2 : notification -->
            <div class="rounded-xl border border-zinc-800 bg-zinc-950 p-5">
              <div class="text-sm text-zinc-400 mb-3">Page 2 : Notification</div>
              <div class="relative rounded-lg border border-blue-800 bg-blue-950/30 p-4 max-w-md">
                <button class="absolute top-3 right-3 w-6 h-6 flex items-center justify-center rounded hover:bg-blue-900 text-blue-400 hover:text-blue-200 transition">
                  <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                  </svg>
                </button>
                <div class="pr-8">
                  <div class="text-sm font-medium text-blue-100 mb-1">Mise à jour disponible</div>
                  <div class="text-sm text-blue-200">Une nouvelle version est prête à être installée.</div>
                </div>
              </div>
              <div class="text-xs text-green-400 mt-2">✓ Bouton en haut à droite (cohérent)</div>
            </div>

            <!-- Page 3 : popup -->
            <div class="rounded-xl border border-zinc-800 bg-zinc-950 p-5">
              <div class="text-sm text-zinc-400 mb-3">Page 3 : Popup d'information</div>
              <div class="relative rounded-lg border border-zinc-700 bg-zinc-900 p-6 max-w-md">
                <button class="absolute top-4 right-4 w-8 h-8 flex items-center justify-center rounded hover:bg-zinc-800 text-zinc-400 hover:text-zinc-100 transition">
                  <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                  </svg>
                </button>
                <h3 class="text-lg font-semibold text-zinc-100 mb-2 pr-8">Aide</h3>
                <p class="text-sm text-zinc-300">Consultez notre guide pour plus d'informations.</p>
              </div>
              <div class="text-xs text-green-400 mt-2">✓ Bouton en haut à droite (cohérent)</div>
            </div>

            <!-- Mauvaise pratique -->
            <div class="rounded-xl border border-red-900/50 bg-zinc-950 p-5">
              <div class="text-sm text-red-400 mb-3">❌ Mauvaise pratique : positions incohérentes</div>
              <div class="grid grid-cols-2 gap-3">
                <div class="relative rounded-lg border border-zinc-700 bg-zinc-900 p-4">
                  <button class="absolute top-2 right-2 text-zinc-400 text-xs">×</button>
                  <div class="text-xs text-zinc-300">Bouton en haut à droite</div>
                </div>
                <div class="relative rounded-lg border border-zinc-700 bg-zinc-900 p-4">
                  <button class="absolute top-2 left-2 text-zinc-400 text-xs">×</button>
                  <div class="text-xs text-zinc-300">Bouton en haut à gauche</div>
                </div>
                <div class="relative rounded-lg border border-zinc-700 bg-zinc-900 p-4 pb-8">
                  <div class="text-xs text-zinc-300 mb-2">Contenu</div>
                  <button class="absolute bottom-2 right-2 text-zinc-400 text-xs">Fermer</button>
                </div>
                <div class="relative rounded-lg border border-zinc-700 bg-zinc-900 p-4">
                  <button class="absolute bottom-2 left-2 text-zinc-400 text-xs">Fermer</button>
                  <div class="text-xs text-zinc-300">Bouton en bas à gauche</div>
                </div>
              </div>
              <div class="text-xs text-red-400 mt-2">⚠️ Positions différentes créent de la confusion</div>
            </div>

            <div class="mt-6 pt-6 border-t border-zinc-800 text-xs text-zinc-400 space-y-1">
              <div>✓ Même position sur toutes les pages (généralement en haut à droite)</div>
              <div>✓ Cohérence dans le design et le comportement</div>
              <div>✓ Facilite l'apprentissage et l'utilisation</div>
              <div>✓ Prévisibilité pour les utilisateurs</div>
            </div>
          </div>

          <!-- CODE -->
          <div v-else>
            <pre class="rounded-xl bg-zinc-950 p-5 overflow-x-auto text-sm text-zinc-100"><code>&lt;!-- ✅ Bonne pratique : Position cohérente --&gt;

&lt;!-- Toutes les modales utilisent la même classe --&gt;
&lt;div class=&quot;modal&quot;&gt;
  &lt;button class=&quot;modal-close&quot;&gt;×&lt;/button&gt;
  &lt;!-- Contenu modale 1 --&gt;
&lt;/div&gt;

&lt;div class=&quot;modal&quot;&gt;
  &lt;button class=&quot;modal-close&quot;&gt;×&lt;/button&gt;
  &lt;!-- Contenu modale 2 --&gt;
&lt;/div&gt;

&lt;!-- Toutes les notifications aussi --&gt;
&lt;div class=&quot;notification&quot;&gt;
  &lt;button class=&quot;notification-close&quot;&gt;×&lt;/button&gt;
  &lt;!-- Contenu notification --&gt;
&lt;/div&gt;

&lt;style&gt;
/* Style cohérent pour tous les boutons de fermeture */
.modal-close,
.notification-close,
.popup-close {
  position: absolute;
  top: 1rem;
  right: 1rem;
  /* Toujours au même endroit */
  width: 2rem;
  height: 2rem;
  display: flex;
  align-items: center;
  justify-content: center;
}

.modal-close:hover,
.notification-close:hover,
.popup-close:hover {
  background: rgba(255, 255, 255, 0.1);
  border-radius: 0.25rem;
}
&lt;/style&gt;

&lt;!-- ❌ Mauvaise pratique : Positions différentes --&gt;
&lt;div class=&quot;modal-1&quot;&gt;
  &lt;button style=&quot;position: absolute; top: 10px; right: 10px&quot;&gt;×&lt;/button&gt;
&lt;/div&gt;

&lt;div class=&quot;modal-2&quot;&gt;
  &lt;button style=&quot;position: absolute; top: 10px; left: 10px&quot;&gt;×&lt;/button&gt;
&lt;/div&gt;

&lt;div class=&quot;modal-3&quot;&gt;
  &lt;button style=&quot;position: absolute; bottom: 10px; right: 10px&quot;&gt;Fermer&lt;/button&gt;
&lt;/div&gt;</code></pre>

            <p class="mt-3 text-xs text-zinc-500">
              Les boutons de fermeture doivent être placés au même emplacement sur toutes les pages du site pour créer une expérience cohérente et prévisible. L'emplacement le plus courant est en haut à droite.
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