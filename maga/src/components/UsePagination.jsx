//==================================
//File:UsePagination.jsx
//Programma per la gestione dellal paginazione.
//E' un hool personalizzato  React che genera un
//array di numeri di pagina da mostrare nel
//nel componente Pagination.
//@author: "villari.andrea@libero.it"
//@version: "1.0.0 2025-05-30"
//==================================

import { useMemo } from "react";

const range = (start, end) => Array.from({ length: end - start + 1 }, (_, i) => i + start);
const DOTS = "...";

/**
 * Hook che genera l'intervallo di pagine da visualizzare.
 * Accetta **totalPages** già calcolate dal backend; non richiede più totalCount/pageSize.
 */
export const UsePagination = ({ totalPages = 1, currentPage = 1, siblingCount = 1 }) => {
  const paginationRange = useMemo(() => {
    if (totalPages <= 1) return [1];

    const totalPageNumbers = siblingCount + 5; // first + last + current + 2*dots

    if (totalPageNumbers >= totalPages) {
      return range(1, totalPages);
    }

    const leftSiblingIndex = Math.max(currentPage - siblingCount, 1);
    const rightSiblingIndex = Math.min(currentPage + siblingCount, totalPages);

    const shouldShowLeftDots = leftSiblingIndex > 2;
    const shouldShowRightDots = rightSiblingIndex < totalPages - 2;

    const firstPageIndex = 1;
    const lastPageIndex = totalPages;

    // Vari casi dots
    if (!shouldShowLeftDots && shouldShowRightDots) {
      const leftRange = range(1, 3 + 2 * siblingCount);
      return [...leftRange, DOTS, lastPageIndex];
    }

    if (shouldShowLeftDots && !shouldShowRightDots) {
      const rightRange = range(totalPages - (3 + 2 * siblingCount) + 1, totalPages);
      return [firstPageIndex, DOTS, ...rightRange];
    }

    if (shouldShowLeftDots && shouldShowRightDots) {
      const middleRange = range(leftSiblingIndex, rightSiblingIndex);
      return [firstPageIndex, DOTS, ...middleRange, DOTS, lastPageIndex];
    }

    return range(1, totalPages);
  }, [totalPages, currentPage, siblingCount]);

  return paginationRange;
};
