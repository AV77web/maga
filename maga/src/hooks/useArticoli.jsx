import { useState, useEffect, useCallback } from "react";
import { useArticoliContext } from "../context/ArticoliContext";
import ricambiApi from "../api/ricambiApi";
import dibaApi from "../api/dibaApi";

export default function useArticoli() {
  const { state, dispatch } = useArticoliContext();
  const [sortConfig, setSortConfig] = useState({ key: null, direction: "asc" });
  const [searchTerm, setSearchTerm] = useState("");

  const fetchArticoli = useCallback(async () => {
    dispatch({ type: "SET_LOADING", payload: true });
    try {
      const response = await ricambiApi.getRicambi();
      dispatch({ type: "SET_ARTICOLI", payload: response });
    } catch (error) {
      dispatch({ type: "SET_ERROR", payload: error.message });
    } finally {
      dispatch({ type: "SET_LOADING", payload: false });
    }
  }, [dispatch]);

  useEffect(() => {
    fetchArticoli();
  }, [fetchArticoli]);

  const updateArticolo = async (id, data) => {
    try {
      await ricambiApi.updateRicambi(id, data);
      fetchArticoli();
    } catch (error) {
      dispatch({ type: "SET_ERROR", payload: error.message });
    }
  };

  const deleteArticolo = async (id) => {
    try {
      await ricambiApi.deleteRicambi(id);
      fetchArticoli();
    } catch (error) {
      dispatch({ type: "SET_ERROR", payload: error.message });
    }
  };

  const handleSort = (key) => {
    let direction = "asc";
    if (sortConfig.key === key && sortConfig.direction === "asc") {
      direction = "desc";
    }
    setSortConfig({ key, direction });
  };

  return {
    articoli: state.articoli,
    loading: state.loading,
    error: state.error,
    sortConfig,
    searchTerm,
    setSearchTerm,
    fetchArticoli,
    updateArticolo,
    deleteArticolo,
    handleSort,
  };
}
