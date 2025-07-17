import React, { useState, useEffect } from 'react';
import PropTypes from 'prop-types';
import orderLineSchema from '#schemas/orderline.schema.json';
import '../css/DialogCustom.css'; // Riusiamo uno stile esistente per coerenza

const OrdineRigaDialog = ({ open, riga, onSave, onClose }) => {
  const [formData, setFormData] = useState({});
  const [errors, setErrors] = useState({});

  useEffect(() => {
    // Quando la prop 'riga' cambia (o al primo render), inizializziamo il form.
    if (riga) {
      setFormData(riga);
    } else {
      // Se 'riga' è null, siamo in modalità creazione. Inizializziamo con i default.
      const defaults = Object.keys(orderLineSchema.properties).reduce((acc, key) => {
        acc[key] = orderLineSchema.properties[key].default !== undefined 
          ? orderLineSchema.properties[key].default 
          : '';
        return acc;
      }, {});
      setFormData(defaults);
    }
  }, [riga, open]);

  if (!open) {
    return null;
  }

  const handleChange = (e) => {
    const { name, value, type, checked } = e.target;
    setFormData(prev => ({
      ...prev,
      [name]: type === 'checkbox' ? checked : value
    }));
  };

  const handleSave = () => {
    // Qui andrà la logica di validazione basata sullo schema
    onSave(formData);
  };
  
  const renderField = (key) => {
    const property = orderLineSchema.properties[key];
    if (!property) return null;

    const { title, type, format } = property;
    let inputType = 'text';
    if (type === 'number') inputType = 'number';
    if (type === 'boolean') inputType = 'checkbox';
    if (format === 'date-time' || format === 'date') inputType = 'date';
    
    return (
      <div className="form-group" key={key}>
        <label htmlFor={key}>{title || key}</label>
        <input
          type={inputType}
          id={key}
          name={key}
          value={formData[key] || ''}
          onChange={handleChange}
          className="form-control"
        />
        {errors[key] && <span className="error-message">{errors[key]}</span>}
      </div>
    );
  };

  return (
    <div className="dialog-overlay">
      <div className="dialog-content">
        <h2>{riga && riga.id ? 'Modifica Riga Ordine' : 'Nuova Riga Ordine'}</h2>
        <form>
          {Object.keys(orderLineSchema.properties).filter(key => key !== 'id' && key !== 'id_ordine').map(renderField)}
        </form>
        <div className="dialog-actions">
          <button onClick={handleSave} className="btn btn-primary">Salva</button>
          <button onClick={onClose} className="btn btn-secondary">Annulla</button>
        </div>
      </div>
    </div>
  );
};

OrdineRigaDialog.propTypes = {
  open: PropTypes.bool.isRequired,
  riga: PropTypes.object, // Riga da modificare, null per nuova riga
  onSave: PropTypes.func.isRequired,
  onClose: PropTypes.func.isRequired,
};

export default OrdineRigaDialog; 