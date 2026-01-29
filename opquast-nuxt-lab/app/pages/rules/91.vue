<script setup>
import { getRuleById } from '~/data/rules'

const ruleId = 91
const rule = getRuleById(ruleId)
const activeTab = ref('preview')

// Simulation de l'état du formulaire
const step = ref(1)
const formData = ref({
  name: 'Jean Dupont',
  email: 'jean.dupont@example.com',
})
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
    </section>

    <!-- Mise en œuvre -->
    <section class="rounded-2xl border border-zinc-800 bg-zinc-900/30 p-6">
      <h2 class="text-lg font-semibold tracking-tight text-zinc-100">
        Mise en œuvre
      </h2>
      <p v-if="rule.implementationIntro" class="mt-3 text-sm text-zinc-400">
        {{ rule.implementationIntro }}
      </p>
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
              Essayez de modifier les champs, passez à l'étape suivante, puis
              revenez : les données sont conservées.
            </div>

            <div class="rounded-xl border border-zinc-800 bg-zinc-950 p-5">
              <div v-if="step === 1" class="space-y-4">
                <h3 class="text-lg font-semibold text-zinc-100">
                  Étape 1 : Informations
                </h3>
                <div class="space-y-2">
                  <label class="block text-sm text-zinc-400">Nom complet</label>
                  <input
                    v-model="formData.name"
                    type="text"
                    class="w-full rounded bg-zinc-900 border border-zinc-700 px-3 py-2 text-zinc-200"
                  />
                </div>
                <div class="space-y-2">
                  <label class="block text-sm text-zinc-400">Email</label>
                  <input
                    v-model="formData.email"
                    type="email"
                    class="w-full rounded bg-zinc-900 border border-zinc-700 px-3 py-2 text-zinc-200"
                  />
                </div>
                <div class="flex justify-end pt-4">
                  <button
                    @click="step = 2"
                    class="px-4 py-2 bg-zinc-100 text-zinc-950 rounded font-medium hover:bg-zinc-200"
                  >
                    Suivant →
                  </button>
                </div>
              </div>

              <div v-else class="space-y-4">
                <h3 class="text-lg font-semibold text-zinc-100">
                  Étape 2 : Confirmation
                </h3>
                <div
                  class="p-4 bg-zinc-900 rounded border border-zinc-800 text-sm text-zinc-300"
                >
                  <p><strong>Nom :</strong> {{ formData.name }}</p>
                  <p><strong>Email :</strong> {{ formData.email }}</p>
                </div>
                <div class="flex justify-start pt-4">
                  <button
                    @click="step = 1"
                    class="px-4 py-2 bg-zinc-800 text-zinc-300 rounded font-medium hover:bg-zinc-700"
                  >
                    ← Précédent (Données conservées)
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
&lt;!-- Exemple avec Vue.js (v-model) --&gt;
&lt;div v-if=&quot;step === 1&quot;&gt;
  &lt;input v-model=&quot;formData.name&quot; type=&quot;text&quot; /&gt;
  &lt;button @click=&quot;step = 2&quot;&gt;Suivant&lt;/button&gt;
&lt;/div&gt;

&lt;div v-else&gt;
  &lt;p&gt;Récapitulatif : {{ formData.name }}&lt;/p&gt;
  &lt;!-- Le retour à l'étape 1 réaffiche l'input avec sa valeur --&gt;
  &lt;button @click=&quot;step = 1&quot;&gt;Précédent&lt;/button&gt;
&lt;/div&gt;

&lt;!-- Note : En production, utilisez un store (Pinia, Redux) 
     ou sessionStorage pour persister entre les rechargements de page --&gt;
</code>
</pre>
          </div>
        </div>
      </div>
    </section>
  </section>
</template>
