//============================================================
//File: HeadDocument.jsx
//Componente che gestisce al testa dei documenti(DDT o ORDINI)
//@author: "villari.andrea@libero.it"
//@version: "1.0.0 2025-07-04"
//============================================================

import {
  React,
  useState,
  useEffect,
  useRef,
  useMemo,
  useCallback,
} from "react";
import TableGrid from "./TableGrid";
import DialogCustom from "./DialogCustom";
import FilterSearch from "./FilterSearch";
import Pagination from "./Pagination1";
import Header from "./Header";

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

  useEffect(() => {
    config.fields
      .filter((f) => f.type === "select" && f.api)
      .forEach(async (f) => {
        try {
          const res = await fetch(f.api);
          const result = await res.json();
          setFkOptions((prev) => ({ ...prev, [f.name]: result }));
        } catch (e) {
          console.error("Errore caricamento dati per", f.name, e);
        }
      });
  }, [config.fields]);

  useEffect(() => {
    onChange && onChange(data);
  }, [data, onChange]);

  const handleChange = (e) =>
    setData({ ...data, [e.target.name]: e.target.value });

  return (
    <div className="doc-header">
      <h3>{config.titolo}</h3>
      {config.fields.map((f) => (
        <div key={f.name} className="field">
          <label>{f.label}</label>
          {f.type === "text" || f.type === "date" ? (
            <input
              type={f.type}
              name={f.name}
              value={data[f.name]}
              onChange={handleChange}
              placeholder={f.placeholder}
              required={f.required}
              readOnly={readOnly}
            />
          ) : f.type === "textarea" ? (
            <textarea
              name={f.name}
              value={data[f.name]}
              onChange={handleChange}
              placeholder={f.placeholder}
              required={f.required}
              readOnly={readOnly}
            />
          ) : f.type === "select" ? (
            <select
              name={f.name}
              value={data[f.name]}
              onChange={handleChange}
              disabled={readOnly}
              required={f.required}
            >
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
          ) : null}
        </div>
      ))}
    </div>
  );
};

export default HeadDocument;
