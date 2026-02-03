<script setup>
import { getRuleById } from '~/data/rules'

const ruleId = 174
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
              Exemple de newsletter avec lien de désinscription clairement visible dans le pied de message.
            </div>

            <!-- Bonne pratique : lien de désinscription clair -->
            <div class="rounded-2xl border border-zinc-800 bg-zinc-950 p-5 space-y-4">
              <div class="text-sm text-zinc-400 mb-2">
                ✓ Bonne pratique : lien unique de désinscription dans chaque newsletter
              </div>

              <article class="rounded-lg border border-zinc-800 bg-zinc-900 p-4 space-y-3 text-sm text-zinc-100">
                <header class="border-b border-zinc-800 pb-3 mb-3">
                  <p class="text-xs uppercase tracking-wide text-zinc-500">
                    Newsletter • Avril 2026
                  </p>
                  <h2 class="text-lg font-semibold text-zinc-50">
                    Nos nouveautés du mois
                  </h2>
                </header>

                <p>
                  Bonjour,
                </p>
                <p>
                  Découvrez les dernières actualités de notre service ainsi qu’une sélection de contenus pour vous.
                </p>

                <footer class="border-t border-zinc-800 pt-3 mt-4 text-xs text-zinc-400">
                  <p>
                    Vous recevez cet e‑mail car vous êtes inscrit à notre newsletter.
                  </p>
                  <p class="mt-1">
                    Pour ne plus recevoir nos messages, vous pouvez
                    <a href="https://exemple.com/newsletter/desinscription?token=ABC123" class="text-zinc-100 underline underline-offset-4 hover:text-zinc-50">
                      vous désinscrire en un clic
                    </a>.
                  </p>
                </footer>
              </article>
            </div>

            <!-- Mauvaise pratique : désinscription cachée ou absente -->
            <div class="rounded-2xl border border-red-900/50 bg-zinc-950 p-5 space-y-3">
              <div class="text-sm text-red-400 mb-1">
                 Mauvaise pratique : aucun lien de désinscription, ou un lien peu visible et complexe
              </div>
              <p class="text-sm text-zinc-300">
                Les utilisateurs doivent chercher longtemps comment se désinscrire, ou ne trouvent tout simplement pas de lien. Cela génère de la frustration et des signalements de spam.
              </p>
            </div>

            <div class="mt-6 pt-6 border-t border-zinc-800 text-xs text-zinc-400 space-y-1">
              <div>✓ Ajouter un lien de désinscription dans chaque newsletter, idéalement dans le pied de message.</div>
              <div>✓ Utiliser un libellé clair (« Se désinscrire », « Ne plus recevoir cette newsletter », etc.).</div>
              <div>✓ Faire en sorte que le processus mène réellement à une désinscription effective.</div>
            </div>
          </div>

          <!-- CODE -->
          <div v-else>
            <pre class="rounded-xl bg-zinc-950 p-5 overflow-x-auto text-sm text-zinc-100"><code>&lt;!-- Pied de page d’une newsletter HTML --&gt;
&lt;footer style=&quot;font-size: 12px; color: #9ca3af; margin-top: 24px; border-top: 1px solid #374151; padding-top: 12px;&quot;&gt;
  &lt;p&gt;
    Vous recevez cet e-mail car vous vous êtes inscrit à la newsletter de
    &lt;strong&gt;Exemple&lt;/strong&gt;.
  &lt;/p&gt;
  &lt;p style=&quot;margin-top: 4px;&quot;&gt;
    Pour ne plus recevoir nos messages, cliquez sur ce lien :
    &lt;a
      href=&quot;https://exemple.com/newsletter/unsubscribe?token={{ token }}&quot;
      style=&quot;color: #e5e7eb; text-decoration: underline;&quot;
    &gt;
      Se désinscrire
    &lt;/a&gt;
  &lt;/p&gt;
&lt;/footer&gt;

&lt;!-- Mauvaise pratique à éviter --&gt;
&lt;!--
  - Aucune mention de désinscription
  - Lien caché au milieu d’un paragraphe flou
  - Processus de désinscription long et confus
--&gt;</code></pre>

            <p class="mt-3 text-xs text-zinc-500">
              Chaque newsletter doit contenir un lien de désinscription clair qui mène à un processus simple et fiable, afin de respecter les attentes des utilisateurs et la protection de leurs données.
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
