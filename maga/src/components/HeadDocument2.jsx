//============================================================
//File: HeadDocument.jsx
//Componente che gestisce la testa dei documenti (DDT o ORDINI)
//@author: "villari.andrea@libero.it"
//@version: "2.1.1 2025-07-09"
//============================================================

import React, { useEffect, useState } from "react";
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

  const validationSchema = Yup.object().shape(
    config.fields.reduce((acc, f) => {
      acc[f.name] = f.required
        ? Yup.string().required(`${f.label} è obbligatorio`)
        : Yup.string();
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
  useEffect(() => {
    onChange?.(watchedValues);
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
      onSubmit={handleSubmit((data) => console.log("Submit:", data))}
      noValidate
    >
      <h3 className="doc-title">{config.titolo}</h3>
      <div className="fields-grid">{config.fields.map(renderField)}</div>
    </form>
  );
};

export default HeadDocument;
