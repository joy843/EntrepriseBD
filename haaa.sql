-- requete pour connaitre les informations generales des entreprises manufacturieres
SELECT e.ID_Entreprise, e.Nom_Entreprise, e.Annee_Creation, e.Adresse_Siege_Social, em.Ventes_Annuelles, em.Exportations
FROM Entreprise e
JOIN Entreprise_Manufacturiere em ON e.ID_Entreprise = em.ID_Entreprise;

-- Pour les contacts d'une entreprise
SELECT e.Nom_Entreprise, c.Nom_Contact, c.Telephone_Contact
FROM Entreprise e
JOIN Contact c ON e.ID_Entreprise = c.ID_Entreprise;

-- Pour le secteur du papier
SELECT e.Nom_Entreprise, sp.Tonnes_Annuelles, sp.Pourcentage_Recycle
FROM Entreprise e
JOIN Entreprise_Manufacturiere em ON e.ID_Entreprise = em.ID_Entreprise
JOIN Secteur_Papier sp ON em.ID_Entreprise = sp.ID_Entreprise;

-- Pour le secteur alimentaire
SELECT e.Nom_Entreprise, sa.Cas_Intoxications, sa.Jours_Conservation, sa.Produits_Jetes
FROM Entreprise e
JOIN Entreprise_Manufacturiere em ON e.ID_Entreprise = em.ID_Entreprise
JOIN Secteur_Alimentaire sa ON em.ID_Entreprise = sa.ID_Entreprise;

-- transactions entre les entreprises
SELECT t.ID_Transaction, e1.Nom_Entreprise AS Fournisseur, e2.Nom_Entreprise AS Client, t.Prix_Total, t.Cout_Livraison, t.Type_Produit, t.Date_Commande, t.Date_Livraison
FROM Transaction t
JOIN Entreprise e1 ON t.ID_Fournisseur = e1.ID_Entreprise
JOIN Entreprise e2 ON t.ID_Client = e2.ID_Entreprise;

-- relation fournisseur entreprise
SELECT e.Nom_Entreprise AS Entreprise, ef.Nom_Entreprise AS Fournisseur, rf.Niveau_Satisfaction, rf.Delai_Livraison
FROM Relation_Fournisseur rf
JOIN Entreprise e ON rf.ID_Entreprise = e.ID_Entreprise
JOIN Entreprise ef ON rf.ID_Fournisseur = ef.ID_Entreprise;

-- relation client entreprise
SELECT e.Nom_Entreprise AS Entreprise, ec.Nom_Entreprise AS Client, rc.Cote, rc.Date_Dernier_Contact
FROM Relation_Client rc
JOIN Entreprise e ON rc.ID_Entreprise = e.ID_Entreprise
JOIN Entreprise ec ON rc.ID_Client = ec.ID_Entreprise;

-- pour identifier les transactions avec details sur les intermediaires
SELECT 
    t.ID_Transaction,
    e1.Nom_Entreprise AS Fournisseur,
    e2.Nom_Entreprise AS Client,
    t.Prix_Total,
    t.Date_Commande,
    t.Date_Livraison,
    t.Type_Produit,
    t.Cout_Livraison,
    i.Nom_Intermediaire,
    it.Cout_Intermediaire
FROM 
    Transaction t
    JOIN Entreprise e1 ON t.ID_Fournisseur = e1.ID_Entreprise
    JOIN Entreprise e2 ON t.ID_Client = e2.ID_Entreprise
    JOIN Intermediaire_Transaction it ON t.ID_Transaction = it.ID_Transaction
    JOIN Intermediaire i ON it.ID_Intermediaire = i.ID_Intermediaire;

-- pour identifier les intermediaires participant aux transactions couteuses
SELECT 
    i.Nom_Intermediaire,
    COUNT(it.ID_Transaction) AS Nombre_Transactions,
    SUM(t.Prix_Total) AS Somme_Totale_Transactions
FROM 
    Intermediaire i
    JOIN Intermediaire_Transaction it ON i.ID_Intermediaire = it.ID_Intermediaire
    JOIN Transaction t ON it.ID_Transaction = t.ID_Transaction
GROUP BY 
    i.Nom_Intermediaire
ORDER BY 
    Somme_Totale_Transactions DESC;

-- pour comparer les ventes et les exportations des entreprises manufacturieres par secteur
SELECT 
    s.Nom_Secteur,
    e.Nom_Entreprise,
    em.Ventes_Annuelles,
    em.Exportations,
    ROUND((em.Exportations / em.Ventes_Annuelles) * 100, 2) AS Pourcentage_Exportations
FROM 
    Secteur s
    JOIN Entreprise_Secteur es ON s.ID_Secteur = es.ID_Secteur
    JOIN Entreprise_Manufacturiere em ON es.ID_Entreprise = em.ID_Entreprise
    JOIN Entreprise e ON em.ID_Entreprise = e.ID_Entreprise
ORDER BY 
    s.Nom_Secteur, Pourcentage_Exportations DESC;


-- trigger pour la mise a jour du pourcentage de recyclage
CREATE TRIGGER Update_Recycling_Percentage
AFTER UPDATE OF Tonnes_Annuelles ON Secteur_Papier
FOR EACH ROW
BEGIN
    UPDATE Secteur_Papier
    SET Pourcentage_Recycle = (:NEW.Tonnes_Annuelles * 0.15)
    WHERE ID_Entreprise = :NEW.ID_Entreprise;
END;

-- trigger pour valider les niveaux de satisfaction
CREATE TRIGGER Validate_Satisfaction
BEFORE INSERT OR UPDATE ON Relation_Fournisseur
FOR EACH ROW
BEGIN
    IF :NEW.Niveau_Satisfaction < 1 OR :NEW.Niveau_Satisfaction > 5 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Niveau de satisfaction doit etre entre 1 et 5.');
    END IF;
END;

-- trigger pour la mise a jour de la date du dernier contact apres chaque transaction
CREATE TRIGGER Update_Last_Contact
AFTER INSERT ON Transaction
FOR EACH ROW
BEGIN
    UPDATE Relation_Client
    SET Date_Dernier_Contact = SYSDATE
    WHERE ID_Entreprise = :NEW.ID_Fournisseur AND ID_Client = :NEW.ID_Client;
END;

-- trigger pour la mise a jour des ventes annuelles apres chaque transaction
CREATE TRIGGER Update_Annual_Sales
AFTER INSERT ON Transaction
FOR EACH ROW
BEGIN
    UPDATE Entreprise_Manufacturiere
    SET Ventes_Annuelles = Ventes_Annuelles + :NEW.Prix_Total
    WHERE ID_Entreprise = :NEW.ID_Fournisseur;
END;

-- trigger pour la mise a jour du cout total de la transaction
CREATE TRIGGER Update_Transaction_Cost
AFTER INSERT OR UPDATE ON Intermediaire_Transaction
FOR EACH ROW
BEGIN
    UPDATE Transaction
    SET Prix_Total = Prix_Total + :NEW.Cout_Intermediaire
    WHERE ID_Transaction = :NEW.ID_Transaction;
END;