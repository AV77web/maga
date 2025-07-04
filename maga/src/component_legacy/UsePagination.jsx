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

const range = (start, end) => {
  let length = end - start + 1;
  return Array.from({ length }, (_, idx) => idx + start);
};

const DOTS = "...";

export const UsePagination = ({
  totalCount, // numero totale di elementi (es: righe di una tabella)
  pageSize, // quanti elementi per pagina
  siblingCount = 1, // quante pagine a sinistra/destra mostrare vicino a quella corrente (default=1)
  currentPage, // la pagina attualmente selezionata (pagina corrente)
}) => {
  const paginationRange = useMemo(() => {
    const totalPageCount = Math.ceil(totalCount / pageSize);

    // Il conteggio delle pagine è determinato come siblingCount + firstPage + lastPage + currentPage + 2*DOTS
    const totalPageNumbers = siblingCount + 5;

    /*
        Caso 1:
        Se il numero di pagine è minore del numero da mostrare nel componente, restituiamo l'intervallo [1..totalPageCount]
      */
    if (totalPageNumbers >= totalPageCount) {
      return range(1, totalPageCount);
    }

    /*
          Calcola gli indici di destra e sinistra e si assicura che siano all'interno dell'intervallo 1 e totalPageCount
      */
    const leftSiblingIndex = Math.max(currentPage - siblingCount, 1);
    const rightSiblingIndex = Math.min(
      currentPage + siblingCount,
      totalPageCount
    );

    /*
        Non mostriamo i puntini quando c'è un solo numero di pagina da inserire
        tra le estremità degli indici e i limiti di pagina, vale a dire 1 e totalPageCount.
        Quindi stiamo usando  leftSiblingIndex > 2 e rightSiblingIndex < totalPageCount - 2
      */
    const shouldShowLeftDots = leftSiblingIndex > 2;
    const shouldShowRightDots = rightSiblingIndex < totalPageCount - 2;

    const firstPageIndex = 1;
    const lastPageIndex = totalPageCount;

    /*
          Caso 2: Non ci sono puntini a sinistra da mostrare ma 
          quelli a destra devono essere mostrati
      */
    if (!shouldShowLeftDots && shouldShowRightDots) {
      let leftItemCount = 3 + 2 * siblingCount;
      let leftRange = range(1, leftItemCount);

      return [...leftRange, DOTS, totalPageCount];
    }

    /*
          Caso 3: Non ci sono puntini a destra da mostrare ma 
          quelli a sinistra devono essere mostrati
      */
    if (shouldShowLeftDots && !shouldShowRightDots) {
      let rightItemCount = 3 + 2 * siblingCount;
      let rightRange = range(
        totalPageCount - rightItemCount + 1,
        totalPageCount
      );
      return [firstPageIndex, DOTS, ...rightRange];
    }

    /*
          Caso 4: Sia i puntini a destra che quelli a sinistra 
          sono da mostrare
      */
    if (shouldShowLeftDots && shouldShowRightDots) {
      let middleRange = range(leftSiblingIndex, rightSiblingIndex);
      return [firstPageIndex, DOTS, ...middleRange, DOTS, lastPageIndex];
    }
  }, [totalCount, pageSize, siblingCount, currentPage]);

  return paginationRange;
};
