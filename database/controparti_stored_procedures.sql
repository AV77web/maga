-- #############################################################
--  STORED PROCEDURE – CONTROPARTI (clienti + fornitori)
--  Compatibile con pattern esistente (JSON results, paginazione)
--  Aggiornata per supportare schema JSON counterparty.schema.json
-- #############################################################
--  Tabella: controparti
--    • id              INT PK AUTO_INCREMENT
--    • codice          VARCHAR(10)
--    • rag_soc         VARCHAR(255)
--    • tipo            ENUM('Privato','Azienda')
--    • cf              VARCHAR(20)
--    • partita_iva     VARCHAR(20)
--    • indirizzo       VARCHAR(255)
--    • citta           VARCHAR(100)
--    • cap             VARCHAR(5)
--    • pv              VARCHAR(2)
--    • nazione         VARCHAR(50)
--    • telefono        VARCHAR(20)
--    • email           VARCHAR(100)
--    • contatto        VARCHAR(100)
--    • note            TEXT
--    • ruolo           ENUM('cliente','fornitore','entrambi')
-- #############################################################

DELIMITER $$

/*****************************************************************
  CONTROPARTI – INSERT
 *****************************************************************/
DROP PROCEDURE IF EXISTS InsertControparte$$
CREATE PROCEDURE InsertControparte(
    IN p_codice         VARCHAR(10),
    IN p_rag_soc        VARCHAR(255),
    IN p_tipo           ENUM('Privato','Azienda'),
    IN p_cf             VARCHAR(20),
    IN p_partita_iva    VARCHAR(20),
    IN p_indirizzo      VARCHAR(255),
    IN p_citta          VARCHAR(100),
    IN p_cap            VARCHAR(5),
    IN p_pv             VARCHAR(2),
    IN p_nazione        VARCHAR(50),
    IN p_telefono       VARCHAR(20),
    IN p_email          VARCHAR(100),
    IN p_contatto       VARCHAR(100),
    IN p_note           TEXT,
    IN p_ruolo          ENUM('cliente','fornitore','entrambi')
) BEGIN
  DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SELECT JSON_OBJECT('status','error','message','Errore inserimento controparte') AS response; END;
  START TRANSACTION;
  IF p_codice IS NULL OR p_codice='' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Codice obbligatorio'; END IF;
  IF p_rag_soc IS NULL OR p_rag_soc='' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Ragione sociale obbligatoria'; END IF;
  IF p_tipo NOT IN ('Privato','Azienda') THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Tipo non valido'; END IF;
  IF p_ruolo NOT IN ('cliente','fornitore','entrambi') THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Ruolo non valido'; END IF;
  INSERT INTO controparti(codice,rag_soc,tipo,cf,partita_iva,indirizzo,citta,cap,pv,nazione,telefono,email,contatto,note,ruolo)
    VALUES(p_codice,p_rag_soc,p_tipo,p_cf,p_partita_iva,p_indirizzo,p_citta,p_cap,p_pv,p_nazione,p_telefono,p_email,p_contatto,p_note,p_ruolo);
  COMMIT;
  SELECT JSON_OBJECT('status','success','insertId',LAST_INSERT_ID()) AS response;
END$$

/*****************************************************************
  CONTROPARTI – UPDATE
 *****************************************************************/
DROP PROCEDURE IF EXISTS UpdateControparte$$
CREATE PROCEDURE UpdateControparte(
    IN p_id             INT,
    IN p_codice         VARCHAR(10),
    IN p_rag_soc        VARCHAR(255),
    IN p_tipo           ENUM('Privato','Azienda'),
    IN p_cf             VARCHAR(20),
    IN p_partita_iva    VARCHAR(20),
    IN p_indirizzo      VARCHAR(255),
    IN p_citta          VARCHAR(100),
    IN p_cap            VARCHAR(5),
    IN p_pv             VARCHAR(2),
    IN p_nazione        VARCHAR(50),
    IN p_telefono       VARCHAR(20),
    IN p_email          VARCHAR(100),
    IN p_contatto       VARCHAR(100),
    IN p_note           TEXT,
    IN p_ruolo          ENUM('cliente','fornitore','entrambi')
) BEGIN
  DECLARE v_rows INT DEFAULT 0;
  DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SELECT JSON_OBJECT('status','error','message','Errore update controparte') AS response; END;
  START TRANSACTION;
  IF NOT EXISTS (SELECT 1 FROM controparti WHERE id=p_id) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Controparte non trovata'; END IF;
  IF p_tipo NOT IN ('Privato','Azienda') THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Tipo non valido'; END IF;
  IF p_ruolo NOT IN ('cliente','fornitore','entrambi') THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Ruolo non valido'; END IF;
  UPDATE controparti SET codice=p_codice,rag_soc=p_rag_soc,tipo=p_tipo,cf=p_cf,partita_iva=p_partita_iva,indirizzo=p_indirizzo,citta=p_citta,cap=p_cap,pv=p_pv,nazione=p_nazione,telefono=p_telefono,email=p_email,contatto=p_contatto,note=p_note,ruolo=p_ruolo
    WHERE id=p_id;
  SET v_rows=ROW_COUNT();
  COMMIT;
  SELECT JSON_OBJECT('status',IF(v_rows>0,'success','warning'),'rowsAffected',v_rows) AS response;
END$$

/*****************************************************************
  CONTROPARTI – DELETE
 *****************************************************************/
DROP PROCEDURE IF EXISTS DeleteControparte$$
CREATE PROCEDURE DeleteControparte(IN p_id INT) BEGIN
  DECLARE v_rows INT DEFAULT 0;
  DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SELECT JSON_OBJECT('status','error','message','Errore delete controparte') AS response; END;
  START TRANSACTION;
  DELETE FROM controparti WHERE id=p_id;
  SET v_rows=ROW_COUNT();
  IF v_rows=0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Controparte non trovata'; END IF;
  COMMIT;
  SELECT JSON_OBJECT('status','success','rowsDeleted',v_rows) AS response;
END$$

/*****************************************************************
  CONTROPARTI – FETCH (paginazione & filtri)
 *****************************************************************/
DROP PROCEDURE IF EXISTS FetchControparti$$
CREATE PROCEDURE FetchControparti(
    IN p_rag_soc        VARCHAR(255),
    IN p_tipo           ENUM('Privato','Azienda'),
    IN p_cf             VARCHAR(20),
    IN p_partita_iva    VARCHAR(20),
    IN p_citta          VARCHAR(100),
    IN p_contatto       VARCHAR(100),
    IN p_page           INT,
    IN p_page_size      INT,
    IN p_order_by       VARCHAR(50),
    IN p_order_dir      VARCHAR(4)
) BEGIN
  DECLARE v_offset INT DEFAULT 0; DECLARE v_total INT DEFAULT 0;
  SET v_offset=(p_page-1)*p_page_size;
  -- Conteggio totale
  SELECT COUNT(*) INTO v_total FROM controparti
    WHERE (p_rag_soc        IS NULL OR rag_soc LIKE CONCAT('%',p_rag_soc,'%'))
      AND (p_tipo           IS NULL OR tipo=p_tipo)
      AND (p_cf             IS NULL OR cf LIKE CONCAT('%',p_cf,'%'))
      AND (p_partita_iva    IS NULL OR partita_iva LIKE CONCAT('%',p_partita_iva,'%'))
      AND (p_citta          IS NULL OR citta LIKE CONCAT('%',p_citta,'%'))
      AND (p_contatto       IS NULL OR contatto LIKE CONCAT('%',p_contatto,'%'));

  -- Build query dinamica con JSON_ARRAYAGG identica a pattern FetchOrdini/FetchMovimenti
  SET @q = CONCAT(
    'SELECT JSON_ARRAYAGG(JSON_OBJECT(',
      '"id",id,',
      '"codice",codice,',
      '"rag_soc",rag_soc,',
      '"tipo",tipo,',
      '"cf",cf,',
      '"partita_iva",partita_iva,',
      '"indirizzo",indirizzo,',
      '"citta",citta,',
      '"cap",cap,',
      '"pv",pv,',
      '"nazione",nazione,',
      '"telefono",telefono,',
      '"email",email,',
      '"contatto",contatto,',
      '"note",note,',
      '"ruolo",ruolo',
    ')) AS data FROM controparti WHERE 1=1',
    IF(p_rag_soc        IS NULL,'', CONCAT(' AND rag_soc LIKE "%',p_rag_soc,'%"')),
    IF(p_tipo           IS NULL,'', CONCAT(' AND tipo="',p_tipo,'"')),
    IF(p_cf             IS NULL,'', CONCAT(' AND cf LIKE "%',p_cf,'%"')),
    IF(p_partita_iva    IS NULL,'', CONCAT(' AND partita_iva LIKE "%',p_partita_iva,'%"')),
    IF(p_citta          IS NULL,'', CONCAT(' AND citta LIKE "%',p_citta,'%"')),
    IF(p_contatto       IS NULL,'', CONCAT(' AND contatto LIKE "%',p_contatto,'%"')),
    ' ORDER BY ', p_order_by, ' ', p_order_dir,
    ' LIMIT ', p_page_size, ' OFFSET ', v_offset
  );
  PREPARE s FROM @q; EXECUTE s; DEALLOCATE PREPARE s;

  SELECT JSON_OBJECT('status','success','totalRows',v_total,'page',p_page,'pageSize',p_page_size) AS meta;
END$$

-- #############################################################
--  FINE STORED PROCEDURE CONTROPARTI
-- #############################################################

DELIMITER ; 