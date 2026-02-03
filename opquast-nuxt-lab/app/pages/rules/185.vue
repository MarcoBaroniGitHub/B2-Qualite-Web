<!-- 
  Règle Qualité Web : Masquage accessible du contenu
  
  Objectifs :
  - Faciliter l'adaptation du rendu (mobile, agrandissement, etc.)
  - Améliorer l'accessibilité aux personnes handicapées
  - Permettre aux lecteurs d'écran d'accéder au contenu pertinent
-->

<template>
  <div class="accessibility-demo">
    <!-- En-tête -->
    <header class="page-header">
      <h1>Techniques de masquage accessible</h1>
      <p class="subtitle">
        Guide des bonnes pratiques pour masquer du contenu tout en préservant l'accessibilité
      </p>
    </header>

    <!-- Navigation avec indicateur d'état -->
    <nav class="demo-navigation" aria-label="Navigation de démonstration">
      <button
        v-for="section in sections"
        :key="section.id"
        :class="['nav-button', { active: activeSection === section.id }]"
        @click="activeSection = section.id"
        :aria-current="activeSection === section.id ? 'page' : undefined"
      >
        {{ section.label }}
        <span class="sr-only" v-if="activeSection === section.id">
          (section actuelle)
        </span>
      </button>
    </nav>

    <main class="demo-content">
      
      <!-- ===== SECTION 1 : MAUVAISES PRATIQUES ===== -->
      <section v-show="activeSection === 'bad'" class="demo-section">
        <h2>❌ Techniques à éviter</h2>
        <p class="intro-text">
          Ces techniques masquent le contenu de manière non accessible, 
          empêchant les lecteurs d'écran et les technologies d'assistance d'y accéder.
        </p>

        <!-- Mauvais exemple 1 : display: none -->
        <div class="example-card bad">
          <h3>❌ display: none</h3>
          <div class="code-block">
            <pre><code>/* ❌ MAUVAIS */
.hidden-content {
  display: none;
}</code></pre>
          </div>
          <p class="explanation">
            <strong>Problème :</strong> Le contenu est complètement retiré du DOM accessible. 
            Les lecteurs d'écran ne peuvent pas le lire.
          </p>
          
          <!-- Démonstration -->
          <div class="demo-box">
            <p>Texte visible avant</p>
            <p style="display: none;">
              ⚠️ Ce texte est masqué avec display: none et n'est pas accessible aux lecteurs d'écran
            </p>
            <p>Texte visible après</p>
          </div>
          
          <div class="warning-box">
            ⚠️ À n'utiliser QUE pour du contenu interactif (onglets, menus déroulants) 
            qui sera affiché sur action utilisateur.
          </div>
        </div>

        <!-- Mauvais exemple 2 : visibility: hidden -->
        <div class="example-card bad">
          <h3>❌ visibility: hidden</h3>
          <div class="code-block">
            <pre><code>/* ❌ MAUVAIS */
.invisible-content {
  visibility: hidden;
}</code></pre>
          </div>
          <p class="explanation">
            <strong>Problème :</strong> Masque le contenu visuellement ET pour les lecteurs d'écran.
          </p>
          
          <div class="demo-box">
            <p>Texte visible avant</p>
            <p style="visibility: hidden;">
              ⚠️ Ce texte est masqué avec visibility: hidden
            </p>
            <p>Texte visible après (notez l'espace vide)</p>
          </div>
        </div>

        <!-- Mauvais exemple 3 : hidden attribute -->
        <div class="example-card bad">
          <h3>❌ Attribut HTML hidden</h3>
          <div class="code-block">
            <pre><code>&lt;!-- ❌ MAUVAIS --&gt;
&lt;p hidden&gt;Contenu masqué&lt;/p&gt;</code></pre>
          </div>
          <p class="explanation">
            <strong>Problème :</strong> Équivalent à display: none, retire le contenu de l'arbre d'accessibilité.
          </p>
          
          <div class="demo-box">
            <p>Texte visible avant</p>
            <p hidden>
              ⚠️ Ce texte est masqué avec l'attribut hidden
            </p>
            <p>Texte visible après</p>
          </div>
        </div>

        <!-- Mauvais exemple 4 : aria-hidden="true" -->
        <div class="example-card bad">
          <h3>❌ aria-hidden="true" sur contenu pertinent</h3>
          <div class="code-block">
            <pre><code>&lt;!-- ❌ MAUVAIS pour contenu important --&gt;
&lt;p aria-hidden="true"&gt;
  Information importante
&lt;/p&gt;</code></pre>
          </div>
          <p class="explanation">
            <strong>Problème :</strong> Cache le contenu aux lecteurs d'écran même s'il est visible à l'écran.
          </p>
          
          <div class="demo-box">
            <p>Texte visible avant</p>
            <p aria-hidden="true" style="color: #e74c3c; font-weight: bold;">
              ⚠️ Ce texte est VISIBLE à l'écran mais MASQUÉ aux lecteurs d'écran
            </p>
            <p>Texte visible après</p>
          </div>
          
          <div class="info-box">
            ℹ️ aria-hidden="true" est acceptable UNIQUEMENT pour masquer des éléments 
            décoratifs (icônes, séparateurs) qui ont une alternative textuelle.
          </div>
        </div>
      </section>

      <!-- ===== SECTION 2 : BONNES PRATIQUES ===== -->
      <section v-show="activeSection === 'good'" class="demo-section">
        <h2>✅ Techniques accessibles</h2>
        <p class="intro-text">
          Ces techniques permettent de masquer visuellement du contenu tout en le gardant 
          accessible aux lecteurs d'écran et technologies d'assistance.
        </p>

        <!-- Bonne pratique 1 : Classe sr-only -->
        <div class="example-card good">
          <h3>✅ Classe "screen reader only" (sr-only)</h3>
          <div class="code-block">
            <pre><code>/* ✅ BON - Masque visuellement, accessible aux lecteurs d'écran */
.sr-only {
  position: absolute;
  width: 1px;
  height: 1px;
  padding: 0;
  margin: -1px;
  overflow: hidden;
  clip: rect(0, 0, 0, 0);
  white-space: nowrap;
  border: 0;
}</code></pre>
          </div>
          <p class="explanation">
            <strong>Avantage :</strong> Le contenu est invisible visuellement mais reste 
            dans le DOM accessible pour les lecteurs d'écran.
          </p>
          
          <div class="demo-box">
            <button class="demo-button">
              <svg class="icon" aria-hidden="true" width="20" height="20" viewBox="0 0 20 20">
                <path d="M10 2L2 18h16L10 2z" fill="currentColor"/>
              </svg>
              <span class="sr-only">Télécharger le document</span>
            </button>
            <p class="success-note">
              ✓ Le bouton ci-dessus affiche uniquement une icône visuellement, 
              mais les lecteurs d'écran annonceront "Télécharger le document"
            </p>
          </div>
        </div>

        <!-- Bonne pratique 2 : Position off-screen -->
        <div class="example-card good">
          <h3>✅ Position hors écran avec text-indent</h3>
          <div class="code-block">
            <pre><code>/* ✅ BON - Alternative pour masquer du texte */
.visually-hidden {
  position: absolute;
  left: -10000px;
  width: 1px;
  height: 1px;
  overflow: hidden;
}</code></pre>
          </div>
          <p class="explanation">
            <strong>Avantage :</strong> Place le contenu hors de la zone visible 
            tout en le gardant accessible.
          </p>
          
          <div class="demo-box">
            <h3 class="logo-heading">
              <span class="visually-hidden-offscreen">MonEntreprise - Retour à l'accueil</span>
              <span aria-hidden="true">🏢</span>
            </h3>
            <p class="success-note">
              ✓ Le logo ci-dessus affiche une icône, mais contient un texte descriptif 
              pour les lecteurs d'écran
            </p>
          </div>
        </div>

        <!-- Bonne pratique 3 : aria-label -->
        <div class="example-card good">
          <h3>✅ aria-label pour étiquettes invisibles</h3>
          <div class="code-block">
            <pre><code>&lt;!-- ✅ BON - Label accessible sans texte visible --&gt;
&lt;button aria-label="Fermer la fenêtre"&gt;
  &lt;svg aria-hidden="true"&gt;...&lt;/svg&gt;
&lt;/button&gt;</code></pre>
          </div>
          <p class="explanation">
            <strong>Avantage :</strong> Fournit une étiquette accessible sans ajouter 
            de texte visible à l'écran.
          </p>
          
          <div class="demo-box">
            <button class="icon-button" aria-label="Fermer la fenêtre">
              <span aria-hidden="true">✕</span>
            </button>
            <button class="icon-button" aria-label="Paramètres">
              <span aria-hidden="true">⚙</span>
            </button>
            <button class="icon-button" aria-label="Favoris">
              <span aria-hidden="true">★</span>
            </button>
            <p class="success-note">
              ✓ Ces boutons n'ont que des icônes visuellement, mais aria-label 
              fournit un nom accessible
            </p>
          </div>
        </div>

        <!-- Bonne pratique 4 : aria-labelledby / aria-describedby -->
        <div class="example-card good">
          <h3>✅ aria-labelledby et aria-describedby</h3>
          <div class="code-block">
            <pre><code>&lt;!-- ✅ BON - Associer des labels existants --&gt;
&lt;div role="region" aria-labelledby="section-title" 
     aria-describedby="section-desc"&gt;
  &lt;h2 id="section-title"&gt;Titre&lt;/h2&gt;
  &lt;p id="section-desc"&gt;Description&lt;/p&gt;
  &lt;!-- Contenu --&gt;
&lt;/div&gt;</code></pre>
          </div>
          <p class="explanation">
            <strong>Avantage :</strong> Réutilise du contenu existant pour créer 
            des relations accessibles.
          </p>
          
          <div class="demo-box">
            <div 
              class="info-panel" 
              role="region" 
              aria-labelledby="panel-title" 
              aria-describedby="panel-description"
            >
              <h4 id="panel-title">Information importante</h4>
              <p id="panel-description">
                Ce panneau utilise aria-labelledby pour associer le titre 
                et aria-describedby pour la description.
              </p>
              <p>Contenu additionnel du panneau...</p>
            </div>
            <p class="success-note">
              ✓ Les lecteurs d'écran annonceront le titre et la description 
              lors de l'entrée dans cette région
            </p>
          </div>
        </div>

        <!-- Bonne pratique 5 : title sur les champs de formulaire -->
        <div class="example-card good">
          <h3>✅ Attribut title pour les champs de formulaire</h3>
          <div class="code-block">
            <pre><code>&lt;!-- ✅ BON - Quand label visible n'est pas possible --&gt;
&lt;input type="search" 
       title="Rechercher dans le site"
       placeholder="Rechercher..." /&gt;</code></pre>
          </div>
          <p class="explanation">
            <strong>Avantage :</strong> Fournit un label accessible même sans 
            élément &lt;label&gt; visible.
          </p>
          
          <div class="demo-box">
            <div class="search-container">
              <input
                type="search"
                title="Rechercher dans le catalogue de produits"
                placeholder="Rechercher..."
                class="search-input"
              />
              <button 
                type="button" 
                aria-label="Lancer la recherche"
                class="search-button"
              >
                <span aria-hidden="true">🔍</span>
              </button>
            </div>
            <p class="success-note">
              ✓ Le champ de recherche utilise l'attribut title pour fournir 
              un label accessible
            </p>
          </div>
        </div>

        <!-- Bonne pratique 6 : Texte conditionnel avec clip -->
        <div class="example-card good">
          <h3>✅ Propriété clip pour masquer partiellement</h3>
          <div class="code-block">
            <pre><code>/* ✅ BON - Masque une partie du contenu */
.clipped-text {
  position: absolute;
  clip: rect(1px, 1px, 1px, 1px);
  clip-path: inset(50%);
  padding: 0;
  border: 0;
  height: 1px;
  width: 1px;
  overflow: hidden;
}</code></pre>
          </div>
          <p class="explanation">
            <strong>Avantage :</strong> Technique robuste compatible avec les anciens navigateurs.
          </p>
        </div>
      </section>

      <!-- ===== SECTION 3 : CAS D'USAGE PRATIQUES ===== -->
      <section v-show="activeSection === 'cases'" class="demo-section">
        <h2>📋 Cas d'usage pratiques</h2>

        <!-- Cas 1 : Navigation avec skip links -->
        <div class="example-card good">
          <h3>✅ Cas 1 : Liens d'évitement (Skip links)</h3>
          <p class="explanation">
            Permettre aux utilisateurs de lecteurs d'écran de sauter directement 
            au contenu principal.
          </p>
          
          <div class="code-block">
            <pre><code>&lt;!-- Lien masqué jusqu'à ce qu'il reçoive le focus --&gt;
&lt;a href="#main-content" class="skip-link"&gt;
  Aller au contenu principal
&lt;/a&gt;

&lt;style&gt;
.skip-link {
  position: absolute;
  top: -40px;
  left: 0;
  background: #000;
  color: #fff;
  padding: 8px;
  text-decoration: none;
  z-index: 100;
}

.skip-link:focus {
  top: 0; /* Apparaît au focus clavier */
}
&lt;/style&gt;</code></pre>
          </div>

          <div class="demo-box">
            <a href="#demo-main" class="skip-link-demo">
              Aller au contenu principal
            </a>
            <p class="success-note">
              ✓ Appuyez sur Tab au début de la page pour voir le lien d'évitement apparaître
            </p>
          </div>
        </div>

        <!-- Cas 2 : Compteurs visuels vs accessibles -->
        <div class="example-card good">
          <h3>✅ Cas 2 : Notifications avec compteurs</h3>
          <p class="explanation">
            Afficher un badge de notification accessible.
          </p>
          
          <div class="code-block">
            <pre><code>&lt;button aria-label="Messages (3 non lus)"&gt;
  &lt;span aria-hidden="true"&gt;💬&lt;/span&gt;
  &lt;span class="badge" aria-hidden="true"&gt;3&lt;/span&gt;
&lt;/button&gt;</code></pre>
          </div>

          <div class="demo-box">
            <button 
              class="notification-button" 
              :aria-label="`Messages (${unreadCount} non lus)`"
            >
              <span aria-hidden="true">💬</span>
              <span class="badge" aria-hidden="true">{{ unreadCount }}</span>
            </button>
            
            <button 
              class="notification-button" 
              aria-label="Notifications (aucune nouvelle)"
            >
              <span aria-hidden="true">🔔</span>
            </button>
            
            <p class="success-note">
              ✓ Les lecteurs d'écran annoncent "Messages (3 non lus)" et 
              "Notifications (aucune nouvelle)"
            </p>
          </div>
        </div>

        <!-- Cas 3 : Tableaux avec en-têtes cachés -->
        <div class="example-card good">
          <h3>✅ Cas 3 : En-têtes de tableau pour lecteurs d'écran</h3>
          <p class="explanation">
            Fournir des en-têtes de colonnes même dans un design minimaliste.
          </p>
          
          <div class="code-block">
            <pre><code>&lt;table&gt;
  &lt;thead&gt;
    &lt;tr&gt;
      &lt;th class="sr-only"&gt;Produit&lt;/th&gt;
      &lt;th class="sr-only"&gt;Prix&lt;/th&gt;
      &lt;th class="sr-only"&gt;Actions&lt;/th&gt;
    &lt;/tr&gt;
  &lt;/thead&gt;
  &lt;tbody&gt;...&lt;/tbody&gt;
&lt;/table&gt;</code></pre>
          </div>

          <div class="demo-box">
            <table class="minimal-table">
              <thead>
                <tr>
                  <th class="sr-only">Produit</th>
                  <th class="sr-only">Prix</th>
                  <th class="sr-only">Stock</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>Ordinateur portable</td>
                  <td>999€</td>
                  <td>En stock</td>
                </tr>
                <tr>
                  <td>Souris sans fil</td>
                  <td>29€</td>
                  <td>En stock</td>
                </tr>
                <tr>
                  <td>Clavier mécanique</td>
                  <td>149€</td>
                  <td>Rupture</td>
                </tr>
              </tbody>
            </table>
            <p class="success-note">
              ✓ Le tableau ci-dessus n'affiche pas visuellement les en-têtes, 
              mais ils sont disponibles pour les lecteurs d'écran
            </p>
          </div>
        </div>

        <!-- Cas 4 : Formulaire avec instructions cachées -->
        <div class="example-card good">
          <h3>✅ Cas 4 : Instructions de formulaire détaillées</h3>
          <p class="explanation">
            Fournir des instructions complètes sans encombrer visuellement le formulaire.
          </p>
          
          <div class="demo-box">
            <form class="demo-form">
              <div class="form-group">
                <label for="password-demo">
                  Mot de passe
                  <span class="sr-only">
                    : doit contenir au moins 8 caractères, une majuscule, 
                    une minuscule, un chiffre et un caractère spécial
                  </span>
                </label>
                <input
                  id="password-demo"
                  type="password"
                  class="form-input"
                  aria-describedby="password-hint"
                />
                <span id="password-hint" class="hint-text">
                  Minimum 8 caractères
                </span>
              </div>

              <div class="form-group">
                <label for="email-demo">
                  Email
                  <span class="sr-only"> (format: utilisateur@domaine.com)</span>
                </label>
                <input
                  id="email-demo"
                  type="email"
                  class="form-input"
                  placeholder="utilisateur@domaine.com"
                />
              </div>
            </form>
            <p class="success-note">
              ✓ Les lecteurs d'écran reçoivent des instructions complètes, 
              tandis que l'affichage visuel reste épuré
            </p>
          </div>
        </div>

        <!-- Cas 5 : Statut de chargement -->
        <div class="example-card good">
          <h3>✅ Cas 5 : Indicateurs de chargement accessibles</h3>
          <p class="explanation">
            Informer les utilisateurs de lecteurs d'écran qu'un chargement est en cours.
          </p>
          
          <div class="code-block">
            <pre><code>&lt;div role="status" aria-live="polite"&gt;
  &lt;span class="spinner" aria-hidden="true"&gt;⏳&lt;/span&gt;
  &lt;span class="sr-only"&gt;Chargement en cours...&lt;/span&gt;
&lt;/div&gt;</code></pre>
          </div>

          <div class="demo-box">
            <button 
              @click="simulateLoading" 
              :disabled="isLoading"
              class="demo-button"
            >
              {{ isLoading ? 'Chargement...' : 'Charger les données' }}
            </button>
            
            <div v-if="isLoading" role="status" aria-live="polite" class="loading-status">
              <span class="spinner" aria-hidden="true">⏳</span>
              <span class="sr-only">Chargement en cours, veuillez patienter</span>
            </div>
            
            <div v-if="loadingComplete" role="status" aria-live="polite" class="success-status">
              <span aria-hidden="true">✓</span>
              <span class="sr-only">Chargement terminé avec succès</span>
              Données chargées
            </div>
          </div>
        </div>
      </section>

      <!-- ===== SECTION 4 : CHECKLIST ===== -->
      <section v-show="activeSection === 'checklist'" class="demo-section">
        <h2>✓ Checklist de vérification</h2>
        
        <div class="checklist-container">
          <h3>Avant de masquer du contenu, posez-vous ces questions :</h3>
          
          <div class="checklist-item">
            <input type="checkbox" id="check1" class="checklist-checkbox" />
            <label for="check1">
              Le contenu doit-il être accessible aux lecteurs d'écran ?
            </label>
            <p class="checklist-help">
              Si OUI → utilisez .sr-only, aria-label, ou position off-screen<br>
              Si NON → vous pouvez utiliser display: none ou hidden
            </p>
          </div>

          <div class="checklist-item">
            <input type="checkbox" id="check2" class="checklist-checkbox" />
            <label for="check2">
              Le contenu sera-t-il affiché sur action utilisateur (menu, onglet) ?
            </label>
            <p class="checklist-help">
              Si OUI → display: none est acceptable<br>
              Pensez à gérer les attributs aria-expanded et aria-hidden
            </p>
          </div>

          <div class="checklist-item">
            <input type="checkbox" id="check3" class="checklist-checkbox" />
            <label for="check3">
              L'élément est-il purement décoratif (icône, séparateur) ?
            </label>
            <p class="checklist-help">
              Si OUI → utilisez aria-hidden="true"<br>
              Assurez-vous qu'une alternative textuelle existe ailleurs
            </p>
          </div>

          <div class="checklist-item">
            <input type="checkbox" id="check4" class="checklist-checkbox" />
            <label for="check4">
              Le contenu donne-t-il des informations importantes ?
            </label>
            <p class="checklist-help">
              Si OUI → NE JAMAIS utiliser display: none, hidden, ou aria-hidden="true"<br>
              Utilisez des techniques de masquage visuel accessibles
            </p>
          </div>

          <div class="checklist-item">
            <input type="checkbox" id="check5" class="checklist-checkbox" />
            <label for="check5">
              Avez-vous testé avec un lecteur d'écran ?
            </label>
            <p class="checklist-help">
              Testez avec NVDA, JAWS, ou VoiceOver pour vérifier que le contenu 
              est correctement annoncé
            </p>
          </div>
        </div>

        <div class="summary-box">
          <h3>📌 Résumé des techniques</h3>
          <table class="techniques-table">
            <thead>
              <tr>
                <th>Technique</th>
                <th>Masquage visuel</th>
                <th>Lecteur d'écran</th>
                <th>Usage recommandé</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td><code>display: none</code></td>
                <td>✓ Masqué</td>
                <td>❌ Inaccessible</td>
                <td>Contenu interactif (menus, onglets)</td>
              </tr>
              <tr>
                <td><code>visibility: hidden</code></td>
                <td>✓ Masqué</td>
                <td>❌ Inaccessible</td>
                <td>Similaire à display: none</td>
              </tr>
              <tr>
                <td><code>hidden</code> (attribut)</td>
                <td>✓ Masqué</td>
                <td>❌ Inaccessible</td>
                <td>Contenu non pertinent actuellement</td>
              </tr>
              <tr>
                <td><code>aria-hidden="true"</code></td>
                <td>❌ Visible</td>
                <td>❌ Inaccessible</td>
                <td>Éléments décoratifs uniquement</td>
              </tr>
              <tr class="good-row">
                <td><code>.sr-only</code></td>
                <td>✓ Masqué</td>
                <td>✓ Accessible</td>
                <td>✅ Texte pour lecteurs d'écran</td>
              </tr>
              <tr class="good-row">
                <td><code>aria-label</code></td>
                <td>❌ N/A</td>
                <td>✓ Accessible</td>
                <td>✅ Labels de boutons/liens</td>
              </tr>
              <tr class="good-row">
                <td><code>position: absolute</code></td>
                <td>✓ Masqué</td>
                <td>✓ Accessible</td>
                <td>✅ Alternative à .sr-only</td>
              </tr>
              <tr class="good-row">
                <td><code>clip / clip-path</code></td>
                <td>✓ Masqué</td>
                <td>✓ Accessible</td>
                <td>✅ Compatibilité navigateurs anciens</td>
              </tr>
            </tbody>
          </table>
        </div>
      </section>
    </main>

    <footer class="demo-footer">
      <p>
        💡 Testez toujours vos implémentations avec de vrais lecteurs d'écran 
        (NVDA sur Windows, VoiceOver sur macOS, TalkBack sur Android)
      </p>
    </footer>
  </div>
</template>

<script setup>
import { ref } from 'vue';

const activeSection = ref('bad');
const isLoading = ref(false);
const loadingComplete = ref(false);
const unreadCount = ref(3);

const sections = [
  { id: 'bad', label: '❌ Mauvaises pratiques' },
  { id: 'good', label: '✅ Bonnes pratiques' },
  { id: 'cases', label: '📋 Cas d\'usage' },
  { id: 'checklist', label: '✓ Checklist' }
];

function simulateLoading() {
  isLoading.value = true;
  loadingComplete.value = false;
  
  setTimeout(() => {
    isLoading.value = false;
    loadingComplete.value = true;
    
    setTimeout(() => {
      loadingComplete.value = false;
    }, 3000);
  }, 2000);
}
</script>

<style scoped>
/* ===== STYLES DE BASE ===== */
.accessibility-demo {
  max-width: 1200px;
  margin: 0 auto;
  padding: 2rem;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
  line-height: 1.6;
  color: #333;
  background: #f5f5f5;
}

/* ===== CLASSE SR-ONLY (Screen Reader Only) ===== */
.sr-only {
  position: absolute;
  width: 1px;
  height: 1px;
  padding: 0;
  margin: -1px;
  overflow: hidden;
  clip: rect(0, 0, 0, 0);
  white-space: nowrap;
  border: 0;
}

/* Alternative avec position off-screen */
.visually-hidden-offscreen {
  position: absolute;
  left: -10000px;
  width: 1px;
  height: 1px;
  overflow: hidden;
}

/* ===== SKIP LINK ===== */
.skip-link-demo {
  position: absolute;
  top: -40px;
  left: 10px;
  background: #000;
  color: #fff;
  padding: 8px 16px;
  text-decoration: none;
  z-index: 100;
  border-radius: 4px;
  font-weight: bold;
}

.skip-link-demo:focus {
  top: 10px;
}

/* ===== EN-TÊTE ===== */
.page-header {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  padding: 3rem 2rem;
  border-radius: 12px;
  text-align: center;
  margin-bottom: 2rem;
  box-shadow: 0 4px 6px rgba(0,0,0,0.1);
}

.page-header h1 {
  margin: 0 0 0.5rem;
  font-size: 2.5rem;
}

.subtitle {
  margin: 0;
  font-size: 1.1rem;
  opacity: 0.95;
}

/* ===== NAVIGATION ===== */
.demo-navigation {
  display: flex;
  gap: 1rem;
  margin-bottom: 2rem;
  flex-wrap: wrap;
}

.nav-button {
  flex: 1;
  min-width: 200px;
  padding: 1rem;
  background: white;
  border: 2px solid #ddd;
  border-radius: 8px;
  font-size: 1rem;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s;
  color: #555;
}

.nav-button:hover {
  background: #f8f9fa;
  border-color: #667eea;
  transform: translateY(-2px);
  box-shadow: 0 4px 8px rgba(0,0,0,0.1);
}

.nav-button.active {
  background: #667eea;
  color: white;
  border-color: #667eea;
}

.nav-button:focus {
  outline: 3px solid #667eea;
  outline-offset: 2px;
}

/* ===== CONTENU PRINCIPAL ===== */
.demo-content {
  background: white;
  padding: 2rem;
  border-radius: 12px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.demo-section {
  animation: fadeIn 0.3s ease-in;
}

@keyframes fadeIn {
  from {
    opacity: 0;
    transform: translateY(10px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.demo-section h2 {
  color: #2c3e50;
  font-size: 2rem;
  margin: 0 0 1rem;
  padding-bottom: 0.5rem;
  border-bottom: 3px solid #667eea;
}

.intro-text {
  font-size: 1.1rem;
  color: #555;
  margin-bottom: 2rem;
  padding: 1rem;
  background: #f8f9fa;
  border-radius: 8px;
  border-left: 4px solid #667eea;
}

/* ===== CARTES D'EXEMPLES ===== */
.example-card {
  margin: 2rem 0;
  padding: 1.5rem;
  border-radius: 8px;
  border-left: 5px solid;
}

.example-card.bad {
  background: #fff5f5;
  border-left-color: #e74c3c;
}

.example-card.good {
  background: #f0fff4;
  border-left-color: #27ae60;
}

.example-card h3 {
  margin: 0 0 1rem;
  font-size: 1.3rem;
}

/* ===== BLOCS DE CODE ===== */
.code-block {
  background: #2c3e50;
  border-radius: 8px;
  overflow: hidden;
  margin: 1rem 0;
}

.code-block pre {
  margin: 0;
  padding: 1.5rem;
  overflow-x: auto;
}

.code-block code {
  color: #ecf0f1;
  font-family: 'Monaco', 'Menlo', 'Ubuntu Mono', monospace;
  font-size: 0.9rem;
  line-height: 1.6;
}

/* ===== EXPLICATIONS ===== */
.explanation {
  color: #555;
  margin: 1rem 0;
  font-size: 1rem;
}

.explanation strong {
  color: #2c3e50;
}

/* ===== BOÎTES DE DÉMONSTRATION ===== */
.demo-box {
  background: white;
  border: 2px dashed #ddd;
  border-radius: 8px;
  padding: 1.5rem;
  margin: 1rem 0;
}

.success-note {
  color: #27ae60;
  background: #f0fff4;
  padding: 0.75rem;
  border-radius: 4px;
  margin-top: 1rem;
  border-left: 3px solid #27ae60;
  font-size: 0.95rem;
}

/* ===== BOÎTES D'ALERTE ===== */
.warning-box {
  background: #fff3cd;
  color: #856404;
  padding: 1rem;
  border-radius: 8px;
  border-left: 4px solid #ffc107;
  margin-top: 1rem;
  font-weight: 600;
}

.info-box {
  background: #e3f2fd;
  color: #0d47a1;
  padding: 1rem;
  border-radius: 8px;
  border-left: 4px solid #2196f3;
  margin-top: 1rem;
}

/* ===== BOUTONS DE DÉMONSTRATION ===== */
.demo-button {
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.75rem 1.5rem;
  background: #667eea;
  color: white;
  border: none;
  border-radius: 6px;
  font-size: 1rem;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s;
}

.demo-button:hover:not(:disabled) {
  background: #5568d3;
  transform: translateY(-2px);
  box-shadow: 0 4px 8px rgba(0,0,0,0.2);
}

.demo-button:disabled {
  opacity: 0.6;
  cursor: not-allowed;
}

.demo-button .icon {
  width: 20px;
  height: 20px;
}

.icon-button {
  width: 48px;
  height: 48px;
  padding: 0;
  background: #ecf0f1;
  border: 2px solid #bdc3c7;
  border-radius: 8px;
  font-size: 1.5rem;
  cursor: pointer;
  transition: all 0.3s;
  margin: 0 0.5rem;
}

.icon-button:hover {
  background: #bdc3c7;
  border-color: #95a5a6;
  transform: scale(1.05);
}

.icon-button:focus {
  outline: 3px solid #667eea;
  outline-offset: 2px;
}

/* ===== BOUTON DE NOTIFICATION ===== */
.notification-button {
  position: relative;
  width: 60px;
  height: 60px;
  padding: 0;
  background: #667eea;
  border: none;
  border-radius: 12px;
  font-size: 1.8rem;
  cursor: pointer;
  transition: all 0.3s;
  margin: 0 1rem;
}

.notification-button:hover {
  background: #5568d3;
  transform: scale(1.05);
}

.badge {
  position: absolute;
  top: -5px;
  right: -5px;
  min-width: 24px;
  height: 24px;
  padding: 0 6px;
  background: #e74c3c;
  color: white;
  border-radius: 12px;
  font-size: 0.75rem;
  font-weight: bold;
  display: flex;
  align-items: center;
  justify-content: center;
  border: 2px solid white;
}

/* ===== STATUTS DE CHARGEMENT ===== */
.loading-status,
.success-status {
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.75rem 1rem;
  border-radius: 6px;
  margin-top: 1rem;
  font-weight: 600;
}

.loading-status {
  background: #e3f2fd;
  color: #1976d2;
}

.success-status {
  background: #f0fff4;
  color: #27ae60;
}

.spinner {
  animation: spin 1s linear infinite;
  font-size: 1.5rem;
}

@keyframes spin {
  from { transform: rotate(0deg); }
  to { transform: rotate(360deg); }
}

/* ===== TABLEAU MINIMAL ===== */
.minimal-table {
  width: 100%;
  border-collapse: collapse;
}

.minimal-table td {
  padding: 0.75rem;
  border-bottom: 1px solid #ecf0f1;
}

.minimal-table tr:hover {
  background: #f8f9fa;
}

/* ===== FORMULAIRE DE DÉMONSTRATION ===== */
.demo-form {
  max-width: 500px;
}

.form-group {
  margin-bottom: 1.5rem;
}

.form-group label {
  display: block;
  font-weight: 600;
  color: #2c3e50;
  margin-bottom: 0.5rem;
}

.form-input {
  width: 100%;
  padding: 0.75rem;
  border: 2px solid #ddd;
  border-radius: 6px;
  font-size: 1rem;
  font-family: inherit;
  transition: border-color 0.3s;
}

.form-input:focus {
  outline: none;
  border-color: #667eea;
  box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
}

.hint-text {
  display: block;
  margin-top: 0.5rem;
  color: #7f8c8d;
  font-size: 0.875rem;
}

/* ===== RECHERCHE ===== */
.search-container {
  display: flex;
  gap: 0.5rem;
}

.search-input {
  flex: 1;
  padding: 0.75rem;
  border: 2px solid #ddd;
  border-radius: 6px;
  font-size: 1rem;
}

.search-button {
  width: 48px;
  height: 48px;
  padding: 0;
  background: #667eea;
  color: white;
  border: none;
  border-radius: 6px;
  font-size: 1.3rem;
  cursor: pointer;
  transition: all 0.3s;
}

.search-button:hover {
  background: #5568d3;
  transform: scale(1.05);
}

/* ===== PANNEAU D'INFORMATION ===== */
.info-panel {
  background: #e3f2fd;
  padding: 1.5rem;
  border-radius: 8px;
  border-left: 4px solid #2196f3;
}

.info-panel h4 {
  margin: 0 0 0.5rem;
  color: #1976d2;
}

.info-panel p {
  margin: 0.5rem 0;
  color: #0d47a1;
}

/* ===== LOGO HEADING ===== */
.logo-heading {
  font-size: 3rem;
  margin: 1rem 0;
}

/* ===== CHECKLIST ===== */
.checklist-container {
  background: #f8f9fa;
  padding: 2rem;
  border-radius: 8px;
  margin: 2rem 0;
}

.checklist-container h3 {
  color: #2c3e50;
  margin: 0 0 1.5rem;
}

.checklist-item {
  margin: 1.5rem 0;
  padding: 1rem;
  background: white;
  border-radius: 6px;
  border-left: 4px solid #667eea;
}

.checklist-checkbox {
  width: 20px;
  height: 20px;
  margin-right: 0.75rem;
  cursor: pointer;
}

.checklist-item label {
  font-weight: 600;
  color: #2c3e50;
  cursor: pointer;
  font-size: 1.05rem;
}

.checklist-help {
  margin: 0.75rem 0 0 2rem;
  color: #7f8c8d;
  font-size: 0.95rem;
  line-height: 1.6;
}

/* ===== TABLEAU RÉCAPITULATIF ===== */
.summary-box {
  margin: 3rem 0;
  padding: 2rem;
  background: #f8f9fa;
  border-radius: 12px;
  border: 2px solid #667eea;
}

.summary-box h3 {
  color: #2c3e50;
  margin: 0 0 1.5rem;
}

.techniques-table {
  width: 100%;
  border-collapse: collapse;
  background: white;
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.techniques-table th,
.techniques-table td {
  padding: 1rem;
  text-align: left;
  border-bottom: 1px solid #ecf0f1;
}

.techniques-table thead th {
  background: #2c3e50;
  color: white;
  font-weight: 600;
}

.techniques-table code {
  background: #ecf0f1;
  padding: 0.2rem 0.5rem;
  border-radius: 4px;
  font-family: 'Monaco', 'Menlo', monospace;
  font-size: 0.9rem;
}

.techniques-table .good-row {
  background: #f0fff4;
}

.techniques-table tr:hover {
  background: #f8f9fa;
}

.techniques-table .good-row:hover {
  background: #e8f8f0;
}

/* ===== PIED DE PAGE ===== */
.demo-footer {
  text-align: center;
  padding: 2rem;
  margin-top: 3rem;
  color: #7f8c8d;
  background: white;
  border-radius: 12px;
  border-top: 3px solid #667eea;
}

/* ===== RESPONSIVE ===== */
@media (max-width: 768px) {
  .accessibility-demo {
    padding: 1rem;
  }

  .page-header h1 {
    font-size: 1.8rem;
  }

  .demo-navigation {
    flex-direction: column;
  }

  .nav-button {
    min-width: 100%;
  }

  .techniques-table {
    font-size: 0.85rem;
  }

  .techniques-table th,
  .techniques-table td {
    padding: 0.5rem;
  }
}
</style>