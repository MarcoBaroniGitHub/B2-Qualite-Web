<script setup>
import { getRuleById } from '~/data/rules'
const ruleId = 20
const rule = getRuleById(ruleId)
const activeTab = ref('preview')
</script>

<template>
  <section v-if="rule" class="space-y-6">
    <header class="space-y-3">
      <button @click="$router.back()" class="inline-flex items-center gap-2 text-sm text-zinc-400 hover:text-zinc-200 transition">← Retour</button>
      <div class="text-sm text-zinc-400">Règle n° {{ rule.id }}</div>
      <h1 class="text-2xl sm:text-3xl font-semibold tracking-tight text-zinc-100">{{ rule.title }}</h1>
      <div class="text-base sm:text-sm tracking-tight text-zinc-300">{{ rule.description }}</div>
      <div class="flex flex-wrap gap-2">
        <span v-for="tag in rule.tags" :key="tag" class="text-xs rounded-full border border-zinc-800 bg-zinc-900/30 px-2.5 py-1 text-zinc-300">{{ tag }}</span>
      </div>
      <div v-if="rule.authors && rule.authors.length" class="text-sm text-zinc-400">Écrit par <span class="text-zinc-300">{{ rule.authors.join(', ') }}</span></div>
    </header>

    <section class="rounded-2xl border border-zinc-800 bg-zinc-900/30 p-6">
      <h2 class="text-lg font-semibold tracking-tight text-zinc-100">Objectif</h2>
      <ul v-if="Array.isArray(rule.objectives)" class="mt-3 list-disc pl-5 space-y-2 text-sm text-zinc-300">
        <li v-for="o in rule.objectives" :key="o">{{ o }}</li>
      </ul>
      <p v-else class="mt-1 text-sm text-zinc-300">{{ rule.objective }}</p>
    </section>

    <section class="rounded-2xl border border-zinc-800 bg-zinc-900/30 p-6">
      <h2 class="text-lg font-semibold tracking-tight text-zinc-100">Mise en œuvre</h2>
      <p v-if="rule.implementationIntro" class="mt-3 text-sm text-zinc-400">{{ rule.implementationIntro }}</p>
      <ul v-if="rule.implementation && rule.implementation.length" class="mt-3 list-disc pl-5 space-y-2 text-sm text-zinc-300">
        <li v-for="x in rule.implementation" :key="x">{{ x }}</li>
      </ul>
    </section>

    <section class="rounded-2xl border border-zinc-800 bg-zinc-900/30 p-6">
      <h2 class="text-lg font-semibold tracking-tight text-zinc-100">Contrôle</h2>
      <ul class="mt-3 list-disc pl-5 space-y-2 text-sm text-zinc-300">
        <li v-for="c in rule.control" :key="c">{{ c }}</li>
      </ul>
    </section>

    <section class="space-y-4">
      <h2 class="text-lg font-semibold tracking-tight text-zinc-100">Screenshots</h2>
      <div class="flex gap-4 overflow-x-auto pb-4 scrollbar-light">
        <div v-for="(source, index) in rule.screenshotsSources" :key="source + index" class="shrink-0 w-[280px] sm:w-[340px]">
          <div class="aspect-[16/10] rounded-2xl border border-zinc-800 bg-zinc-900/20 overflow-hidden flex items-center justify-center">
            <a :href="`/screenshots/rule-${rule.id}/screenshot-${index + 1}.png`" target="_blank" rel="noreferrer" class="block cursor-zoom-in">
              <img :src="`/screenshots/rule-${rule.id}/screenshot-${index + 1}.png`" :alt="`Exemple d'application de la règle ${rule.id}`" class="h-full w-full object-cover" onerror="this.style.display = 'none'; this.nextElementSibling.style.display = 'block'" />
            </a>
            <div class="hidden text-center px-4"><div class="text-sm text-zinc-300 font-medium">Screenshot à ajouter</div><div class="mt-1 text-xs text-zinc-500">Exemple réel attendu</div></div>
          </div>
          <div class="mt-2 text-xs text-zinc-500">Source : <a :href="source" target="_blank" rel="noreferrer" class="underline underline-offset-4 hover:text-zinc-300">{{ source }}</a></div>
        </div>
      </div>
    </section>

    <section class="space-y-4">
      <h2 class="text-lg font-semibold tracking-tight text-zinc-100">Exemples</h2>
      <div class="rounded-2xl border border-zinc-800 bg-zinc-900/30 overflow-hidden">
        <div class="flex border-b border-zinc-800">
          <button @click="activeTab = 'preview'" :class="['px-5 py-3 text-sm transition', activeTab === 'preview' ? 'text-zinc-100 border-b-2 border-zinc-100' : 'text-zinc-400 hover:text-zinc-200']">Rendu</button>
          <button @click="activeTab = 'code'" :class="['px-5 py-3 text-sm transition', activeTab === 'code' ? 'text-zinc-100 border-b-2 border-zinc-100' : 'text-zinc-400 hover:text-zinc-200']">Code</button>
        </div>
        <div class="p-6">
          <div v-if="activeTab === 'preview'" class="space-y-4">
            <div class="text-sm text-zinc-400">Interface de suppression de compte</div>
            <div class="rounded-xl border border-zinc-800 bg-zinc-950 p-6 max-w-lg mx-auto">
              <h3 class="text-lg font-semibold text-zinc-100 mb-2">Paramètres du compte</h3>
              <p class="text-sm text-zinc-400 mb-6">Gérez vos informations et préférences</p>
              <div class="space-y-4">
                <div class="rounded-lg border border-zinc-700 bg-zinc-900/30 p-4"><h4 class="text-sm font-medium text-zinc-200 mb-2">Informations personnelles</h4><button class="text-sm text-blue-400 hover:text-blue-300">Modifier</button></div>
                <div class="rounded-lg border border-zinc-700 bg-zinc-900/30 p-4"><h4 class="text-sm font-medium text-zinc-200 mb-2">Sécurité</h4><button class="text-sm text-blue-400 hover:text-blue-300">Changer le mot de passe</button></div>
                <div class="rounded-lg border-2 border-red-900/50 bg-red-950/20 p-4">
                  <h4 class="text-sm font-medium text-red-200 mb-2">⚠️ Zone dangereuse</h4>
                  <p class="text-xs text-zinc-400 mb-3">La suppression de votre compte est définitive et irréversible. Toutes vos données seront perdues.</p>
                  <button class="w-full rounded-lg bg-red-900 px-4 py-2 text-sm font-medium text-red-100 hover:bg-red-800 transition">Supprimer mon compte</button>
                </div>
              </div>
            </div>
            <div class="rounded-lg border border-zinc-700 bg-zinc-900/50 p-4 text-xs text-zinc-400">
              <p class="font-medium text-zinc-300 mb-2">💡 Point clé de la règle 20 :</p>
              <p>Si un utilisateur peut créer un compte en ligne facilement, il doit pouvoir le supprimer avec la même facilité. Pas besoin d'envoyer un courrier recommandé ou d'appeler un service client. Un bouton accessible depuis les paramètres suffit, avec une confirmation pour éviter les accidents.</p>
            </div>
          </div>
          <div v-else>
            <pre class="rounded-xl bg-zinc-950 p-5 overflow-x-auto text-sm text-zinc-100"><code>&lt;!-- Formulaire de suppression de compte --&gt;
&lt;section class="account-deletion"&gt;
  &lt;h3&gt;Zone dangereuse&lt;/h3&gt;
  
  &lt;div class="warning-box"&gt;
    &lt;p&gt;La suppression de votre compte est définitive.&lt;/p&gt;
    &lt;ul&gt;
      &lt;li&gt;Toutes vos données seront supprimées&lt;/li&gt;
      &lt;li&gt;Vos abonnements seront annulés&lt;/li&gt;
      &lt;li&gt;Cette action est irréversible&lt;/li&gt;
    &lt;/ul&gt;
  &lt;/div&gt;

  &lt;!-- Processus de confirmation en 2 étapes --&gt;
  &lt;form action="/account/delete" method="POST"&gt;
    &lt;!-- Étape 1 : Confirmation par mot de passe --&gt;
    &lt;div&gt;
      &lt;label for="password"&gt;
        Confirmez avec votre mot de passe
      &lt;/label&gt;
      &lt;input 
        type="password" 
        id="password" 
        name="password" 
        required
      /&gt;
    &lt;/div&gt;

    &lt;!-- Étape 2 : Case à cocher de confirmation --&gt;
    &lt;div&gt;
      &lt;input 
        type="checkbox" 
        id="confirm" 
        name="confirm" 
        required
      /&gt;
      &lt;label for="confirm"&gt;
        Je comprends que cette action est irréversible
      &lt;/label&gt;
    &lt;/div&gt;

    &lt;button type="submit" class="danger-btn"&gt;
      Supprimer définitivement mon compte
    &lt;/button&gt;
  &lt;/form&gt;
&lt;/section&gt;</code></pre>
            <p class="mt-3 text-xs text-zinc-500"><strong>Bonnes pratiques :</strong><br />• Demander confirmation (mot de passe + case à cocher)<br />• Expliquer clairement les conséquences<br />• Proposer un délai de grâce avant suppression définitive<br />• Envoyer un email de confirmation après la demande<br />• Permettre l'annulation pendant le délai de grâce</p>
          </div>
        </div>
      </div>
    </section>
  </section>

  <section v-else class="rounded-2xl border border-zinc-800 bg-zinc-900/30 p-6">
    <h1 class="text-lg font-semibold text-zinc-100">Règle introuvable</h1>
    <p class="mt-2 text-sm text-zinc-400">Vérifiez que la règle existe dans <code class="text-zinc-300">rules.json</code>.</p>
  </section>
</template>

<style scoped>
.scrollbar-light { scrollbar-color: transparent transparent; border-radius: 4px; }
.scrollbar-light:hover { scrollbar-color: #a3a3a3 transparent; border-radius: 4px; }
</style>
