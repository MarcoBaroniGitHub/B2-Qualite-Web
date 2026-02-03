<script setup>
import { getRuleById } from '~/data/rules'

const ruleId = 30
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

      <ul class="mt-1 list-disc pl-5 space-y-2 text-sm text-zinc-300">
        <li v-for="o in rule.objectives" :key="o">{{ o }}</li>
      </ul>
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
              Exemple de page de paiement avec option "Continuer en tant
              qu'invité" (guest checkout) bien visible
            </div>
            <div class="rounded-xl border border-zinc-800 bg-zinc-950 p-5">
              <div class="flex flex-col gap-5">
                <div class="text-base font-semibold text-zinc-100">
                  Finaliser votre commande
                </div>

                <div class="space-y-4">
                  <p class="text-sm text-zinc-300">
                    Vous pouvez commander sans créer de compte. Vos informations
                    ne seront utilisées que pour traiter cette commande.
                  </p>

                  <!-- Option Guest bien mise en avant -->
                  <div
                    class="rounded-lg border border-zinc-700 bg-zinc-900/50 p-4"
                  >
                    <div class="flex items-center gap-3">
                      <input
                        type="radio"
                        id="guest"
                        name="account"
                        checked
                        class="w-5 h-5 accent-zinc-400"
                      />
                      <label
                        for="guest"
                        class="text-sm font-medium text-zinc-100 cursor-pointer"
                      >
                        Continuer en tant qu'invité (sans compte)
                      </label>
                    </div>
                    <p class="mt-1 text-xs text-zinc-500 pl-8">
                      Rapide et sans obligation. Vous pourrez suivre votre
                      commande via le lien reçu par email.
                    </p>
                  </div>

                  <!-- Option compte (secondaire) -->
                  <div
                    class="rounded-lg border border-zinc-800 bg-zinc-900/30 p-4"
                  >
                    <div class="flex items-center gap-3">
                      <input
                        type="radio"
                        id="account"
                        name="account"
                        class="w-5 h-5 accent-zinc-400"
                      />
                      <label
                        for="account"
                        class="text-sm text-zinc-400 cursor-pointer"
                      >
                        Créer un compte (optionnel)
                      </label>
                    </div>
                    <p class="mt-1 text-xs text-zinc-600 pl-8">
                      Pour des commandes plus rapides à l'avenir et un
                      historique personnel.
                    </p>
                  </div>
                </div>

                <div class="flex justify-end gap-3 mt-4">
                  <button
                    class="px-6 py-2.5 bg-zinc-700 text-zinc-100 rounded-lg hover:bg-zinc-600 transition"
                  >
                    Retour au panier
                  </button>
                  <button
                    class="px-6 py-2.5 bg-blue-600 text-white rounded-lg hover:bg-blue-500 transition"
                  >
                    Continuer vers le paiement
                  </button>
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
          &lt;div class="rounded-xl border border-zinc-800 bg-zinc-950 p-5"&gt;
            &lt;div class="flex flex-col gap-5"&gt;
              &lt;div class="text-base font-semibold text-zinc-100"&gt;
                Finaliser votre commande
              &lt;/div&gt;
              
              &lt;div class="space-y-4"&gt;
                &lt;p class="text-sm text-zinc-300"&gt;
                  Vous pouvez commander sans créer de compte. Vos informations ne seront utilisées que pour traiter cette commande.
                &lt;/p&gt;
                
                &lt;!-- Option Guest bien mise en avant --&gt;
                &lt;div class="rounded-lg border border-zinc-700 bg-zinc-900/50 p-4"&gt;
                  &lt;div class="flex items-center gap-3"&gt;
                    &lt;input type="radio" id="guest" name="account" checked class="w-5 h-5 accent-zinc-400" /&gt;
                    &lt;label for="guest" class="text-sm font-medium text-zinc-100 cursor-pointer"&gt;
                      Continuer en tant qu'invité (sans compte)
                    &lt;/label&gt;
                  &lt;/div&gt;
                  &lt;p class="mt-1 text-xs text-zinc-500 pl-8"&gt;
                    Rapide et sans obligation. Vous pourrez suivre votre commande via le lien reçu par email.
                  &lt;/p&gt;
                &lt;/div&gt;
                
                &lt;!-- Option compte (secondaire) --&gt;
                &lt;div class="rounded-lg border border-zinc-800 bg-zinc-900/30 p-4"&gt;
                  &lt;div class="flex items-center gap-3"&gt;
                    &lt;input type="radio" id="account" name="account" class="w-5 h-5 accent-zinc-400" /&gt;
                    &lt;label for="account" class="text-sm text-zinc-400 cursor-pointer"&gt;
                      Créer un compte (optionnel)
                    &lt;/label&gt;
                  &lt;/div&gt;
                  &lt;p class="mt-1 text-xs text-zinc-600 pl-8"&gt;
                    Pour des commandes plus rapides à l'avenir et un historique personnel.
                  &lt;/p&gt;
                &lt;/div&gt;
              &lt;/div&gt;
              
              &lt;div class="flex justify-end gap-3 mt-4"&gt;
                &lt;button class="px-6 py-2.5 bg-zinc-700 text-zinc-100 rounded-lg hover:bg-zinc-600 transition"&gt;
                  Retour au panier
                &lt;/button&gt;
                &lt;button class="px-6 py-2.5 bg-blue-600 text-white rounded-lg hover:bg-blue-500 transition"&gt;
                  Continuer vers le paiement
                &lt;/button&gt;
              &lt;/div&gt;
            &lt;/div&gt;
          &lt;/div&gt;
          </code>
              </pre>
            <p class="mt-3 text-xs text-zinc-500">
              Le principe essentiel est de rendre l'option "sans compte" claire,
              prioritaire et rassurante, pour réduire les abandons de panier.
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
