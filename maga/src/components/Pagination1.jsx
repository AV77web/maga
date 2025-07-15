import React from "react";
import classnames from "classnames";
import  { UsePagination } from "./UsePagination";
import "../css/pagination.css";

const DOTS = "...";

const Pagination1 = ({
  onPageChange,
  totalPages,
  siblingCount = 1,
  currentPage,
  className,
}) => {
  const paginationRange = UsePagination({
    currentPage,
    totalPages,
    siblingCount,
  });

  // debug log removed

  if (paginationRange.length < 2) return null;

  const lastPage = paginationRange.length > 0 ? paginationRange[paginationRange.length - 1] : 1;

  return (
    <nav className="pagination-wrapper" aria-label="Navigazione pagine">
      <button
        className="arrow-button"
        onClick={() => onPageChange(currentPage - 1)}
        disabled={currentPage === 1}
        aria-label="Pagina precedente"
      >
        <span className="arrow-icon-left" />
      </button>

      <ul className={classnames("pagination-container", className)}>
        {paginationRange.map((pageNumber, index) =>
          pageNumber === DOTS ? (
            <li
              key={`dots-${index}`}
              className="pagination-item dots"
              aria-hidden
            >
              &hellip;
            </li>
          ) : (
            <li
              key={pageNumber}
              className={classnames("pagination-item", {
                selected: pageNumber === currentPage,
              })}
              onClick={() => onPageChange(pageNumber)}
              aria-current={pageNumber === currentPage ? "page" : undefined}
              role="button"
              tabIndex={0}
              onKeyDown={(e) => e.key === "Enter" && onPageChange(pageNumber)}
            >
              {pageNumber}
            </li>
          )
        )}
      </ul>

      <button
        className="arrow-button"
        onClick={() => onPageChange(currentPage + 1)}
        disabled={currentPage === lastPage}
        aria-label="Pagina successiva"
      >
        <span className="arrow-icon-right" />
      </button>
    </nav>
  );
};

export default Pagination1;
