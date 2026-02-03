<script setup>
import { getRuleById } from '~/data/rules'

const ruleId = 54
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
              Exemple de fiche technique visible avant l'ajout au panier
              (logiciel ou jeu).
            </div>

            <div class="rounded-xl border border-zinc-800 bg-zinc-950 p-6">
              <h3
                class="flex items-center gap-2 text-base font-semibold text-zinc-100 mb-5"
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
                    d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z"
                  />
                  <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    stroke-width="2"
                    d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"
                  />
                </svg>
                Configuration requise
              </h3>

              <div class="grid gap-4 sm:grid-cols-2">
                <div class="rounded bg-zinc-900/40 p-3">
                  <div
                    class="text-xs font-medium text-zinc-500 uppercase tracking-wider mb-1"
                  >
                    Système
                  </div>
                  <div class="text-sm text-zinc-200">
                    Windows 10 (64-bit) ou macOS 12+
                  </div>
                </div>

                <div class="rounded bg-zinc-900/40 p-3">
                  <div
                    class="text-xs font-medium text-zinc-500 uppercase tracking-wider mb-1"
                  >
                    Espace Disque
                  </div>
                  <div class="text-sm text-zinc-200">
                    20 Go d'espace disponible
                  </div>
                </div>

                <div class="rounded bg-zinc-900/40 p-3">
                  <div
                    class="text-xs font-medium text-zinc-500 uppercase tracking-wider mb-1"
                  >
                    Mémoire (RAM)
                  </div>
                  <div class="text-sm text-zinc-200">
                    8 Go minimum (16 Go recommandés)
                  </div>
                </div>

                <div class="rounded bg-zinc-900/40 p-3">
                  <div
                    class="text-xs font-medium text-zinc-500 uppercase tracking-wider mb-1"
                  >
                    Connexion
                  </div>
                  <div class="text-sm text-zinc-200">
                    Internet haut débit requis
                  </div>
                </div>
              </div>

              <div
                class="mt-4 flex gap-3 items-start border-l-2 border-yellow-500/50 bg-yellow-500/5 pl-3 py-2 pr-2"
              >
                <svg
                  width="16"
                  height="16"
                  class="h-4 w-4 text-yellow-500 shrink-0 mt-0.5"
                  fill="none"
                  viewBox="0 0 24 24"
                  stroke="currentColor"
                >
                  <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    stroke-width="2"
                    d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"
                  />
                </svg>
                <div class="text-xs text-yellow-200/90">
                  <strong>Attention :</strong> Ce logiciel nécessite une carte
                  graphique compatible DirectX 12.
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
&lt;div class=&quot;rounded-xl border border-zinc-800 bg-zinc-950 p-6&quot;&gt;
  &lt;h3 class=&quot;mb-5 flex items-center gap-2 text-base font-semibold text-zinc-100&quot;&gt;
    &lt;!-- Icone Gear --&gt;
    Configuration requise
  &lt;/h3&gt;

  &lt;div class=&quot;grid gap-4 sm:grid-cols-2&quot;&gt;
    &lt;!-- Item Système --&gt;
    &lt;div class=&quot;rounded bg-zinc-900/40 p-3&quot;&gt;
      &lt;div class=&quot;text-xs font-medium text-zinc-500 uppercase mb-1&quot;&gt;Système&lt;/div&gt;
      &lt;div class=&quot;text-sm text-zinc-200&quot;&gt;Windows 10 (64-bit) ou macOS 12+&lt;/div&gt;
    &lt;/div&gt;

    &lt;!-- Item Stockage --&gt;
    &lt;div class=&quot;rounded bg-zinc-900/40 p-3&quot;&gt;
      &lt;div class=&quot;text-xs font-medium text-zinc-500 uppercase mb-1&quot;&gt;Espace Disque&lt;/div&gt;
      &lt;div class=&quot;text-sm text-zinc-200&quot;&gt;20 Go d'espace disponible&lt;/div&gt;
    &lt;/div&gt;
    
    &lt;!-- Item RAM --&gt;
    &lt;div class=&quot;rounded bg-zinc-900/40 p-3&quot;&gt;
      &lt;div class=&quot;text-xs font-medium text-zinc-500 uppercase mb-1&quot;&gt;Mémoire (RAM)&lt;/div&gt;
      &lt;div class=&quot;text-sm text-zinc-200&quot;&gt;8 Go minimum&lt;/div&gt;
    &lt;/div&gt;
  &lt;/div&gt;

  &lt;!-- Warning important --&gt;
  &lt;div class=&quot;mt-4 border-l-2 border-yellow-500/50 bg-yellow-500/5 p-2 text-xs text-yellow-200&quot;&gt;
    &lt;strong&gt;Attention :&lt;/strong&gt; Carte graphique compatible DirectX 12 requise.
  &lt;/div&gt;
&lt;/div&gt;
</code>
  </pre>

            <p class="mt-3 text-xs text-zinc-500">
              L'objectif est d'éviter l'achat d'un produit inutilisable par le
              client faute d'équipement compatible.
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
