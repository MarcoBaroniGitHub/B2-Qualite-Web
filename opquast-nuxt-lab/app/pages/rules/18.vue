<script setup>
import { getRuleById } from '~/data/rules'
const ruleId = 18
const rule = getRuleById(ruleId)
const activeTab = ref('preview')
// État pour la simulation d'email
const showConfirmation = ref(false)
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
            <div class="hidden text-center px-4">
              <div class="text-sm text-zinc-300 font-medium">Screenshot à ajouter</div>
              <div class="mt-1 text-xs text-zinc-500">Exemple réel attendu</div>
            </div>
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
            <div class="text-sm text-zinc-400">Simulation du processus de confirmation</div>

            <!-- Message après inscription -->
            <div v-if="!showConfirmation" class="rounded-xl border border-zinc-800 bg-zinc-950 p-6 max-w-md mx-auto">
              <button @click="showConfirmation = true" class="w-full rounded-lg bg-blue-600 px-4 py-2.5 text-sm font-medium text-white hover:bg-blue-700 transition">S'inscrire (démo)</button>
            </div>

            <!-- ⭐ EMAIL DE CONFIRMATION - ÉLÉMENT CLÉ DE LA RÈGLE 18 ⭐ -->
            <div v-else class="space-y-4">
              <!-- Message de succès -->
              <div class="rounded-xl border border-green-900/50 bg-green-950/20 p-6">
                <div class="flex items-center gap-3 mb-4">
                  <span class="text-2xl">✅</span>
                  <h3 class="text-lg font-semibold text-green-200">Inscription réussie !</h3>
                </div>
                <p class="text-sm text-zinc-300">Nous vous avons envoyé un email de confirmation à <strong>votre@email.com</strong></p>
              </div>

              <!-- Simulation de l'email reçu -->
              <div class="rounded-xl border-2 border-blue-900/50 bg-zinc-950 p-6">
                <div class="flex items-center justify-between mb-4 pb-3 border-b border-zinc-800">
                  <div><div class="text-xs text-zinc-500 mb-1">De: noreply@exemple.fr</div><div class="text-sm font-medium text-zinc-200">Confirmez votre compte</div></div>
                  <span class="text-xs text-zinc-500">À l'instant</span>
                </div>
                <div class="space-y-4 text-sm text-zinc-300">
                  <p>Bonjour,</p>
                  <p>Merci de vous être inscrit ! Pour activer votre compte, veuillez cliquer sur le bouton ci-dessous :</p>
                  <!-- Le lien de confirmation avec token unique -->
                  <div class="my-6">
                    <a href="#" class="inline-block rounded-lg bg-blue-600 px-6 py-3 text-sm font-medium text-white hover:bg-blue-700 transition">Confirmer mon compte</a>
                  </div>
                  <p class="text-xs text-zinc-400">Ce lien est valable 48 heures. Si vous n'avez pas créé de compte, ignorez cet email.</p>
                  <p class="text-xs text-zinc-500 pt-4 border-t border-zinc-800">URL complète : https://exemple.fr/confirm?token=abc123xyz789def</p>
                </div>
              </div>

              <!-- Explication du process -->
              <div class="rounded-lg border border-zinc-700 bg-zinc-900/50 p-4 text-xs text-zinc-400">
                <p class="font-medium text-zinc-300 mb-2">💡 Point clé de la règle 18 :</p>
                <p>Le compte n'est <strong>pas immédiatement actif</strong>. L'utilisateur doit cliquer sur le lien dans l'email pour confirmer son adresse. Cela garantit que l'email appartient bien à la personne qui s'est inscrite et empêche les inscriptions frauduleuses.</p>
              </div>
            </div>
          </div>

          <div v-else>
            <pre class="rounded-xl bg-zinc-950 p-5 overflow-x-auto text-sm text-zinc-100"><code>// Backend : Génération du token de confirmation
const crypto = require('crypto');

// 1. Lors de l'inscription
async function createUser(email, password) {
  // Générer un token unique et aléatoire
  const confirmationToken = crypto.randomBytes(32).toString('hex');
  
  // Créer l'utilisateur avec le statut "non confirmé"
  const user = await User.create({
    email: email,
    password: hashPassword(password),
    confirmed: false,  // ⭐ COMPTE NON ACTIVÉ
    confirmationToken: confirmationToken,
    tokenExpiry: Date.now() + 48 * 60 * 60 * 1000 // 48h
  });

  // 2. Envoyer l'email de confirmation
  await sendConfirmationEmail(email, confirmationToken);
  
  return user;
}

// 3. Route de confirmation
app.get('/confirm', async (req, res) => {
  const { token } = req.query;
  
  // Vérifier le token
  const user = await User.findOne({
    confirmationToken: token,
    tokenExpiry: { $gt: Date.now() }
  });

  if (!user) {
    return res.status(400).send('Token invalide ou expiré');
  }

  // ⭐ ACTIVER LE COMPTE ⭐
  user.confirmed = true;
  user.confirmationToken = null;
  await user.save();

  res.send('Compte confirmé avec succès !');
});</code></pre>
            <p class="mt-3 text-xs text-zinc-500"><strong>Bonnes pratiques :</strong><br />• Générer un token cryptographiquement sécurisé<br />• Définir une date d'expiration (24-48h)<br />• Bloquer la connexion tant que le compte n'est pas confirmé<br />• Permettre de renvoyer l'email de confirmation<br />• Nettoyer les tokens après utilisation</p>
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
.scrollbar-dark { scrollbar-color: transparent transparent; border-radius: 4px; }
.scrollbar-light:hover { scrollbar-color: #a3a3a3 transparent; border-radius: 4px; }
.scrollbar-dark:hover { scrollbar-color: #4d4d4d transparent; border-radius: 4px; }
</style>
