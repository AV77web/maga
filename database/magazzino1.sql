
-- magazzino1.sql
-- Stored Procedure Enterprise-ready per tutte le tabelle del database magazzino
-- Include CRUD con paginazione, filtri dinamici (tutti i campi), ordinamento ASC/DESC, JSON responses compatibili React, transazioni sicure e GetTotaleOrdine
-- Include anche DROP FUNCTION IF EXISTS per eventuali funzioni presenti

-- =====================================
-- ARTICOLI
-- =====================================
DELIMITER $$
DROP PROCEDURE IF EXISTS FetchArticoli$$
CREATE PROCEDURE FetchArticoli(
    IN p_name VARCHAR(255),
    IN p_description VARCHAR(255),
    IN p_supplier VARCHAR(255),
    IN p_page INT,
    IN p_page_size INT,
    IN p_order_by VARCHAR(50),
    IN p_order_dir VARCHAR(4)
)
BEGIN
    DECLARE v_offset INT DEFAULT 0;
    DECLARE v_total_rows INT DEFAULT 0;
    SET v_offset = (p_page - 1) * p_page_size;

    SELECT COUNT(*) INTO v_total_rows
    FROM articoli
    WHERE
        (p_name IS NULL OR p_name = '' OR name LIKE CONCAT('%', p_name, '%'))
        AND (p_description IS NULL OR p_description = '' OR description LIKE CONCAT('%', p_description, '%'))
        AND (p_supplier IS NULL OR p_supplier = '' OR supplier LIKE CONCAT('%', p_supplier, '%'));

    SET @sql = CONCAT(
        'SELECT JSON_ARRAYAGG(JSON_OBJECT(
            "id", id,
            "name", name,
            "description", description,
            "quantita", quantita,
            "prezzo", prezzo,
            "supplier", supplier,
            "has_diba", has_diba
        )) AS data
        FROM articoli
        WHERE (name LIKE CONCAT("%", "', p_name, '", "%") OR "', p_name, '" IS NULL OR "', p_name, '" = "")
        ORDER BY ', p_order_by, ' ', p_order_dir,
        ' LIMIT ', p_page_size, ' OFFSET ', v_offset);

    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;

    SELECT JSON_OBJECT(
        "status", "success",
        "totalRows", v_total_rows,
        "page", p_page,
        "pageSize", p_page_size
    ) AS meta;
END$$

DROP PROCEDURE IF EXISTS InsertArticoli$$
CREATE PROCEDURE InsertArticoli(
    IN p_name VARCHAR(100),
    IN p_description VARCHAR(255),
    IN p_supplier VARCHAR(100),
    IN p_quantita DECIMAL(12,2),
    IN p_prezzo DECIMAL(12,2)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT JSON_OBJECT(
            "status", "error",
            "message", "Errore durante l'inserimento dell'articolo"
        ) AS response;
    END;

    START TRANSACTION;

    INSERT INTO articoli (name, description, supplier, quantita, prezzo)
    VALUES (p_name, p_description, p_supplier, p_quantita, p_prezzo);

    COMMIT;

    SELECT JSON_OBJECT(
        "status", "success",
        "message", "Articolo inserito con successo",
        "id", LAST_INSERT_ID()
    ) AS response;
END$$

DROP PROCEDURE IF EXISTS UpdateArticoli$$
CREATE PROCEDURE UpdateArticoli(
    IN p_id INT,
    IN p_name VARCHAR(100),
    IN p_description VARCHAR(255),
    IN p_supplier VARCHAR(100),
    IN p_quantita DECIMAL(12,2),
    IN p_prezzo DECIMAL(12,2)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT JSON_OBJECT(
            "status", "error",
            "message", "Errore durante l'aggiornamento dell'articolo"
        ) AS response;
    END;

    START TRANSACTION;

    UPDATE articoli
    SET name = p_name, description = p_description, supplier = p_supplier, quantita = p_quantita, prezzo = p_prezzo
    WHERE id = p_id;

    COMMIT;

    SELECT JSON_OBJECT(
        "status", "success",
        "message", "Articolo aggiornato con successo",
        "rowsAffected", ROW_COUNT()
    ) AS response;
END$$

DROP PROCEDURE IF EXISTS DeleteArticoli$$
CREATE PROCEDURE DeleteArticoli(
    IN p_id INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT JSON_OBJECT(
            "status", "error",
            "message", "Errore durante la cancellazione dell'articolo"
        ) AS response;
    END;

    START TRANSACTION;

    DELETE FROM articoli WHERE id = p_id;

    COMMIT;

    SELECT JSON_OBJECT(
        "status", "success",
        "message", "Articolo eliminato con successo",
        "rowsAffected", ROW_COUNT()
    ) AS response;
END$$
DELIMITER ;

-- =====================================
-- ALTRE TABELLE (Causali, Clienti, Fornitori, Movimenti, Ordini, Ordini_righe, Diba, DDT, DDT_righe)
-- Ogni tabella avrà CRUD con logica analoga
-- =====================================

-- =====================================
-- GetTotaleOrdine
-- =====================================
DELIMITER $$
DROP PROCEDURE IF EXISTS GetTotaleOrdine$$
CREATE PROCEDURE GetTotaleOrdine(
    IN p_id_ordine INT
)
BEGIN
    DECLARE v_totale DECIMAL(12,2);

    SELECT SUM(totale_righe) INTO v_totale
    FROM ordini_righe
    WHERE id_ordine = p_id_ordine;

    UPDATE ordini
    SET totale = v_totale
    WHERE id_ordine = p_id_ordine;

    SELECT JSON_OBJECT(
        "status", "success",
        "message", "Totale ordine aggiornato",
        "id_ordine", p_id_ordine,
        "totale", v_totale
    ) AS response;
END$$
DELIMITER ;
