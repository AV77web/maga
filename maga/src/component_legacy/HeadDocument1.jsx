//============================================================
//File: HeadDocument.jsx
//Componente che gestisce la testa dei documenti (DDT o ORDINI)
//@author: "villari.andrea@libero.it"
//@version: "1.1.0 2025-07-05"
//============================================================

import React, { useState, useEffect, useCallback } from "react";

const HeadDocument = ({
  config,
  initialData = {},
  onChange,
  readOnly = false,
}) => {
  const [data, setData] = useState(() =>
    config.fields.reduce(
      (acc, f) => ({ ...acc, [f.name]: initialData[f.name] || "" }),
      {}
    )
  );
  const [fkOptions, setFkOptions] = useState({});

  // Carica opzioni foreign key
  useEffect(() => {
    let isMounted = true;

    const fetchOptions = async () => {
      try {
        const selectFields = config.fields.filter(
          (f) => f.type === "select" && f.api
        );

        const results = await Promise.all(
          selectFields.map((f) =>
            fetch(f.api)
              .then((res) => res.json())
              .then((data) => ({ name: f.name, data }))
              .catch((err) => {
                console.error(`Errore caricamento dati per ${f.name}:`, err);
                return { name: f.name, data: [] };
              })
          )
        );

        if (isMounted) {
          const optionsMap = results.reduce(
            (acc, { name, data }) => ({ ...acc, [name]: data }),
            {}
          );
          setFkOptions(optionsMap);
        }
      } catch (err) {
        console.error("Errore generale caricamento opzioni FK:", err);
      }
    };

    fetchOptions();

    return () => {
      isMounted = false; // Cleanup per evitare memory leak
    };
  }, [config.fields]);

  // Propaga cambiamenti al parent
  useEffect(() => {
    onChange?.(data);
  }, [data, onChange]);

  const handleChange = useCallback((e) => {
    const { name, value } = e.target;
    setData((prev) => ({ ...prev, [name]: value }));
  }, []);

  const renderField = (f) => {
    const commonProps = {
      name: f.name,
      value: data[f.name],
      onChange: handleChange,
      placeholder: f.placeholder,
      required: f.required,
      readOnly,
    };

    switch (f.type) {
      case "text":
      case "date":
        return <input type={f.type} {...commonProps} />;
      case "textarea":
        return <textarea {...commonProps} />;
      case "select":
        return (
          <select {...commonProps} disabled={readOnly}>
            <option value="">-- Seleziona {f.label} --</option>
            {(f.options || fkOptions[f.name] || []).map((opt) =>
              typeof opt === "string" ? (
                <option key={opt} value={opt}>
                  {opt}
                </option>
              ) : (
                <option key={opt.id} value={opt.id}>
                  {opt.nome}
                </option>
              )
            )}
          </select>
        );
      default:
        return null;
    }
  };

  return (
    <div className="doc-header">
      <h3>{config.titolo}</h3>
      {config.fields.map((f) => (
        <div key={f.name} className="field">
          <label>{f.label}</label>
          {renderField(f)}
        </div>
      ))}
    </div>
  );
};

export default HeadDocument;
