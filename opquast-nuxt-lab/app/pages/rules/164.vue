<script setup>
import { getRuleById } from '~/data/rules'

const ruleId = 164
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
              Exemples de liens d'accès rapide (skip links)
            </div>

            <!-- Bonne pratique : Skip links visibles au focus -->
            <div class="rounded-xl border border-zinc-800 bg-zinc-950 p-5">
              <div class="text-sm text-zinc-400 mb-3">✓ Bonne pratique : liens d'accès rapide au début du code</div>

              <div class="rounded-lg border border-zinc-700 bg-zinc-900 p-4">
                <div class="text-xs text-zinc-500 mb-3">Appuyez sur Tab pour voir les liens d'accès rapide</div>

                <!-- Simulation de skip links -->
                <div class="space-y-2 mb-4">
                  <a href="#main" class="block px-3 py-2 bg-blue-600 text-white text-sm rounded focus:outline-none focus:ring-2 focus:ring-blue-400">
                    Aller au contenu principal
                  </a>
                  <a href="#nav" class="block px-3 py-2 bg-blue-600 text-white text-sm rounded focus:outline-none focus:ring-2 focus:ring-blue-400">
                    Aller à la navigation
                  </a>
                  <a href="#search" class="block px-3 py-2 bg-blue-600 text-white text-sm rounded focus:outline-none focus:ring-2 focus:ring-blue-400">
                    Aller à la recherche
                  </a>
                </div>

                <div class="text-xs text-zinc-400 space-y-1">
                  <div>✓ Placés au tout début du code source</div>
                  <div>✓ Visibles au focus clavier</div>
                  <div>✓ Permettent de sauter les éléments répétitifs</div>
                </div>
              </div>
            </div>

            <!-- Exemple d'utilisation dans une page -->
            <div class="rounded-xl border border-zinc-800 bg-zinc-950 p-5">
              <div class="text-sm text-zinc-400 mb-3">Exemple : structure de page avec skip links</div>

              <div class="rounded-lg border border-zinc-700 bg-zinc-900 p-4 space-y-3">
                <div class="bg-blue-900/30 border border-blue-700 rounded p-2">
                  <div class="text-xs text-blue-300 font-medium">Skip Links (visibles au focus)</div>
                  <div class="text-xs text-blue-400 mt-1">→ Contenu | Navigation | Recherche</div>
                </div>

                <div class="bg-zinc-800 rounded p-2">
                  <div class="text-xs text-zinc-400">Header / Logo / Menu</div>
                </div>

                <div id="main" class="bg-zinc-800 rounded p-2">
                  <div class="text-xs text-zinc-400">Contenu principal (zone #main)</div>
                </div>

                <div class="bg-zinc-800 rounded p-2">
                  <div class="text-xs text-zinc-400">Footer</div>
                </div>
              </div>
            </div>

            <!-- Mauvaise pratique -->
            <div class="rounded-xl border border-red-900/50 bg-zinc-950 p-5">
              <div class="text-sm text-red-400 mb-3">❌ Mauvaise pratique : pas de skip links</div>

              <div class="rounded-lg border border-zinc-700 bg-zinc-900 p-4 space-y-3">
                <div class="bg-zinc-800 rounded p-2">
                  <div class="text-xs text-zinc-400">Header / Logo / Menu (30+ liens)</div>
                </div>

                <div class="bg-zinc-800 rounded p-2">
                  <div class="text-xs text-zinc-400">Sidebar (20+ liens)</div>
                </div>

                <div class="bg-zinc-800 rounded p-2">
                  <div class="text-xs text-zinc-400">Contenu principal</div>
                </div>
              </div>

              <div class="text-xs text-red-400 mt-2">
                ⚠️ L'utilisateur au clavier doit parcourir tous les liens répétitifs
              </div>
            </div>

            <div class="mt-6 pt-6 border-t border-zinc-800 text-xs text-zinc-400 space-y-1">
              <div>✓ Liens placés au tout début du code HTML (avant le header)</div>
              <div>✓ Visibles uniquement au focus clavier (ou toujours visibles)</div>
              <div>✓ Permettent d'accéder directement aux zones principales</div>
              <div>✓ Améliorent l'accessibilité pour les utilisateurs au clavier</div>
            </div>
          </div>

          <!-- CODE -->
          <div v-else>
            <pre class="rounded-xl bg-zinc-950 p-5 overflow-x-auto text-sm text-zinc-100"><code>&lt;!DOCTYPE html&gt;
&lt;html lang=&quot;fr&quot;&gt;
&lt;head&gt;
  &lt;meta charset=&quot;UTF-8&quot;&gt;
  &lt;title&gt;Page avec liens d'accès rapide&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
  &lt;!-- ✅ Skip links au début du code --&gt;
  &lt;a href=&quot;#main&quot; class=&quot;skip-link&quot;&gt;
    Aller au contenu principal
  &lt;/a&gt;
  &lt;a href=&quot;#navigation&quot; class=&quot;skip-link&quot;&gt;
    Aller à la navigation
  &lt;/a&gt;
  &lt;a href=&quot;#search&quot; class=&quot;skip-link&quot;&gt;
    Aller à la recherche
  &lt;/a&gt;

  &lt;header&gt;
    &lt;!-- Header content --&gt;
  &lt;/header&gt;

  &lt;nav id=&quot;navigation&quot;&gt;
    &lt;!-- Navigation --&gt;
  &lt;/nav&gt;

  &lt;main id=&quot;main&quot;&gt;
    &lt;!-- Contenu principal --&gt;
  &lt;/main&gt;

  &lt;footer&gt;
    &lt;!-- Footer --&gt;
  &lt;/footer&gt;
&lt;/body&gt;
&lt;/html&gt;

&lt;!-- CSS pour les skip links --&gt;
&lt;style&gt;
.skip-link {
  position: absolute;
  top: -40px;
  left: 0;
  background: #000;
  color: #fff;
  padding: 8px;
  text-decoration: none;
  z-index: 100;
}

.skip-link:focus {
  top: 0;
  /* Devient visible au focus */
}

/* Alternative : toujours visible */
.skip-link-visible {
  display: block;
  padding: 8px;
  background: #0066cc;
  color: white;
  text-align: center;
}
&lt;/style&gt;</code></pre>

            <p class="mt-3 text-xs text-zinc-500">
              Les liens d'accès rapide (skip links) doivent être placés au tout début du code source, avant le header. Ils permettent aux utilisateurs naviguant au clavier de sauter directement aux zones principales du contenu sans avoir à parcourir tous les liens de navigation.
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