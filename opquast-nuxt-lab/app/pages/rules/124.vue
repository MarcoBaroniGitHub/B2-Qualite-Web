<script setup>
import { getRuleById } from '~/data/rules'

const ruleId = 1
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
              Exemple de vidéo nécessitant une action utilisateur pour démarrer
            </div>

            <div class="rounded-xl border border-zinc-800 bg-zinc-950 p-5">
              <div class="space-y-4">
                <!-- Vidéo avec contrôles -->
                <div class="relative rounded-lg overflow-hidden bg-black">
                  <div class="aspect-video relative">
                    <!-- Poster/Thumbnail -->
                    <div
                      class="absolute inset-0 flex items-center justify-center bg-gradient-to-br from-zinc-800 to-zinc-900"
                    >
                      <svg
                        class="w-16 h-16 text-zinc-600"
                        fill="none"
                        stroke="currentColor"
                        viewBox="0 0 24 24"
                      >
                        <path
                          stroke-linecap="round"
                          stroke-linejoin="round"
                          stroke-width="2"
                          d="M14.752 11.168l-3.197-2.132A1 1 0 0010 9.87v4.263a1 1 0 001.555.832l3.197-2.132a1 1 0 000-1.664z"
                        />
                        <path
                          stroke-linecap="round"
                          stroke-linejoin="round"
                          stroke-width="2"
                          d="M21 12a9 9 0 11-18 0 9 9 0 0118 0z"
                        />
                      </svg>
                    </div>

                    <!-- Bouton Play -->
                    <button
                      class="absolute inset-0 flex items-center justify-center group"
                    >
                      <div
                        class="w-20 h-20 rounded-full bg-white/90 group-hover:bg-white flex items-center justify-center transition shadow-lg"
                      >
                        <svg
                          class="w-10 h-10 text-zinc-900 ml-1"
                          fill="currentColor"
                          viewBox="0 0 24 24"
                        >
                          <path d="M8 5v14l11-7z" />
                        </svg>
                      </div>
                    </button>
                  </div>

                  <!-- Contrôles vidéo -->
                  <div
                    class="absolute bottom-0 left-0 right-0 bg-gradient-to-t from-black/80 to-transparent p-4"
                  >
                    <div class="flex items-center gap-3">
                      <button class="text-white hover:text-zinc-300 transition">
                        <svg
                          class="w-5 h-5"
                          fill="currentColor"
                          viewBox="0 0 24 24"
                        >
                          <path d="M8 5v14l11-7z" />
                        </svg>
                      </button>
                      <div class="flex-1 h-1 bg-zinc-700 rounded-full">
                        <div class="h-full w-0 bg-white rounded-full"></div>
                      </div>
                      <span class="text-xs text-white">0:00 / 2:34</span>
                      <button class="text-white hover:text-zinc-300 transition">
                        <svg
                          class="w-5 h-5"
                          fill="currentColor"
                          viewBox="0 0 24 24"
                        >
                          <path
                            d="M3 9v6h4l5 5V4L7 9H3zm13.5 3c0-1.77-1.02-3.29-2.5-4.03v8.05c1.48-.73 2.5-2.25 2.5-4.02z"
                          />
                        </svg>
                      </button>
                    </div>
                  </div>
                </div>

                <div class="text-sm text-zinc-400">
                  <p class="font-medium text-zinc-300">Titre de la vidéo</p>
                  <p class="mt-1">
                    La vidéo ne se lance que lorsque l'utilisateur clique sur le
                    bouton de lecture.
                  </p>
                </div>
              </div>
            </div>

            <!-- Contre-exemple -->
            <div class="rounded-xl border border-red-900/50 bg-red-950/20 p-5">
              <div class="flex items-start gap-3">
                <svg
                  class="w-5 h-5 text-red-400 mt-0.5 shrink-0"
                  fill="currentColor"
                  viewBox="0 0 20 20"
                >
                  <path
                    fill-rule="evenodd"
                    d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z"
                    clip-rule="evenodd"
                  />
                </svg>
                <div>
                  <p class="text-sm font-medium text-red-300">À éviter</p>
                  <p class="mt-1 text-sm text-red-200/80">
                    Vidéo avec
                    <code
                      class="px-1.5 py-0.5 rounded bg-red-900/40 text-red-200"
                      >autoplay</code
                    >
                    activé, qui démarre automatiquement au chargement de la
                    page.
                  </p>
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
&lt;!-- ✅ BON : Vidéo sans autoplay --&gt;
&lt;video 
  controls 
  poster=&quot;/images/video-thumbnail.jpg&quot;
  width=&quot;100%&quot;
&gt;
  &lt;source src=&quot;/videos/presentation.mp4&quot; type=&quot;video/mp4&quot;&gt;
  &lt;source src=&quot;/videos/presentation.webm&quot; type=&quot;video/webm&quot;&gt;
  &lt;track 
    kind=&quot;captions&quot; 
    src=&quot;/videos/captions-fr.vtt&quot; 
    srclang=&quot;fr&quot; 
    label=&quot;Français&quot;
  &gt;
  Votre navigateur ne supporte pas la balise vidéo.
&lt;/video&gt;

&lt;!-- ✅ BON : Vidéo YouTube sans autoplay --&gt;
&lt;iframe 
  width=&quot;560&quot; 
  height=&quot;315&quot;
  src=&quot;https://www.youtube.com/embed/VIDEO_ID&quot;
  title=&quot;Titre de la vidéo&quot;
  frameborder=&quot;0&quot;
  allow=&quot;accelerometer; clipboard-write; encrypted-media; gyroscope; picture-in-picture&quot;
  allowfullscreen
&gt;&lt;/iframe&gt;

&lt;!-- ❌ MAUVAIS : Vidéo avec autoplay --&gt;
&lt;video 
  controls 
  autoplay
  poster=&quot;/images/video-thumbnail.jpg&quot;
&gt;
  &lt;source src=&quot;/videos/presentation.mp4&quot; type=&quot;video/mp4&quot;&gt;
&lt;/video&gt;

&lt;!-- ❌ MAUVAIS : YouTube avec autoplay activé --&gt;
&lt;iframe 
  src=&quot;https://www.youtube.com/embed/VIDEO_ID?autoplay=1&quot;
  ...
&gt;&lt;/iframe&gt;
</code>
</pre>

            <div class="mt-4 space-y-3">
              <div class="rounded-lg border border-zinc-800 bg-zinc-900/50 p-4">
                <p class="text-xs font-medium text-zinc-300">
                  💡 Bonnes pratiques
                </p>
                <ul class="mt-2 space-y-1.5 text-xs text-zinc-400">
                  <li>
                    • Toujours inclure l'attribut
                    <code class="text-zinc-300">controls</code>
                  </li>
                  <li>
                    • Définir une image de prévisualisation avec
                    <code class="text-zinc-300">poster</code>
                  </li>
                  <li>
                    • Fournir des sous-titres avec
                    <code class="text-zinc-300">&lt;track&gt;</code>
                  </li>
                  <li>
                    • Ne jamais utiliser
                    <code class="text-zinc-300">autoplay</code> sans
                    <code class="text-zinc-300">muted</code>
                  </li>
                  <li>
                    • Pour les vidéos d'ambiance, utiliser
                    <code class="text-zinc-300">autoplay muted loop</code>
                  </li>
                </ul>
              </div>

              <p class="text-xs text-zinc-500">
                Le contrôle utilisateur sur la lecture des vidéos est essentiel
                pour l'accessibilité, les performances et l'expérience
                utilisateur globale.
              </p>
            </div>
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
