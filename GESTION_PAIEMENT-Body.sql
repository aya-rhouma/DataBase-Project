CREATE OR REPLACE PACKAGE BODY GESTION_PAIEMENT IS  
    PROCEDURE ASSOCIER_MONTANT  
    (ID_RES RESERVER.ID_RESERVATION%TYPE, PRIX_P ITINERAIRE.PRIX%TYPE, NB RESERVER.NOMBRE_PASSAGERS%TYPE, CL RESERVER.CLASSE%TYPE)  
    IS   
        M RESERVER.MONTANT%TYPE;  
        SOLDE UTILISATEUR.SOLDE%TYPE;  
        ID_UTIL UTILISATEUR.ID_UTILISATEUR%TYPE;  
    BEGIN  
        IF CL = 1 THEN   
            M := (PRIX_P + 8) * NB;  
        ELSIF CL = 3 THEN   
            M := (PRIX_P + 3) * NB;  
        ELSE  
            M := PRIX_P * NB;  
        END IF;  

        SELECT SOLDE, U.ID_UTILISATEUR INTO SOLDE, ID_UTIL   
        FROM RESERVER R, UTILISATEUR U  
        WHERE R.ID_RESERVATION = ID_RES AND U.ID_UTILISATEUR = R.ID_UTILISATEUR;  

        IF SOLDE >= 100 THEN  
            M := M * 0.95;  
            DBMS_OUTPUT.PUT_LINE('SOLDE DE 5% EST REALISEE POUR L UTILISATEUR ' || ID_UTIL);  
        END IF;  

        DBMS_OUTPUT.PUT_LINE('ID_RESERVATION ' || ID_RES || ' PRIX ' || PRIX_P || ' NOMBRE_PASSAGERS ' || NB || ' CLASSE ' || CL || ' montant ' || M);  

        UPDATE RESERVER  
        SET MONTANT = M  
        WHERE ID_RESERVATION = ID_RES; 
    END ASSOCIER_MONTANT;  

    PROCEDURE REMPLIR_BILLET  
    (ID_R RESERVER.ID_RESERVATION%TYPE, ID_B NUMBER)  
    IS   
    BEGIN  
        INSERT INTO BILLET (ID_BILLET, ID_RESERVATION)  
        VALUES (ID_B, ID_R);
    END REMPLIR_BILLET;  
END GESTION_PAIEMENT;
