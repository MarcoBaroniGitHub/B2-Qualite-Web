<script setup>
import { getRuleById } from '~/data/rules'
const ruleId = 19
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
            <div class="text-sm text-zinc-400">Interface d'activation de l'authentification à deux facteurs</div>
            <div class="rounded-xl border border-zinc-800 bg-zinc-950 p-6 max-w-lg mx-auto">
              <h3 class="text-lg font-semibold text-zinc-100 mb-4">Sécurité du compte</h3>
              <div class="rounded-lg border border-zinc-700 bg-zinc-900/50 p-4">
                <div class="flex items-center justify-between mb-3">
                  <div><h4 class="text-sm font-semibold text-zinc-200">Authentification à deux facteurs</h4><p class="text-xs text-zinc-400 mt-1">Ajoutez une couche de sécurité supplémentaire</p></div>
                  <div class="w-12 h-6 bg-zinc-700 rounded-full relative cursor-pointer"><div class="w-5 h-5 bg-zinc-400 rounded-full absolute top-0.5 left-0.5 transition"></div></div>
                </div>
                <button class="w-full rounded-lg bg-blue-600 px-4 py-2 text-sm font-medium text-white hover:bg-blue-700 transition">Activer la 2FA</button>
              </div>
              <div class="mt-4 space-y-2 text-xs text-zinc-400">
                <p>Options disponibles :</p>
                <ul class="list-disc pl-5 space-y-1"><li>Application d'authentification (Google Authenticator, Authy)</li><li>SMS sur votre téléphone</li><li>Email de confirmation</li></ul>
              </div>
            </div>
            <div class="rounded-lg border border-zinc-700 bg-zinc-900/50 p-4 text-xs text-zinc-400">
              <p class="font-medium text-zinc-300 mb-2">💡 Point clé de la règle 19 :</p>
              <p>L'authentification à deux facteurs (2FA) ajoute une étape de vérification lors de la connexion, en plus du mot de passe. Même si quelqu'un obtient votre mot de passe, il ne pourra pas accéder à votre compte sans le second facteur (code temporaire, SMS, etc.).</p>
            </div>
          </div>
          <div v-else>
            <pre class="rounded-xl bg-zinc-950 p-5 overflow-x-auto text-sm text-zinc-100"><code>// Implémentation 2FA avec speakeasy (TOTP)
const speakeasy = require('speakeasy');
const QRCode = require('qrcode');

// 1. Génération du secret pour l'utilisateur
async function enable2FA(userId) {
  const secret = speakeasy.generateSecret({
    name: 'MonApp (user@example.com)'
  });
  
  // Sauvegarder le secret en DB
  await User.update(userId, {
    twoFactorSecret: secret.base32,
    twoFactorEnabled: false // Pas encore activé
  });

  // Générer QR code pour l'app mobile
  const qrCodeUrl = await QRCode.toDataURL(secret.otpauth_url);
  
  return { secret: secret.base32, qrCode: qrCodeUrl };
}

// 2. Vérification du code lors de la connexion
function verify2FA(userSecret, userToken) {
  return speakeasy.totp.verify({
    secret: userSecret,
    encoding: 'base32',
    token: userToken,
    window: 2 // Accepte codes ±2 intervalles
  });
}</code></pre>
            <p class="mt-3 text-xs text-zinc-500"><strong>Bonnes pratiques :</strong><br />• Proposer plusieurs méthodes 2FA (app, SMS, email)<br />• Générer des codes de secours en cas de perte d'accès<br />• Ne jamais forcer la 2FA brutalement (période de transition)<br />• Permettre la désactivation avec vérification renforcée</p>
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
