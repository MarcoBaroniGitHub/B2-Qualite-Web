<script setup>
import { getRuleById } from '~/data/rules'

// Récupération de l'ID de la règle (17 dans ce cas)
const ruleId = 17
// Chargement des données de la règle depuis le fichier JSON centralisé
const rule = getRuleById(ruleId)
// Gestion de l'onglet actif (Rendu ou Code)
const activeTab = ref('preview')

// State pour la démo du formulaire
const formData = ref({
  email: '',
  password: '',
  confirmPassword: ''
})
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

    <!-- Section Objectif -->
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

      <p v-else class="mt-1 text-sm text-zinc-300">
        {{ rule.objective }}
      </p>
    </section>

    <!-- Section Mise en œuvre -->
    <section class="rounded-2xl border border-zinc-800 bg-zinc-900/30 p-6">
      <h2 class="text-lg font-semibold tracking-tight text-zinc-100">
        Mise en œuvre
      </h2>

      <p v-if="rule.implementationIntro" class="mt-3 text-sm text-zinc-400">
        {{ rule.implementationIntro }}
      </p>

      <ul
        v-if="rule.implementation && rule.implementation.length"
        class="mt-3 list-disc pl-5 space-y-2 text-sm text-zinc-300"
      >
        <li v-for="x in rule.implementation" :key="x">{{ x }}</li>
      </ul>
    </section>

    <!-- Section Contrôle -->
    <section class="rounded-2xl border border-zinc-800 bg-zinc-900/30 p-6">
      <h2 class="text-lg font-semibold tracking-tight text-zinc-100">
        Contrôle
      </h2>

      <ul class="mt-3 list-disc pl-5 space-y-2 text-sm text-zinc-300">
        <li v-for="c in rule.control" :key="c">{{ c }}</li>
      </ul>
    </section>

    <!-- Section Screenshots -->
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

    <!-- Section Exemples -->
    <section class="space-y-4">
      <h2 class="text-lg font-semibold tracking-tight text-zinc-100">
        Exemples
      </h2>

      <div
        class="rounded-2xl border border-zinc-800 bg-zinc-900/30 overflow-hidden"
      >
        <!-- Système d'onglets -->
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
          <!-- ONGLET RENDU -->
          <div v-if="activeTab === 'preview'" class="space-y-4">
            <div class="text-sm text-zinc-400">
              Exemple de formulaire d'inscription avec méthode traditionnelle
            </div>

            <!-- ⭐ FORMULAIRE DÉMONSTRANT LA RÈGLE 17 ⭐ -->
            <div class="rounded-xl border border-zinc-800 bg-zinc-950 p-6 max-w-md mx-auto">
              <h3 class="text-xl font-semibold text-zinc-100 mb-6">
                Créer un compte
              </h3>

              <!-- OPTION 1 : Méthodes OAuth (FACULTATIVES) -->
              <div class="space-y-3 mb-6">
                <p class="text-xs text-zinc-400 text-center mb-3">
                  Inscription rapide avec :
                </p>
                
                <!-- Ces boutons sont OPTIONNELS mais ne doivent PAS être la seule méthode -->
                <button
                  type="button"
                  class="w-full flex items-center justify-center gap-3 rounded-lg border border-zinc-700 bg-zinc-900 px-4 py-2.5 text-sm text-zinc-200 hover:bg-zinc-800 transition"
                >
                  <span>🔵</span>
                  <span>Continuer avec Google</span>
                </button>

                <button
                  type="button"
                  class="w-full flex items-center justify-center gap-3 rounded-lg border border-zinc-700 bg-zinc-900 px-4 py-2.5 text-sm text-zinc-200 hover:bg-zinc-800 transition"
                >
                  <span>⚫</span>
                  <span>Continuer avec GitHub</span>
                </button>
              </div>

              <!-- Séparateur visuel -->
              <div class="relative my-6">
                <div class="absolute inset-0 flex items-center">
                  <div class="w-full border-t border-zinc-800"></div>
                </div>
                <div class="relative flex justify-center text-xs">
                  <span class="bg-zinc-950 px-2 text-zinc-500">ou</span>
                </div>
              </div>

              <!-- ⭐ OPTION 2 : MÉTHODE TRADITIONNELLE (OBLIGATOIRE) ⭐ -->
              <!-- C'est l'élément clé de la règle 17 : cette option DOIT exister -->
              <form @submit.prevent class="space-y-4">
                <!-- Champ Email -->
                <div>
                  <label class="block text-sm font-medium text-zinc-300 mb-1.5">
                    Adresse email
                  </label>
                  <input
                    v-model="formData.email"
                    type="email"
                    placeholder="votre@email.com"
                    required
                    class="w-full rounded-lg border border-zinc-700 bg-zinc-900 px-3 py-2 text-sm text-zinc-200 placeholder-zinc-600 focus:border-zinc-500 focus:outline-none focus:ring-1 focus:ring-zinc-500"
                  />
                </div>

                <!-- Champ Mot de passe -->
                <div>
                  <label class="block text-sm font-medium text-zinc-300 mb-1.5">
                    Mot de passe
                  </label>
                  <input
                    v-model="formData.password"
                    type="password"
                    placeholder="••••••••"
                    required
                    class="w-full rounded-lg border border-zinc-700 bg-zinc-900 px-3 py-2 text-sm text-zinc-200 placeholder-zinc-600 focus:border-zinc-500 focus:outline-none focus:ring-1 focus:ring-zinc-500"
                  />
                  <p class="mt-1 text-xs text-zinc-500">
                    Minimum 8 caractères
                  </p>
                </div>

                <!-- Champ Confirmation de mot de passe -->
                <div>
                  <label class="block text-sm font-medium text-zinc-300 mb-1.5">
                    Confirmer le mot de passe
                  </label>
                  <input
                    v-model="formData.confirmPassword"
                    type="password"
                    placeholder="••••••••"
                    required
                    class="w-full rounded-lg border border-zinc-700 bg-zinc-900 px-3 py-2 text-sm text-zinc-200 placeholder-zinc-600 focus:border-zinc-500 focus:outline-none focus:ring-1 focus:ring-zinc-500"
                  />
                </div>

                <!-- Bouton de soumission -->
                <button
                  type="submit"
                  class="w-full rounded-lg bg-blue-600 px-4 py-2.5 text-sm font-medium text-white hover:bg-blue-700 transition"
                >
                  Créer mon compte
                </button>

                <!-- Lien vers connexion -->
                <p class="text-xs text-center text-zinc-500">
                  Vous avez déjà un compte ?
                  <a href="#" class="text-blue-400 hover:text-blue-300 underline">
                    Se connecter
                  </a>
                </p>
              </form>
            </div>

            <!-- Note explicative -->
            <div
              class="rounded-lg border border-zinc-700 bg-zinc-900/50 p-4 text-xs text-zinc-400"
            >
              <p class="font-medium text-zinc-300 mb-2">
                💡 Point clé de la règle 17 :
              </p>
              <p>
                Bien que les options d'authentification tierces (Google, GitHub, etc.) 
                soient pratiques, elles ne doivent <strong>jamais être la seule méthode</strong> 
                d'inscription. Un formulaire classique email/mot de passe doit toujours être proposé 
                pour garantir l'indépendance vis-à-vis des services tiers et l'accessibilité pour tous.
              </p>
            </div>
          </div>

          <!-- ONGLET CODE -->
          <div v-else>
            <pre
              class="rounded-xl bg-zinc-950 p-5 overflow-x-auto text-sm text-zinc-100"
            ><code>&lt;!-- Formulaire d'inscription --&gt;
&lt;form class="signup-form"&gt;
  &lt;h2&gt;Créer un compte&lt;/h2&gt;

  &lt;!-- OPTIONS OAUTH (facultatives) --&gt;
  &lt;div class="oauth-options"&gt;
    &lt;button type="button" class="oauth-btn"&gt;
      Continuer avec Google
    &lt;/button&gt;
    &lt;button type="button" class="oauth-btn"&gt;
      Continuer avec GitHub
    &lt;/button&gt;
  &lt;/div&gt;

  &lt;div class="separator"&gt;ou&lt;/div&gt;

  &lt;!-- ⭐ MÉTHODE TRADITIONNELLE (OBLIGATOIRE - RÈGLE 17) ⭐ --&gt;
  &lt;div class="traditional-signup"&gt;
    &lt;!-- Email --&gt;
    &lt;div class="form-group"&gt;
      &lt;label for="email"&gt;Adresse email&lt;/label&gt;
      &lt;input 
        type="email" 
        id="email" 
        name="email" 
        required
        placeholder="votre@email.com"
      /&gt;
    &lt;/div&gt;

    &lt;!-- Mot de passe --&gt;
    &lt;div class="form-group"&gt;
      &lt;label for="password"&gt;Mot de passe&lt;/label&gt;
      &lt;input 
        type="password" 
        id="password" 
        name="password" 
        required
        minlength="8"
        placeholder="••••••••"
      /&gt;
      &lt;small&gt;Minimum 8 caractères&lt;/small&gt;
    &lt;/div&gt;

    &lt;!-- Confirmation --&gt;
    &lt;div class="form-group"&gt;
      &lt;label for="confirm-password"&gt;
        Confirmer le mot de passe
      &lt;/label&gt;
      &lt;input 
        type="password" 
        id="confirm-password" 
        name="confirm-password" 
        required
        placeholder="••••••••"
      /&gt;
    &lt;/div&gt;

    &lt;!-- Bouton de soumission --&gt;
    &lt;button type="submit" class="submit-btn"&gt;
      Créer mon compte
    &lt;/button&gt;
  &lt;/div&gt;

  &lt;!-- Lien vers connexion --&gt;
  &lt;p class="login-link"&gt;
    Vous avez déjà un compte ? 
    &lt;a href="/connexion"&gt;Se connecter&lt;/a&gt;
  &lt;/p&gt;
&lt;/form&gt;</code></pre>

            <p class="mt-3 text-xs text-zinc-500">
              <strong>Bonnes pratiques :</strong><br />
              • Toujours proposer une méthode d'inscription traditionnelle (email/mot de passe)<br />
              • Les options OAuth sont un complément, jamais un remplacement<br />
              • Valider la force du mot de passe côté client et serveur<br />
              • Utiliser des attributs HTML5 (required, minlength, type="email")<br />
              • Implémenter une confirmation de mot de passe pour éviter les erreurs<br />
              • Assurer l'accessibilité avec des labels explicites et une structure sémantique
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
