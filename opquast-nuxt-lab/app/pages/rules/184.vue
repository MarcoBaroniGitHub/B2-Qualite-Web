<!-- 
  Règle Qualité Web : Références indépendantes de la forme et de la position
  
  Objectifs :
  - Permettre la compréhension sans accès au support visuel
  - Améliorer l'accessibilité aux personnes handicapées
  - Assurer que l'information est accessible même si le rendu est altéré
-->

<template>
  <div class="documentation-page">
    <!-- En-tête -->
    <header class="page-header">
      <h1>Guide d'utilisation - Application MonApp</h1>
      <p class="subtitle">Documentation complète avec références accessibles</p>
    </header>

    <!-- Navigation -->
    <nav class="doc-navigation" aria-label="Navigation de la documentation">
      <h2 class="nav-title">Sommaire</h2>
      <ul class="nav-list">
        <li><a href="#section-intro">Introduction</a></li>
        <li><a href="#section-installation">Installation</a></li>
        <li><a href="#section-configuration">Configuration</a></li>
        <li><a href="#section-examples">Exemples d'utilisation</a></li>
        <li><a href="#section-faq">Questions fréquentes</a></li>
        <li><a href="#section-data">Données et statistiques</a></li>
      </ul>
    </nav>

    <main class="doc-content">
      
      <!-- ===== SECTION 1 : INTRODUCTION ===== -->
      <section id="section-intro" class="doc-section">
        <h2>Introduction</h2>
        
        <p>
          Bienvenue dans ce guide d'utilisation. Ce document présente les fonctionnalités 
          principales de l'application avec des exemples illustrés.
        </p>

        <!-- ❌ MAUVAIS EXEMPLE -->
        <div class="example-box bad-example">
          <h3>❌ Mauvaise pratique</h3>
          <p>
            Pour configurer l'application, cliquez sur l'icône en forme d'engrenage 
            <strong class="highlight-bad">dans le coin supérieur droit</strong>.
          </p>
          <p class="warning">
            ⚠️ Problème : La référence "coin supérieur droit" ne fonctionne pas 
            pour les lecteurs d'écran ou sur mobile en mode portrait.
          </p>
        </div>

        <!-- ✅ BON EXEMPLE -->
        <div class="example-box good-example">
          <h3>✅ Bonne pratique</h3>
          <p>
            Pour configurer l'application, cliquez sur le 
            <strong class="highlight-good">bouton "Paramètres"</strong> 
            (icône d'engrenage) dans la barre de navigation principale 
            (voir <a href="#figure-1">Figure 1 : Interface principale</a>).
          </p>
          <p class="success">
            ✓ Avantage : L'élément est identifiable par son nom et sa fonction, 
            avec une référence explicite à une figure numérotée.
          </p>
        </div>

        <!-- Figure référencée -->
        <figure id="figure-1" class="doc-figure">
          <img 
            src="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='800' height='400'%3E%3Crect fill='%23f0f0f0' width='800' height='400'/%3E%3Crect fill='%232c3e50' x='0' y='0' width='800' height='60'/%3E%3Ctext x='20' y='35' fill='white' font-size='18' font-weight='bold'%3EMonApp%3C/text%3E%3Ctext x='720' y='35' fill='white' font-size='24'%3E⚙%3C/text%3E%3Ctext x='680' y='38' fill='white' font-size='12'%3EParamètres%3C/text%3E%3Crect fill='white' x='0' y='60' width='800' height='340'/%3E%3Ctext x='50%25' y='240' text-anchor='middle' fill='%23999' font-size='20'%3EContenu principal%3C/text%3E%3C/svg%3E"
            alt="Capture d'écran de l'interface principale de MonApp montrant la barre de navigation en haut avec le logo à gauche et le bouton Paramètres (icône d'engrenage) à droite"
            class="figure-image"
          />
          <figcaption class="figure-caption">
            <strong>Figure 1 :</strong> Interface principale de l'application. 
            Le bouton "Paramètres" (icône d'engrenage) est situé dans la barre de 
            navigation en haut de l'écran, à côté du nom de l'application.
          </figcaption>
        </figure>
      </section>

      <!-- ===== SECTION 2 : INSTALLATION ===== -->
      <section id="section-installation" class="doc-section">
        <h2>Installation</h2>

        <h3>Étape 1 : Téléchargement</h3>
        
        <!-- ❌ MAUVAIS -->
        <div class="example-box bad-example">
          <h4>❌ Référence visuelle uniquement</h4>
          <p>
            Cliquez sur <strong class="highlight-bad">le gros bouton vert</strong> 
            pour télécharger l'application.
          </p>
          <p class="warning">
            ⚠️ Problème : "gros bouton vert" ne signifie rien pour une personne aveugle 
            ou daltonienne.
          </p>
        </div>

        <!-- ✅ BON -->
        <div class="example-box good-example">
          <h4>✅ Identification textuelle claire</h4>
          <p>
            Cliquez sur le bouton <strong class="highlight-good">"Télécharger MonApp"</strong> 
            pour lancer le téléchargement 
            (voir <a href="#figure-2">Figure 2 : Page de téléchargement</a>).
          </p>
          <p class="success">
            ✓ L'élément est identifié par son texte explicite, pas par sa couleur ou sa taille.
          </p>
        </div>

        <figure id="figure-2" class="doc-figure">
          <img 
            src="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='600' height='300'%3E%3Crect fill='white' width='600' height='300'/%3E%3Crect fill='%2327ae60' x='200' y='120' width='200' height='60' rx='8'/%3E%3Ctext x='300' y='155' text-anchor='middle' fill='white' font-size='18' font-weight='bold'%3ETélécharger MonApp%3C/text%3E%3C/svg%3E"
            alt="Bouton vert avec le texte 'Télécharger MonApp' centré au milieu de la page"
            class="figure-image"
          />
          <figcaption class="figure-caption">
            <strong>Figure 2 :</strong> Page de téléchargement avec le bouton principal 
            "Télécharger MonApp".
          </figcaption>
        </figure>

        <h3>Étape 2 : Paramètres de sécurité</h3>

        <!-- ❌ MAUVAIS -->
        <div class="example-box bad-example">
          <h4>❌ Références de position relatives</h4>
          <p>
            Dans la fenêtre qui s'ouvre, cochez 
            <strong class="highlight-bad">la case du milieu</strong> 
            et décochez <strong class="highlight-bad">celle en bas</strong>.
          </p>
          <p class="warning">
            ⚠️ Problème : "du milieu" et "en bas" sont des positions visuelles 
            qui peuvent changer selon la taille d'écran.
          </p>
        </div>

        <!-- ✅ BON -->
        <div class="example-box good-example">
          <h4>✅ Identification par le contenu</h4>
          <p>
            Dans la boîte de dialogue "Paramètres de sécurité" 
            (voir <a href="#figure-3">Figure 3</a>), effectuez les actions suivantes :
          </p>
          <ol class="instruction-list">
            <li>
              Cochez la case <strong class="highlight-good">"Activer les mises à jour automatiques"</strong>
            </li>
            <li>
              Décochez la case <strong class="highlight-good">"Partager les données d'utilisation"</strong>
            </li>
            <li>
              Laissez la case <strong class="highlight-good">"Activer le pare-feu"</strong> cochée
            </li>
          </ol>
          <p class="success">
            ✓ Chaque option est identifiée par son intitulé exact, pas sa position.
          </p>
        </div>

        <figure id="figure-3" class="doc-figure">
          <img 
            src="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='500' height='350'%3E%3Crect fill='%23f8f9fa' width='500' height='350' stroke='%23ddd' stroke-width='2'/%3E%3Ctext x='250' y='30' text-anchor='middle' font-size='18' font-weight='bold' fill='%232c3e50'%3EParamètres de sécurité%3C/text%3E%3Crect fill='white' x='30' y='70' width='20' height='20' stroke='%23333' stroke-width='2'/%3E%3Ctext x='60' y='85' font-size='14' fill='%23333'%3EActiver le pare-feu%3C/text%3E%3Cpolyline points='33,75 38,82 47,70' fill='none' stroke='%2327ae60' stroke-width='3'/%3E%3Crect fill='white' x='30' y='120' width='20' height='20' stroke='%23333' stroke-width='2'/%3E%3Ctext x='60' y='135' font-size='14' fill='%23333'%3EActiver les mises à jour automatiques%3C/text%3E%3Crect fill='white' x='30' y='170' width='20' height='20' stroke='%23333' stroke-width='2'/%3E%3Ctext x='60' y='185' font-size='14' fill='%23333'%3EPartager les données d'utilisation%3C/text%3E%3Crect fill='%232c3e50' x='200' y='280' width='100' height='40' rx='4'/%3E%3Ctext x='250' y='305' text-anchor='middle' fill='white' font-size='14'%3EValider%3C/text%3E%3C/svg%3E"
            alt="Boîte de dialogue 'Paramètres de sécurité' contenant trois cases à cocher : 'Activer le pare-feu' (cochée), 'Activer les mises à jour automatiques' (non cochée), et 'Partager les données d'utilisation' (non cochée), avec un bouton Valider en bas"
            class="figure-image"
          />
          <figcaption class="figure-caption">
            <strong>Figure 3 :</strong> Boîte de dialogue des paramètres de sécurité 
            montrant les trois options disponibles avec leurs intitulés complets.
          </figcaption>
        </figure>
      </section>

      <!-- ===== SECTION 3 : CONFIGURATION ===== -->
      <section id="section-configuration" class="doc-section">
        <h2>Configuration</h2>

        <!-- ❌ MAUVAIS -->
        <div class="example-box bad-example">
          <h3>❌ Référence par forme et couleur</h3>
          <p>
            Pour ajouter un utilisateur, cliquez sur 
            <strong class="highlight-bad">l'icône ronde bleue avec un plus</strong> 
            <strong class="highlight-bad">en haut à gauche du tableau</strong>.
          </p>
          <p class="warning">
            ⚠️ Problèmes multiples : forme (ronde), couleur (bleue), position (haut à gauche).
          </p>
        </div>

        <!-- ✅ BON -->
        <div class="example-box good-example">
          <h3>✅ Référence accessible et complète</h3>
          <p>
            Pour ajouter un utilisateur, utilisez le bouton 
            <strong class="highlight-good">"Ajouter un utilisateur"</strong> 
            situé au-dessus du tableau de gestion des utilisateurs 
            (voir <a href="#figure-4">Figure 4 : Gestion des utilisateurs</a>).
          </p>
          <p>
            Vous pouvez également utiliser le raccourci clavier 
            <kbd class="keyboard-shortcut">Ctrl</kbd> + 
            <kbd class="keyboard-shortcut">N</kbd> pour créer un nouvel utilisateur.
          </p>
          <p class="success">
            ✓ Triple référence : nom du bouton + contexte + alternative clavier.
          </p>
        </div>

        <figure id="figure-4" class="doc-figure">
          <img 
            src="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='700' height='400'%3E%3Crect fill='white' width='700' height='400'/%3E%3Ctext x='20' y='30' font-size='20' font-weight='bold' fill='%232c3e50'%3EGestion des utilisateurs%3C/text%3E%3Crect fill='%233498db' x='20' y='50' width='200' height='40' rx='6'/%3E%3Ctext x='120' y='75' text-anchor='middle' fill='white' font-size='14' font-weight='bold'%3E%2B Ajouter un utilisateur%3C/text%3E%3Crect fill='%23f8f9fa' x='20' y='110' width='660' height='270' stroke='%23ddd' stroke-width='2'/%3E%3Crect fill='%23ecf0f1' x='20' y='110' width='660' height='40'/%3E%3Ctext x='40' y='135' font-size='14' font-weight='bold'%3ENom%3C/text%3E%3Ctext x='250' y='135' font-size='14' font-weight='bold'%3EEmail%3C/text%3E%3Ctext x='500' y='135' font-size='14' font-weight='bold'%3ERôle%3C/text%3E%3C/svg%3E"
            alt="Interface de gestion des utilisateurs avec un bouton bleu 'Ajouter un utilisateur' en haut, suivi d'un tableau avec les colonnes Nom, Email et Rôle"
            class="figure-image"
          />
          <figcaption class="figure-caption">
            <strong>Figure 4 :</strong> Interface de gestion des utilisateurs. 
            Le bouton "Ajouter un utilisateur" (avec icône +) se trouve au-dessus 
            du tableau listant les utilisateurs existants.
          </figcaption>
        </figure>
      </section>

      <!-- ===== SECTION 4 : EXEMPLES D'UTILISATION ===== -->
      <section id="section-examples" class="doc-section">
        <h2>Exemples d'utilisation</h2>

        <h3>Créer un nouveau projet</h3>

        <p>
          Pour créer un nouveau projet, suivez la procédure illustrée dans la 
          <a href="#figure-5">Figure 5 : Formulaire de création de projet</a> :
        </p>

        <ol class="instruction-list">
          <li>
            Accédez au menu <strong>"Projets"</strong> dans la barre latérale principale
          </li>
          <li>
            Cliquez sur <strong>"Nouveau projet"</strong> dans le sous-menu
          </li>
          <li>
            Remplissez le formulaire avec les informations suivantes :
            <ul class="sub-list">
              <li>
                Champ <strong>"Nom du projet"</strong> : Entrez un nom descriptif
              </li>
              <li>
                Champ <strong>"Description"</strong> : Ajoutez une description détaillée
              </li>
              <li>
                Menu déroulant <strong>"Catégorie"</strong> : Sélectionnez la catégorie appropriée
              </li>
              <li>
                Case à cocher <strong>"Projet confidentiel"</strong> : Cochez si nécessaire
              </li>
            </ul>
          </li>
          <li>
            Validez en cliquant sur le bouton <strong>"Créer le projet"</strong> 
            en bas du formulaire
          </li>
        </ol>

        <figure id="figure-5" class="doc-figure">
          <img 
            src="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='600' height='500'%3E%3Crect fill='white' width='600' height='500'/%3E%3Ctext x='300' y='40' text-anchor='middle' font-size='22' font-weight='bold' fill='%232c3e50'%3ENouveau projet%3C/text%3E%3Ctext x='50' y='90' font-size='14' fill='%23333'%3ENom du projet *%3C/text%3E%3Crect fill='white' x='50' y='100' width='500' height='40' stroke='%23ddd' stroke-width='2' rx='4'/%3E%3Ctext x='50' y='170' font-size='14' fill='%23333'%3EDescription *%3C/text%3E%3Crect fill='white' x='50' y='180' width='500' height='100' stroke='%23ddd' stroke-width='2' rx='4'/%3E%3Ctext x='50' y='310' font-size='14' fill='%23333'%3ECatégorie *%3C/text%3E%3Crect fill='white' x='50' y='320' width='500' height='40' stroke='%23ddd' stroke-width='2' rx='4'/%3E%3Crect fill='white' x='50' y='390' width='20' height='20' stroke='%23333' stroke-width='2'/%3E%3Ctext x='80' y='405' font-size='14' fill='%23333'%3EProjet confidentiel%3C/text%3E%3Crect fill='%2327ae60' x='200' y='440' width='200' height='45' rx='6'/%3E%3Ctext x='300' y='468' text-anchor='middle' fill='white' font-size='16' font-weight='bold'%3ECréer le projet%3C/text%3E%3C/svg%3E"
            alt="Formulaire de création de projet contenant quatre champs : un champ texte 'Nom du projet', une zone de texte 'Description', un menu déroulant 'Catégorie', une case à cocher 'Projet confidentiel', et un bouton vert 'Créer le projet' en bas"
            class="figure-image"
          />
          <figcaption class="figure-caption">
            <strong>Figure 5 :</strong> Formulaire de création de projet montrant 
            les quatre champs requis et le bouton de validation.
          </figcaption>
        </figure>

        <!-- Référence à un tableau -->
        <h3>Comparaison des forfaits</h3>

        <p>
          Le <a href="#tableau-1">Tableau 1 : Comparaison des forfaits</a> ci-dessous 
          présente les différentes options disponibles. Notez particulièrement la 
          colonne <strong>"Stockage"</strong> qui indique les limites de chaque forfait.
        </p>

        <table id="tableau-1" class="data-table">
          <caption class="table-caption">
            <strong>Tableau 1 :</strong> Comparaison des forfaits disponibles
          </caption>
          <thead>
            <tr>
              <th scope="col">Fonctionnalité</th>
              <th scope="col">Gratuit</th>
              <th scope="col">Pro</th>
              <th scope="col">Entreprise</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <th scope="row">Utilisateurs</th>
              <td>1</td>
              <td>5</td>
              <td>Illimité</td>
            </tr>
            <tr>
              <th scope="row">Stockage</th>
              <td>5 GB</td>
              <td>100 GB</td>
              <td>1 TB</td>
            </tr>
            <tr>
              <th scope="row">Support</th>
              <td>Email</td>
              <td>Email + Chat</td>
              <td>24/7 Prioritaire</td>
            </tr>
            <tr>
              <th scope="row">Prix mensuel</th>
              <td>0€</td>
              <td>29€</td>
              <td>99€</td>
            </tr>
          </tbody>
        </table>

        <p>
          Comme indiqué dans la ligne <strong>"Stockage"</strong> du 
          <a href="#tableau-1">Tableau 1</a>, le forfait Pro offre 100 GB, 
          ce qui convient à la plupart des équipes de taille moyenne.
        </p>
      </section>

      <!-- ===== SECTION 5 : FAQ ===== -->
      <section id="section-faq" class="doc-section">
        <h2>Questions fréquentes</h2>

        <div class="faq-item">
          <h3 class="faq-question" id="faq-1">
            Q1 : Comment modifier mes informations personnelles ?
          </h3>
          <div class="faq-answer">
            <p>
              Pour modifier vos informations personnelles :
            </p>
            <ol class="instruction-list">
              <li>
                Cliquez sur votre <strong>nom d'utilisateur</strong> dans la barre 
                de navigation (voir <a href="#figure-6">Figure 6</a>)
              </li>
              <li>
                Sélectionnez <strong>"Mon profil"</strong> dans le menu déroulant
              </li>
              <li>
                Utilisez le bouton <strong>"Modifier"</strong> pour chaque section 
                que vous souhaitez mettre à jour
              </li>
            </ol>
          </div>
        </div>

        <figure id="figure-6" class="doc-figure">
          <img 
            src="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='500' height='300'%3E%3Crect fill='%232c3e50' width='500' height='60'/%3E%3Ccircle cx='450' cy='30' r='20' fill='%233498db'/%3E%3Ctext x='450' y='35' text-anchor='middle' fill='white' font-size='16' font-weight='bold'%3EJD%3C/text%3E%3Crect fill='white' x='350' y='60' width='150' height='150' stroke='%23ddd' stroke-width='1'/%3E%3Ctext x='425' y='85' text-anchor='middle' font-size='14' fill='%23333'%3EMon profil%3C/text%3E%3Ctext x='425' y='115' text-anchor='middle' font-size='14' fill='%23333'%3EParamètres%3C/text%3E%3Ctext x='425' y='145' text-anchor='middle' font-size='14' fill='%23333'%3EAide%3C/text%3E%3Cline x1='350' y1='155' x2='500' y2='155' stroke='%23ddd' stroke-width='1'/%3E%3Ctext x='425' y='185' text-anchor='middle' font-size='14' fill='%23e74c3c'%3EDéconnexion%3C/text%3E%3C/svg%3E"
            alt="Menu déroulant du profil utilisateur montrant quatre options : Mon profil, Paramètres, Aide, et Déconnexion en rouge séparé par une ligne"
            class="figure-image"
          />
          <figcaption class="figure-caption">
            <strong>Figure 6 :</strong> Menu du profil utilisateur accessible via 
            l'avatar dans la barre de navigation.
          </figcaption>
        </figure>

        <div class="faq-item">
          <h3 class="faq-question" id="faq-2">
            Q2 : Où trouver les rapports d'activité ?
          </h3>
          <div class="faq-answer">
            <p>
              Les rapports d'activité sont accessibles depuis le menu principal :
            </p>
            <ol class="instruction-list">
              <li>
                Ouvrez le menu <strong>"Rapports"</strong> dans la barre latérale
              </li>
              <li>
                Sélectionnez <strong>"Rapports d'activité"</strong>
              </li>
              <li>
                Utilisez les filtres <strong>"Période"</strong> et 
                <strong>"Type d'activité"</strong> pour affiner votre recherche
              </li>
              <li>
                Cliquez sur <strong>"Générer le rapport"</strong> pour créer le document
              </li>
            </ol>
            <p>
              Pour plus de détails, consultez la section 
              <a href="#section-data">"Données et statistiques"</a> de cette documentation.
            </p>
          </div>
        </div>
      </section>

      <!-- ===== SECTION 6 : DONNÉES ET STATISTIQUES ===== -->
      <section id="section-data" class="doc-section">
        <h2>Données et statistiques</h2>

        <p>
          Cette section présente comment interpréter les données affichées dans 
          l'application. Le <a href="#graphique-1">Graphique 1 : Évolution mensuelle</a> 
          montre la tendance générale.
        </p>

        <figure id="graphique-1" class="doc-figure">
          <img 
            src="data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='700' height='400'%3E%3Crect fill='white' width='700' height='400'/%3E%3Ctext x='350' y='30' text-anchor='middle' font-size='18' font-weight='bold' fill='%232c3e50'%3EÉvolution mensuelle des ventes%3C/text%3E%3Cline x1='50' y1='350' x2='650' y2='350' stroke='%23333' stroke-width='2'/%3E%3Cline x1='50' y1='50' x2='50' y2='350' stroke='%23333' stroke-width='2'/%3E%3Cpolyline points='100,300 200,250 300,200 400,180 500,150 600,120' fill='none' stroke='%233498db' stroke-width='3'/%3E%3Ccircle cx='100' cy='300' r='5' fill='%233498db'/%3E%3Ccircle cx='200' cy='250' r='5' fill='%233498db'/%3E%3Ccircle cx='300' cy='200' r='5' fill='%233498db'/%3E%3Ccircle cx='400' cy='180' r='5' fill='%233498db'/%3E%3Ccircle cx='500' cy='150' r='5' fill='%233498db'/%3E%3Ccircle cx='600' cy='120' r='5' fill='%233498db'/%3E%3Ctext x='100' y='370' text-anchor='middle' font-size='12'%3EJan%3C/text%3E%3Ctext x='200' y='370' text-anchor='middle' font-size='12'%3EFév%3C/text%3E%3Ctext x='300' y='370' text-anchor='middle' font-size='12'%3EMar%3C/text%3E%3Ctext x='400' y='370' text-anchor='middle' font-size='12'%3EAvr%3C/text%3E%3Ctext x='500' y='370' text-anchor='middle' font-size='12'%3EMai%3C/text%3E%3Ctext x='600' y='370' text-anchor='middle' font-size='12'%3EJun%3C/text%3E%3Ctext x='30' y='355' text-anchor='end' font-size='12'%3E0%3C/text%3E%3Ctext x='30' y='255' text-anchor='end' font-size='12'%3E50%3C/text%3E%3Ctext x='30' y='155' text-anchor='end' font-size='12'%3E100%3C/text%3E%3Ctext x='30' y='55' text-anchor='end' font-size='12'%3E150%3C/text%3E%3C/svg%3E"
            alt="Graphique en ligne montrant l'évolution mensuelle des ventes de janvier à juin. Les valeurs augmentent progressivement : 20 en janvier, 35 en février, 55 en mars, 62 en avril, 78 en mai et 95 en juin. La courbe présente une tendance à la hausse constante."
            class="figure-image"
          />
          <figcaption class="figure-caption">
            <strong>Graphique 1 :</strong> Évolution mensuelle des ventes de janvier à juin. 
            Les données montrent une croissance constante, passant de 20 unités en janvier 
            à 95 unités en juin, soit une augmentation de 375% sur la période.
          </figcaption>
        </figure>

        <p>
          Comme l'indique le <a href="#graphique-1">Graphique 1</a>, la courbe des ventes 
          (ligne bleue) montre une progression constante. Les valeurs exactes pour chaque 
          mois sont également disponibles dans le 
          <a href="#tableau-2">Tableau 2 : Données mensuelles détaillées</a>.
        </p>

        <table id="tableau-2" class="data-table">
          <caption class="table-caption">
            <strong>Tableau 2 :</strong> Données mensuelles détaillées des ventes
          </caption>
          <thead>
            <tr>
              <th scope="col">Mois</th>
              <th scope="col">Ventes (unités)</th>
              <th scope="col">Variation</th>
              <th scope="col">Tendance</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <th scope="row">Janvier</th>
              <td>20</td>
              <td>-</td>
              <td>Base</td>
            </tr>
            <tr>
              <th scope="row">Février</th>
              <td>35</td>
              <td>+75%</td>
              <td>Hausse</td>
            </tr>
            <tr>
              <th scope="row">Mars</th>
              <td>55</td>
              <td>+57%</td>
              <td>Hausse</td>
            </tr>
            <tr>
              <th scope="row">Avril</th>
              <td>62</td>
              <td>+13%</td>
              <td>Hausse modérée</td>
            </tr>
            <tr>
              <th scope="row">Mai</th>
              <td>78</td>
              <td>+26%</td>
              <td>Hausse</td>
            </tr>
            <tr>
              <th scope="row">Juin</th>
              <td>95</td>
              <td>+22%</td>
              <td>Hausse</td>
            </tr>
          </tbody>
        </table>

        <div class="info-box">
          <h3>💡 Astuce : Navigation entre données</h3>
          <p>
            Pour basculer entre la vue graphique (<a href="#graphique-1">Graphique 1</a>) 
            et la vue tabulaire (<a href="#tableau-2">Tableau 2</a>), utilisez le bouton 
            <strong>"Changer de vue"</strong> dans la barre d'outils des rapports.
          </p>
          <p>
            Vous pouvez également utiliser le raccourci clavier 
            <kbd class="keyboard-shortcut">Ctrl</kbd> + 
            <kbd class="keyboard-shortcut">T</kbd> pour basculer rapidement entre les deux vues.
          </p>
        </div>
      </section>

      <!-- ===== GUIDE DES BONNES PRATIQUES ===== -->
      <section class="doc-section best-practices">
        <h2>✓ Résumé des bonnes pratiques appliquées</h2>
        
        <div class="practices-grid">
          <div class="practice-card">
            <h3>✅ Identification textuelle</h3>
            <p>
              Tous les éléments sont identifiés par leur nom ou fonction, 
              jamais uniquement par leur forme, couleur ou position.
            </p>
            <p class="example-text">
              Exemple : "bouton Paramètres" au lieu de "icône d'engrenage en haut à droite"
            </p>
          </div>

          <div class="practice-card">
            <h3>✅ Figures numérotées</h3>
            <p>
              Toutes les images et captures d'écran ont un identifiant unique 
              (Figure 1, Figure 2, etc.) avec légendes descriptives.
            </p>
            <p class="example-text">
              Exemple : "voir Figure 3 : Paramètres de sécurité"
            </p>
          </div>

          <div class="practice-card">
            <h3>✅ Tableaux référencés</h3>
            <p>
              Les tableaux ont des identifiants et sont référencés par leur 
              numéro et titre descriptif.
            </p>
            <p class="example-text">
              Exemple : "comme indiqué dans le Tableau 1 : Comparaison des forfaits"
            </p>
          </div>

          <div class="practice-card">
            <h3>✅ Ancres explicites</h3>
            <p>
              Les liens internes utilisent des ancres avec des identifiants 
              sémantiques (#figure-1, #tableau-2, etc.).
            </p>
            <p class="example-text">
              Exemple : href="#figure-1" avec texte "Figure 1 : Interface principale"
            </p>
          </div>

          <div class="practice-card">
            <h3>✅ Contexte fourni</h3>
            <p>
              Les instructions donnent le contexte en plus de l'identification 
              de l'élément.
            </p>
            <p class="example-text">
              Exemple : "bouton Ajouter situé au-dessus du tableau de gestion"
            </p>
          </div>

          <div class="practice-card">
            <h3>✅ Alternatives multiples</h3>
            <p>
              Plusieurs moyens d'identifier ou d'accéder à un élément 
              (bouton, raccourci clavier, menu).
            </p>
            <p class="example-text">
              Exemple : "Cliquez sur Nouveau projet ou utilisez Ctrl+N"
            </p>
          </div>

          <div class="practice-card">
            <h3>✅ Textes alternatifs complets</h3>
            <p>
              Les images ont des attributs alt descriptifs qui expliquent 
              le contenu visuel.
            </p>
            <p class="example-text">
              Exemple : alt="Formulaire contenant 4 champs : Nom, Description, Catégorie..."
            </p>
          </div>

          <div class="practice-card">
            <h3>✅ Navigation cohérente</h3>
            <p>
              Les références croisées permettent de naviguer facilement 
              entre sections, figures et tableaux.
            </p>
            <p class="example-text">
              Exemple : liens bidirectionnels entre texte et figures
            </p>
          </div>
        </div>
      </section>
    </main>

    <footer class="page-footer">
      <p>Documentation MonApp - Version 2.0 - Dernière mise à jour : Janvier 2026</p>
    </footer>
  </div>
</template>

<script setup>
// Composant de documentation démonstrant les bonnes pratiques d'accessibilité
// Pas de logique complexe nécessaire pour cette démo
</script>

<style scoped>
.documentation-page {
  max-width: 1200px;
  margin: 0 auto;
  padding: 2rem;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
  line-height: 1.7;
  color: #333;
  background: #f8f9fa;
}

/* En-tête */
.page-header {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  padding: 3rem 2rem;
  border-radius: 12px;
  margin-bottom: 2rem;
  text-align: center;
}

.page-header h1 {
  margin: 0 0 0.5rem;
  font-size: 2.5rem;
}

.subtitle {
  margin: 0;
  font-size: 1.2rem;
  opacity: 0.95;
}

/* Navigation */
.doc-navigation {
  background: white;
  padding: 1.5rem;
  border-radius: 8px;
  margin-bottom: 2rem;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
  border-left: 4px solid #667eea;
}

.nav-title {
  margin: 0 0 1rem;
  color: #2c3e50;
  font-size: 1.3rem;
}

.nav-list {
  list-style: none;
  padding: 0;
  margin: 0;
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 0.5rem;
}

.nav-list a {
  color: #667eea;
  text-decoration: none;
  padding: 0.5rem;
  display: block;
  border-radius: 4px;
  transition: all 0.3s;
}

.nav-list a:hover,
.nav-list a:focus {
  background: #f0f0ff;
  padding-left: 1rem;
  outline: 2px solid #667eea;
  outline-offset: 2px;
}

/* Contenu principal */
.doc-content {
  background: white;
  padding: 2rem;
  border-radius: 8px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.doc-section {
  margin-bottom: 4rem;
  padding-bottom: 2rem;
  border-bottom: 2px solid #ecf0f1;
}

.doc-section:last-child {
  border-bottom: none;
}

.doc-section h2 {
  color: #2c3e50;
  font-size: 2rem;
  margin: 0 0 1.5rem;
  padding-bottom: 0.5rem;
  border-bottom: 3px solid #667eea;
}

.doc-section h3 {
  color: #34495e;
  font-size: 1.5rem;
  margin: 2rem 0 1rem;
}

.doc-section h4 {
  color: #555;
  font-size: 1.2rem;
  margin: 1.5rem 0 0.75rem;
}

/* Exemples bons/mauvais */
.example-box {
  margin: 1.5rem 0;
  padding: 1.5rem;
  border-radius: 8px;
  border-left: 5px solid;
}

.bad-example {
  background: #fff3f3;
  border-left-color: #e74c3c;
}

.good-example {
  background: #f0fff4;
  border-left-color: #27ae60;
}

.example-box h3,
.example-box h4 {
  margin-top: 0;
}

.highlight-bad {
  background: #ffe0e0;
  padding: 0.2rem 0.4rem;
  border-radius: 3px;
  color: #c0392b;
}

.highlight-good {
  background: #d4edda;
  padding: 0.2rem 0.4rem;
  border-radius: 3px;
  color: #155724;
  font-weight: 600;
}

.warning {
  color: #c0392b;
  background: #ffe0e0;
  padding: 0.75rem;
  border-radius: 4px;
  margin-top: 1rem;
  font-size: 0.95rem;
}

.success {
  color: #155724;
  background: #d4edda;
  padding: 0.75rem;
  border-radius: 4px;
  margin-top: 1rem;
  font-size: 0.95rem;
}

/* Figures */
.doc-figure {
  margin: 2rem 0;
  padding: 1.5rem;
  background: #f8f9fa;
  border-radius: 8px;
  border: 1px solid #dee2e6;
}

.figure-image {
  width: 100%;
  height: auto;
  display: block;
  border-radius: 4px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
}

.figure-caption {
  margin-top: 1rem;
  color: #555;
  font-size: 0.95rem;
  line-height: 1.6;
  padding: 0.75rem;
  background: white;
  border-radius: 4px;
  border-left: 3px solid #667eea;
}

.figure-caption strong {
  color: #2c3e50;
}

/* Tableaux */
.data-table {
  width: 100%;
  border-collapse: collapse;
  margin: 1.5rem 0;
  background: white;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.table-caption {
  font-size: 1rem;
  padding: 1rem;
  background: #34495e;
  color: white;
  text-align: left;
  border-radius: 8px 8px 0 0;
}

.data-table th,
.data-table td {
  padding: 1rem;
  text-align: left;
  border: 1px solid #dee2e6;
}

.data-table thead th {
  background: #667eea;
  color: white;
  font-weight: 600;
}

.data-table tbody th {
  background: #f8f9fa;
  font-weight: 600;
  color: #2c3e50;
}

.data-table tbody tr:hover {
  background: #f0f0ff;
}

/* Listes d'instructions */
.instruction-list {
  background: #f8f9fa;
  padding: 1.5rem 1.5rem 1.5rem 3rem;
  border-radius: 8px;
  margin: 1rem 0;
  border-left: 4px solid #667eea;
}

.instruction-list li {
  margin-bottom: 0.75rem;
  line-height: 1.6;
}

.instruction-list li:last-child {
  margin-bottom: 0;
}

.sub-list {
  margin-top: 0.5rem;
  padding-left: 1.5rem;
}

.sub-list li {
  margin-bottom: 0.5rem;
}

/* Raccourcis clavier */
.keyboard-shortcut {
  display: inline-block;
  padding: 0.2rem 0.5rem;
  background: #ecf0f1;
  border: 1px solid #bdc3c7;
  border-radius: 4px;
  font-family: 'Courier New', monospace;
  font-size: 0.9rem;
  font-weight: 600;
  box-shadow: 0 2px 0 #95a5a6;
}

/* FAQ */
.faq-item {
  margin: 2rem 0;
  padding: 1.5rem;
  background: #f8f9fa;
  border-radius: 8px;
  border-left: 4px solid #667eea;
}

.faq-question {
  color: #2c3e50;
  margin: 0 0 1rem;
  font-size: 1.2rem;
}

.faq-answer {
  color: #555;
}

/* Boîte d'information */
.info-box {
  background: #e3f2fd;
  border: 2px solid #2196f3;
  border-radius: 8px;
  padding: 1.5rem;
  margin: 2rem 0;
}

.info-box h3 {
  color: #1976d2;
  margin-top: 0;
}

.info-box p {
  color: #0d47a1;
  margin: 0.5rem 0;
}

/* Guide des bonnes pratiques */
.best-practices {
  background: linear-gradient(135deg, #e8f5e9 0%, #c8e6c9 100%);
  padding: 2rem;
  border-radius: 12px;
  border: 3px solid #27ae60;
}

.best-practices h2 {
  color: #27ae60;
  border-bottom-color: #27ae60;
}

.practices-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 1.5rem;
  margin-top: 2rem;
}

.practice-card {
  background: white;
  padding: 1.5rem;
  border-radius: 8px;
  border-left: 4px solid #27ae60;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.practice-card h3 {
  color: #27ae60;
  margin: 0 0 1rem;
  font-size: 1.1rem;
}

.practice-card p {
  color: #555;
  margin: 0.5rem 0;
  font-size: 0.95rem;
  line-height: 1.6;
}

.example-text {
  font-style: italic;
  color: #7f8c8d;
  font-size: 0.875rem;
  padding-top: 0.5rem;
  border-top: 1px solid #ecf0f1;
  margin-top: 0.75rem;
}

/* Pied de page */
.page-footer {
  text-align: center;
  padding: 2rem;
  margin-top: 3rem;
  color: #7f8c8d;
  border-top: 2px solid #ecf0f1;
}

/* Liens */
a {
  color: #667eea;
  text-decoration: underline;
  transition: color 0.3s;
}

a:hover,
a:focus {
  color: #764ba2;
  outline: 2px solid #667eea;
  outline-offset: 2px;
}

/* Responsive */
@media (max-width: 768px) {
  .documentation-page {
    padding: 1rem;
  }
  
  .page-header h1 {
    font-size: 1.8rem;
  }
  
  .nav-list {
    grid-template-columns: 1fr;
  }
  
  .practices-grid {
    grid-template-columns: 1fr;
  }
}
</style>