import { useState, useMemo } from "react";

export default function EsempioUseMemmo() {
  const [count, setCount] = useState(0);
  const [altroState, setAltroState] = useState(false);

  const calcoloCostoso = () => {
    console.log("Calcolo costoso in esescuzione...");
    let result = 0;
    for (let i = 0; i < 1_000_000_000; i++) {
      result = Math.sin(count) + Math.cos(count);
    }
    return result;
  };
  return (
    <div>
      <p>
        Count: {count} Calcolo costoso: {calcoloCostoso()}
      </p>
      <button onClick={() => setCount(count + 1)}>Incrementa</button>
      <button onClick={() => setAltroState(!altroState)}>Cambia Stato</button>
    </div>
  );
}
