CREATE OR REPLACE TRIGGER VERIFIER_RES
AFTER INSERT ON RESERVER
FOR EACH ROW 
DECLARE
        NB_VOYAGEURS ITINERAIRE.NOMBRE_ACTUEL%TYPE;
        CAPACITE MOYEN_TRANSPORT.CAPACITE%TYPE;
        DI ITINERAIRE.DATE_DEPART%TYPE;
    BEGIN
        SELECT DATE_DEPART INTO DI
        FROM ITINERAIRE I
        WHERE I.ID_ITINERAIRE=:NEW.ID_ITINERAIRE;

        IF :NEW.DATE_RESERVATION<DI THEN 
            SELECT NOMBRE_ACTUEL INTO NB_VOYAGEURS
            FROM ITINERAIRE I
            WHERE I.ID_ITINERAIRE=:NEW.ID_ITINERAIRE;
            
            SELECT CAPACITE INTO CAPACITE
            FROM MOYEN_TRANSPORT M, ITINERAIRE I
            WHERE I.ID_ITINERAIRE=:NEW.ID_ITINERAIRE AND M.ID_TRANSPORT=I.ID_TRANSPORT;
            NB_VOYAGEURS:= NB_VOYAGEURS+:NEW.NOMBRE_PASSAGERS;
            
            IF (:NEW.NOMBRE_PASSAGERS<=0) THEN 
            DBMS_OUTPUT.PUT_LINE('La reservation '||:NEW.ID_RESERVATION||' est supprimer car le nombre des voyageurs est nul');
               DELETE FROM RESERVER
               WHERE ID_RESERVATION=:NEW.ID_RESERVATION;

            ELSIF (NB_VOYAGEURS>CAPACITE ) THEN
               DBMS_OUTPUT.PUT_LINE('La reservation '||:NEW.ID_RESERVATION||' est supprimer car le nombre des voyageurs depasse la capacite');
               DELETE FROM RESERVER
               WHERE ID_RESERVATION=:NEW.ID_RESERVATION;

            ELSE 
                DBMS_OUTPUT.PUT_LINE('UPDATE');
                UPDATE ITINERAIRE
                SET NOMBRE_ACTUEL=NB_VOYAGEURS
                WHERE ID_ITINERAIRE=:NEW.ID_ITINERAIRE;
            END IF;
            
        ELSE 
            DBMS_OUTPUT.PUT_LINE('La reservation '||:NEW.ID_RESERVATION||' est supprimer car le voyage est déjà realisé');
           DELETE FROM RESERVER
           WHERE ID_RESERVATION=:NEW.ID_RESERVATION;
        END IF;
END;
