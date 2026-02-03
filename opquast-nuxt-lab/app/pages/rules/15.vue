<script setup>
import { getRuleById } from '~/data/rules'

// Récupération de l'ID de la règle (15 dans ce cas)
const ruleId = 15
// Chargement des données de la règle depuis le fichier JSON centralisé
const rule = getRuleById(ruleId)
// Gestion de l'onglet actif (Rendu ou Code)
const activeTab = ref('preview')
</script>

<template>
  <section v-if="rule" class="space-y-6">
    <!-- En-tête de la règle -->
    <header class="space-y-3">
      <!-- Bouton de retour vers la liste des règles -->
      <button
        @click="$router.back()"
        class="inline-flex items-center gap-2 text-sm text-zinc-400 hover:text-zinc-200 transition"
      >
        ← Retour
      </button>
      
      <!-- Numéro de la règle -->
      <div class="text-sm text-zinc-400">Règle n° {{ rule.id }}</div>

      <!-- Titre principal de la règle -->
      <h1
        class="text-2xl sm:text-3xl font-semibold tracking-tight text-zinc-100"
      >
        {{ rule.title }}
      </h1>

      <!-- Description détaillée issue du référentiel Opquast -->
      <div class="text-base sm:text-sm tracking-tight text-zinc-300">
        {{ rule.description }}
      </div>

      <!-- Tags/catégories de la règle -->
      <div class="flex flex-wrap gap-2">
        <span
          v-for="tag in rule.tags"
          :key="tag"
          class="text-xs rounded-full border border-zinc-800 bg-zinc-900/30 px-2.5 py-1 text-zinc-300"
        >
          {{ tag }}
        </span>
      </div>

      <!-- Affichage des auteurs si présents -->
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

    <!-- Section Objectif : Pourquoi cette règle est importante -->
    <section class="rounded-2xl border border-zinc-800 bg-zinc-900/30 p-6">
      <h2 class="text-lg font-semibold tracking-tight text-zinc-100">
        Objectif
      </h2>

      <!-- Affichage des objectifs sous forme de liste -->
      <ul
        v-if="Array.isArray(rule.objectives)"
        class="mt-3 list-disc pl-5 space-y-2 text-sm text-zinc-300"
      >
        <li v-for="o in rule.objectives" :key="o">{{ o }}</li>
      </ul>

      <!-- Alternative si objectives est une chaîne simple -->
      <p v-else class="mt-1 text-sm text-zinc-300">
        {{ rule.objective }}
      </p>
    </section>

    <!-- Section Mise en œuvre : Comment appliquer cette règle -->
    <section class="rounded-2xl border border-zinc-800 bg-zinc-900/30 p-6">
      <h2 class="text-lg font-semibold tracking-tight text-zinc-100">
        Mise en œuvre
      </h2>

      <!-- Introduction à la mise en œuvre si présente -->
      <p v-if="rule.implementationIntro" class="mt-3 text-sm text-zinc-400">
        {{ rule.implementationIntro }}
      </p>

      <!-- Liste des actions concrètes à réaliser -->
      <ul
        v-if="rule.implementation && rule.implementation.length"
        class="mt-3 list-disc pl-5 space-y-2 text-sm text-zinc-300"
      >
        <li v-for="x in rule.implementation" :key="x">{{ x }}</li>
      </ul>
    </section>

    <!-- Section Contrôle : Comment vérifier la conformité -->
    <section class="rounded-2xl border border-zinc-800 bg-zinc-900/30 p-6">
      <h2 class="text-lg font-semibold tracking-tight text-zinc-100">
        Contrôle
      </h2>

      <!-- Liste des points de contrôle -->
      <ul class="mt-3 list-disc pl-5 space-y-2 text-sm text-zinc-300">
        <li v-for="c in rule.control" :key="c">{{ c }}</li>
      </ul>
    </section>

    <!-- Section Screenshots : Exemples visuels de sites réels -->
    <section class="space-y-4">
      <h2 class="text-lg font-semibold tracking-tight text-zinc-100">
        Screenshots
      </h2>

      <!-- Conteneur scrollable horizontal pour les captures d'écran -->
      <div class="flex gap-4 overflow-x-auto pb-4 scrollbar-light">
        <div
          v-for="(source, index) in rule.screenshotsSources"
          :key="source + index"
          class="shrink-0 w-[280px] sm:w-[340px]"
        >
          <!-- Conteneur de l'image avec ratio 16:10 -->
          <div
            class="aspect-[16/10] rounded-2xl border border-zinc-800 bg-zinc-900/20 overflow-hidden flex items-center justify-center"
          >
            <!-- Lien vers l'image en taille réelle -->
            <a
              :href="`/screenshots/rule-${rule.id}/screenshot-${index + 1}.png`"
              target="_blank"
              rel="noreferrer"
              class="block cursor-zoom-in"
            >
              <!-- Image avec gestion d'erreur pour afficher le placeholder -->
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

            <!-- Placeholder affiché si l'image n'existe pas encore -->
            <div class="hidden text-center px-4">
              <div class="text-sm text-zinc-300 font-medium">
                Screenshot à ajouter
              </div>
              <div class="mt-1 text-xs text-zinc-500">Exemple réel attendu</div>
            </div>
          </div>

          <!-- Source URL du screenshot -->
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

    <!-- Section Exemples : Démonstration pratique avec code -->
    <section class="space-y-4">
      <h2 class="text-lg font-semibold tracking-tight text-zinc-100">
        Exemples
      </h2>

      <div
        class="rounded-2xl border border-zinc-800 bg-zinc-900/30 overflow-hidden"
      >
        <!-- Système d'onglets pour alterner entre Rendu et Code -->
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

        <!-- Contenu des onglets -->
        <div class="p-6">
          <!-- ONGLET RENDU : Visualisation du composant -->
          <div v-if="activeTab === 'preview'" class="space-y-4">
            <div class="text-sm text-zinc-400">
              Exemple de footer avec lien vers la politique de confidentialité
            </div>

            <!-- Simulation d'un footer de site web -->
            <div class="rounded-xl border border-zinc-800 bg-zinc-950 p-6">
              <!-- Contenu principal du footer simulé -->
              <div class="grid grid-cols-1 md:grid-cols-3 gap-8 mb-6">
                <!-- Colonne 1 : À propos -->
                <div>
                  <h3 class="text-sm font-semibold text-zinc-100 mb-3">
                    À propos
                  </h3>
                  <p class="text-xs text-zinc-400">
                    Notre entreprise s'engage à protéger vos données
                    personnelles et votre vie privée.
                  </p>
                </div>

                <!-- Colonne 2 : Liens utiles -->
                <div>
                  <h3 class="text-sm font-semibold text-zinc-100 mb-3">
                    Liens utiles
                  </h3>
                  <ul class="space-y-2 text-xs text-zinc-400">
                    <li>
                      <a href="#" class="hover:text-zinc-200 transition">
                        FAQ
                      </a>
                    </li>
                    <li>
                      <a href="#" class="hover:text-zinc-200 transition">
                        Contact
                      </a>
                    </li>
                    <li>
                      <a href="#" class="hover:text-zinc-200 transition">
                        Support
                      </a>
                    </li>
                  </ul>
                </div>

                <!-- Colonne 3 : Contact -->
                <div>
                  <h3 class="text-sm font-semibold text-zinc-100 mb-3">
                    Contact
                  </h3>
                  <p class="text-xs text-zinc-400">
                    contact@exemple.fr<br />
                    +33 1 23 45 67 89
                  </p>
                </div>
              </div>

              <!-- Ligne de séparation -->
              <div class="border-t border-zinc-800 pt-6">
                <!-- Section des liens légaux : L'ÉLÉMENT CLÉ DE LA RÈGLE 15 -->
                <div
                  class="flex flex-col sm:flex-row justify-between items-center gap-4 text-xs text-zinc-400"
                >
                  <div>
                    © 2026 Exemple. Tous droits réservés.
                  </div>

                  <!-- IMPORTANT : Ces liens doivent être présents sur TOUTES les pages -->
                  <div class="flex flex-wrap gap-4">
                    <a
                      href="#"
                      class="hover:text-zinc-200 transition underline underline-offset-4"
                    >
                      Mentions légales
                    </a>
                    <!-- ⭐ LIEN VERS LA POLITIQUE DE CONFIDENTIALITÉ ⭐ -->
                    <!-- C'est l'élément central de la règle 15 -->
                    <a
                      href="#"
                      class="hover:text-zinc-200 transition underline underline-offset-4 font-medium"
                    >
                      Politique de confidentialité
                    </a>
                    <a
                      href="#"
                      class="hover:text-zinc-200 transition underline underline-offset-4"
                    >
                      Gestion des cookies
                    </a>
                  </div>
                </div>
              </div>
            </div>

            <!-- Note explicative sur l'importance de cette implémentation -->
            <div
              class="rounded-lg border border-zinc-700 bg-zinc-900/50 p-4 text-xs text-zinc-400"
            >
              <p class="font-medium text-zinc-300 mb-2">
                💡 Point clé de la règle 15 :
              </p>
              <p>
                Le lien vers la politique de confidentialité doit être présent
                dans le <strong>footer de toutes les pages</strong> du site.
                Cela permet aux utilisateurs d'accéder facilement aux
                informations sur la protection de leurs données depuis n'importe
                quelle page.
              </p>
            </div>
          </div>

          <!-- ONGLET CODE : Code source HTML/CSS -->
          <div v-else>
            <pre
              class="rounded-xl bg-zinc-950 p-5 overflow-x-auto text-sm text-zinc-100"
            ><code>&lt;!-- Footer présent sur toutes les pages du site --&gt;
&lt;footer class=&quot;bg-zinc-950 p-6&quot;&gt;
  &lt;!-- Contenu principal du footer --&gt;
  &lt;div class=&quot;grid grid-cols-1 md:grid-cols-3 gap-8&quot;&gt;
    &lt;!-- Colonnes de contenu --&gt;
    &lt;div&gt;
      &lt;h3&gt;À propos&lt;/h3&gt;
      &lt;p&gt;Notre entreprise...&lt;/p&gt;
    &lt;/div&gt;
    &lt;!-- ... autres colonnes ... --&gt;
  &lt;/div&gt;

  &lt;!-- Barre de liens légaux --&gt;
  &lt;div class=&quot;border-t border-zinc-800 pt-6 mt-6&quot;&gt;
    &lt;div class=&quot;flex justify-between items-center&quot;&gt;
      &lt;div&gt;© 2026 Exemple&lt;/div&gt;
      
      &lt;!-- ⭐ LIENS LÉGAUX OBLIGATOIRES ⭐ --&gt;
      &lt;div class=&quot;flex gap-4&quot;&gt;
        &lt;a href=&quot;/mentions-legales&quot;&gt;
          Mentions légales
        &lt;/a&gt;
        
        &lt;!-- RÈGLE 15 : Ce lien doit être présent partout --&gt;
        &lt;a href=&quot;/politique-confidentialite&quot;&gt;
          Politique de confidentialité
        &lt;/a&gt;
        
        &lt;a href=&quot;/cookies&quot;&gt;
          Gestion des cookies
        &lt;/a&gt;
      &lt;/div&gt;
    &lt;/div&gt;
  &lt;/div&gt;
&lt;/footer&gt;</code></pre>

            <!-- Explications techniques complémentaires -->
            <p class="mt-3 text-xs text-zinc-500">
              <strong>Bonnes pratiques :</strong><br />
              • Le footer doit être inclus dans le layout principal pour
              apparaître sur toutes les pages<br />
              • Le lien doit être clairement identifiable et accessible<br />
              • L'URL doit pointer vers une page dédiée avec le contenu complet
              de la politique<br />
              • Pour l'accessibilité, utiliser un texte de lien explicite (éviter
              "cliquez ici")
            </p>
          </div>
        </div>
      </div>
    </section>
  </section>

  <!-- Message d'erreur si la règle n'est pas trouvée -->
  <section v-else class="rounded-2xl border border-zinc-800 bg-zinc-900/30 p-6">
    <h1 class="text-lg font-semibold text-zinc-100">Règle introuvable</h1>
    <p class="mt-2 text-sm text-zinc-400">
      Vérifiez que la règle existe dans
      <code class="text-zinc-300">rules.json</code>.
    </p>
  </section>
</template>

<style scoped>
/* Styles personnalisés pour la scrollbar */
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
