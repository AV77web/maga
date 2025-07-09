//============================================================
//File: HeadDocument.jsx
//Componente che gestisce la testa dei documenti (DDT o ORDINI)
//@author: "villari.andrea@libero.it"
//@version: "2.0.0 2025-07-05"
//============================================================

import React, { useEffect, useState } from "react";
import { useForm, Controller } from "react-hook-form";
import { yupResolver } from "@hookform/resolvers/yup";
import * as Yup from "yup";

const HeadDocument = ({
  config,
  initialData = {},
  onChange,
  readOnly = false,
}) => {
  const [fkOptions, setFkOptions] = useState({});

  // Crea lo schema Yup dinamico in base ai campi
  const validationSchema = Yup.object().shape(
    config.fields.reduce((acc, f) => {
      if (f.required) {
        acc[f.name] = Yup.string().required(`${f.label} è obbligatorio`);
      } else {
        acc[f.name] = Yup.string();
      }
      return acc;
    }, {})
  );

  const {
    control,
    handleSubmit,
    watch,
    formState: { errors },
  } = useForm({
    defaultValues: config.fields.reduce(
      (acc, f) => ({ ...acc, [f.name]: initialData[f.name] || "" }),
      {}
    ),
    resolver: yupResolver(validationSchema),
  });

  // Guarda i valori del form e notifica il parent
  const watchedValues = watch();
  useEffect(() => {
    onChange?.(watchedValues);
  }, [watchedValues, onChange]);

  // Carica opzioni foreign key per i campi select
  useEffect(() => {
    let isMounted = true;

    const fetchOptions = async () => {
      const selectFields = config.fields.filter(
        (f) => f.type === "select" && f.api
      );
      const results = await Promise.all(
        selectFields.map(async (f) => {
          try {
            let apiResponse;
            if (typeof f.api === 'string') {
              const res = await fetch(f.api);
              if (!res.ok) {
                throw new Error(`API request failed with status ${res.status}`);
              }
              apiResponse = await res.json();
            } else if (typeof f.api === 'function') {
              apiResponse = await f.api();
            } else {
              apiResponse = { data: [] };
            }
            // Rilevamento robusto dell'array di opzioni
            let optionsData;
            if (Array.isArray(apiResponse)) {
              // Caso 1: L'API restituisce direttamente l'array, es: fetchAll restituisce response.data.data
              optionsData = apiResponse;
            } else if (apiResponse && Array.isArray(apiResponse.data)) {
              // Caso 2: L'API restituisce un oggetto come { data: [...] }
              optionsData = apiResponse.data;
            } else {
              console.warn(`Dati per il campo select "${f.name}" non sono in un formato array atteso. Ricevuto:`, apiResponse);
              optionsData = [];
            }
            return { name: f.name, data: optionsData };
          } catch (err) {
            console.error(`Errore caricamento dati per ${f.name}:`, err);
            return { name: f.name, data: [] };
          }
        })
      );

      if (isMounted) {
        const optionsMap = results.reduce(
          (acc, { name, data }) => ({ ...acc, [name]: data }),
          {}
        );
        setFkOptions(optionsMap);
      }
    };

    fetchOptions();
    return () => {
      isMounted = false;
    };
  }, [config.fields]);

  const renderField = (f) => (
    <div key={f.name} className="field">
      <label>{f.label}</label>
      <Controller
        name={f.name}
        control={control}
        render={({ field }) => {
          const commonProps = {
            ...field,
            placeholder: f.placeholder,
            readOnly,
            disabled: readOnly,
          };

          if (f.type === "text" || f.type === "date") {
            return <input type={f.type} {...commonProps} />;
          }

          if (f.type === "textarea") {
            return <textarea {...commonProps} />;
          }

          if (f.type === "select") {
            const options = f.options || fkOptions[f.name] || [];
            return (
              <select {...commonProps}>
                <option value="">-- Seleziona {f.label} --</option>
                {options.map((opt) =>
                  typeof opt === "string" ? (
                    <option key={opt} value={opt}>
                      {opt}
                    </option>
                  ) : (
                    <option key={opt.id} value={opt.id}>
                      {opt[f.optionLabel || 'nome']}
                    </option>
                  )
                )}
              </select>
            );
          }

          return null;
        }}
      />
      {errors[f.name] && <p className="error">{errors[f.name]?.message}</p>}
    </div>
  );

  return (
    <form
      className="doc-header"
      onSubmit={handleSubmit((data) => console.log("Submit:", data))}
    >
      <h3>{config.titolo}</h3>
      {config.fields.map(renderField)}
    </form>
  );
};

export default HeadDocument;
