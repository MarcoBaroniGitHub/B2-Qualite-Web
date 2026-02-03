<script setup>
import { getRuleById } from '~/data/rules'

const ruleId = 171
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
              Exemple de plan de site clair, accessible et atteignable depuis chaque page via un lien constant.
            </div>

            <!-- Lien plan du site dans le pied de page -->
            <div class="rounded-2xl border border-zinc-800 bg-zinc-950 p-5 space-y-4">
              <div class="text-sm text-zinc-400 mb-2">
                ✓ Bonne pratique : lien « Plan du site » présent dans le pied de page de toutes les pages
              </div>

              <footer class="border-t border-zinc-800 pt-4 flex flex-wrap items-center gap-4 text-sm text-zinc-400">
                <nav aria-label="Liens utilitaires">
                  <ul class="flex flex-wrap gap-4">
                    <li><a href="/plan-du-site" class="text-zinc-100 hover:text-zinc-50 underline underline-offset-4">Plan du site</a></li>
                    <li><a href="/accessibilite" class="hover:text-zinc-200">Accessibilité</a></li>
                    <li><a href="/mentions-legales" class="hover:text-zinc-200">Mentions légales</a></li>
                    <li><a href="/contact" class="hover:text-zinc-200">Contact</a></li>
                  </ul>
                </nav>
              </footer>

              <p class="text-xs text-zinc-500">
                Le lien reste au même endroit sur tout le site et est particulièrement utile dans les pages d’erreur (404, 403).
              </p>
            </div>

            <!-- Page de plan du site -->
            <div class="rounded-2xl border border-zinc-800 bg-zinc-950 p-5 space-y-4">
              <div class="text-sm text-zinc-400 mb-2">
                ✓ Bonne pratique : page de plan de site structurée en titres et listes imbriquées
              </div>

              <section aria-labelledby="sitemap-title" class="space-y-3 text-sm text-zinc-200">
                <h2 id="sitemap-title" class="text-lg font-semibold text-zinc-50">
                  Plan du site
                </h2>
                <p class="text-xs text-zinc-500">
                  Utilisez ce plan pour visualiser l’organisation du site et accéder rapidement aux principales rubriques.
                </p>

                <nav aria-label="Plan du site">
                  <ul class="space-y-2">
                    <li>
                      <a href="/" class="hover:underline">Accueil</a>
                    </li>
                    <li>
                      <h3 class="text-sm font-semibold text-zinc-100 mt-2">Produits</h3>
                      <ul class="ml-4 list-disc space-y-1">
                        <li><a href="/produits/ordinateurs" class="hover:underline">Ordinateurs</a></li>
                        <li><a href="/produits/smartphones" class="hover:underline">Smartphones</a></li>
                        <li><a href="/produits/accessoires" class="hover:underline">Accessoires</a></li>
                      </ul>
                    </li>
                    <li>
                      <h3 class="text-sm font-semibold text-zinc-100 mt-2">Services</h3>
                      <ul class="ml-4 list-disc space-y-1">
                        <li><a href="/services/livraison" class="hover:underline">Livraison</a></li>
                        <li><a href="/services/sav" class="hover:underline">SAV</a></li>
                      </ul>
                    </li>
                    <li>
                      <h3 class="text-sm font-semibold text-zinc-100 mt-2">À propos</h3>
                      <ul class="ml-4 list-disc space-y-1">
                        <li><a href="/a-propos" class="hover:underline">Notre histoire</a></li>
                        <li><a href="/a-propos/equipe" class="hover:underline">L’équipe</a></li>
                      </ul>
                    </li>
                    <li>
                      <h3 class="text-sm font-semibold text-zinc-100 mt-2">Pages satellites</h3>
                      <ul class="ml-4 list-disc space-y-1">
                        <li><a href="/contact" class="hover:underline">Contact</a></li>
                        <li><a href="/mentions-legales" class="hover:underline">Mentions légales</a></li>
                        <li><a href="/politique-confidentialite" class="hover:underline">Politique de confidentialité</a></li>
                      </ul>
                    </li>
                  </ul>
                </nav>
              </section>
            </div>

            <!-- Mauvaise pratique -->
            <div class="rounded-2xl border border-red-900/50 bg-zinc-950 p-5 space-y-3">
              <div class="text-sm text-red-400 mb-1">
                 Mauvaise pratique : aucun plan du site, ni lien pour s’y rendre
              </div>
              <p class="text-sm text-zinc-300">
                L’utilisateur désorienté ne dispose ni de plan global, ni de solution simple pour comprendre l’étendue du site et retrouver une rubrique.
              </p>
            </div>

            <div class="mt-6 pt-6 border-t border-zinc-800 text-xs text-zinc-400 space-y-1">
              <div>✓ Proposer une page de plan du site listant les principales pages et rubriques.</div>
              <div>✓ Structurer le plan avec des titres et des listes imbriquées pour refléter l’arborescence.</div>
              <div>✓ Afficher un lien « Plan du site » depuis chaque page, idéalement à un emplacement constant (souvent en pied de page).</div>
              <div>✓ Inclure les pages satellites importantes (Contact, mentions légales, etc.).</div>
            </div>
          </div>

          <!-- CODE -->
          <div v-else>
            <pre class="rounded-xl bg-zinc-950 p-5 overflow-x-auto text-sm text-zinc-100"><code>&lt;!-- ✅ Lien vers le plan du site dans le pied de page --&gt;
&lt;footer&gt;
  &lt;nav aria-label=&quot;Liens utilitaires&quot;&gt;
    &lt;ul&gt;
      &lt;li&gt;&lt;a href=&quot;/plan-du-site&quot;&gt;Plan du site&lt;/a&gt;&lt;/li&gt;
      &lt;li&gt;&lt;a href=&quot;/mentions-legales&quot;&gt;Mentions légales&lt;/a&gt;&lt;/li&gt;
      &lt;li&gt;&lt;a href=&quot;/contact&quot;&gt;Contact&lt;/a&gt;&lt;/li&gt;
    &lt;/ul&gt;
  &lt;/nav&gt;
&lt;/footer&gt;

&lt;!--  Page de plan du site structurée --&gt;
&lt;main&gt;
  &lt;h1&gt;Plan du site&lt;/h1&gt;

  &lt;nav aria-label=&quot;Plan du site&quot;&gt;
    &lt;ul&gt;
      &lt;li&gt;&lt;a href=&quot;/&quot;&gt;Accueil&lt;/a&gt;&lt;/li&gt;
      &lt;li&gt;
        &lt;h2&gt;Produits&lt;/h2&gt;
        &lt;ul&gt;
          &lt;li&gt;&lt;a href=&quot;/produits/ordinateurs&quot;&gt;Ordinateurs&lt;/a&gt;&lt;/li&gt;
          &lt;li&gt;&lt;a href=&quot;/produits/smartphones&quot;&gt;Smartphones&lt;/a&gt;&lt;/li&gt;
        &lt;/ul&gt;
      &lt;/li&gt;
      &lt;li&gt;
        &lt;h2&gt;Services&lt;/h2&gt;
        &lt;ul&gt;
          &lt;li&gt;&lt;a href=&quot;/services/livraison&quot;&gt;Livraison&lt;/a&gt;&lt;/li&gt;
          &lt;li&gt;&lt;a href=&quot;/services/sav&quot;&gt;SAV&lt;/a&gt;&lt;/li&gt;
        &lt;/ul&gt;
      &lt;/li&gt;
      &lt;li&gt;
        &lt;h2&gt;Pages légales et contact&lt;/h2&gt;
        &lt;ul&gt;
          &lt;li&gt;&lt;a href=&quot;/contact&quot;&gt;Contact&lt;/a&gt;&lt;/li&gt;
          &lt;li&gt;&lt;a href=&quot;/mentions-legales&quot;&gt;Mentions légales&lt;/a&gt;&lt;/li&gt;
        &lt;/ul&gt;
      &lt;/li&gt;
    &lt;/ul&gt;
  &lt;/nav&gt;
&lt;/main&gt;

&lt;!--  Mauvaise pratique : aucun plan du site --&gt;
&lt;!--
  - Pas de lien « Plan du site » dans l’en-tête ou le pied de page
  - Aucune page synthétique listant les principales rubriques
--&gt;</code></pre>

            <p class="mt-3 text-xs text-zinc-500">
              Un plan du site accessible depuis chaque page aide les utilisateurs désorientés, les personnes handicapées et les moteurs de recherche à comprendre la structure globale du site et à accéder rapidement aux contenus.
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
