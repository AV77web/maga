import React, { useEffect, useRef } from "react";
import "../css/ArticoliTable.css"; // Usiamo lo stesso CSS per coerenza

const DibaPopover = ({ anchorEl, open, onClose, data, loading }) => {
  const { article, components } = data || {}; // Estrai article e components da data

  const popoverRef = useRef(null);

  useEffect(() => {
    const handleOutsideClick = (event) => {
      // Chiude se il click è fuori dal popover E fuori dall'elemento che lo ha aperto
      if (
        popoverRef.current &&
        !popoverRef.current.contains(event.target) &&
        !anchorEl.contains(event.target)
      ) {
        onClose();
      }
    };

    if (open) {
      document.addEventListener("mousedown", handleOutsideClick);
    }

    return () => {
      document.removeEventListener("mousedown", handleOutsideClick);
    };
  }, [open, onClose, anchorEl]);

  if (!open || !anchorEl) {
    return null;
  }

  const rect = anchorEl.getBoundingClientRect();
  const style = {
    top: `${rect.bottom + window.scrollY + 5}px`, // +5 per un piccolo spazio
    left: `${rect.left + window.scrollX}px`,
  };

  return (
    <div className="diba-popover" style={style} ref={popoverRef}>
      <div className="diba-popover-header">
        <h3>
          Componenti DiBa per articolo: <br />
          ID {article ? `${article.id} - ${article.name}` : ""}
        </h3>
        <button onClick={onClose} className="diba-popover-close">
          &times;
        </button>
      </div>
      <div className="diba-popover-content">
        {loading ? (
          <p>Caricamento...</p>
        ) : components && components.length > 0 ? (
          <table>
            <thead>
              <tr>
                <th>Codice</th>
                <th>Nome</th>
                <th>Descrizione</th>
                <th>Q.tà</th>
              </tr>
            </thead>
            <tbody>
              {components.map((item) => (
                <tr key={item.id}>
                  <td>{item.id_son}</td>
                  <td>{item.son_name}</td>
                  <td title={item.son_description}>{item.son_description}</td>
                  <td className="text-right">{item.quantita}</td>
                </tr>
              ))}
            </tbody>
          </table>
        ) : (
          <p>Nessun componente trovato.</p>
        )}
      </div>
    </div>
  );
};

export default DibaPopover;
