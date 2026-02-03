<script setup>
import { getRuleById } from '~/data/rules'

const ruleId = 158
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

      <ul class="mt-3 list-disc pl-5 space-y-2 text-sm text-zinc-300">
        <li v-for="o in rule.objectives" :key="o">{{ o }}</li>
      </ul>
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
                :src="`/screenshots/rule-${rule.id}/screenshot-${index + 1}.png`"
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
          <div v-if="activeTab === 'preview'" class="space-y-6">
            <div class="text-sm text-zinc-400">
              Comparaison de la cohérence de placement de la navigation entre pages
            </div>

            <!-- Bonne pratique -->
            <div class="space-y-2">
              <div class="text-xs font-medium text-green-400">✅ Bonne pratique : Navigation constante</div>
              <div class="grid grid-cols-2 gap-4">
                <div class="rounded-xl border border-green-900/50 bg-zinc-950 p-3">
                  <div class="text-xs text-zinc-500 mb-2">Page Accueil</div>
                  <header class="bg-zinc-900 p-2 rounded mb-2">
                    <nav class="flex gap-2 text-xs text-zinc-400">
                      <span class="text-blue-400">Logo</span>
                      <span>Menu</span>
                      <span>Contact</span>
                    </nav>
                  </header>
                  <div class="h-12 bg-zinc-900/50 rounded flex items-center justify-center text-xs text-zinc-500">Contenu</div>
                </div>
                <div class="rounded-xl border border-green-900/50 bg-zinc-950 p-3">
                  <div class="text-xs text-zinc-500 mb-2">Page Produit</div>
                  <header class="bg-zinc-900 p-2 rounded mb-2">
                    <nav class="flex gap-2 text-xs text-zinc-400">
                      <span class="text-blue-400">Logo</span>
                      <span>Menu</span>
                      <span>Contact</span>
                    </nav>
                  </header>
                  <div class="h-12 bg-zinc-900/50 rounded flex items-center justify-center text-xs text-zinc-500">Contenu</div>
                </div>
              </div>
              <p class="text-xs text-zinc-400">Le header reste identique sur toutes les pages</p>
            </div>

            <!-- Mauvaise pratique -->
            <div class="space-y-2">
              <div class="text-xs font-medium text-red-400">❌ Mauvaise pratique : Navigation instable</div>
              <div class="grid grid-cols-2 gap-4">
                <div class="rounded-xl border border-red-900/50 bg-zinc-950 p-3">
                  <div class="text-xs text-zinc-500 mb-2">Page Accueil</div>
                  <header class="bg-zinc-900 p-2 rounded mb-2">
                    <nav class="flex gap-2 text-xs text-zinc-400">
                      <span>Logo</span>
                      <span>Menu</span>
                    </nav>
                  </header>
                  <div class="h-12 bg-zinc-900/50 rounded"></div>
                </div>
                <div class="rounded-xl border border-red-900/50 bg-zinc-950 p-3">
                  <div class="text-xs text-zinc-500 mb-2">Page Produit</div>
                  <div class="flex">
                    <aside class="bg-zinc-900 p-2 rounded mr-2 w-16">
                      <nav class="flex flex-col gap-1 text-xs text-zinc-400">
                        <span>Logo</span>
                        <span>Menu</span>
                      </nav>
                    </aside>
                    <div class="flex-1 h-16 bg-zinc-900/50 rounded"></div>
                  </div>
                </div>
              </div>
              <p class="text-xs text-zinc-500">Le menu change de position entre les pages !</p>
            </div>
          </div>

          <!-- CODE -->
          <div v-else class="space-y-4">
            <div>
              <div class="text-xs font-medium text-red-400 mb-2">❌ À ne pas faire (Positionnement variable via CSS) :</div>
              <pre class="rounded-xl bg-zinc-950 p-5 overflow-x-auto text-sm text-zinc-100"><code>/* Page A : Menu en haut */
.header { position: static; }

/* Page B : Le menu devient latéral sans raison */
.header { position: fixed; left: 0; width: 200px; }</code></pre>
            </div>

            <div>
              <div class="text-xs font-medium text-green-400 mb-2">✅ À privilégier (Structure de template fixe) :</div>
              <pre class="rounded-xl bg-zinc-950 p-5 overflow-x-auto text-sm text-zinc-100"><code>&lt;!-- Utilisation d'un template unique pour tout le site --&gt;
&lt;div id="layout"&gt;
    &lt;header&gt; &lt;!-- Toujours en haut --&gt;
        &lt;nav&gt;...&lt;/nav&gt;
    &lt;/header&gt;
    &lt;main&gt;Contenu variable&lt;/main&gt;
    &lt;footer&gt;...&lt;/footer&gt;
&lt;/div&gt;</code></pre>
            </div>

            <p class="text-xs text-zinc-500">
              Utilisez un layout/template unique pour garantir la cohérence de la navigation sur toutes les pages.
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
