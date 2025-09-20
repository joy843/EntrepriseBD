-- Table pour stocker les informations generales des entreprises
CREATE TABLE Entreprise (
    ID_Entreprise INTEGER PRIMARY KEY,
    Nom_Entreprise VARCHAR2(100) NOT NULL,
    Annee_Creation DATE NOT NULL,
    Adresse_Siege_Social VARCHAR2(100) NOT NULL
);

-- Table pour gerer les contacts de chaque entreprise
CREATE TABLE Contact (
    ID_Contact INTEGER PRIMARY KEY,
    ID_Entreprise INTEGER NOT NULL,
    Nom_Contact VARCHAR2(100) NOT NULL,
    Telephone_Contact VARCHAR2(20) NOT NULL,
    FOREIGN KEY (ID_Entreprise) REFERENCES Entreprise(ID_Entreprise)
);

-- Table pour les entreprises manufacturieres avec informations specifiques
CREATE TABLE Entreprise_Manufacturiere (
    ID_Entreprise INTEGER PRIMARY KEY,
    Ventes_Annuelles NUMBER(12, 2) NOT NULL CHECK (Ventes_Annuelles >= 0),
    Exportations NUMBER(12, 2) NOT NULL CHECK (Exportations >= 0),
    FOREIGN KEY (ID_Entreprise) REFERENCES Entreprise(ID_Entreprise)
);

-- Table pour les differents secteurs d'activites
CREATE TABLE Secteur (
    ID_Secteur INTEGER PRIMARY KEY,
    Nom_Secteur VARCHAR2(100) NOT NULL
);

-- Table pour lier les entreprises manufacturieres aux secteurs
CREATE TABLE Entreprise_Secteur (
    ID_Entreprise INTEGER NOT NULL,
    ID_Secteur INTEGER NOT NULL,
    PRIMARY KEY (ID_Entreprise, ID_Secteur),
    FOREIGN KEY (ID_Entreprise) REFERENCES Entreprise_Manufacturiere(ID_Entreprise),
    FOREIGN KEY (ID_Secteur) REFERENCES Secteur(ID_Secteur)
);

-- Table pour les informations specifiques au secteur du papier
CREATE TABLE Secteur_Papier (
    ID_Secteur INTEGER PRIMARY KEY,
    ID_Entreprise INTEGER NOT NULL,
    Tonnes_Annuelles NUMBER(12, 2) NOT NULL CHECK (Tonnes_Annuelles >= 0),
    Pourcentage_Recycle NUMBER(5, 2) NOT NULL CHECK (Pourcentage_Recycle BETWEEN 0 AND 100),
    FOREIGN KEY (ID_Secteur) REFERENCES Secteur(ID_Secteur),
    FOREIGN KEY (ID_Entreprise) REFERENCES Entreprise_Manufacturiere(ID_Entreprise)
);

-- Table pour les informations specifiques au secteur alimentaire
CREATE TABLE Secteur_Alimentaire (
    ID_Secteur INTEGER PRIMARY KEY,
    ID_Entreprise INTEGER NOT NULL,
    Cas_Intoxications INTEGER NOT NULL CHECK (Cas_Intoxications >= 0),
    Jours_Conservation INTEGER NOT NULL CHECK (Jours_Conservation >= 0),
    Produits_Jetes INTEGER NOT NULL CHECK (Produits_Jetes >= 0),
    FOREIGN KEY (ID_Secteur) REFERENCES Secteur(ID_Secteur),
    FOREIGN KEY (ID_Entreprise) REFERENCES Entreprise_Manufacturiere(ID_Entreprise)
);

-- Table pour gerer les transactions entre entreprises
CREATE TABLE Transaction (
    ID_Transaction INTEGER PRIMARY KEY,
    ID_Fournisseur INTEGER NOT NULL,
    ID_Client INTEGER NOT NULL,
    Prix_Total NUMBER(12, 2) NOT NULL CHECK (Prix_Total > 0),
    Date_Commande DATE NOT NULL,
    Date_Livraison DATE NOT NULL,
    Type_Produit VARCHAR2(100) NOT NULL,
    Cout_Livraison NUMBER(12, 2) NOT NULL CHECK (Cout_Livraison >= 0),
    FOREIGN KEY (ID_Fournisseur) REFERENCES Entreprise(ID_Entreprise),
    FOREIGN KEY (ID_Client) REFERENCES Entreprise(ID_Entreprise)
);

-- Table pour gerer les intermediaires impliques dans les transactions
CREATE TABLE Intermediaire (
    ID_Intermediaire INTEGER PRIMARY KEY,
    Nom_Intermediaire VARCHAR2(100) NOT NULL
);

-- Table de liaison pour les intermediaires et les transactions
CREATE TABLE Intermediaire_Transaction (
    ID_Transaction INTEGER NOT NULL,
    ID_Intermediaire INTEGER NOT NULL,
    Cout_Intermediaire NUMBER(12, 2) NOT NULL CHECK (Cout_Intermediaire >= 0),
    PRIMARY KEY (ID_Transaction, ID_Intermediaire),
    FOREIGN KEY (ID_Transaction) REFERENCES Transaction(ID_Transaction),
    FOREIGN KEY (ID_Intermediaire) REFERENCES Intermediaire(ID_Intermediaire)
);

-- Table pour gerer la relation entre les entreprises et leurs clients
CREATE TABLE Relation_Client (
    ID_Entreprise INTEGER,
    ID_Client INTEGER,
    Nom_Client VARCHAR2 (100) NOT NULL,
    Cote VARCHAR2(50) NOT NULL,
    Date_Dernier_Contact DATE NOT NULL,
    PRIMARY KEY (ID_Entreprise, ID_Client),
    FOREIGN KEY (ID_Entreprise) REFERENCES Entreprise(ID_Entreprise),
    FOREIGN KEY (ID_Client) REFERENCES Entreprise(ID_Entreprise)
);

-- Table pour gerer la relation entre les entreprises et leurs fournisseurs
CREATE TABLE Relation_Fournisseur (
    ID_Entreprise INTEGER,
    ID_Fournisseur INTEGER,
    Nom_Fournisseur VARCHAR2 (100) NOT NULL,
    Niveau_Satisfaction INTEGER NOT NULL CHECK (Niveau_Satisfaction BETWEEN 1 AND 5),
    Delai_Livraison INTEGER NOT NULL CHECK (Delai_Livraison >= 0),
    PRIMARY KEY (ID_Entreprise, ID_Fournisseur),
    FOREIGN KEY (ID_Entreprise) REFERENCES Entreprise(ID_Entreprise),
    FOREIGN KEY (ID_Fournisseur) REFERENCES Entreprise(ID_Entreprise)
);

-- Insertion des entreprises
INSERT INTO Entreprise (ID_Entreprise, Nom_Entreprise, Annee_Creation, Adresse_Siege_Social) VALUES
(1, 'Jobalot', TO_DATE('1988-01-01', 'YYYY-MM-DD'), '1 rue Jutras, St-Mathilde');
INSERT INTO Entreprise (ID_Entreprise, Nom_Entreprise, Annee_Creation, Adresse_Siege_Social) VALUES
(2, 'Magic Touch inc.', TO_DATE('1990-05-20', 'YYYY-MM-DD'), '100 avenue des Innovations, Technopolis');
INSERT INTO Entreprise (ID_Entreprise, Nom_Entreprise, Annee_Creation, Adresse_Siege_Social) VALUES
(3, 'Jean-Pierre et ass.', TO_DATE('1985-09-15', 'YYYY-MM-DD'), '25 boulevard des Electrons, Circuitville');
INSERT INTO Entreprise (ID_Entreprise, Nom_Entreprise, Annee_Creation, Adresse_Siege_Social) VALUES
(4, 'Les consultants Honnetes inc.', TO_DATE('2000-12-01', 'YYYY-MM-DD'), '88 chemin des Conseils, Consultopolis');
INSERT INTO Entreprise (ID_Entreprise, Nom_Entreprise, Annee_Creation, Adresse_Siege_Social) VALUES
(5, 'La puce verte inc.', TO_DATE('1998-08-30', 'YYYY-MM-DD'), '55 route du Silicone, Silicon Valley');

-- Insertion des entreprises manufacturieres
INSERT INTO Entreprise_Manufacturiere (ID_Entreprise, Ventes_Annuelles, Exportations) VALUES
(1, 300000, 150000);
INSERT INTO Entreprise_Manufacturiere (ID_Entreprise, Ventes_Annuelles, Exportations) VALUES
(2, 500000, 350000);
INSERT INTO Entreprise_Manufacturiere (ID_Entreprise, Ventes_Annuelles, Exportations) VALUES
(3, 200000, 50000);

-- Insertion des secteurs
INSERT INTO Secteur (ID_Secteur, Nom_Secteur) VALUES
(1, 'electronique');
INSERT INTO Secteur (ID_Secteur, Nom_Secteur) VALUES
(2, 'electrique');
INSERT INTO Secteur (ID_Secteur, Nom_Secteur) VALUES
(3, 'Consultation');
INSERT INTO Secteur (ID_Secteur, Nom_Secteur) VALUES
(4, 'Informatique');
INSERT INTO Secteur (ID_Secteur, Nom_Secteur) VALUES
(5, 'Papier');
INSERT INTO Secteur (ID_Secteur, Nom_Secteur) VALUES
(6, 'Produits Alimentaires');

-- Liaison des entreprises aux secteurs
INSERT INTO Entreprise_Secteur (ID_Entreprise, ID_Secteur) VALUES
(1, 1);
INSERT INTO Entreprise_Secteur (ID_Entreprise, ID_Secteur) VALUES
(2, 1);
INSERT INTO Entreprise_Secteur (ID_Entreprise, ID_Secteur) VALUES
(3, 2);

-- Insertion des transactions
INSERT INTO Transaction (ID_Transaction, ID_Fournisseur, ID_Client, Prix_Total, Date_Commande, Date_Livraison, Type_Produit, Cout_Livraison) VALUES
(1, 2, 4, 1500.00, TO_DATE('2023-09-15', 'YYYY-MM-DD'), TO_DATE('2023-09-20', 'YYYY-MM-DD'), 'Claviers', 100.00);
INSERT INTO Transaction (ID_Transaction, ID_Fournisseur, ID_Client, Prix_Total, Date_Commande, Date_Livraison, Type_Produit, Cout_Livraison) VALUES
(2, 3, 1, 2000.00, TO_DATE('2023-09-16', 'YYYY-MM-DD'), TO_DATE('2023-09-21', 'YYYY-MM-DD'), 'Circuits imprimes', 150.00);

-- Insertion des intermediaires
INSERT INTO Intermediaire (ID_Intermediaire, Nom_Intermediaire) VALUES
(1, 'DHL');
INSERT INTO Intermediaire (ID_Intermediaire, Nom_Intermediaire) VALUES
(2, 'FedEx');

-- Insertion des relations intermediaires et transactions
INSERT INTO Intermediaire_Transaction (ID_Transaction, ID_Intermediaire, Cout_Intermediaire) VALUES
(1, 1, 50.00);
INSERT INTO Intermediaire_Transaction (ID_Transaction, ID_Intermediaire, Cout_Intermediaire) VALUES
(1, 2, 50.00);
INSERT INTO Intermediaire_Transaction (ID_Transaction, ID_Intermediaire, Cout_Intermediaire) VALUES
(2, 1, 75.00);
INSERT INTO Intermediaire_Transaction (ID_Transaction, ID_Intermediaire, Cout_Intermediaire) VALUES
(2, 2, 75.00);

-- Insertion des relations entre les entreprises et leurs clients
INSERT INTO Relation_Client (ID_Entreprise, ID_Client, Nom_Client, Cote, Date_Dernier_Contact) VALUES
(2, 4, 'Les consultants Honnetes inc.', 'Regulier', TO_DATE('2023-09-22', 'YYYY-MM-DD'));
INSERT INTO Relation_Client (ID_Entreprise, ID_Client, Nom_Client, Cote, Date_Dernier_Contact) VALUES
(3, 1, 'Jobalot', 'Occasionnel', TO_DATE('2023-09-23', 'YYYY-MM-DD'));

-- Insertion des relations entre les entreprises et leurs fournisseurs
INSERT INTO Relation_Fournisseur (ID_Entreprise, ID_Fournisseur, Nom_Fournisseur, Niveau_Satisfaction, Delai_Livraison) VALUES
(1, 2, 'Magic Touch inc.', 5, 2);
INSERT INTO Relation_Fournisseur (ID_Entreprise, ID_Fournisseur, Nom_Fournisseur, Niveau_Satisfaction, Delai_Livraison) VALUES
(4, 3, 'Jean-Pierre et ass.', 4, 3);

-- Contacts pour chaque entreprise
INSERT INTO Contact (ID_Contact, ID_Entreprise, Nom_Contact, Telephone_Contact) VALUES (1, 1, 'Louis Jutras', '555-555-0000');
INSERT INTO Contact (ID_Contact, ID_Entreprise, Nom_Contact, Telephone_Contact) VALUES (2, 2, 'Hector Magique', '555-555-0200');
INSERT INTO Contact (ID_Contact, ID_Entreprise, Nom_Contact, Telephone_Contact) VALUES (3, 3, 'Jean-Pierre Leon', '555-555-0300');
INSERT INTO Contact (ID_Contact, ID_Entreprise, Nom_Contact, Telephone_Contact) VALUES (4, 4, 'Alice Martin', '555-555-0400');
INSERT INTO Contact (ID_Contact, ID_Entreprise, Nom_Contact, Telephone_Contact) VALUES (5, 5, 'Bob Green', '555-555-0500');

-- Insertion pour le secteur du papier
INSERT INTO Secteur_Papier (ID_Secteur, ID_Entreprise, Tonnes_Annuelles, Pourcentage_Recycle) VALUES
(5, 1, 1000, 20);

-- Insertion pour le secteur alimentaire
INSERT INTO Secteur_Alimentaire (ID_Secteur, ID_Entreprise, Cas_Intoxications, Jours_Conservation, Produits_Jetes) VALUES
(6, 2, 2, 30, 150);



