-- #############################################################
--  STORED PROCEDURE – CONTROPARTI (clienti + fornitori)
--  Compatibile con pattern esistente (JSON results, paginazione)
-- #############################################################
--  Tabella: controparti
--    • id              INT PK AUTO_INCREMENT
--    • nome            VARCHAR(255)
--    • tipo            ENUM('CLIENTE','FORNITORE')
--    • codice_fiscale  VARCHAR(20)
--    • partita_iva     VARCHAR(20)
--    • indirizzo       VARCHAR(255)
--    • citta           VARCHAR(100)
--    • cap             VARCHAR(10)
--    • provincia       VARCHAR(2)
--    • nazione         VARCHAR(50)
--    • telefono        VARCHAR(20)
--    • email           VARCHAR(100)
--    • contatto        VARCHAR(100)
--    • note            TEXT
-- #############################################################

DELIMITER $$

/*****************************************************************
  CONTROPARTI – INSERT
 *****************************************************************/
DROP PROCEDURE IF EXISTS InsertControparte$$
CREATE PROCEDURE InsertControparte(
    IN p_nome           VARCHAR(255),
    IN p_tipo           ENUM('CLIENTE','FORNITORE'),
    IN p_codice_fiscale VARCHAR(20),
    IN p_partita_iva    VARCHAR(20),
    IN p_indirizzo      VARCHAR(255),
    IN p_citta          VARCHAR(100),
    IN p_cap            VARCHAR(10),
    IN p_provincia      VARCHAR(2),
    IN p_nazione        VARCHAR(50),
    IN p_telefono       VARCHAR(20),
    IN p_email          VARCHAR(100),
    IN p_contatto       VARCHAR(100),
    IN p_note           TEXT
) BEGIN
  DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SELECT JSON_OBJECT('status','error','message','Errore inserimento controparte') AS response; END;
  START TRANSACTION;
  IF p_nome IS NULL OR p_nome='' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Nome obbligatorio'; END IF;
  IF p_tipo NOT IN ('CLIENTE','FORNITORE') THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Tipo non valido'; END IF;
  INSERT INTO controparti(nome,tipo,codice_fiscale,partita_iva,indirizzo,citta,cap,provincia,nazione,telefono,email,contatto,note)
    VALUES(p_nome,p_tipo,p_codice_fiscale,p_partita_iva,p_indirizzo,p_citta,p_cap,p_provincia,p_nazione,p_telefono,p_email,p_contatto,p_note);
  COMMIT;
  SELECT JSON_OBJECT('status','success','insertId',LAST_INSERT_ID()) AS response;
END$$

/*****************************************************************
  CONTROPARTI – UPDATE
 *****************************************************************/
DROP PROCEDURE IF EXISTS UpdateControparte$$
CREATE PROCEDURE UpdateControparte(
    IN p_id             INT,
    IN p_nome           VARCHAR(255),
    IN p_tipo           ENUM('CLIENTE','FORNITORE'),
    IN p_codice_fiscale VARCHAR(20),
    IN p_partita_iva    VARCHAR(20),
    IN p_indirizzo      VARCHAR(255),
    IN p_citta          VARCHAR(100),
    IN p_cap            VARCHAR(10),
    IN p_provincia      VARCHAR(2),
    IN p_nazione        VARCHAR(50),
    IN p_telefono       VARCHAR(20),
    IN p_email          VARCHAR(100),
    IN p_contatto       VARCHAR(100),
    IN p_note           TEXT
) BEGIN
  DECLARE v_rows INT DEFAULT 0;
  DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SELECT JSON_OBJECT('status','error','message','Errore update controparte') AS response; END;
  START TRANSACTION;
  IF NOT EXISTS (SELECT 1 FROM controparti WHERE id=p_id) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Controparte non trovata'; END IF;
  IF p_tipo NOT IN ('CLIENTE','FORNITORE') THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Tipo non valido'; END IF;
  UPDATE controparti SET nome=p_nome,tipo=p_tipo,codice_fiscale=p_codice_fiscale,partita_iva=p_partita_iva,indirizzo=p_indirizzo,citta=p_citta,cap=p_cap,provincia=p_provincia,nazione=p_nazione,telefono=p_telefono,email=p_email,contatto=p_contatto,note=p_note
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
    IN p_nome           VARCHAR(255),
    IN p_tipo           ENUM('CLIENTE','FORNITORE'),
    IN p_codice_fiscale VARCHAR(20),
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
    WHERE (p_nome           IS NULL OR nome LIKE CONCAT('%',p_nome,'%'))
      AND (p_tipo           IS NULL OR tipo=p_tipo)
      AND (p_codice_fiscale IS NULL OR codice_fiscale LIKE CONCAT('%',p_codice_fiscale,'%'))
      AND (p_partita_iva    IS NULL OR partita_iva LIKE CONCAT('%',p_partita_iva,'%'))
      AND (p_citta          IS NULL OR citta LIKE CONCAT('%',p_citta,'%'))
      AND (p_contatto       IS NULL OR contatto LIKE CONCAT('%',p_contatto,'%'));

  -- Build query dinamica con JSON_ARRAYAGG identica a pattern FetchOrdini/FetchMovimenti
  SET @q = CONCAT(
    'SELECT JSON_ARRAYAGG(JSON_OBJECT(',
      '"id",id,',
      '"nome",nome,',
      '"tipo",tipo,',
      '"codice_fiscale",codice_fiscale,',
      '"partita_iva",partita_iva,',
      '"citta",citta,',
      '"telefono",telefono,',
      '"email",email,',
      '"contatto",contatto',
    ')) AS data FROM controparti WHERE 1=1',
    IF(p_nome           IS NULL,'', CONCAT(' AND nome LIKE "%',p_nome,'%"')),
    IF(p_tipo           IS NULL,'', CONCAT(' AND tipo="',p_tipo,'"')),
    IF(p_codice_fiscale IS NULL,'', CONCAT(' AND codice_fiscale LIKE "%',p_codice_fiscale,'%"')),
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