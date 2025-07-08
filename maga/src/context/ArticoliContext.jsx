import { createContext, useContext, useReducer } from "react";

const ArticoliContext = createContext();

const initialState = {
  articoli: [],
  loading: false,
  error: null,
};

function articoliReducer(state, action) {
  switch (action.type) {
    case "SET_ARTICOLI":
      return { ...state, articoli: action.payload };
    case "SET_LOADING":
      return { ...state, loading: action.payload };
    case "SET_ERROR":
      return { ...state, error: action.payload };
    default:
      throw new Error(`Unknown action: ${action.type}`);
  }
}

export const ArticoliProvider = ({ children }) => {
  const [state, dispatch] = useReducer(articoliReducer, initialState);

  return (
    <ArticoliContext.Provider value={{ state, dispatch }}>
      {children}
    </ArticoliContext.Provider>
  );
};

export const useArticoliContext = () => useContext(ArticoliContext);
