<script setup>
import { getRuleById } from '~/data/rules'

// Récupération de l'ID de la règle (16 dans ce cas)
const ruleId = 16
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
              Exemple de section décrivant la procédure RGPD
            </div>

            <!-- Simulation d'une page de politique de confidentialité -->
            <div class="rounded-xl border border-zinc-800 bg-zinc-950 p-6">
              <!-- Titre de la section -->
              <h3 class="text-xl font-semibold text-zinc-100 mb-6">
                Vos droits sur vos données personnelles
              </h3>

              <!-- Introduction contextuelle -->
              <p class="text-sm text-zinc-300 mb-6">
                Conformément au Règlement Général sur la Protection des Données
                (RGPD), vous disposez de droits sur vos données personnelles.
              </p>

              <!-- Bloc principal : ⭐ ÉLÉMENT CLÉ DE LA RÈGLE 16 ⭐ -->
              <div
                class="rounded-lg border border-zinc-700 bg-zinc-900/50 p-5 mb-6"
              >
                <h4 class="text-base font-semibold text-zinc-100 mb-4">
                  Comment exercer vos droits ?
                </h4>

                <!-- Liste des droits de l'utilisateur -->
                <div class="space-y-4 text-sm text-zinc-300">
                  <!-- Droit d'accès -->
                  <div>
                    <strong class="text-zinc-200">
                      • Droit d'accès :
                    </strong>
                    Vous pouvez demander à consulter toutes les données que nous
                    détenons sur vous.
                  </div>

                  <!-- Droit de rectification -->
                  <div>
                    <strong class="text-zinc-200">
                      • Droit de rectification :
                    </strong>
                    Vous pouvez corriger ou mettre à jour vos informations si
                    elles sont inexactes.
                  </div>

                  <!-- Droit de suppression -->
                  <div>
                    <strong class="text-zinc-200">
                      • Droit à l'effacement :
                    </strong>
                    Vous pouvez demander la suppression de vos données sous
                    certaines conditions.
                  </div>

                  <!-- Droit d'opposition -->
                  <div>
                    <strong class="text-zinc-200">
                      • Droit d'opposition :
                    </strong>
                    Vous pouvez vous opposer au traitement de vos données pour
                    des motifs légitimes.
                  </div>
                </div>
              </div>

              <!-- ⭐ PROCÉDURE DE CONTACT : CŒUR DE LA RÈGLE 16 ⭐ -->
              <div
                class="rounded-lg border-2 border-blue-900/50 bg-blue-950/20 p-5"
              >
                <h4 class="text-base font-semibold text-blue-200 mb-4">
                  📧 Procédure de demande
                </h4>

                <p class="text-sm text-zinc-300 mb-4">
                  Pour exercer l'un de ces droits, vous pouvez nous contacter
                  par les moyens suivants :
                </p>

                <!-- Méthodes de contact détaillées -->
                <div class="space-y-3 text-sm">
                  <!-- Par email -->
                  <div class="flex items-start gap-3">
                    <div
                      class="flex-shrink-0 w-8 h-8 rounded-lg bg-blue-900/30 flex items-center justify-center"
                    >
                      <span class="text-blue-300">📧</span>
                    </div>
                    <div>
                      <div class="font-medium text-zinc-200">Par email</div>
                      <a
                        href="mailto:dpo@exemple.fr"
                        class="text-blue-400 hover:text-blue-300 underline"
                      >
                        dpo@exemple.fr
                      </a>
                      <p class="text-xs text-zinc-400 mt-1">
                        Réponse sous 30 jours maximum
                      </p>
                    </div>
                  </div>

                  <!-- Par formulaire -->
                  <div class="flex items-start gap-3">
                    <div
                      class="flex-shrink-0 w-8 h-8 rounded-lg bg-blue-900/30 flex items-center justify-center"
                    >
                      <span class="text-blue-300">📝</span>
                    </div>
                    <div>
                      <div class="font-medium text-zinc-200">
                        Par formulaire en ligne
                      </div>
                      <a
                        href="#"
                        class="text-blue-400 hover:text-blue-300 underline"
                      >
                        Accéder au formulaire RGPD
                      </a>
                      <p class="text-xs text-zinc-400 mt-1">
                        Traitement automatisé et suivi de votre demande
                      </p>
                    </div>
                  </div>

                  <!-- Par courrier -->
                  <div class="flex items-start gap-3">
                    <div
                      class="flex-shrink-0 w-8 h-8 rounded-lg bg-blue-900/30 flex items-center justify-center"
                    >
                      <span class="text-blue-300">✉️</span>
                    </div>
                    <div>
                      <div class="font-medium text-zinc-200">
                        Par courrier postal
                      </div>
                      <p class="text-zinc-300">
                        Service RGPD - DPO<br />
                        123 Rue de l'Exemple<br />
                        75000 Paris, France
                      </p>
                    </div>
                  </div>
                </div>

                <!-- Information sur les pièces justificatives -->
                <div
                  class="mt-4 pt-4 border-t border-blue-900/30 text-xs text-zinc-400"
                >
                  <strong class="text-zinc-300">Note :</strong> Pour traiter
                  votre demande, nous pourrons vous demander une copie de votre
                  pièce d'identité afin de vérifier votre identité.
                </div>
              </div>

              <!-- Délai de réponse -->
              <div class="mt-6 text-sm text-zinc-400">
                <strong class="text-zinc-300">Délai de traitement :</strong>
                Nous nous engageons à répondre à votre demande dans un délai
                d'un mois maximum à compter de sa réception.
              </div>
            </div>

            <!-- Note explicative sur l'importance de cette implémentation -->
            <div
              class="rounded-lg border border-zinc-700 bg-zinc-900/50 p-4 text-xs text-zinc-400"
            >
              <p class="font-medium text-zinc-300 mb-2">
                💡 Point clé de la règle 16 :
              </p>
              <p>
                Il ne suffit pas d'évoquer les droits RGPD de manière générale.
                Il faut <strong>décrire précisément la procédure</strong> à
                suivre : moyens de contact concrets (email, formulaire,
                courrier), délais de réponse, et documents nécessaires. Cette
                transparence renforce la confiance des utilisateurs.
              </p>
            </div>
          </div>

          <!-- ONGLET CODE : Code source HTML/CSS -->
          <div v-else>
            <pre
              class="rounded-xl bg-zinc-950 p-5 overflow-x-auto text-sm text-zinc-100"
            ><code>&lt;!-- Section RGPD dans la politique de confidentialité --&gt;
&lt;section class=&quot;rgpd-rights&quot;&gt;
  &lt;h3&gt;Vos droits sur vos données personnelles&lt;/h3&gt;
  
  &lt;p&gt;Conformément au RGPD, vous disposez de droits...&lt;/p&gt;

  &lt;!-- ⭐ DESCRIPTION DE LA PROCÉDURE (RÈGLE 16) ⭐ --&gt;
  &lt;div class=&quot;procedure-section&quot;&gt;
    &lt;h4&gt;Comment exercer vos droits ?&lt;/h4&gt;
    
    &lt;!-- Méthode 1 : Email --&gt;
    &lt;div class=&quot;contact-method&quot;&gt;
      &lt;h5&gt;Par email&lt;/h5&gt;
      &lt;a href=&quot;mailto:dpo@exemple.fr&quot;&gt;
        dpo@exemple.fr
      &lt;/a&gt;
      &lt;p&gt;Réponse sous 30 jours maximum&lt;/p&gt;
    &lt;/div&gt;

    &lt;!-- Méthode 2 : Formulaire --&gt;
    &lt;div class=&quot;contact-method&quot;&gt;
      &lt;h5&gt;Par formulaire en ligne&lt;/h5&gt;
      &lt;a href=&quot;/formulaire-rgpd&quot;&gt;
        Accéder au formulaire RGPD
      &lt;/a&gt;
      &lt;p&gt;Traitement automatisé et suivi&lt;/p&gt;
    &lt;/div&gt;

    &lt;!-- Méthode 3 : Courrier --&gt;
    &lt;div class=&quot;contact-method&quot;&gt;
      &lt;h5&gt;Par courrier postal&lt;/h5&gt;
      &lt;address&gt;
        Service RGPD - DPO&lt;br&gt;
        123 Rue de l'Exemple&lt;br&gt;
        75000 Paris, France
      &lt;/address&gt;
    &lt;/div&gt;

    &lt;!-- Information sur pièces justificatives --&gt;
    &lt;p class=&quot;note&quot;&gt;
      Note : Une copie de votre pièce d'identité 
      pourra être demandée pour vérifier votre identité.
    &lt;/p&gt;
  &lt;/div&gt;

  &lt;!-- Délai de traitement --&gt;
  &lt;p&gt;
    Délai de traitement : Réponse dans un délai 
    d'un mois maximum.
  &lt;/p&gt;
&lt;/section&gt;</code></pre>

            <!-- Explications techniques complémentaires -->
            <p class="mt-3 text-xs text-zinc-500">
              <strong>Bonnes pratiques :</strong><br />
              • Indiquer plusieurs moyens de contact pour s'adapter aux
              préférences des utilisateurs<br />
              • Préciser les délais de traitement pour gérer les attentes<br />
              • Mentionner les éventuels documents à fournir (pièce d'identité)<br />
              • Utiliser un langage clair et accessible, sans jargon juridique
              excessif<br />
              • Structurer l'information de manière hiérarchique pour faciliter
              la lecture
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
