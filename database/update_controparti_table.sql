-- =============================================================
-- Script per aggiornare la tabella controparti
-- per supportare lo schema JSON counterparty.schema.json
-- =============================================================

-- Backup della tabella esistente (opzionale)
-- CREATE TABLE controparti_backup AS SELECT * FROM controparti;

-- Aggiungi nuove colonne
ALTER TABLE controparti 
ADD COLUMN codice VARCHAR(10) AFTER id,
ADD COLUMN ruolo ENUM('cliente','fornitore','entrambi') DEFAULT 'cliente' AFTER note;

-- Rinomina colonne esistenti
ALTER TABLE controparti 
CHANGE COLUMN nome rag_soc VARCHAR(255),
CHANGE COLUMN codice_fiscale cf VARCHAR(20),
CHANGE COLUMN provincia pv VARCHAR(2);

-- Aggiorna i valori ENUM per il campo tipo
ALTER TABLE controparti 
MODIFY COLUMN tipo ENUM('Privato','Azienda') DEFAULT 'Privato';

-- Aggiorna i valori esistenti (se necessario)
UPDATE controparti SET tipo = 'Azienda' WHERE tipo = 'FORNITORE';
UPDATE controparti SET tipo = 'Privato' WHERE tipo = 'CLIENTE';

-- Imposta valori di default per i nuovi campi
UPDATE controparti SET 
  codice = CONCAT('C', LPAD(id, 5, '0')) WHERE codice IS NULL OR codice = '';

-- Aggiungi indici per migliorare le performance
ALTER TABLE controparti 
ADD INDEX idx_codice (codice),
ADD INDEX idx_rag_soc (rag_soc),
ADD INDEX idx_tipo (tipo),
ADD INDEX idx_ruolo (ruolo);

-- Verifica la struttura finale
DESCRIBE controparti; 