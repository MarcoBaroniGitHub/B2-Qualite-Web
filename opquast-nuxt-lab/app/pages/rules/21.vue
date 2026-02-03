<script setup>
import { getRuleById } from '~/data/rules'
const ruleId = 21
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
            <div class="text-sm text-zinc-400">Interface d'export des données personnelles</div>
            <div class="rounded-xl border border-zinc-800 bg-zinc-950 p-6 max-w-lg mx-auto">
              <h3 class="text-lg font-semibold text-zinc-100 mb-2">Télécharger vos données</h3>
              <p class="text-sm text-zinc-400 mb-6">Exportez une copie de toutes vos données personnelles</p>
              <div class="rounded-lg border border-zinc-700 bg-zinc-900/50 p-5 mb-4">
                <h4 class="text-sm font-semibold text-zinc-200 mb-3">Que contient l'export ?</h4>
                <ul class="space-y-2 text-sm text-zinc-300">
                  <li class="flex items-center gap-2"><span>✓</span><span>Informations de profil</span></li>
                  <li class="flex items-center gap-2"><span>✓</span><span>Historique des commandes</span></li>
                  <li class="flex items-center gap-2"><span>✓</span><span>Contenus publiés</span></li>
                  <li class="flex items-center gap-2"><span>✓</span><span>Paramètres et préférences</span></li>
                </ul>
              </div>
              <div class="rounded-lg border border-blue-900/50 bg-blue-950/20 p-4 mb-4">
                <div class="flex items-start gap-3">
                  <span class="text-xl">📦</span>
                  <div class="flex-1"><h4 class="text-sm font-medium text-blue-200 mb-1">Format de l'export</h4><p class="text-xs text-zinc-400">Archive ZIP contenant vos données en JSON + fichiers joints</p></div>
                </div>
              </div>
              <button class="w-full rounded-lg bg-blue-600 px-4 py-2.5 text-sm font-medium text-white hover:bg-blue-700 transition">Créer l'export</button>
              <p class="mt-3 text-xs text-center text-zinc-500">Le fichier sera prêt dans quelques minutes et vous recevrez un email avec le lien de téléchargement.</p>
            </div>
            <div class="rounded-lg border border-zinc-700 bg-zinc-900/50 p-4 text-xs text-zinc-400">
              <p class="font-medium text-zinc-300 mb-2">💡 Point clé de la règle 21 :</p>
              <p>Les utilisateurs doivent pouvoir récupérer leurs données dans un format standard et réutilisable (JSON, CSV, XML). Cela leur permet de migrer vers un autre service, de faire des sauvegardes, ou simplement de consulter leurs données hors ligne. C'est aussi une obligation RGPD.</p>
            </div>
          </div>
          <div v-else>
            <pre class="rounded-xl bg-zinc-950 p-5 overflow-x-auto text-sm text-zinc-100"><code>// Backend : Génération de l'export utilisateur
const archiver = require('archiver');
const fs = require('fs');

async function exportUserData(userId) {
  // 1. Récupérer toutes les données de l'utilisateur
  const user = await User.findById(userId);
  const orders = await Order.find({ userId });
  const posts = await Post.find({ authorId: userId });
  
  // 2. Créer la structure de données JSON
  const exportData = {
    user: {
      email: user.email,
      name: user.name,
      createdAt: user.createdAt,
      preferences: user.preferences
    },
    orders: orders.map(o => ({
      id: o.id,
      date: o.date,
      items: o.items,
      total: o.total
    })),
    posts: posts.map(p => ({
      id: p.id,
      title: p.title,
      content: p.content,
      createdAt: p.createdAt
    }))
  };

  // 3. Créer l'archive ZIP
  const output = fs.createWriteStream(`exports/user_${userId}.zip`);
  const archive = archiver('zip', { zlib: { level: 9 } });
  
  archive.pipe(output);
  
  // Ajouter le fichier JSON principal
  archive.append(
    JSON.stringify(exportData, null, 2),
    { name: 'data.json' }
  );
  
  // Ajouter un README explicatif
  archive.append(
    '# Export de vos données\\n\\nCe fichier contient...',
    { name: 'README.txt' }
  );
  
  // Ajouter les fichiers joints (photos, documents)
  for (const file of user.uploadedFiles) {
    archive.file(file.path, { name: `files/${file.name}` });
  }
  
  await archive.finalize();
  
  // 4. Envoyer l'email avec le lien
  await sendExportEmail(user.email, `exports/user_${userId}.zip`);
  
  return 'Export créé avec succès';
}</code></pre>
            <p class="mt-3 text-xs text-zinc-500"><strong>Bonnes pratiques :</strong><br />• Utiliser des formats standards (JSON, CSV) + README<br />• Inclure tous les types de données (texte, images, fichiers)<br />• Générer l'export de manière asynchrone (tâche en arrière-plan)<br />• Envoyer un email avec lien de téléchargement temporaire<br />• Supprimer l'archive après quelques jours pour respecter la confidentialité</p>
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
