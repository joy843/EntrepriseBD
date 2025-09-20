# Projet Base de Données –   

Projet réalisé dans le cadre du cours **SMI1001-00 – Bases de données I** .  
Ce travail pratique consistait à **concevoir, implémenter et manipuler une base de données relationnelle robuste et cohérente** en SQL pour un organisme spécialisé dans l’analyse des entreprises manufacturières en Amérique du Nord.  

Ce projet m’a permis d’explorer toutes les étapes de la démarche :  

. de la **modélisation conceptuelle** (diagrammes ER, modèle relationnel)  
. jusqu’à l’**implémentation des requêtes SQL et des triggers** dans Oracle.

## Objectifs du projet

- Mettre en œuvre les bases de la **modélisation et de l’implémentation SQL**.  
- Traduire un besoin métier en **tables et relations**.  
- Manipuler les données avec des **requêtes SQL** pour analyser l’information.  
- Documenter et expliquer clairement les étapes suivies.  

Plus concrètement :  

- Concevoir une base de données adaptée aux besoins d’un organisme (entreprises, contacts, transactions, secteurs d’activité).  
- Mettre en place des **requêtes SQL pertinentes** pour extraire des informations utiles.  
- Développer des **triggers** garantissant l’intégrité et l’automatisation de la gestion des données.  
- Relier la **théorie** (modélisation, contraintes) à la **pratique** (implémentation dans Oracle).  

## Travail réalisé

- **Scripts SQL (`.sql`)** pour :  
  - créer la structure de la base de données ;  
  - définir les **clés primaires** et **clés étrangères** afin d’assurer l’intégrité référentielle ;   
  - exécuter et **tester les requêtes**.

## 1) Analyse et conception

- Identification des entités principales : **Entreprise**, **Contact**, **Transaction**, **Secteur**, **Intermédiaire**, **Relations Client/Fournisseur**.  
- Définition des **cardinalités** et de l’**intégrité référentielle**.  
- Passage du **modèle entité–association** au **modèle relationnel**.

## 2) Implémentation SQL

Les fichiers **`Entreprise.sql`** et **`haaa.sql`** contiennent :

- la **création des tables** avec leurs clés primaires et étrangères ;  
- **10 requêtes SQL** illustrant différents besoins :  
  - informations générales des entreprises manufacturières ;  
  - relations clients/fournisseurs ;  
  - transactions et coûts ;  
  - analyse sectorielle (papier, alimentaire, exportations).

## 3) Triggers

Des **triggers** ont été développés pour :

- mettre à jour automatiquement le **pourcentage de recyclage** ;  
- vérifier les **niveaux de satisfaction** (1 à 5) dans les relations fournisseurs ;  
- actualiser la **date du dernier contact** après chaque transaction ;  
- mettre à jour les **ventes annuelles** après chaque transaction ;  
- répercuter les **coûts des intermédiaires** dans le prix total d’une transaction.

## Ce que ce projet m’a appris

- **Comprendre un besoin métier** avant de le traduire en structure SQL.  
- **Organiser** clairement tables, relations et dépendances.  
- **Travailler en équipe** et documenter les choix pour faciliter la validation.  
- **Automatiser** des tâches avec des **triggers** pertinents.  
- Travailler avec **Oracle SQL Developer** et **justifier** chaque choix technique. 

## Environnement utilisé

- **Oracle SQL Developer**

## Équipe (collaboration) avec

- Ezekiel Sthol Djanfa Tchoukoua  
- Durell Bertold Kamdem Tekam  
- Losseni Camara  
