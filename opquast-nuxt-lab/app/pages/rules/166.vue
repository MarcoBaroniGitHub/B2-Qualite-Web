<script setup>
import { getRuleById } from '~/data/rules'

const ruleId = 166
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
              Exemples d'interfaces entièrement accessibles au clavier
            </div>

            <!-- Bonne pratique : tous les éléments interactifs -->
            <div class="rounded-xl border border-zinc-800 bg-zinc-950 p-5">
              <div class="text-sm text-zinc-400 mb-3">✓ Bonne pratique : navigation complète au clavier</div>

              <div class="rounded-lg border border-zinc-700 bg-zinc-900 p-4 space-y-4">
                <div class="text-xs text-zinc-500 mb-2">Utilisez Tab, Entrée, Espace et les flèches</div>

                <!-- Boutons -->
                <div class="space-y-2">
                  <button class="px-4 py-2 bg-blue-600 hover:bg-blue-700 text-white text-sm rounded transition focus:outline-none focus:ring-2 focus:ring-blue-400">
                    Bouton cliquable (Entrée/Espace)
                  </button>
                </div>

                <!-- Liens -->
                <div class="space-y-2">
                  <a href="#" class="inline-block text-blue-400 hover:text-blue-300 focus:outline-none focus:ring-2 focus:ring-blue-400 rounded px-1">
                    Lien activable (Entrée)
                  </a>
                </div>

                <!-- Champs de formulaire -->
                <div class="space-y-2">
                  <input
                      type="text"
                      placeholder="Champ texte"
                      class="w-full bg-zinc-950 border border-zinc-700 rounded px-3 py-2 text-sm text-zinc-100 focus:outline-none focus:border-blue-500"
                  />

                  <select class="w-full bg-zinc-950 border border-zinc-700 rounded px-3 py-2 text-sm text-zinc-100 focus:outline-none focus:border-blue-500">
                    <option>Option 1</option>
                    <option>Option 2</option>
                  </select>

                  <label class="flex items-center gap-2 text-sm text-zinc-300">
                    <input type="checkbox" class="focus:outline-none focus:ring-2 focus:ring-blue-400" />
                    Case à cocher (Espace)
                  </label>
                </div>

                <!-- Menu déroulant -->
                <div class="relative">
                  <button class="px-4 py-2 bg-zinc-700 hover:bg-zinc-600 text-zinc-100 text-sm rounded transition focus:outline-none focus:ring-2 focus:ring-zinc-400">
                    Menu ▼
                  </button>
                </div>

                <div class="text-xs text-green-400 mt-3">
                  ✓ Tous les éléments sont accessibles avec Tab
                  <br/>✓ Toutes les actions sont réalisables au clavier
                </div>
              </div>
            </div>

            <!-- Mauvaise pratique : div cliquable non accessible -->
            <div class="rounded-xl border border-red-900/50 bg-zinc-950 p-5">
              <div class="text-sm text-red-400 mb-3">❌ Mauvaise pratique : div cliquable sans tabindex</div>

              <div class="rounded-lg border border-zinc-700 bg-zinc-900 p-4 space-y-3">
                <div class="px-4 py-2 bg-blue-900/30 border border-blue-700 text-blue-200 text-sm rounded cursor-pointer hover:bg-blue-900/50">
                  Div cliquable (non accessible au clavier)
                </div>

                <div class="text-xs text-red-400">
                  ⚠️ Impossible de sélectionner avec Tab
                  <br/>⚠️ Pas d'action possible au clavier
                </div>
              </div>
            </div>

            <!-- Exemple correct de composant personnalisé -->
            <div class="rounded-xl border border-zinc-800 bg-zinc-950 p-5">
              <div class="text-sm text-zinc-400 mb-3">✓ Composant personnalisé accessible</div>

              <div class="rounded-lg border border-zinc-700 bg-zinc-900 p-4">
                <div
                    tabindex="0"
                    role="button"
                    class="px-4 py-2 bg-green-600 hover:bg-green-700 text-white text-sm rounded transition focus:outline-none focus:ring-2 focus:ring-green-400 cursor-pointer"
                >
                  Div avec tabindex et role
                </div>

                <div class="text-xs text-green-400 mt-2">
                  ✓ tabindex="0" pour le rendre focusable
                  <br/>✓ role="button" pour la sémantique
                  <br/>✓ Gestion des événements clavier (Entrée/Espace)
                </div>
              </div>
            </div>

            <div class="mt-6 pt-6 border-t border-zinc-800 text-xs text-zinc-400 space-y-1">
              <div>✓ Tous les éléments interactifs accessibles avec Tab</div>
              <div>✓ Toutes les actions réalisables au clavier (Entrée, Espace, flèches)</div>
              <div>✓ Utiliser des éléments HTML natifs quand possible</div>
              <div>✓ Ajouter tabindex="0" et les rôles ARIA si nécessaire</div>
            </div>
          </div>

          <!-- CODE -->
          <div v-else>
            <pre class="rounded-xl bg-zinc-950 p-5 overflow-x-auto text-sm text-zinc-100"><code>&lt;!-- ✅ Bonne pratique : Éléments natifs --&gt;
&lt;button&gt;Bouton natif&lt;/button&gt;
&lt;a href=&quot;#&quot;&gt;Lien natif&lt;/a&gt;
&lt;input type=&quot;text&quot;&gt;
&lt;select&gt;...&lt;/select&gt;
&lt;!-- Tous accessibles automatiquement --&gt;

&lt;!-- ✅ Composant personnalisé accessible --&gt;
&lt;div
  tabindex=&quot;0&quot;
  role=&quot;button&quot;
  aria-label=&quot;Ouvrir le menu&quot;
  onclick=&quot;handleClick()&quot;
  onkeydown=&quot;handleKeyDown(event)&quot;
  class=&quot;custom-button&quot;
&gt;
  Cliquez-moi
&lt;/div&gt;

&lt;script&gt;
function handleKeyDown(event) {
  // Gérer Entrée et Espace
  if (event.key === 'Enter' || event.key === ' ') {
    event.preventDefault();
    handleClick();
  }
}

function handleClick() {
  // Action du bouton
  console.log('Clicked');
}
&lt;/script&gt;

&lt;!-- ❌ Mauvaise pratique : Div non accessible --&gt;
&lt;div onclick=&quot;doSomething()&quot; class=&quot;clickable&quot;&gt;
  Cliquez-moi
&lt;/div&gt;
&lt;!-- Problèmes :
  - Pas de tabindex (pas focusable)
  - Pas de role
  - Pas de gestion clavier
--&gt;

&lt;!-- ✅ Menu accessible au clavier --&gt;
&lt;nav role=&quot;navigation&quot;&gt;
  &lt;ul role=&quot;menubar&quot;&gt;
    &lt;li role=&quot;none&quot;&gt;
      &lt;a href=&quot;#&quot; role=&quot;menuitem&quot;&gt;Accueil&lt;/a&gt;
    &lt;/li&gt;
    &lt;li role=&quot;none&quot;&gt;
      &lt;button
        role=&quot;menuitem&quot;
        aria-haspopup=&quot;true&quot;
        aria-expanded=&quot;false&quot;
      &gt;
        Services
      &lt;/button&gt;
      &lt;ul role=&quot;menu&quot; aria-label=&quot;Services&quot;&gt;
        &lt;li role=&quot;none&quot;&gt;
          &lt;a href=&quot;#&quot; role=&quot;menuitem&quot;&gt;Service 1&lt;/a&gt;
        &lt;/li&gt;
      &lt;/ul&gt;
    &lt;/li&gt;
  &lt;/ul&gt;
&lt;/nav&gt;

&lt;!-- ✅ Slider accessible --&gt;
&lt;div
  role=&quot;slider&quot;
  aria-valuemin=&quot;0&quot;
  aria-valuemax=&quot;100&quot;
  aria-valuenow=&quot;50&quot;
  aria-label=&quot;Volume&quot;
  tabindex=&quot;0&quot;
  onkeydown=&quot;handleSliderKeys(event)&quot;
&gt;&lt;/div&gt;

&lt;script&gt;
function handleSliderKeys(event) {
  // Flèches gauche/droite pour ajuster
  if (event.key === 'ArrowLeft') {
    decreaseValue();
  } else if (event.key === 'ArrowRight') {
    increaseValue();
  }
}
&lt;/script&gt;</code></pre>

            <p class="mt-3 text-xs text-zinc-500">
              La navigation au clavier doit permettre d'interagir avec l'intégralité des contenus et services. Tous les éléments interactifs doivent être accessibles avec Tab et activables au clavier (Entrée, Espace, flèches). Privilégiez les éléments HTML natifs et ajoutez tabindex, rôles ARIA et gestion d'événements clavier pour les composants personnalisés.
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