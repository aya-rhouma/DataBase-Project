CREATE OR REPLACE PACKAGE GESTION_RESERVATION
IS
    PROCEDURE VERIFIER_RESERVATION
    (ID_R RESERVER.ID_RESERVATION%TYPE);
    PROCEDURE ASSOCIER_SOLDE
    (ID_U RESERVER.ID_UTILISATEUR%TYPE);
    PROCEDURE AJOUTER_RESERVATION
    (ID_R RESERVER.ID_RESERVATION%TYPE,ID_U RESERVER.ID_UTILISATEUR%TYPE,ID_I RESERVER.ID_ITINERAIRE%TYPE,NBP RESERVER.NOMBRE_PASSAGERS%TYPE,ETAT RESERVER.ETAT%TYPE,CL RESERVER.CLASSE%TYPE);
END GESTION_RESERVATION;
