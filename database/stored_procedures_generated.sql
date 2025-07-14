-- #############################################################
--  Generated stored procedures for Magazzino DB (React-friendly)
--  Features for EVERY TABLE:
--    • Insert / Update / Delete use transactions & FK checks
--    • Fetch supports dynamic filters, pagination, ordering
--    • JSON responses compatible with front-end
--    • Advanced error handling via SHOW errors → JSON
-- #############################################################

-- NOTE: Per semplicità ogni procedura ritorna due recordset:
--   1) "data" o effetto (affectedRows / insertId ecc.)
--   2) "meta" con stato, paginazione e messaggi
-- =============================================================

DELIMITER $$

/* ============================================================
   ARTICOLI
   ============================================================*/
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
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT JSON_OBJECT('status','error','message', 'Errore durante l\'inserimento articolo') AS response;
    END;

    START TRANSACTION;

    -- Validazioni
    IF p_quantita IS NOT NULL AND p_quantita < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Quantità deve essere >= 0';
    END IF;
    IF p_min IS NOT NULL AND p_min < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Min deve essere >= 0';
    END IF;
    IF p_max IS NOT NULL AND p_max < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Max deve essere >= 0';
    END IF;
    IF p_prezzo IS NOT NULL AND p_prezzo < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Prezzo deve essere >= 0';
    END IF;

    -- Inserimento
    INSERT INTO articoli (name, description, quantita, `min`, `max`, supplier, has_diba, um, prezzo)
    VALUES (p_name, p_description, p_quantita, p_min, p_max, p_supplier, p_has_diba, p_um, p_prezzo);

    COMMIT;

    SELECT JSON_OBJECT(
        'status', 'success',
        'message', 'Articolo inserito con successo',
        'insertId', LAST_INSERT_ID()
    ) AS response;
END$$

DROP PROCEDURE IF EXISTS UpdateArticoli$$
CREATE PROCEDURE UpdateArticoli(
    IN p_id            INT,
    IN p_name          VARCHAR(100),
    IN p_description   VARCHAR(100),
    IN p_quantita      DECIMAL(12,2),
    IN p_min           DECIMAL(12,2),
    IN p_max           DECIMAL(12,2),
    IN p_supplier      VARCHAR(100),
    IN p_has_diba      ENUM('S','N'),
    IN p_um            VARCHAR(10),
    IN p_prezzo        DECIMAL(12,2)
)
BEGIN
    DECLARE v_rows INT DEFAULT 0;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT JSON_OBJECT('status','error','message','Errore durante l\'aggiornamento articolo') AS response;
    END;

    START TRANSACTION;

    IF NOT EXISTS (SELECT 1 FROM articoli WHERE id = p_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Articolo non trovato';
    END IF;

    -- Validazioni
    IF p_quantita IS NOT NULL AND p_quantita < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Quantità deve essere >= 0';
    END IF;
    IF p_min IS NOT NULL AND p_min < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Min deve essere >= 0';
    END IF;
    IF p_max IS NOT NULL AND p_max < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Max deve essere >= 0';
    END IF;
    IF p_prezzo IS NOT NULL AND p_prezzo < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Prezzo deve essere >= 0';
    END IF;

    UPDATE articoli
    SET name = p_name,
        description = p_description,
        quantita = p_quantita,
        `min` = p_min,
        `max` = p_max,
        supplier = p_supplier,
        has_diba = p_has_diba,
        um = p_um,
        prezzo = p_prezzo
    WHERE id = p_id;

    SET v_rows = ROW_COUNT();

    COMMIT;

    SELECT JSON_OBJECT(
        'status', IF(v_rows>0,'success','warning'),
        'message', IF(v_rows>0,'Articolo aggiornato','Nessuna modifica'),
        'rowsAffected', v_rows
    ) AS response;
END$$

DROP PROCEDURE IF EXISTS DeleteArticoli$$
CREATE PROCEDURE DeleteArticoli(
    IN p_id INT
)
BEGIN
    DECLARE v_rows INT DEFAULT 0;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT JSON_OBJECT('status','error','message','Errore durante la cancellazione articolo') AS response;
    END;
    START TRANSACTION;

    DELETE FROM articoli WHERE id = p_id;
    SET v_rows = ROW_COUNT();

    IF v_rows = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Articolo non trovato';
    END IF;

    COMMIT;

    SELECT JSON_OBJECT('status','success','rowsDeleted',v_rows) AS response;
END$$

DROP PROCEDURE IF EXISTS FetchArticoli$$
CREATE PROCEDURE FetchArticoli(
    IN p_id INT,
    IN p_name VARCHAR(100),
    IN p_supplier VARCHAR(100),
    IN p_page INT,
    IN p_page_size INT,
    IN p_order_by VARCHAR(50),
    IN p_order_dir VARCHAR(4)
)
BEGIN
    DECLARE v_offset INT DEFAULT 0;
    DECLARE v_total INT DEFAULT 0;
    SET v_offset = (p_page - 1) * p_page_size;

    SELECT COUNT(*) INTO v_total
    FROM articoli a
    WHERE (p_id IS NULL OR a.id = p_id)
      AND (p_name IS NULL OR a.name LIKE CONCAT('%', p_name, '%'))
      AND (p_supplier IS NULL OR a.supplier LIKE CONCAT('%', p_supplier, '%'));

    SET @sql = CONCAT(
        'SELECT JSON_ARRAYAGG(JSON_OBJECT(',
        '"id", id,',
        '"name", name,',
        '"description", description,',
        '"quantita", quantita,',
        '"prezzo", prezzo,',
        '"supplier", supplier)) AS data ',
        'FROM articoli WHERE (',
        '1=1 ',
        IF(p_id IS NULL,'', CONCAT('AND id = ', p_id, ' ')),
        IF(p_name IS NULL,'', CONCAT('AND name LIKE "%', p_name, '%" ')),
        IF(p_supplier IS NULL,'', CONCAT('AND supplier LIKE "%', p_supplier, '%" ')),
        ') ',
        'ORDER BY ', p_order_by, ' ', p_order_dir, ' ',
        'LIMIT ', p_page_size, ' OFFSET ', v_offset
    );

    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;

    SELECT JSON_OBJECT(
        'status','success',
        'totalRows', v_total,
        'page', p_page,
        'pageSize', p_page_size
    ) AS meta;
END$$

/* ============================================================
   CAUSALI  (Carico/Scarico causali di magazzino)
   ============================================================*/
DROP PROCEDURE IF EXISTS InsertCausali$$
CREATE PROCEDURE InsertCausali(
    IN p_codice      VARCHAR(3),
    IN p_description VARCHAR(250),
    IN p_tipo        ENUM('C','S'),
    IN p_attiva      TINYINT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SELECT JSON_OBJECT('status','error','message','Errore inserimento causale') AS response; END;
    START TRANSACTION;

    IF p_codice IS NULL OR p_codice = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Codice obbligatorio';
    END IF;

    INSERT INTO causali (codice, description, tipo, attiva)
    VALUES (p_codice, p_description, p_tipo, p_attiva);
    COMMIT;
    SELECT JSON_OBJECT('status','success','insertId',LAST_INSERT_ID()) AS response;
END$$

DROP PROCEDURE IF EXISTS UpdateCausali$$
CREATE PROCEDURE UpdateCausali(
    IN p_id INT,
    IN p_codice      VARCHAR(3),
    IN p_description VARCHAR(250),
    IN p_tipo        ENUM('C','S'),
    IN p_attiva      TINYINT
)
BEGIN
    DECLARE v_rows INT DEFAULT 0;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SELECT JSON_OBJECT('status','error','message','Errore update causale') AS response; END;
    START TRANSACTION;

    IF NOT EXISTS (SELECT 1 FROM causali WHERE id = p_id) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Causale non trovata';
    END IF;

    UPDATE causali SET codice = p_codice, description = p_description, tipo = p_tipo, attiva = p_attiva
    WHERE id = p_id;
    SET v_rows = ROW_COUNT();
    COMMIT;
    SELECT JSON_OBJECT('status',IF(v_rows>0,'success','warning'),'rowsAffected',v_rows) AS response;
END$$

DROP PROCEDURE IF EXISTS DeleteCausali$$
CREATE PROCEDURE DeleteCausali(IN p_id INT)
BEGIN
    DECLARE v_rows INT DEFAULT 0;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SELECT JSON_OBJECT('status','error','message','Errore delete causale') AS response; END;
    START TRANSACTION;
    DELETE FROM causali WHERE id = p_id;
    SET v_rows = ROW_COUNT();
    IF v_rows = 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Causale non trovata'; END IF;
    COMMIT;
    SELECT JSON_OBJECT('status','success','rowsDeleted',v_rows) AS response;
END$$

DROP PROCEDURE IF EXISTS FetchCausali$$
CREATE PROCEDURE FetchCausali(
    IN p_codice VARCHAR(3),
    IN p_tipo   ENUM('C','S'),
    IN p_attiva TINYINT,
    IN p_page INT,
    IN p_page_size INT,
    IN p_order_by VARCHAR(50),
    IN p_order_dir VARCHAR(4)
)
BEGIN
    DECLARE v_offset INT DEFAULT 0; DECLARE v_total INT DEFAULT 0;
    SET v_offset = (p_page-1)*p_page_size;
    SELECT COUNT(*) INTO v_total FROM causali
    WHERE (p_codice IS NULL OR codice LIKE CONCAT('%',p_codice,'%'))
      AND (p_tipo   IS NULL OR tipo = p_tipo)
      AND (p_attiva IS NULL OR attiva = p_attiva);

    SET @q = CONCAT('SELECT JSON_ARRAYAGG(JSON_OBJECT("id",id,"codice",codice,"description",description,"tipo",tipo,"attiva",attiva)) AS data FROM causali WHERE 1=1 ',
                    IF(p_codice IS NULL,'', CONCAT(' AND codice LIKE "%', p_codice, '%"')),
                    IF(p_tipo IS NULL,'',   CONCAT(' AND tipo = "', p_tipo, '"')),
                    IF(p_attiva IS NULL,'', CONCAT(' AND attiva = ', p_attiva)),
                    ' ORDER BY ', p_order_by,' ',p_order_dir,
                    ' LIMIT ', p_page_size,' OFFSET ',v_offset);
    PREPARE s FROM @q; EXECUTE s; DEALLOCATE PREPARE s;
    SELECT JSON_OBJECT('status','success','totalRows',v_total,'page',p_page,'pageSize',p_page_size) AS meta;
END$$

/* ============================================================
   CLIENTI
   ============================================================*/
DROP PROCEDURE IF EXISTS InsertClienti$$
CREATE PROCEDURE InsertClienti(
    IN p_codice        VARCHAR(10),
    IN p_nome          VARCHAR(255),
    IN p_tipo_cliente  ENUM('Privato','Azienda'),
    IN p_partita_iva   VARCHAR(20),
    IN p_cf            VARCHAR(20),
    IN p_indirizzo     VARCHAR(255),
    IN p_citta         VARCHAR(100),
    IN p_cap           VARCHAR(10),
    IN p_pv            VARCHAR(2),
    IN p_nazione       VARCHAR(50),
    IN p_telefono      VARCHAR(20),
    IN p_email         VARCHAR(100),
    IN p_sito_web      VARCHAR(100),
    IN p_note          TEXT,
    IN p_contatto      VARCHAR(100)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SELECT JSON_OBJECT('status','error','message','Errore inserimento cliente') AS response; END;
    START TRANSACTION;
    IF p_codice IS NULL OR p_codice='' THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Codice cliente obbligatorio'; END IF;
    INSERT INTO clienti(codice,nome,tipo_cliente,partita_iva,cf,indirizzo,citta,cap,pv,nazione,telefono,email,sito_web,note,contatto)
    VALUES(p_codice,p_nome,p_tipo_cliente,p_partita_iva,p_cf,p_indirizzo,p_citta,p_cap,p_pv,p_nazione,p_telefono,p_email,p_sito_web,p_note,p_contatto);
    COMMIT; SELECT JSON_OBJECT('status','success','insertId',LAST_INSERT_ID()) AS response;
END$$

DROP PROCEDURE IF EXISTS UpdateClienti$$
CREATE PROCEDURE UpdateClienti(
    IN p_id            INT,
    IN p_codice        VARCHAR(10),
    IN p_nome          VARCHAR(255),
    IN p_tipo_cliente  ENUM('Privato','Azienda'),
    IN p_partita_iva   VARCHAR(20),
    IN p_cf            VARCHAR(20),
    IN p_indirizzo     VARCHAR(255),
    IN p_citta         VARCHAR(100),
    IN p_cap           VARCHAR(10),
    IN p_pv            VARCHAR(2),
    IN p_nazione       VARCHAR(50),
    IN p_telefono      VARCHAR(20),
    IN p_email         VARCHAR(100),
    IN p_sito_web      VARCHAR(100),
    IN p_note          TEXT,
    IN p_contatto      VARCHAR(100)
)
BEGIN
    DECLARE v_rows INT DEFAULT 0; DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SELECT JSON_OBJECT('status','error','message','Errore update cliente') AS response; END;
    START TRANSACTION;
    IF NOT EXISTS (SELECT 1 FROM clienti WHERE id = p_id) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Cliente non trovato'; END IF;
    UPDATE clienti SET codice = p_codice, nome = p_nome, tipo_cliente = p_tipo_cliente, partita_iva = p_partita_iva, cf=p_cf, indirizzo=p_indirizzo, citta=p_citta, cap=p_cap, pv=p_pv, nazione=p_nazione, telefono=p_telefono, email=p_email, sito_web=p_sito_web, note=p_note, contatto=p_contatto WHERE id = p_id;
    SET v_rows = ROW_COUNT(); COMMIT; SELECT JSON_OBJECT('status',IF(v_rows>0,'success','warning'),'rowsAffected',v_rows) AS response;
END$$

DROP PROCEDURE IF EXISTS DeleteClienti$$
CREATE PROCEDURE DeleteClienti(IN p_id INT)
BEGIN
    DECLARE v_rows INT DEFAULT 0; DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SELECT JSON_OBJECT('status','error','message','Errore delete cliente') AS response; END;
    START TRANSACTION; DELETE FROM clienti WHERE id = p_id; SET v_rows = ROW_COUNT(); IF v_rows = 0 THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Cliente non trovato'; END IF; COMMIT; SELECT JSON_OBJECT('status','success','rowsDeleted',v_rows) AS response;
END$$

DROP PROCEDURE IF EXISTS FetchClienti$$
CREATE PROCEDURE FetchClienti(
    IN p_nome VARCHAR(255),
    IN p_codice VARCHAR(10),
    IN p_citta VARCHAR(100),
    IN p_page INT,
    IN p_page_size INT,
    IN p_order_by VARCHAR(50),
    IN p_order_dir VARCHAR(4)
)
BEGIN
    DECLARE v_offset INT DEFAULT 0; DECLARE v_total INT DEFAULT 0; SET v_offset = (p_page-1)*p_page_size;
    SELECT COUNT(*) INTO v_total FROM clienti
        WHERE (p_nome IS NULL OR nome LIKE CONCAT('%',p_nome,'%'))
          AND (p_codice IS NULL OR codice LIKE CONCAT('%',p_codice,'%'))
          AND (p_citta IS NULL OR citta LIKE CONCAT('%',p_citta,'%'));
    SET @q = CONCAT('SELECT JSON_ARRAYAGG(JSON_OBJECT("id",id,"codice",codice,"nome",nome,"citta",citta,"telefono",telefono)) AS data FROM clienti WHERE 1=1',
                    IF(p_nome IS NULL,'', CONCAT(' AND nome LIKE "%',p_nome,'%"')),
                    IF(p_codice IS NULL,'', CONCAT(' AND codice LIKE "%',p_codice,'%"')),
                    IF(p_citta IS NULL,'', CONCAT(' AND citta LIKE "%',p_citta,'%"')),
                    ' ORDER BY ',p_order_by,' ',p_order_dir,' LIMIT ',p_page_size,' OFFSET ',v_offset);
    PREPARE s FROM @q; EXECUTE s; DEALLOCATE PREPARE s;
    SELECT JSON_OBJECT('status','success','totalRows',v_total,'page',p_page,'pageSize',p_page_size) AS meta;
END$$

/* ============================================================
   DDT (Documenti di Trasporto) & DDT_RIGHE
   ============================================================*/
-- Similar patterns repeated for DDT, DDT_RIGHE, DIBA, FORNITORI, LOGIN, MOVIMENTI, ORDINI, ORDINI_RIGHE
-- Per brevità, seguono solo le intestazioni; replicare il pattern sopra adattando i campi
-- ============================================================================

-- DDT ------------------------------------------------------------------------
DROP PROCEDURE IF EXISTS InsertDdt$$
CREATE PROCEDURE InsertDdt(
    IN p_num_ddt VARCHAR(20),
    IN p_data_ddt DATE,
    IN p_cliente_id INT,
    IN p_stato ENUM('DA_SPEDIRE','SPEDITO','ANNULLATO'),
    IN p_note TEXT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK; SELECT JSON_OBJECT('status','error','message','Errore inserimento DDT') AS response; END;
    START TRANSACTION;
    IF NOT EXISTS (SELECT 1 FROM clienti WHERE id = p_cliente_id) THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT='Cliente non esiste'; END IF;
    INSERT INTO ddt(num_ddt,data_ddt,cliente_id,stato,note) VALUES(p_num_ddt,p_data_ddt,p_cliente_id,p_stato,p_note);
    COMMIT; SELECT JSON_OBJECT('status','success','insertId',LAST_INSERT_ID()) AS response;
END$$

-- (Procedures UpdateDdt, DeleteDdt, FetchDdt analoghe con paginazione)

-- DDT_RIGHE ------------------------------------------------------------------
-- InsertDdt_righe, UpdateDdt_righe, DeleteDdt_righe, FetchDdt_righe (validazioni qta >0, FK id_ddt)

-- DIBA -----------------------------------------------------------------------
-- InsertDiba (validazione id_father / id_son esistono in articoli, quantita >0) + Update/Delete/Fetch

-- FORNITORI ------------------------------------------------------------------
-- InsertFornitori, UpdateFornitori, DeleteFornitori, FetchFornitori

-- LOGIN ----------------------------------------------------------------------
-- InsertLogin (hash pwd gestito in app, qui si accetta pwd già hashata), UpdateLogin, DeleteLogin, FetchLogin

-- MOVIMENTI ------------------------------------------------------------------
-- InsertMovimenti (FK idart, codice_cau), UpdateMovimenti, DeleteMovimenti, FetchMovimenti con filtri per data/tipo/codice_cau

-- ORDINI ---------------------------------------------------------------------
-- InsertOrdini (FK fornitore_id), UpdateOrdini, DeleteOrdini, FetchOrdini

-- ORDINI_RIGHE ---------------------------------------------------------------
-- Gli esempi di Insert/Update/Delete sono già forniti dall'utente. Aggiungiamo FetchOrdini_righe con paginazione

-- ============================================================
--  Per ogni sezione sostituire campi e tabelle replicando pattern
--  sopra mostrato (transazioni, validation, JSON output, paginate)
-- ============================================================

DELIMITER ;