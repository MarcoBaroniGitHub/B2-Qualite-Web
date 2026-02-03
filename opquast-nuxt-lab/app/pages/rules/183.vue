<!-- 
  Règle Qualité Web : Cohérence des contenus avec et sans CSS
  
  Objectifs :
  - Assurer la compréhension des contenus sans CSS
  - Séparer contenu et présentation
  - Améliorer l'accessibilité et le référencement
-->

<template>
  <div class="app-container">
    <!-- Toggle pour simuler la désactivation CSS -->
    <div class="dev-controls" :class="{ 'no-css': noCssMode }">
      <button 
        @click="toggleCss" 
        class="toggle-button"
        :aria-pressed="noCssMode"
      >
        {{ noCssMode ? '✓ Mode sans CSS activé' : 'Tester sans CSS' }}
      </button>
      <p class="info-text">
        Ce bouton simule la désactivation des styles CSS pour vérifier la cohérence du contenu
      </p>
    </div>

    <!-- Contenu principal avec structure HTML sémantique -->
    <div :class="['content-wrapper', { 'no-css': noCssMode }]">
      
      <!-- ===== EXEMPLE 1 : Navigation accessible ===== -->
      <nav class="main-navigation" aria-label="Navigation principale">
        <h2 class="nav-title">Menu principal</h2>
        <ul class="nav-list">
          <li class="nav-item"><a href="#accueil" class="nav-link">Accueil</a></li>
          <li class="nav-item"><a href="#produits" class="nav-link">Produits</a></li>
          <li class="nav-item"><a href="#services" class="nav-link">Services</a></li>
          <li class="nav-item"><a href="#contact" class="nav-link">Contact</a></li>
        </ul>
      </nav>

      <!-- ===== EXEMPLE 2 : En-tête avec logo ===== -->
      <header class="site-header">
        <div class="logo-container">
          <!-- Le texte alternatif rend le logo compréhensible sans CSS -->
          <img 
            src="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='200' height='60'%3E%3Crect fill='%230066cc' width='200' height='60'/%3E%3Ctext x='50%25' y='50%25' text-anchor='middle' dy='.3em' fill='white' font-size='24' font-weight='bold'%3ELOGO%3C/text%3E%3C/svg%3E"
            alt="MonEntreprise - Solutions digitales"
            class="site-logo"
          />
          <!-- Texte de secours visible sans CSS -->
          <h1 class="site-title">MonEntreprise - Solutions digitales</h1>
        </div>
      </header>

      <!-- ===== EXEMPLE 3 : Contenu principal structuré ===== -->
      <main class="main-content">
        <article class="content-article">
          <header class="article-header">
            <h2 class="article-title">Bienvenue sur notre site</h2>
            <p class="article-meta">
              <time datetime="2026-01-29">29 janvier 2026</time> | 
              <span class="author">Par Jean Dupont</span>
            </p>
          </header>

          <div class="article-body">
            <p class="intro-text">
              Notre entreprise propose des solutions innovantes pour vos projets digitaux.
              Cette structure reste cohérente même sans application des styles CSS.
            </p>

            <!-- ===== EXEMPLE 4 : Liste de caractéristiques ===== -->
            <section class="features-section">
              <h3 class="section-title">Nos services</h3>
              <ul class="features-list">
                <li class="feature-item">
                  <strong class="feature-title">Développement web</strong>
                  <p class="feature-description">Applications performantes et accessibles</p>
                </li>
                <li class="feature-item">
                  <strong class="feature-title">Design UX/UI</strong>
                  <p class="feature-description">Interfaces intuitives et élégantes</p>
                </li>
                <li class="feature-item">
                  <strong class="feature-title">Conseil stratégique</strong>
                  <p class="feature-description">Accompagnement personnalisé</p>
                </li>
              </ul>
            </section>

            <!-- ===== EXEMPLE 5 : Grille de produits (structure linéaire sans CSS) ===== -->
            <section class="products-section">
              <h3 class="section-title">Nos produits phares</h3>
              
              <article class="product-card">
                <h4 class="product-name">Produit Alpha</h4>
                <img 
                  src="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='300' height='200'%3E%3Crect fill='%23e0e0e0' width='300' height='200'/%3E%3Ctext x='50%25' y='50%25' text-anchor='middle' dy='.3em' fill='%23666' font-size='16'%3EImage produit%3C/text%3E%3C/svg%3E"
                  alt="Capture d'écran du Produit Alpha"
                  class="product-image"
                />
                <p class="product-description">
                  Description complète du produit Alpha avec ses principales fonctionnalités.
                </p>
                <p class="product-price">Prix : <strong>299€</strong></p>
                <a href="#alpha" class="product-link">En savoir plus</a>
              </article>

              <article class="product-card">
                <h4 class="product-name">Produit Beta</h4>
                <img 
                  src="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='300' height='200'%3E%3Crect fill='%23e0e0e0' width='300' height='200'/%3E%3Ctext x='50%25' y='50%25' text-anchor='middle' dy='.3em' fill='%23666' font-size='16'%3EImage produit%3C/text%3E%3C/svg%3E"
                  alt="Capture d'écran du Produit Beta"
                  class="product-image"
                />
                <p class="product-description">
                  Description complète du produit Beta avec ses principales fonctionnalités.
                </p>
                <p class="product-price">Prix : <strong>399€</strong></p>
                <a href="#beta" class="product-link">En savoir plus</a>
              </article>
            </section>

            <!-- ===== EXEMPLE 6 : Organigramme accessible ===== -->
            <section class="organization-section">
              <h3 class="section-title">Notre organisation</h3>
              
              <!-- Structure hiérarchique claire même sans CSS -->
              <div class="org-chart">
                <div class="org-level org-level-1">
                  <div class="org-position">
                    <strong class="org-title">Direction Générale</strong>
                    <p class="org-name">Marie Martin</p>
                  </div>
                </div>

                <div class="org-level org-level-2">
                  <h4 class="org-level-title">Directions</h4>
                  
                  <div class="org-position">
                    <strong class="org-title">Direction Technique</strong>
                    <p class="org-name">Pierre Durand</p>
                    
                    <div class="org-subordinates">
                      <h5 class="org-sublevel-title">Équipe technique</h5>
                      <ul class="org-team-list">
                        <li class="org-team-member">Jean Petit - Développeur senior</li>
                        <li class="org-team-member">Sophie Blanc - DevOps</li>
                      </ul>
                    </div>
                  </div>

                  <div class="org-position">
                    <strong class="org-title">Direction Marketing</strong>
                    <p class="org-name">Lucie Moreau</p>
                    
                    <div class="org-subordinates">
                      <h5 class="org-sublevel-title">Équipe marketing</h5>
                      <ul class="org-team-list">
                        <li class="org-team-member">Paul Rousseau - Content Manager</li>
                        <li class="org-team-member">Julie Simon - Social Media</li>
                      </ul>
                    </div>
                  </div>
                </div>
              </div>
            </section>

            <!-- ===== EXEMPLE 7 : Tableau de données accessible ===== -->
            <section class="data-section">
              <h3 class="section-title">Statistiques annuelles</h3>
              <table class="data-table">
                <caption class="table-caption">
                  Évolution du chiffre d'affaires 2023-2025
                </caption>
                <thead>
                  <tr>
                    <th scope="col">Année</th>
                    <th scope="col">Chiffre d'affaires</th>
                    <th scope="col">Croissance</th>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <th scope="row">2023</th>
                    <td>1.2M€</td>
                    <td>-</td>
                  </tr>
                  <tr>
                    <th scope="row">2024</th>
                    <td>1.5M€</td>
                    <td>+25%</td>
                  </tr>
                  <tr>
                    <th scope="row">2025</th>
                    <td>1.9M€</td>
                    <td>+27%</td>
                  </tr>
                </tbody>
              </table>
            </section>

            <!-- ===== EXEMPLE 8 : Formulaire structuré ===== -->
            <section class="form-section">
              <h3 class="section-title">Nous contacter</h3>
              <form class="contact-form" @submit.prevent="handleSubmit">
                <div class="form-group">
                  <label for="name" class="form-label">Nom complet *</label>
                  <input 
                    id="name" 
                    type="text" 
                    class="form-input" 
                    required
                    aria-required="true"
                  />
                </div>

                <div class="form-group">
                  <label for="email" class="form-label">Email *</label>
                  <input 
                    id="email" 
                    type="email" 
                    class="form-input" 
                    required
                    aria-required="true"
                  />
                </div>

                <div class="form-group">
                  <label for="subject" class="form-label">Sujet</label>
                  <select id="subject" class="form-select">
                    <option value="">Choisir un sujet</option>
                    <option value="info">Demande d'information</option>
                    <option value="devis">Demande de devis</option>
                    <option value="support">Support technique</option>
                  </select>
                </div>

                <div class="form-group">
                  <label for="message" class="form-label">Message *</label>
                  <textarea 
                    id="message" 
                    class="form-textarea" 
                    rows="5" 
                    required
                    aria-required="true"
                  ></textarea>
                </div>

                <div class="form-actions">
                  <button type="submit" class="submit-button">Envoyer le message</button>
                  <button type="reset" class="reset-button">Réinitialiser</button>
                </div>
              </form>
            </section>
          </div>
        </article>

        <!-- ===== EXEMPLE 9 : Sidebar avec informations complémentaires ===== -->
        <aside class="sidebar">
          <section class="sidebar-section">
            <h3 class="sidebar-title">Informations utiles</h3>
            <ul class="sidebar-list">
              <li class="sidebar-item">
                <strong>Téléphone :</strong> 01 23 45 67 89
              </li>
              <li class="sidebar-item">
                <strong>Email :</strong> contact@exemple.fr
              </li>
              <li class="sidebar-item">
                <strong>Horaires :</strong> Lun-Ven 9h-18h
              </li>
            </ul>
          </section>

          <section class="sidebar-section">
            <h3 class="sidebar-title">Dernières actualités</h3>
            <article class="news-item">
              <h4 class="news-title">Nouveau produit lancé</h4>
              <time class="news-date" datetime="2026-01-20">20 janvier 2026</time>
              <p class="news-excerpt">Découvrez notre dernière innovation...</p>
            </article>
          </section>
        </aside>
      </main>

      <!-- ===== Pied de page ===== -->
      <footer class="site-footer">
        <div class="footer-content">
          <section class="footer-section">
            <h3 class="footer-title">À propos</h3>
            <p class="footer-text">
              MonEntreprise propose des solutions digitales depuis 2010.
            </p>
          </section>

          <section class="footer-section">
            <h3 class="footer-title">Liens rapides</h3>
            <ul class="footer-links">
              <li><a href="#mentions">Mentions légales</a></li>
              <li><a href="#cgv">CGV</a></li>
              <li><a href="#privacy">Confidentialité</a></li>
            </ul>
          </section>

          <section class="footer-section">
            <h3 class="footer-title">Suivez-nous</h3>
            <ul class="social-links">
              <li><a href="#twitter" aria-label="Twitter">Twitter</a></li>
              <li><a href="#linkedin" aria-label="LinkedIn">LinkedIn</a></li>
              <li><a href="#facebook" aria-label="Facebook">Facebook</a></li>
            </ul>
          </section>
        </div>

        <p class="copyright">
          © 2026 MonEntreprise - Tous droits réservés
        </p>
      </footer>
    </div>

    <!-- Guide de bonnes pratiques -->
    <div class="guidelines" :class="{ 'no-css': noCssMode }">
      <h2 class="guidelines-title">✓ Bonnes pratiques appliquées</h2>
      <ul class="guidelines-list">
        <li><strong>Structure sémantique :</strong> Utilisation de balises HTML5 appropriées (nav, main, article, aside, section)</li>
        <li><strong>Hiérarchie des titres :</strong> H1, H2, H3, etc. dans le bon ordre</li>
        <li><strong>Ordre logique :</strong> Le contenu principal avant la sidebar dans le HTML</li>
        <li><strong>Textes alternatifs :</strong> Images avec attributs alt descriptifs</li>
        <li><strong>Labels de formulaires :</strong> Tous les champs associés à un label</li>
        <li><strong>Liens explicites :</strong> Textes de liens compréhensibles hors contexte</li>
        <li><strong>Tableaux structurés :</strong> Utilisation de caption, thead, th avec scope</li>
        <li><strong>Navigation accessible :</strong> Attributs ARIA et navigation au clavier</li>
      </ul>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue';

const noCssMode = ref(false);

function toggleCss() {
  noCssMode.value = !noCssMode.value;
}

function handleSubmit() {
  alert('Formulaire soumis (mode démo)');
}
</script>

<style scoped>
/* ===== STYLES DE BASE (toujours actifs) ===== */
* {
  box-sizing: border-box;
}

/* ===== STYLES CONDITIONNELS ===== */
/* Ces styles ne s'appliquent QUE quand noCssMode est false */

.content-wrapper:not(.no-css) {
  max-width: 1200px;
  margin: 0 auto;
  padding: 1rem;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
  line-height: 1.6;
  color: #333;
}

/* Contrôles développeur */
.dev-controls {
  position: sticky;
  top: 0;
  z-index: 1000;
  background: #2c3e50;
  color: white;
  padding: 1rem;
  text-align: center;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.dev-controls.no-css {
  background: #e74c3c;
}

.toggle-button {
  background: white;
  color: #2c3e50;
  border: none;
  padding: 0.75rem 1.5rem;
  font-size: 1rem;
  font-weight: bold;
  border-radius: 4px;
  cursor: pointer;
  transition: all 0.3s;
}

.dev-controls.no-css .toggle-button {
  background: #c0392b;
  color: white;
}

.toggle-button:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 8px rgba(0,0,0,0.2);
}

.info-text {
  margin: 0.5rem 0 0;
  font-size: 0.875rem;
  opacity: 0.9;
}

/* ===== NAVIGATION ===== */
.main-navigation:not(.no-css) {
  background: #34495e;
  padding: 1rem;
  margin-bottom: 2rem;
  border-radius: 4px;
}

.nav-title:not(.no-css) {
  color: white;
  margin: 0 0 1rem;
  font-size: 1.2rem;
}

.nav-list:not(.no-css) {
  list-style: none;
  padding: 0;
  margin: 0;
  display: flex;
  gap: 1rem;
  flex-wrap: wrap;
}

.nav-item:not(.no-css) {
  display: inline-block;
}

.nav-link:not(.no-css) {
  color: white;
  text-decoration: none;
  padding: 0.5rem 1rem;
  display: block;
  border-radius: 4px;
  transition: background 0.3s;
}

.nav-link:not(.no-css):hover,
.nav-link:not(.no-css):focus {
  background: rgba(255,255,255,0.1);
  outline: 2px solid white;
  outline-offset: 2px;
}

/* ===== EN-TÊTE ===== */
.site-header:not(.no-css) {
  text-align: center;
  padding: 2rem 0;
  border-bottom: 3px solid #3498db;
  margin-bottom: 2rem;
}

.logo-container:not(.no-css) {
  position: relative;
}

.site-logo:not(.no-css) {
  max-width: 200px;
  height: auto;
  display: block;
  margin: 0 auto;
}

.site-title:not(.no-css) {
  /* Masquer visuellement mais garder accessible */
  position: absolute;
  width: 1px;
  height: 1px;
  padding: 0;
  margin: -1px;
  overflow: hidden;
  clip: rect(0,0,0,0);
  white-space: nowrap;
  border: 0;
}

/* En mode sans CSS, afficher le titre */
.no-css .site-title {
  position: static;
  width: auto;
  height: auto;
  margin: 1rem 0;
  clip: auto;
  white-space: normal;
}

/* ===== CONTENU PRINCIPAL ===== */
.main-content:not(.no-css) {
  display: grid;
  grid-template-columns: 1fr 300px;
  gap: 2rem;
  margin-bottom: 2rem;
}

.content-article:not(.no-css) {
  background: white;
  padding: 2rem;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.article-header:not(.no-css) {
  border-bottom: 2px solid #ecf0f1;
  padding-bottom: 1rem;
  margin-bottom: 2rem;
}

.article-title:not(.no-css) {
  color: #2c3e50;
  margin: 0 0 0.5rem;
  font-size: 2rem;
}

.article-meta:not(.no-css) {
  color: #7f8c8d;
  font-size: 0.9rem;
  margin: 0;
}

.intro-text:not(.no-css) {
  font-size: 1.1rem;
  color: #34495e;
  margin-bottom: 2rem;
}

/* ===== SECTIONS ===== */
.features-section:not(.no-css),
.products-section:not(.no-css),
.organization-section:not(.no-css),
.data-section:not(.no-css),
.form-section:not(.no-css) {
  margin: 3rem 0;
}

.section-title:not(.no-css) {
  color: #2c3e50;
  border-left: 4px solid #3498db;
  padding-left: 1rem;
  margin-bottom: 1.5rem;
}

/* ===== LISTE DE CARACTÉRISTIQUES ===== */
.features-list:not(.no-css) {
  list-style: none;
  padding: 0;
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 1.5rem;
}

.feature-item:not(.no-css) {
  background: #f8f9fa;
  padding: 1.5rem;
  border-radius: 8px;
  border-left: 4px solid #3498db;
}

.feature-title:not(.no-css) {
  display: block;
  color: #2c3e50;
  font-size: 1.2rem;
  margin-bottom: 0.5rem;
}

.feature-description:not(.no-css) {
  color: #555;
  margin: 0;
}

/* ===== PRODUITS ===== */
.product-card:not(.no-css) {
  background: white;
  border: 1px solid #ddd;
  border-radius: 8px;
  padding: 1.5rem;
  margin-bottom: 1.5rem;
  transition: transform 0.3s, box-shadow 0.3s;
}

.product-card:not(.no-css):hover {
  transform: translateY(-4px);
  box-shadow: 0 4px 12px rgba(0,0,0,0.15);
}

.product-name:not(.no-css) {
  color: #2c3e50;
  margin: 0 0 1rem;
}

.product-image:not(.no-css) {
  width: 100%;
  height: auto;
  border-radius: 4px;
  margin-bottom: 1rem;
}

.product-description:not(.no-css) {
  color: #555;
  margin-bottom: 1rem;
}

.product-price:not(.no-css) {
  font-size: 1.3rem;
  color: #27ae60;
  margin-bottom: 1rem;
}

.product-link:not(.no-css) {
  display: inline-block;
  background: #3498db;
  color: white;
  padding: 0.5rem 1.5rem;
  text-decoration: none;
  border-radius: 4px;
  transition: background 0.3s;
}

.product-link:not(.no-css):hover {
  background: #2980b9;
}

/* ===== ORGANIGRAMME ===== */
.org-chart:not(.no-css) {
  background: #f8f9fa;
  padding: 2rem;
  border-radius: 8px;
}

.org-level:not(.no-css) {
  margin-bottom: 2rem;
}

.org-level-1:not(.no-css) {
  text-align: center;
}

.org-level-2:not(.no-css) {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 1rem;
  margin-top: 1rem;
}

.org-level-title:not(.no-css) {
  grid-column: 1 / -1;
  color: #2c3e50;
  border-bottom: 2px solid #3498db;
  padding-bottom: 0.5rem;
  margin-bottom: 1rem;
}

.org-position:not(.no-css) {
  background: white;
  padding: 1rem;
  border-radius: 8px;
  border: 2px solid #3498db;
  margin-bottom: 1rem;
}

.org-title:not(.no-css) {
  display: block;
  color: #3498db;
  font-size: 1.1rem;
  margin-bottom: 0.5rem;
}

.org-name:not(.no-css) {
  color: #2c3e50;
  font-weight: 600;
  margin: 0;
}

.org-subordinates:not(.no-css) {
  margin-top: 1rem;
  padding-top: 1rem;
  border-top: 1px solid #ecf0f1;
}

.org-sublevel-title:not(.no-css) {
  font-size: 0.9rem;
  color: #7f8c8d;
  margin: 0 0 0.5rem;
}

.org-team-list:not(.no-css) {
  list-style: none;
  padding: 0;
  margin: 0;
}

.org-team-member:not(.no-css) {
  padding: 0.3rem 0;
  color: #555;
  font-size: 0.9rem;
}

/* ===== TABLEAU ===== */
.data-table:not(.no-css) {
  width: 100%;
  border-collapse: collapse;
  margin-top: 1rem;
  background: white;
}

.table-caption:not(.no-css) {
  font-weight: bold;
  padding: 0.5rem;
  background: #ecf0f1;
  text-align: left;
}

.data-table:not(.no-css) th,
.data-table:not(.no-css) td {
  padding: 0.75rem;
  text-align: left;
  border: 1px solid #ddd;
}

.data-table:not(.no-css) thead th {
  background: #34495e;
  color: white;
  font-weight: bold;
}

.data-table:not(.no-css) tbody th {
  background: #ecf0f1;
  font-weight: 600;
}

.data-table:not(.no-css) tbody tr:hover {
  background: #f8f9fa;
}

/* ===== FORMULAIRE ===== */
.contact-form:not(.no-css) {
  background: #f8f9fa;
  padding: 2rem;
  border-radius: 8px;
}

.form-group:not(.no-css) {
  margin-bottom: 1.5rem;
}

.form-label:not(.no-css) {
  display: block;
  font-weight: 600;
  color: #2c3e50;
  margin-bottom: 0.5rem;
}

.form-input:not(.no-css),
.form-select:not(.no-css),
.form-textarea:not(.no-css) {
  width: 100%;
  padding: 0.75rem;
  border: 2px solid #ddd;
  border-radius: 4px;
  font-family: inherit;
  font-size: 1rem;
  transition: border-color 0.3s;
}

.form-input:not(.no-css):focus,
.form-select:not(.no-css):focus,
.form-textarea:not(.no-css):focus {
  outline: none;
  border-color: #3498db;
  box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
}

.form-actions:not(.no-css) {
  display: flex;
  gap: 1rem;
}

.submit-button:not(.no-css),
.reset-button:not(.no-css) {
  padding: 0.75rem 2rem;
  border: none;
  border-radius: 4px;
  font-size: 1rem;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s;
}

.submit-button:not(.no-css) {
  background: #27ae60;
  color: white;
}

.submit-button:not(.no-css):hover {
  background: #229954;
  transform: translateY(-2px);
  box-shadow: 0 4px 8px rgba(0,0,0,0.2);
}

.reset-button:not(.no-css) {
  background: #95a5a6;
  color: white;
}

.reset-button:not(.no-css):hover {
  background: #7f8c8d;
}

/* ===== SIDEBAR ===== */
.sidebar:not(.no-css) {
  background: #f8f9fa;
  padding: 1.5rem;
  border-radius: 8px;
}

.sidebar-section:not(.no-css) {
  margin-bottom: 2rem;
}

.sidebar-title:not(.no-css) {
  color: #2c3e50;
  font-size: 1.2rem;
  margin: 0 0 1rem;
  border-bottom: 2px solid #3498db;
  padding-bottom: 0.5rem;
}

.sidebar-list:not(.no-css) {
  list-style: none;
  padding: 0;
  margin: 0;
}

.sidebar-item:not(.no-css) {
  padding: 0.5rem 0;
  border-bottom: 1px solid #ecf0f1;
}

.news-item:not(.no-css) {
  padding: 1rem;
  background: white;
  border-radius: 4px;
  margin-bottom: 1rem;
}

.news-title:not(.no-css) {
  color: #2c3e50;
  font-size: 1rem;
  margin: 0 0 0.5rem;
}

.news-date:not(.no-css) {
  display: block;
  color: #7f8c8d;
  font-size: 0.85rem;
  margin-bottom: 0.5rem;
}

.news-excerpt:not(.no-css) {
  color: #555;
  font-size: 0.9rem;
  margin: 0;
}

/* ===== PIED DE PAGE ===== */
.site-footer:not(.no-css) {
  background: #2c3e50;
  color: white;
  padding: 2rem 1rem 1rem;
  margin-top: 3rem;
}

.footer-content:not(.no-css) {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 2rem;
  max-width: 1200px;
  margin: 0 auto 2rem;
}

.footer-section:not(.no-css) {
  margin-bottom: 1rem;
}

.footer-title:not(.no-css) {
  color: #3498db;
  font-size: 1.1rem;
  margin: 0 0 1rem;
}

.footer-text:not(.no-css) {
  color: #ecf0f1;
  line-height: 1.6;
}

.footer-links:not(.no-css),
.social-links:not(.no-css) {
  list-style: none;
  padding: 0;
  margin: 0;
}

.footer-links:not(.no-css) li,
.social-links:not(.no-css) li {
  margin-bottom: 0.5rem;
}

.footer-links:not(.no-css) a,
.social-links:not(.no-css) a {
  color: #ecf0f1;
  text-decoration: none;
  transition: color 0.3s;
}

.footer-links:not(.no-css) a:hover,
.social-links:not(.no-css) a:hover {
  color: #3498db;
  text-decoration: underline;
}

.copyright:not(.no-css) {
  text-align: center;
  color: #95a5a6;
  font-size: 0.9rem;
  padding-top: 1rem;
  border-top: 1px solid #34495e;
  margin: 0;
}

/* ===== GUIDE ===== */
.guidelines:not(.no-css) {
  background: #e8f5e9;
  border: 2px solid #27ae60;
  border-radius: 8px;
  padding: 2rem;
  margin: 2rem auto;
  max-width: 1200px;
}

.guidelines-title:not(.no-css) {
  color: #27ae60;
  margin: 0 0 1rem;
}

.guidelines-list:not(.no-css) {
  color: #2c3e50;
  line-height: 1.8;
}

.guidelines-list:not(.no-css) li {
  margin-bottom: 0.5rem;
}

/* ===== MODE SANS CSS ===== */
.no-css {
  /* Réinitialiser tous les styles visuels */
  background: white !important;
  color: black !important;
  padding: 0 !important;
  margin: 0 !important;
  border: none !important;
  box-shadow: none !important;
  border-radius: 0 !important;
  display: block !important;
  position: static !important;
  width: auto !important;
  max-width: 100% !important;
  grid-template-columns: none !important;
  flex-direction: column !important;
}

.no-css * {
  background: transparent !important;
  color: inherit !important;
  border: none !important;
  padding: 0.2rem 0 !important;
  margin: 0.2rem 0 !important;
  display: block !important;
  width: auto !important;
  max-width: 100% !important;
  position: static !important;
}

.no-css img {
  max-width: 300px !important;
  height: auto !important;
}

.no-css a {
  text-decoration: underline !important;
  color: blue !important;
}

/* ===== RESPONSIVE ===== */
@media (max-width: 768px) {
  .main-content:not(.no-css) {
    grid-template-columns: 1fr;
  }
  
  .footer-content:not(.no-css) {
    grid-template-columns: 1fr;
  }
}
</style>