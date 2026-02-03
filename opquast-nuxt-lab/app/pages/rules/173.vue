<script setup>
import { getRuleById } from '~/data/rules'

const ruleId = 173
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
              Exemple de processus d’inscription à une newsletter avec confirmation par e‑mail (double opt‑in).
            </div>

            <!-- Étape 1 : formulaire d'inscription -->
            <div class="rounded-2xl border border-zinc-800 bg-zinc-950 p-5 space-y-4">
              <div class="text-sm text-zinc-400 mb-2">
                ✓ Étape 1 : saisie de l’adresse e‑mail
              </div>

              <form class="space-y-3" aria-label="Inscription à la newsletter">
                <div>
                  <label for="newsletter-email" class="block text-xs font-medium text-zinc-300 mb-1">
                    Adresse e‑mail
                  </label>
                  <input
                      id="newsletter-email"
                      type="email"
                      name="email"
                      placeholder="vous@example.com"
                      class="w-full bg-zinc-950 border border-zinc-700 rounded px-3 py-2 text-sm text-zinc-100 placeholder-zinc-500 focus:outline-none focus:border-blue-500"
                  />
                </div>
                <p class="text-xs text-zinc-500">
                  Nous vous enverrons un e‑mail pour confirmer votre inscription. Votre adresse ne sera ajoutée à la liste qu’après votre confirmation.
                </p>
                <button
                    type="submit"
                    class="px-4 py-2 bg-blue-600 hover:bg-blue-700 text-white text-sm rounded transition"
                >
                  Je m’inscris
                </button>
              </form>
            </div>

            <!-- Étape 2 : mail de confirmation -->
            <div class="rounded-2xl border border-zinc-800 bg-zinc-950 p-5 space-y-3">
              <div class="text-sm text-zinc-400 mb-2">
                ✓ Étape 2 : e‑mail de confirmation (double opt‑in)
              </div>
              <div class="rounded-lg border border-zinc-800 bg-zinc-900 p-4 space-y-2 text-sm text-zinc-200">
                <p class="text-xs uppercase tracking-wide text-zinc-500">
                  Objet : Confirmez votre inscription à notre newsletter
                </p>
                <p>Bonjour,</p>
                <p>
                  Vous avez demandé à recevoir notre newsletter à l’adresse
                  <span class="font-mono text-zinc-100">vous@example.com</span>.
                </p>
                <p>
                  Pour confirmer votre inscription, cliquez sur le bouton ci‑dessous. Si vous n’êtes pas à l’origine de cette demande, vous pouvez ignorer ce message.
                </p>
                <button class="mt-2 px-4 py-2 bg-emerald-600 hover:bg-emerald-700 text-white text-xs font-semibold rounded transition">
                  Confirmer mon inscription
                </button>
              </div>
            </div>

            <!-- Mauvaise pratique : inscription directe -->
            <div class="rounded-2xl border border-red-900/50 bg-zinc-950 p-5 space-y-3">
              <div class="text-sm text-red-400 mb-1">
                 Mauvaise pratique : inscription immédiate sans confirmation
              </div>
              <p class="text-sm text-zinc-300">
                Toute adresse saisie (même par un tiers) est ajoutée directement à la liste de diffusion, ce qui favorise le spam et les usurpations d’identité.
              </p>
            </div>

            <div class="mt-6 pt-6 border-t border-zinc-800 text-xs text-zinc-400 space-y-1">
              <div>✓ Utiliser un processus de confirmation (double opt‑in) pour chaque inscription.</div>
              <div>✓ N’ajouter l’adresse à la liste qu’après un clic sur le lien de confirmation ou un bouton dans l’e‑mail.</div>
              <div>✓ Expliquer dans l’interface et dans l’e‑mail ce qui se passe et comment se désinscrire.</div>
            </div>
          </div>

          <!-- CODE -->
          <div v-else>
            <pre class="rounded-xl bg-zinc-950 p-5 overflow-x-auto text-sm text-zinc-100"><code>&lt;!-- Étape 1 : formulaire d’inscription --&gt;
&lt;form method=&quot;post&quot; action=&quot;/newsletter/inscription&quot;&gt;
  &lt;label for=&quot;email&quot;&gt;Adresse e-mail&lt;/label&gt;
  &lt;input
    id=&quot;email&quot;
    name=&quot;email&quot;
    type=&quot;email&quot;
    required
  /&gt;

  &lt;p class=&quot;hint&quot;&gt;
    Vous recevrez un e-mail pour confirmer votre inscription.
    Votre adresse ne sera ajoutée à notre liste qu’après confirmation.
  &lt;/p&gt;

  &lt;button type=&quot;submit&quot;&gt;Je m’inscris&lt;/button&gt;
&lt;/form&gt;

&lt;!-- Étape 2 : e-mail de confirmation (exemple de contenu) --&gt;
Objet : Confirmez votre inscription à notre newsletter

Bonjour,

Vous avez demandé à recevoir notre newsletter à l’adresse {{ email }}.

Pour confirmer votre inscription, cliquez sur le lien suivant :
{{ confirmation_url }}

Si vous n’êtes pas à l’origine de cette demande, vous pouvez ignorer ce message :
votre adresse ne sera pas ajoutée.

&lt;!--  Mauvaise pratique à éviter --&gt;
&lt;!--
  - Ajout immédiat de l’adresse à la liste sans e-mail de confirmation
  - Aucune vérification que la personne contrôle réellement la boîte mail
--&gt;</code></pre>

            <p class="mt-3 text-xs text-zinc-500">
              Soumettre l’inscription à une newsletter à un processus de confirmation (double opt‑in) limite le spam, évite les usurpations d’identité et rassure les utilisateurs sur l’utilisation de leur adresse e‑mail.
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
