//=======================================
// File: DocumentHeaderForm.jsx
// Componente che gestisce il form per la gestione degli ordini
// @author: "villari.andrea@libero.it"
// @version: "1.0.0 2025-07-15"
//=======================================

import React, { useMemo, useEffect } from 'react';
import { useForm, Controller } from 'react-hook-form';
import { ajvResolver } from '@hookform/resolvers/ajv';
import Ajv from 'ajv';
import addFormats from 'ajv-formats';
import debounce from 'lodash/debounce';

/* --------------------------------------------------
   buildFieldConfig: converte JSON-Schema (+ uiHints)
   in metadati per rendere i campi
-------------------------------------------------- */
const buildFieldConfig = (schema, uiHints = {}) =>
  Object.entries(schema.properties)
    .map(([name, prop]) => {
      const hint = uiHints[name] || {};
      const type =
        hint.type ||
        (prop.enum            ? 'select'  :
         prop.format === 'date'           ? 'date' :
         ['integer', 'number'].includes(prop.type) ? 'number' :
         prop.type === 'boolean'          ? 'checkbox' :
         'text');

      return {
        name,
        label: hint.label || prop.title || name,
        order: hint.order || 0,
        type,
        enum: prop.enum,
        ...hint, // fetchOptions, optionLabel, ecc.
      };
    })
    .sort((a, b) => a.order - b.order);

export default function DocumentHeaderForm({
  schema,             // JSON-Schema
  uiHints = {},       // override UI
  initialData = {},   // dati iniziali
  onChange,           // callback (debounced)
  readOnly = false,
}) {
  /* ---------- AJV ---------- */
  const ajv = useMemo(() => {
    const a = new Ajv({ allErrors: true, coerceTypes: true });
    addFormats(a);
    return a;
  }, []);

  /* ---------- RHF ---------- */
  const {
    control,
    watch,
    formState: { errors },
  } = useForm({
    resolver: ajvResolver(schema, undefined, undefined, { ajv }),
    defaultValues: { ...initialData },
  });

  /* ---------- Change propagation ---------- */
  const watched = watch();
  useEffect(() => {
    const fn = debounce((v) => onChange?.(v), 300);
    fn(watched);
    return () => fn.cancel();
  }, [watched, onChange]);

  const HIDDEN_FIELDS = ['data_creazione', 'data_modifica', 'operation'];
  const fields = useMemo(
    () => buildFieldConfig(schema, uiHints),
    [schema, uiHints]
  );
  const visibleFields = fields.filter(f => !HIDDEN_FIELDS.includes(f.name));
  console.log('FIELDS:', visibleFields.map(f => f.name));

  const requiredFields = schema.required || [];

  /* ---------- Render helpers ---------- */
  const renderSelect = (f, field) => {
    const [options, setOptions] = React.useState(f.enum || []);
    useEffect(() => {
      if (!f.fetchOptions) return;
      (async () => setOptions(await f.fetchOptions()))();
    }, []);
    return (
      <select {...field} disabled={readOnly}>
        <option value="">--</option>
        {options.map((o) =>
          typeof o === 'string' ? (
            <option key={o} value={o}>
              {o}
            </option>
          ) : (
            <option key={o.id} value={o.id}>
              {o[f.optionLabel || 'name']}
            </option>
          )
        )}
      </select>
    );
  };

  const renderInput = (f, field) => {
    const common = { ...field, disabled: readOnly, readOnly };
    switch (f.type) {
      case 'textarea':
        return <textarea {...common} />;
      case 'date':
        return <input type="date" {...common} />;
      case 'number':
        return <input type="number" {...common} />;
      case 'checkbox':
        return <input type="checkbox" {...common} checked={field.value} />;
      default:
        return <input type="text" {...common} />;
    }
  };

  const renderField = (f) => (
    <div key={f.name} className="field">
      <label>
        {f.label}
        {requiredFields.includes(f.name) && <span style={{ color: 'red', marginLeft: 4 }}>*</span>}
      </label>
      <Controller
        name={f.name}
        control={control}
        render={({ field }) => {
          const isRequired = requiredFields.includes(f.name);
          const common = {
            ...field,
            disabled: readOnly,
            readOnly,
            className: isRequired ? 'required-field' : undefined,
          };
          if (f.type === 'select') return renderSelect(f, { ...field, className: isRequired ? 'required-field' : undefined });
          return renderInput(f, common);
        }}
      />
      {errors[f.name] && <p className="error">{errors[f.name]?.message}</p>}
    </div>
  );

  return (
    <form className="doc-header" noValidate>
      <h3>{uiHints?.title || schema.title || 'Dettaglio Documento'}</h3>
      <div className="fields-grid">{visibleFields.map(renderField)}</div>
    </form>
  );
} 