//======================================
//File: crudHandlers.js
//Script per la creazione di un controller
//per le operazioni CRUD.
//@author: "villari.andrea@libero.it"  
//@version: "1.0.0 2025-06-17"
//=======================================
const db = require('../db/db');

function createCrudHandlers(tableName, { fieldsToSelect = '*', validateInput } = {}) {
  return {
    /**
     * Get all records from the table.
     */
    getAll: async (req, res, next) => {
      try {
        const [rows] = await db.query(`SELECT ${fieldsToSelect} FROM ${tableName}`);
        res.json({ success: true, data: rows });
      } catch (error) {
        console.error(`Error fetching all from ${tableName}:`, error);
        next(error);
      }
    },

    /**
     * Get a single record by ID.
     */
    getById: async (req, res, next) => {
      const { id } = req.params;
      try {
        const [rows] = await db.query(`SELECT ${fieldsToSelect} FROM ${tableName} WHERE id = ?`, [id]);
        if (rows.length === 0) {
          return res.status(404).json({ success: false, error: `${tableName.slice(0, -1)} not found.` });
        }
        res.json({ success: true, data: rows[0] });
      } catch (error) {
        console.error(`Error fetching ${tableName} by ID ${id}:`, error);
        next(error);
      }
    },

    /**
     * Create a new record.
     * Assumes req.body contains the data.
     * `validateInput` is an optional function to validate req.body.
     */
    create: async (req, res, next) => {
      if (validateInput) {
        const validationError = validateInput(req.body, 'create');
        if (validationError) {
          return res.status(400).json({ success: false, error: validationError });
        }
      }

      // Create a copy of req.body to modify
      const dataToInsert = { ...req.body };

      // Remove 'id' field if present, as it's auto-incremented by the database
      // This prevents errors like trying to insert an empty string for an INT AUTO_INCREMENT field.
      delete dataToInsert.id;

      const columns = Object.keys(dataToInsert);
      const values = Object.values(dataToInsert);
      const placeholders = columns.map(() => '?').join(', ');

      if (columns.length === 0) {
        return res.status(400).json({ success: false, error: "No data provided for creation." });
      }

      try {
        const [result] = await db.query(
          `INSERT INTO ${tableName} (${columns.join(', ')}) VALUES (${placeholders})`,
          values
        );
        res.status(201).json({ success: true, id: result.insertId, message: `${tableName.slice(0, -1)} created successfully.` });
      } catch (error) {
        console.error(`Error creating ${tableName}:`, error);
        next(error);
      }
    },

    /**
     * Update an existing record by ID.
     * Assumes req.body contains the data to update.
     * `validateInput` is an optional function to validate req.body.
     */
    update: async (req, res, next) => {
      const { id } = req.params;
      if (validateInput) {
        const validationError = validateInput(req.body, 'update');
        if (validationError) {
          return res.status(400).json({ success: false, error: validationError });
        }
      }

      const fieldsToUpdate = Object.keys(req.body);
      const values = Object.values(req.body);

      if (fieldsToUpdate.length === 0) {
        return res.status(400).json({ success: false, error: "No data provided for update." });
      }

      const setClause = fieldsToUpdate.map(field => `${field} = ?`).join(', ');

      try {
        const [result] = await db.query(
          `UPDATE ${tableName} SET ${setClause} WHERE id = ?`,
          [...values, id]
        );
        if (result.affectedRows === 0) {
          return res.status(404).json({ success: false, error: `${tableName.slice(0, -1)} not found for update.` });
        }
        res.json({ success: true, message: `${tableName.slice(0, -1)} updated successfully.` });
      } catch (error) {
        console.error(`Error updating ${tableName} with ID ${id}:`, error);
        next(error);
      }
    },

    /**
     * Delete a record by ID.
     */
    delete: async (req, res, next) => {
      const { id } = req.params;
      try {
        const [result] = await db.query(`DELETE FROM ${tableName} WHERE id = ?`, [id]);
        if (result.affectedRows === 0) {
          return res.status(404).json({ success: false, error: `${tableName.slice(0, -1)} not found for deletion.` });
        }
        res.json({ success: true, message: `${tableName.slice(0, -1)} deleted successfully.` });
      } catch (error) {
        console.error(`Error deleting ${tableName} with ID ${id}:`, error);
        next(error);
      }
    },
  };
}

module.exports = { createCrudHandlers };
