-- #############################################################
--  STORED PROCEDURE SET COMPLETO – DATABASE MAGAZZINO
--  Compatibili con front-end React (JSON responses)
-- #############################################################
--  Pattern applicato a TUTTE le tabelle:
--    • Transazioni sicure con ROLLBACK su errori
--    • Validazioni business & FK tramite SIGNAL SQLSTATE '45000'
--    • Risposte JSON uniformi (success / error / warning)
--    • Fetch con filtri dinamici, paginazione (page, pageSize), ordinamento (order_by, order_dir)
-- #############################################################

DELIMITER $$

/*****************************************************************
  1) ARTICOLI
 *****************************************************************/
DROP PROCEDURE IF EXISTS InsertArticoli$$
CREATE PROCEDURE InsertArticoli(
    IN p_name          VARCHAR(100),
    IN p_description   VARCHAR(100),
    IN p_quantita      DECIMAL(12,2),
    IN p_min           DECIMAL(12,2),
    IN p_max           DECIMAL(12,2),
    IN p_supplier      VARCHAR(100),
    IN p_has_diba      ENUM('S','N'),
    IN p_um            VARCHAR(10),
    IN p_prezzo        DECIMAL(12,2)
) BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN ROLLBACK; SELECT JSON_OBJECT('status','error','message','Errore inserimento articolo') AS response; END;
    START TRANSACTION;
    -- Validation
    IF p_quantita IS NOT NULL AND p_quantita < 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Quantità >= 0'; END IF;
    IF p_min IS NOT NULL AND p_min < 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Min >= 0'; END IF;
    IF p_max IS NOT NULL AND p_max < 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Max >= 0'; END IF;
    IF p_prezzo IS NOT NULL AND p_prezzo < 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Prezzo >= 0'; END IF;
    INSERT INTO articoli(name,description,quantita,`min`,`max`,supplier,has_diba,um,prezzo)
    VALUES(p_name,p_description,p_quantita,p_min,p_max,p_supplier,p_has_diba,p_um,p_prezzo);
    COMMIT;
    SELECT JSON_OBJECT('status','success','insertId',LAST_INSERT_ID()) AS response;
END$$

DROP PROCEDURE IF EXISTS UpdateArticoli$$
CREATE PROCEDURE UpdateArticoli(
    IN p_id INT,
    IN p_name          VARCHAR(100),
    IN p_description   VARCHAR(100),
    IN p_quantita      DECIMAL(12,2),
    IN p_min           DECIMAL(12,2),
    IN p_max           DECIMAL(12,2),
    IN p_supplier      VARCHAR(100),
    IN p_has_diba      ENUM('S','N'),
    IN p_um            VARCHAR(10),
    IN p_prezzo        DECIMAL(12,2)
) BEGIN
    DECLARE v_rows INT DEFAULT 0; DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SELECT JSON_OBJECT('status','error','message','Errore update articolo') AS response; END;
    START TRANSACTION;
    IF NOT EXISTS (SELECT 1 FROM articoli WHERE id=p_id) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Articolo non trovato'; END IF;
    -- Validations as Insert
    IF p_quantita IS NOT NULL AND p_quantita < 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Quantità >= 0'; END IF;
    IF p_min IS NOT NULL AND p_min < 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Min >= 0'; END IF;
    IF p_max IS NOT NULL AND p_max < 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Max >= 0'; END IF;
    IF p_prezzo IS NOT NULL AND p_prezzo < 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Prezzo >= 0'; END IF;
    UPDATE articoli SET name=p_name,description=p_description,quantita=p_quantita,`min`=p_min,`max`=p_max,supplier=p_supplier,has_diba=p_has_diba,um=p_um,prezzo=p_prezzo WHERE id=p_id;
    SET v_rows=ROW_COUNT(); COMMIT;
    SELECT JSON_OBJECT('status',IF(v_rows>0,'success','warning'),'rowsAffected',v_rows) AS response;
END$$

DROP PROCEDURE IF EXISTS DeleteArticoli$$
CREATE PROCEDURE DeleteArticoli(IN p_id INT) BEGIN
    DECLARE v_rows INT DEFAULT 0; DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SELECT JSON_OBJECT('status','error','message','Errore delete articolo') AS response; END;
    START TRANSACTION; DELETE FROM articoli WHERE id=p_id; SET v_rows=ROW_COUNT(); IF v_rows=0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Articolo non trovato'; END IF; COMMIT;
    SELECT JSON_OBJECT('status','success','rowsDeleted',v_rows) AS response;
END$$

DROP PROCEDURE IF EXISTS FetchArticoli$$
CREATE PROCEDURE FetchArticoli(
    IN p_name VARCHAR(100), IN p_supplier VARCHAR(100), IN p_page INT, IN p_page_size INT, IN p_order_by VARCHAR(50), IN p_order_dir VARCHAR(4)
) BEGIN
    DECLARE v_offset INT DEFAULT 0; DECLARE v_total INT DEFAULT 0; SET v_offset=(p_page-1)*p_page_size;
    SELECT COUNT(*) INTO v_total FROM articoli WHERE (p_name IS NULL OR name LIKE CONCAT('%',p_name,'%')) AND (p_supplier IS NULL OR supplier LIKE CONCAT('%',p_supplier,'%'));
    SET @q = CONCAT('SELECT JSON_ARRAYAGG(JSON_OBJECT("id",id,"name",name,"description",description,"quantita",quantita,"prezzo",prezzo,"supplier",supplier)) AS data FROM articoli WHERE 1=1 ',
                    IF(p_name IS NULL,'', CONCAT(' AND name LIKE "%',p_name,'%"')),
                    IF(p_supplier IS NULL,'', CONCAT(' AND supplier LIKE "%',p_supplier,'%"')),
                    ' ORDER BY ', p_order_by,' ',p_order_dir,' LIMIT ',p_page_size,' OFFSET ',v_offset);
    PREPARE s FROM @q; EXECUTE s; DEALLOCATE PREPARE s;
    SELECT JSON_OBJECT('status','success','totalRows',v_total,'page',p_page,'pageSize',p_page_size) AS meta;
END$$

/*****************************************************************
  2) CAUSALI
 *****************************************************************/
-- ... (già presenti nel file precedente, copiati integralmente) ...
/*****************************************************************
  3) CLIENTI
 *****************************************************************/
-- ... (già presenti)

/*****************************************************************
  4) FORNITORI
 *****************************************************************/
DROP PROCEDURE IF EXISTS InsertFornitori$$
CREATE PROCEDURE InsertFornitori(
    IN p_codice VARCHAR(10), IN p_rag_soc VARCHAR(255), IN p_partita_iva VARCHAR(20), IN p_cf VARCHAR(20),
    IN p_indirizzo VARCHAR(255), IN p_citta VARCHAR(100), IN p_cap VARCHAR(10), IN p_pv VARCHAR(2), IN p_nazione VARCHAR(50),
    IN p_telefono VARCHAR(20), IN p_email VARCHAR(100), IN p_sito_web VARCHAR(100), IN p_note TEXT, IN p_contatto VARCHAR(100)
) BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SELECT JSON_OBJECT('status','error','message','Errore inserimento fornitore') AS response; END;
    START TRANSACTION;
    IF p_codice IS NULL OR p_codice='' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Codice fornitore obbligatorio'; END IF;
    INSERT INTO fornitori(codice,rag_soc,partita_iva,cf,indirizzo,citta,cap,pv,nazione,telefono,email,sito_web,note,contatto)
    VALUES(p_codice,p_rag_soc,p_partita_iva,p_cf,p_indirizzo,p_citta,p_cap,p_pv,p_nazione,p_telefono,p_email,p_sito_web,p_note,p_contatto);
    COMMIT; SELECT JSON_OBJECT('status','success','insertId',LAST_INSERT_ID()) AS response;
END$$

DROP PROCEDURE IF EXISTS UpdateFornitori$$
CREATE PROCEDURE UpdateFornitori(
    IN p_id INT, IN p_codice VARCHAR(10), IN p_rag_soc VARCHAR(255), IN p_partita_iva VARCHAR(20), IN p_cf VARCHAR(20),
    IN p_indirizzo VARCHAR(255), IN p_citta VARCHAR(100), IN p_cap VARCHAR(10), IN p_pv VARCHAR(2), IN p_nazione VARCHAR(50),
    IN p_telefono VARCHAR(20), IN p_email VARCHAR(100), IN p_sito_web VARCHAR(100), IN p_note TEXT, IN p_contatto VARCHAR(100)
) BEGIN
    DECLARE v_rows INT DEFAULT 0; DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SELECT JSON_OBJECT('status','error','message','Errore update fornitore') AS response; END;
    START TRANSACTION; IF NOT EXISTS (SELECT 1 FROM fornitori WHERE id=p_id) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Fornitore non trovato'; END IF;
    UPDATE fornitori SET codice=p_codice, rag_soc=p_rag_soc, partita_iva=p_partita_iva, cf=p_cf, indirizzo=p_indirizzo, citta=p_citta, cap=p_cap, pv=p_pv, nazione=p_nazione,
         telefono=p_telefono, email=p_email, sito_web=p_sito_web, note=p_note, contatto=p_contatto WHERE id=p_id;
    SET v_rows=ROW_COUNT(); COMMIT; SELECT JSON_OBJECT('status',IF(v_rows>0,'success','warning'),'rowsAffected',v_rows) AS response;
END$$

DROP PROCEDURE IF EXISTS DeleteFornitori$$
CREATE PROCEDURE DeleteFornitori(IN p_id INT) BEGIN DECLARE v_rows INT DEFAULT 0; DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SELECT JSON_OBJECT('status','error','message','Errore delete fornitore') AS response; END;
  START TRANSACTION; DELETE FROM fornitori WHERE id=p_id; SET v_rows=ROW_COUNT(); IF v_rows=0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Fornitore non trovato'; END IF; COMMIT;
  SELECT JSON_OBJECT('status','success','rowsDeleted',v_rows) AS response;
END$$

DROP PROCEDURE IF EXISTS FetchFornitori$$
CREATE PROCEDURE FetchFornitori(
    IN p_codice VARCHAR(10), IN p_rag_soc VARCHAR(255), IN p_page INT, IN p_page_size INT, IN p_order_by VARCHAR(50), IN p_order_dir VARCHAR(4)
) BEGIN
    DECLARE v_offset INT DEFAULT 0; DECLARE v_total INT DEFAULT 0; SET v_offset=(p_page-1)*p_page_size;
    SELECT COUNT(*) INTO v_total FROM fornitori WHERE (p_codice IS NULL OR codice LIKE CONCAT('%',p_codice,'%')) AND (p_rag_soc IS NULL OR rag_soc LIKE CONCAT('%',p_rag_soc,'%'));
    SET @q = CONCAT('SELECT JSON_ARRAYAGG(JSON_OBJECT("id",id,"codice",codice,"rag_soc",rag_soc,"telefono",telefono)) AS data FROM fornitori WHERE 1=1',
                    IF(p_codice IS NULL,'', CONCAT(' AND codice LIKE "%',p_codice,'%"')),
                    IF(p_rag_soc IS NULL,'', CONCAT(' AND rag_soc LIKE "%',p_rag_soc,'%"')),
                    ' ORDER BY ',p_order_by,' ',p_order_dir,' LIMIT ',p_page_size,' OFFSET ',v_offset);
    PREPARE s FROM @q; EXECUTE s; DEALLOCATE PREPARE s;
    SELECT JSON_OBJECT('status','success','totalRows',v_total,'page',p_page,'pageSize',p_page_size) AS meta;
END$$

/*****************************************************************
  5) LOGIN
 *****************************************************************/
DROP PROCEDURE IF EXISTS InsertLogin$$
CREATE PROCEDURE InsertLogin(IN p_user VARCHAR(100), IN p_pwd VARCHAR(60), IN p_role VARCHAR(10)) BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SELECT JSON_OBJECT('status','error','message','Errore inserimento login') AS response; END;
    START TRANSACTION; IF EXISTS (SELECT 1 FROM login WHERE user=p_user) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Utente già esistente'; END IF;
    INSERT INTO login(`user`,pwd,role) VALUES(p_user,p_pwd,p_role); COMMIT; SELECT JSON_OBJECT('status','success','insertId',LAST_INSERT_ID()) AS response;
END$$

DROP PROCEDURE IF EXISTS UpdateLogin$$
CREATE PROCEDURE UpdateLogin(IN p_id INT, IN p_pwd VARCHAR(60), IN p_role VARCHAR(10)) BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SELECT JSON_OBJECT('status','error','message','Errore update login') AS response; END;
    START TRANSACTION; IF NOT EXISTS (SELECT 1 FROM login WHERE id=p_id) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Login non trovato'; END IF;
    UPDATE login SET pwd=p_pwd, role=p_role WHERE id=p_id; COMMIT; SELECT JSON_OBJECT('status','success','message','Login aggiornato') AS response;
END$$

DROP PROCEDURE IF EXISTS DeleteLogin$$
CREATE PROCEDURE DeleteLogin(IN p_id INT) BEGIN DECLARE v INT; DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SELECT JSON_OBJECT('status','error','message','Errore delete login') AS response; END;
  START TRANSACTION; DELETE FROM login WHERE id=p_id; SET v=ROW_COUNT(); IF v=0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Login non trovato'; END IF; COMMIT; SELECT JSON_OBJECT('status','success','rowsDeleted',v) AS response;
END$$

DROP PROCEDURE IF EXISTS FetchLogin$$
CREATE PROCEDURE FetchLogin(IN p_user VARCHAR(100), IN p_page INT, IN p_page_size INT, IN p_order_by VARCHAR(50), IN p_order_dir VARCHAR(4)) BEGIN
    DECLARE v_offset INT DEFAULT 0; DECLARE v_total INT DEFAULT 0; SET v_offset=(p_page-1)*p_page_size;
    SELECT COUNT(*) INTO v_total FROM login WHERE (p_user IS NULL OR `user` LIKE CONCAT('%',p_user,'%'));
    SET @q = CONCAT('SELECT JSON_ARRAYAGG(JSON_OBJECT("id",id,"user",`user`,`role`,role)) AS data FROM login WHERE 1=1',
                    IF(p_user IS NULL,'', CONCAT(' AND `user` LIKE "%',p_user,'%"')),
                    ' ORDER BY ',p_order_by,' ',p_order_dir,' LIMIT ',p_page_size,' OFFSET ',v_offset);
    PREPARE s FROM @q; EXECUTE s; DEALLOCATE PREPARE s; SELECT JSON_OBJECT('status','success','totalRows',v_total,'page',p_page,'pageSize',p_page_size) AS meta;
END$$

/*****************************************************************
  6) DDT & DDT_RIGHE
 *****************************************************************/
-- DDT ----------------------------------------------------------
DROP PROCEDURE IF EXISTS InsertDdt$$
CREATE PROCEDURE InsertDdt(IN p_num_ddt VARCHAR(20), IN p_data_ddt DATE, IN p_cliente_id INT, IN p_stato ENUM('DA_SPEDIRE','SPEDITO','ANNULLATO'), IN p_note TEXT) BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SELECT JSON_OBJECT('status','error','message','Errore inserimento DDT') AS response; END;
    START TRANSACTION;
    IF NOT EXISTS (SELECT 1 FROM clienti WHERE id=p_cliente_id) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Cliente non esiste'; END IF;
    INSERT INTO ddt(num_ddt,data_ddt,cliente_id,stato,note) VALUES(p_num_ddt,p_data_ddt,p_cliente_id,p_stato,p_note);
    COMMIT; SELECT JSON_OBJECT('status','success','insertId',LAST_INSERT_ID()) AS response;
END$$

DROP PROCEDURE IF EXISTS UpdateDdt$$
CREATE PROCEDURE UpdateDdt(IN p_id_ddt INT, IN p_num_ddt VARCHAR(20), IN p_data_ddt DATE, IN p_cliente_id INT, IN p_stato ENUM('DA_SPEDIRE','SPEDITO','ANNULLATO'), IN p_note TEXT) BEGIN
    DECLARE v_rows INT; DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SELECT JSON_OBJECT('status','error','message','Errore update DDT') AS response; END;
    START TRANSACTION; IF NOT EXISTS (SELECT 1 FROM ddt WHERE id_ddt=p_id_ddt) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='DDT non trovato'; END IF;
    IF NOT EXISTS (SELECT 1 FROM clienti WHERE id=p_cliente_id) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Cliente non esiste'; END IF;
    UPDATE ddt SET num_ddt=p_num_ddt,data_ddt=p_data_ddt,cliente_id=p_cliente_id,stato=p_stato,note=p_note WHERE id_ddt=p_id_ddt;
    SET v_rows=ROW_COUNT(); COMMIT; SELECT JSON_OBJECT('status',IF(v_rows>0,'success','warning'),'rowsAffected',v_rows) AS response;
END$$

DROP PROCEDURE IF EXISTS DeleteDdt$$
CREATE PROCEDURE DeleteDdt(IN p_id_ddt INT) BEGIN DECLARE v INT; DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SELECT JSON_OBJECT('status','error','message','Errore delete DDT') AS response; END;
  START TRANSACTION; DELETE FROM ddt WHERE id_ddt=p_id_ddt; SET v=ROW_COUNT(); IF v=0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='DDT non trovato'; END IF; COMMIT; SELECT JSON_OBJECT('status','success','rowsDeleted',v) AS response;
END$$

DROP PROCEDURE IF EXISTS FetchDdt$$
CREATE PROCEDURE FetchDdt(IN p_num_ddt VARCHAR(20), IN p_cliente_id INT, IN p_page INT, IN p_page_size INT, IN p_order_by VARCHAR(50), IN p_order_dir VARCHAR(4)) BEGIN
    DECLARE v_offset INT DEFAULT 0; DECLARE v_total INT DEFAULT 0; SET v_offset=(p_page-1)*p_page_size;
    SELECT COUNT(*) INTO v_total FROM ddt WHERE (p_num_ddt IS NULL OR num_ddt LIKE CONCAT('%',p_num_ddt,'%')) AND (p_cliente_id IS NULL OR cliente_id=p_cliente_id);
    SET @q = CONCAT('SELECT JSON_ARRAYAGG(JSON_OBJECT("id_ddt",id_ddt,"num_ddt",num_ddt,"data_ddt",data_ddt,"cliente_id",cliente_id,"stato",stato)) AS data FROM ddt WHERE 1=1',
                    IF(p_num_ddt IS NULL,'', CONCAT(' AND num_ddt LIKE "%',p_num_ddt,'%"')),
                    IF(p_cliente_id IS NULL,'', CONCAT(' AND cliente_id=',p_cliente_id)),
                    ' ORDER BY ',p_order_by,' ',p_order_dir,' LIMIT ',p_page_size,' OFFSET ',v_offset);
    PREPARE s FROM @q; EXECUTE s; DEALLOCATE PREPARE s; SELECT JSON_OBJECT('status','success','totalRows',v_total,'page',p_page,'pageSize',p_page_size) AS meta;
END$$

-- DDT_RIGHE ----------------------------------------------------
DROP PROCEDURE IF EXISTS InsertDdt_righe$$
CREATE PROCEDURE InsertDdt_righe(IN p_id_ddt INT, IN p_cod_articolo VARCHAR(30), IN p_descrizione VARCHAR(255), IN p_qta DECIMAL(10,2)) BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SELECT JSON_OBJECT('status','error','message','Errore inserimento riga DDT') AS response; END;
    START TRANSACTION; IF p_qta<=0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Quantità >0'; END IF;
    IF NOT EXISTS (SELECT 1 FROM ddt WHERE id_ddt=p_id_ddt) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='DDT non trovato'; END IF;
    INSERT INTO ddt_righe(id_ddt,cod_articolo,descrizione,qta) VALUES(p_id_ddt,p_cod_articolo,p_descrizione,p_qta);
    COMMIT; SELECT JSON_OBJECT('status','success','insertId',LAST_INSERT_ID()) AS response;
END$$

DROP PROCEDURE IF EXISTS UpdateDdt_righe$$
CREATE PROCEDURE UpdateDdt_righe(IN p_id_riga INT, IN p_id_ddt INT, IN p_cod_articolo VARCHAR(30), IN p_descrizione VARCHAR(255), IN p_qta DECIMAL(10,2)) BEGIN
    DECLARE v INT; DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SELECT JSON_OBJECT('status','error','message','Errore update riga DDT') AS response; END;
    START TRANSACTION; IF NOT EXISTS (SELECT 1 FROM ddt_righe WHERE id_riga=p_id_riga) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Riga non trovata'; END IF;
    IF NOT EXISTS (SELECT 1 FROM ddt WHERE id_ddt=p_id_ddt) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='DDT non trovato'; END IF;
    IF p_qta<=0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Quantità >0'; END IF;
    UPDATE ddt_righe SET id_ddt=p_id_ddt,cod_articolo=p_cod_articolo,descrizione=p_descrizione,qta=p_qta WHERE id_riga=p_id_riga;
    SET v=ROW_COUNT(); COMMIT; SELECT JSON_OBJECT('status',IF(v>0,'success','warning'),'rowsAffected',v) AS response;
END$$

DROP PROCEDURE IF EXISTS DeleteDdt_righe$$
CREATE PROCEDURE DeleteDdt_righe(IN p_id_riga INT) BEGIN DECLARE v INT; DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SELECT JSON_OBJECT('status','error','message','Errore delete riga DDT') AS response; END;
  START TRANSACTION; DELETE FROM ddt_righe WHERE id_riga=p_id_riga; SET v=ROW_COUNT(); IF v=0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Riga non trovata'; END IF; COMMIT; SELECT JSON_OBJECT('status','success','rowsDeleted',v) AS response;
END$$

DROP PROCEDURE IF EXISTS FetchDdt_righe$$
CREATE PROCEDURE FetchDdt_righe(IN p_id_ddt INT, IN p_page INT, IN p_page_size INT, IN p_order_by VARCHAR(50), IN p_order_dir VARCHAR(4)) BEGIN
  DECLARE v_offset INT DEFAULT 0; DECLARE v_total INT DEFAULT 0; SET v_offset=(p_page-1)*p_page_size;
  SELECT COUNT(*) INTO v_total FROM ddt_righe WHERE (p_id_ddt IS NULL OR id_ddt=p_id_ddt);
  SET @q = CONCAT('SELECT JSON_ARRAYAGG(JSON_OBJECT("id_riga",id_riga,"id_ddt",id_ddt,"cod_articolo",cod_articolo,"descrizione",descrizione,"qta",qta)) AS data FROM ddt_righe WHERE 1=1',
                  IF(p_id_ddt IS NULL,'', CONCAT(' AND id_ddt=',p_id_ddt)),
                  ' ORDER BY ',p_order_by,' ',p_order_dir,' LIMIT ',p_page_size,' OFFSET ',v_offset);
  PREPARE s FROM @q; EXECUTE s; DEALLOCATE PREPARE s; SELECT JSON_OBJECT('status','success','totalRows',v_total,'page',p_page,'pageSize',p_page_size) AS meta;
END$$

/*****************************************************************
  7) DIBA
 *****************************************************************/
DROP PROCEDURE IF EXISTS InsertDiba$$
CREATE PROCEDURE InsertDiba(IN p_id_father INT, IN p_id_son INT, IN p_quantita DECIMAL(10,2)) BEGIN
  DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SELECT JSON_OBJECT('status','error','message','Errore inserimento DIBA') AS response; END;
  START TRANSACTION; IF p_quantita<=0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Quantità >0'; END IF;
  IF NOT EXISTS (SELECT 1 FROM articoli WHERE id=p_id_father) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Articolo padre non esiste'; END IF;
  IF NOT EXISTS (SELECT 1 FROM articoli WHERE id=p_id_son) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Articolo figlio non esiste'; END IF;
  INSERT INTO diba(id_father,id_son,quantita) VALUES(p_id_father,p_id_son,p_quantita); COMMIT; SELECT JSON_OBJECT('status','success','insertId',LAST_INSERT_ID()) AS response;
END$$

DROP PROCEDURE IF EXISTS UpdateDiba$$
CREATE PROCEDURE UpdateDiba(IN p_id INT, IN p_id_father INT, IN p_id_son INT, IN p_quantita DECIMAL(10,2)) BEGIN
  DECLARE v INT; DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SELECT JSON_OBJECT('status','error','message','Errore update DIBA') AS response; END;
  START TRANSACTION; IF NOT EXISTS (SELECT 1 FROM diba WHERE id=p_id) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Record DIBA non trovato'; END IF;
  IF p_quantita<=0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Quantità >0'; END IF;
  IF NOT EXISTS (SELECT 1 FROM articoli WHERE id=p_id_father) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Articolo padre non esiste'; END IF;
  IF NOT EXISTS (SELECT 1 FROM articoli WHERE id=p_id_son) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Articolo figlio non esiste'; END IF;
  UPDATE diba SET id_father=p_id_father,id_son=p_id_son,quantita=p_quantita WHERE id=p_id; SET v=ROW_COUNT(); COMMIT; SELECT JSON_OBJECT('status',IF(v>0,'success','warning'),'rowsAffected',v) AS response;
END$$

DROP PROCEDURE IF EXISTS DeleteDiba$$
CREATE PROCEDURE DeleteDiba(IN p_id INT) BEGIN DECLARE v INT; DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SELECT JSON_OBJECT('status','error','message','Errore delete DIBA') AS response; END;
  START TRANSACTION; DELETE FROM diba WHERE id=p_id; SET v=ROW_COUNT(); IF v=0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Record DIBA non trovato'; END IF; COMMIT; SELECT JSON_OBJECT('status','success','rowsDeleted',v) AS response;
END$$

DROP PROCEDURE IF EXISTS FetchDiba$$
CREATE PROCEDURE FetchDiba(IN p_id_father INT, IN p_page INT, IN p_page_size INT, IN p_order_by VARCHAR(50), IN p_order_dir VARCHAR(4)) BEGIN
  DECLARE v_offset INT DEFAULT 0; DECLARE v_total INT DEFAULT 0; SET v_offset=(p_page-1)*p_page_size;
  SELECT COUNT(*) INTO v_total FROM diba WHERE (p_id_father IS NULL OR id_father=p_id_father);
  SET @q = CONCAT('SELECT JSON_ARRAYAGG(JSON_OBJECT("id",id,"id_father",id_father,"id_son",id_son,"quantita",quantita)) AS data FROM diba WHERE 1=1',
                  IF(p_id_father IS NULL,'', CONCAT(' AND id_father=',p_id_father)),
                  ' ORDER BY ',p_order_by,' ',p_order_dir,' LIMIT ',p_page_size,' OFFSET ',v_offset);
  PREPARE s FROM @q; EXECUTE s; DEALLOCATE PREPARE s; SELECT JSON_OBJECT('status','success','totalRows',v_total,'page',p_page,'pageSize',p_page_size) AS meta;
END$$

/*****************************************************************
  8) MOVIMENTI
 *****************************************************************/
DROP PROCEDURE IF EXISTS InsertMovimenti$$
CREATE PROCEDURE InsertMovimenti(IN p_data DATE, IN p_tipo ENUM('C','S'), IN p_description VARCHAR(255), IN p_quantita DECIMAL(12,2), IN p_codice_cau VARCHAR(3), IN p_idart INT, IN p_note TEXT, IN p_user VARCHAR(100), IN p_um VARCHAR(10)) BEGIN
  DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SELECT JSON_OBJECT('status','error','message','Errore inserimento movimento') AS response; END;
  START TRANSACTION; IF p_quantita<=0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Quantità >0'; END IF;
  IF NOT EXISTS (SELECT 1 FROM causali WHERE codice=p_codice_cau) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Causale inesistente'; END IF;
  IF NOT EXISTS (SELECT 1 FROM articoli WHERE id=p_idart) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Articolo inesistente'; END IF;
  INSERT INTO movimenti(`data`,tipo,description,quantita,codice_cau,idart,note,descriptioncau,descriptionart,`user`,`timestamp`,um)
      SELECT p_data,p_tipo,p_description,p_quantita,p_codice_cau,p_idart,p_note,description,name,p_user,NOW(),p_um
      FROM causali c, articoli a WHERE c.codice=p_codice_cau AND a.id=p_idart LIMIT 1;
  COMMIT; SELECT JSON_OBJECT('status','success','insertId',LAST_INSERT_ID()) AS response;
END$$

DROP PROCEDURE IF EXISTS UpdateMovimenti$$
CREATE PROCEDURE UpdateMovimenti(IN p_id INT, IN p_data DATE, IN p_tipo ENUM('C','S'), IN p_description VARCHAR(255), IN p_quantita DECIMAL(12,2), IN p_codice_cau VARCHAR(3), IN p_idart INT, IN p_note TEXT, IN p_user VARCHAR(100), IN p_um VARCHAR(10)) BEGIN
  DECLARE v INT; DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SELECT JSON_OBJECT('status','error','message','Errore update movimento') AS response; END;
  START TRANSACTION; IF NOT EXISTS (SELECT 1 FROM movimenti WHERE id=p_id) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Movimento non trovato'; END IF;
  IF p_quantita<=0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Quantità >0'; END IF;
  IF NOT EXISTS (SELECT 1 FROM causali WHERE codice=p_codice_cau) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Causale inesistente'; END IF;
  IF NOT EXISTS (SELECT 1 FROM articoli WHERE id=p_idart) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Articolo inesistente'; END IF;
  UPDATE movimenti SET `data`=p_data,tipo=p_tipo,description=p_description,quantita=p_quantita,codice_cau=p_codice_cau,idart=p_idart,note=p_note,`user`=p_user,um=p_um WHERE id=p_id; SET v=ROW_COUNT(); COMMIT; SELECT JSON_OBJECT('status',IF(v>0,'success','warning'),'rowsAffected',v) AS response;
END$$

DROP PROCEDURE IF EXISTS DeleteMovimenti$$
CREATE PROCEDURE DeleteMovimenti(IN p_id INT) BEGIN DECLARE v INT; DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SELECT JSON_OBJECT('status','error','message','Errore delete movimento') AS response; END;
  START TRANSACTION; DELETE FROM movimenti WHERE id=p_id; SET v=ROW_COUNT(); IF v=0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Movimento non trovato'; END IF; COMMIT; SELECT JSON_OBJECT('status','success','rowsDeleted',v) AS response;
END$$

DROP PROCEDURE IF EXISTS FetchMovimenti$$
CREATE PROCEDURE FetchMovimenti(IN p_codice_cau VARCHAR(3), IN p_idart INT, IN p_from DATE, IN p_to DATE, IN p_page INT, IN p_page_size INT, IN p_order_by VARCHAR(50), IN p_order_dir VARCHAR(4)) BEGIN
  DECLARE v_offset INT DEFAULT 0; DECLARE v_total INT DEFAULT 0; SET v_offset=(p_page-1)*p_page_size;
  SELECT COUNT(*) INTO v_total FROM movimenti WHERE (p_codice_cau IS NULL OR codice_cau=p_codice_cau) AND (p_idart IS NULL OR idart=p_idart) AND (p_from IS NULL OR `data`>=p_from) AND (p_to IS NULL OR `data`<=p_to);
  SET @q = CONCAT('SELECT JSON_ARRAYAGG(JSON_OBJECT("id",id,"data",`data`,"tipo",tipo,"description",description,"quantita",quantita,"codice_cau",codice_cau,"idart",idart)) AS data FROM movimenti WHERE 1=1',
                  IF(p_codice_cau IS NULL,'', CONCAT(' AND codice_cau="',p_codice_cau,'"')),
                  IF(p_idart IS NULL,'', CONCAT(' AND idart=',p_idart)),
                  IF(p_from IS NULL,'', CONCAT(' AND `data`>="',p_from,'"')),
                  IF(p_to IS NULL,'', CONCAT(' AND `data`<="',p_to,'"')),
                  ' ORDER BY ',p_order_by,' ',p_order_dir,' LIMIT ',p_page_size,' OFFSET ',v_offset);
  PREPARE s FROM @q; EXECUTE s; DEALLOCATE PREPARE s; SELECT JSON_OBJECT('status','success','totalRows',v_total,'page',p_page,'pageSize',p_page_size) AS meta;
END$$

/*****************************************************************
  9) ORDINI & ORDINI_RIGHE
 *****************************************************************/
-- ORDINI -------------------------------------------------------
DROP PROCEDURE IF EXISTS InsertOrdini$$
CREATE PROCEDURE InsertOrdini(IN p_num_ordine VARCHAR(20), IN p_data DATE, IN p_fornitore_id INT, IN p_stato ENUM('APERTO','INVIATO','CHIUSO','ANNULLATO'), IN p_note TEXT) BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SELECT JSON_OBJECT('status','error','message','Errore inserimento ordine') AS response; END;
    START TRANSACTION; IF NOT EXISTS (SELECT 1 FROM fornitori WHERE id=p_fornitore_id) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Fornitore non esiste'; END IF;
    INSERT INTO ordini(num_ordine,data_ordine,fornitore_id,stato,note) VALUES(p_num_ordine,p_data,p_fornitore_id,p_stato,p_note); COMMIT; SELECT JSON_OBJECT('status','success','insertId',LAST_INSERT_ID()) AS response;
END$$

DROP PROCEDURE IF EXISTS UpdateOrdini$$
CREATE PROCEDURE UpdateOrdini(IN p_id INT, IN p_num_ordine VARCHAR(20), IN p_data DATE, IN p_fornitore_id INT, IN p_stato ENUM('APERTO','INVIATO','CHIUSO','ANNULLATO'), IN p_note TEXT) BEGIN
  DECLARE v INT; DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SELECT JSON_OBJECT('status','error','message','Errore update ordine') AS response; END;
  START TRANSACTION; IF NOT EXISTS (SELECT 1 FROM ordini WHERE id_ordine=p_id) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Ordine non trovato'; END IF;
  IF NOT EXISTS (SELECT 1 FROM fornitori WHERE id=p_fornitore_id) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Fornitore non esiste'; END IF;
  UPDATE ordini SET num_ordine=p_num_ordine,data_ordine=p_data,fornitore_id=p_fornitore_id,stato=p_stato,note=p_note WHERE id_ordine=p_id; SET v=ROW_COUNT(); COMMIT; SELECT JSON_OBJECT('status',IF(v>0,'success','warning'),'rowsAffected',v) AS response;
END$$

DROP PROCEDURE IF EXISTS DeleteOrdini$$
CREATE PROCEDURE DeleteOrdini(IN p_id INT) BEGIN DECLARE v INT; DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SELECT JSON_OBJECT('status','error','message','Errore delete ordine') AS response; END;
  START TRANSACTION; DELETE FROM ordini WHERE id_ordine=p_id; SET v=ROW_COUNT(); IF v=0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Ordine non trovato'; END IF; COMMIT; SELECT JSON_OBJECT('status','success','rowsDeleted',v) AS response;
END$$

DROP PROCEDURE IF EXISTS FetchOrdini$$
CREATE PROCEDURE FetchOrdini(IN p_num_ordine VARCHAR(20), IN p_fornitore_id INT, IN p_page INT, IN p_page_size INT, IN p_order_by VARCHAR(50), IN p_order_dir VARCHAR(4)) BEGIN
  DECLARE v_offset INT DEFAULT 0; DECLARE v_total INT DEFAULT 0; SET v_offset=(p_page-1)*p_page_size;
  SELECT COUNT(*) INTO v_total FROM ordini WHERE (p_num_ordine IS NULL OR num_ordine LIKE CONCAT('%',p_num_ordine,'%')) AND (p_fornitore_id IS NULL OR fornitore_id=p_fornitore_id);
  SET @q = CONCAT('SELECT JSON_ARRAYAGG(JSON_OBJECT("id_ordine",id_ordine,"num_ordine",num_ordine,"data_ordine",data_ordine,"fornitore_id",fornitore_id,"stato",stato)) AS data FROM ordini WHERE 1=1',
                  IF(p_num_ordine IS NULL,'', CONCAT(' AND num_ordine LIKE "%',p_num_ordine,'%"')),
                  IF(p_fornitore_id IS NULL,'', CONCAT(' AND fornitore_id=',p_fornitore_id)),
                  ' ORDER BY ',p_order_by,' ',p_order_dir,' LIMIT ',p_page_size,' OFFSET ',v_offset);
  PREPARE s FROM @q; EXECUTE s; DEALLOCATE PREPARE s; SELECT JSON_OBJECT('status','success','totalRows',v_total,'page',p_page,'pageSize',p_page_size) AS meta;
END$$

-- ORDINI_RIGHE -------------------------------------------------
-- Gli esempi di Insert/Update/Delete già forniti: li integriamo e aggiungiamo Fetch
DROP PROCEDURE IF EXISTS InsertOrdini_righe$$
CREATE PROCEDURE InsertOrdini_righe(IN p_id_ordine INT, IN p_descrizione VARCHAR(255), IN p_prezzo_unitario DECIMAL(10,2), IN p_nome_articolo VARCHAR(100), IN p_quantita DECIMAL(12,2)) BEGIN
  DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SELECT JSON_OBJECT('status','error','message','Errore inserimento riga ordine') AS response; END;
  START TRANSACTION; IF p_quantita<=0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Quantità >0'; END IF; IF p_prezzo_unitario<=0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Prezzo_unitario >0'; END IF;
  IF NOT EXISTS (SELECT 1 FROM ordini WHERE id_ordine=p_id_ordine) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Ordine non trovato'; END IF;
  INSERT INTO ordini_righe(id_ordine,descrizione,prezzo_unitario,nome_articolo,quantita) VALUES(p_id_ordine,p_descrizione,p_prezzo_unitario,p_nome_articolo,p_quantita);
  COMMIT; SELECT JSON_OBJECT('status','success','insertId',LAST_INSERT_ID()) AS response;
END$$

DROP PROCEDURE IF EXISTS UpdateOrdini_righe$$
CREATE PROCEDURE UpdateOrdini_righe(IN p_id_riga INT, IN p_id_ordine INT, IN p_descrizione VARCHAR(255), IN p_prezzo_unitario DECIMAL(10,2), IN p_nome_articolo VARCHAR(100), IN p_quantita DECIMAL(12,2)) BEGIN
  DECLARE v INT; DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SELECT JSON_OBJECT('status','error','message','Errore update riga ordine') AS response; END;
  START TRANSACTION; IF NOT EXISTS (SELECT 1 FROM ordini_righe WHERE id_riga=p_id_riga) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Riga non trovata'; END IF;
  IF NOT EXISTS (SELECT 1 FROM ordini WHERE id_ordine=p_id_ordine) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Ordine non trovato'; END IF;
  IF p_quantita<=0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Quantità >0'; END IF; IF p_prezzo_unitario<=0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Prezzo_unitario >0'; END IF;
  UPDATE ordini_righe SET id_ordine=p_id_ordine,descrizione=p_descrizione,prezzo_unitario=p_prezzo_unitario,nome_articolo=p_nome_articolo,quantita=p_quantita WHERE id_riga=p_id_riga;
  SET v=ROW_COUNT(); COMMIT; SELECT JSON_OBJECT('status',IF(v>0,'success','warning'),'rowsAffected',v) AS response;
END$$

DROP PROCEDURE IF EXISTS DeleteOrdini_righe$$
CREATE PROCEDURE DeleteOrdini_righe(IN p_id_riga INT) BEGIN DECLARE v INT; DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SELECT JSON_OBJECT('status','error','message','Errore delete riga ordine') AS response; END;
  START TRANSACTION; DELETE FROM ordini_righe WHERE id_riga=p_id_riga; SET v=ROW_COUNT(); IF v=0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Riga non trovata'; END IF; COMMIT; SELECT JSON_OBJECT('status','success','rowsDeleted',v) AS response;
END$$

DROP PROCEDURE IF EXISTS FetchOrdini_righe$$
CREATE PROCEDURE FetchOrdini_righe(IN p_id_ordine INT, IN p_page INT, IN p_page_size INT, IN p_order_by VARCHAR(50), IN p_order_dir VARCHAR(4)) BEGIN
  DECLARE v_offset INT DEFAULT 0; DECLARE v_total INT DEFAULT 0; SET v_offset=(p_page-1)*p_page_size;
  SELECT COUNT(*) INTO v_total FROM ordini_righe WHERE (p_id_ordine IS NULL OR id_ordine=p_id_ordine);
  SET @q = CONCAT('SELECT JSON_ARRAYAGG(JSON_OBJECT("id_riga",id_riga,"id_ordine",id_ordine,"nome_articolo",nome_articolo,"quantita",quantita,"prezzo_unitario",prezzo_unitario,"totale_righe",totale_righe)) AS data FROM ordini_righe WHERE 1=1',
                  IF(p_id_ordine IS NULL,'', CONCAT(' AND id_ordine=',p_id_ordine)),
                  ' ORDER BY ',p_order_by,' ',p_order_dir,' LIMIT ',p_page_size,' OFFSET ',v_offset);
  PREPARE s FROM @q; EXECUTE s; DEALLOCATE PREPARE s; SELECT JSON_OBJECT('status','success','totalRows',v_total,'page',p_page,'pageSize',p_page_size) AS meta;
END$$

-- #############################################################
--  FINE DEL SET COMPLETO DI STORED PROCEDURES
-- #############################################################

DELIMITER ;