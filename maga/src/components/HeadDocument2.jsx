//============================================================
//File: HeadDocument.jsx
//Componente che gestisce la testa dei documenti (DDT o ORDINI)
//@author: "villari.andrea@libero.it"
//@version: "2.3.0 2025-07-10"
//============================================================

import React, { useEffect, useState, useMemo } from "react";
import debounce from "lodash/debounce";
import { useForm, Controller } from "react-hook-form";
import { yupResolver } from "@hookform/resolvers/yup";
import * as Yup from "yup";
import "../css/Ordini.css";

const HeadDocument = ({
  config,
  initialData = {},
  onChange,
  readOnly = false,
}) => {
  const [fkOptions, setFkOptions] = useState({});

  // 🔥 Regex comuni
  const regex = {
    codiceFiscale: /^[A-Z]{6}[0-9]{2}[A-Z][0-9]{2}[A-Z][0-9]{3}[A-Z]$/i,
    cap: /^\d{5}$/,
  };

  // 🔥 Yup schema dinamico
  const validationSchema = Yup.object().shape(
    config.fields.reduce((acc, f) => {
      let validator = Yup.string()
        .transform((value) => {
          // Sanifica: trim e vuoti a null
          const trimmed = value?.trim();
          return trimmed === "" ? null : trimmed;
        });

      if (f.required) {
        validator = validator.required(`${f.label} è obbligatorio`);
      }

      if (f.maxLength) {
        validator = validator.max(
          f.maxLength,
          `${f.label} deve essere al massimo di ${f.maxLength} caratteri`
        );
      }

      // 🔥 Pattern specifici
      if (f.pattern === "codiceFiscale") {
        validator = validator.matches(
          regex.codiceFiscale,
          "Codice Fiscale non valido (es. RSSMRA85M01H501Z)"
        );
      }
      if (f.pattern === "cap") {
        validator = validator.matches(regex.cap, "CAP non valido (es. 35100)");
      }

      if (f.type === "email") {
        validator = Yup.string()
          .email("Inserisci un'email valida")
          .max(f.maxLength || 254, `${f.label} troppo lungo`);
      }

      if (f.type === "number") {
        validator = Yup.number()
          .typeError(`${f.label} deve essere un numero`)
          .transform((value, originalValue) =>
            String(originalValue).trim() === "" ? null : value
          );
      }

      acc[f.name] = validator;
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

  const watchedValues = watch();

  // ✅ Debounce per onChange
  const handleChangeDebounced = useMemo(
    () => debounce((values) => onChange?.(values), 300),
    [onChange]
  );

  useEffect(() => {
    handleChangeDebounced(watchedValues);
    return () => handleChangeDebounced.cancel();
  }, [watchedValues, onChange]);

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
            if (typeof f.api === "string") {
              const res = await fetch(f.api);
              if (!res.ok) throw new Error(`API status ${res.status}`);
              apiResponse = await res.json();
            } else if (typeof f.api === "function") {
              apiResponse = await f.api();
            } else {
              apiResponse = { data: [] };
            }

            const optionsData = Array.isArray(apiResponse)
              ? apiResponse
              : apiResponse.data || [];

            return { name: f.name, data: optionsData };
          } catch (err) {
            console.error(`Errore caricamento ${f.name}:`, err);
            return { name: f.name, data: [] };
          }
        })
      );

      if (isMounted) {
        setFkOptions(
          results.reduce((acc, { name, data }) => ({ ...acc, [name]: data }), {})
        );
      }
    };

    fetchOptions();
    return () => {
      isMounted = false;
    };
  }, [JSON.stringify(config.fields)]); // 🔥 evita ricreazioni inutili

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
            maxLength: f.maxLength || undefined,
          };

          if (f.type === "text" || f.type === "date" || f.type === "email") {
            return <input type={f.type} {...commonProps} />;
          }

          if (f.type === "number") {
            return (
              <input
                type="number"
                {...commonProps}
                onInput={(e) => {
                  if (f.maxLength && e.target.value.length > f.maxLength) {
                    e.target.value = e.target.value.slice(0, f.maxLength);
                  }
                  field.onChange(e);
                }}
              />
            );
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
                      {opt[f.optionLabel || "nome"]}
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
      onSubmit={handleSubmit((data) =>
        console.log("Submit HeadDocument:", data)
      )}
      noValidate
    >
      <h3 className="doc-title">{config.titolo}</h3>
      <div className="fields-grid">{config.fields.map(renderField)}</div>
    </form>
  );
};

export default HeadDocument;
