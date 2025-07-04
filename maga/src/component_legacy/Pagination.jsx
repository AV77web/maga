import React from "react";
import classnames from "classnames";
import { UsePagination } from "./UsePagination";
import "../css/pagination.css";

const Pagination = (props) => {
  const {
    onPageChange,
    totalCount,
    siblingCount = 1,
    currentPage,
    pageSize,
    className,
  } = props;

  const DOTS = "...";

  const paginationRange = UsePagination({
    currentPage,
    totalCount,
    siblingCount,
    pageSize,
  });

  if (currentPage === 0 || paginationRange.length < 2) {
    return null;
  }

  const onNext = () => {
    if (currentPage < paginationRange[paginationRange.length - 1]) {
      onPageChange(currentPage + 1);
    }
  };

  const onPrevious = () => {
    if (currentPage > 1) {
      onPageChange(currentPage - 1);
    }
  };

  let lastPage = paginationRange[paginationRange.length - 1];

  return (
    <div className="pagination-wrapper">
      <button
        className="arrow-button"
        onClick={onPrevious}
        disabled={currentPage === 1}
      >
        <span className="arrow-icon-left" />
      </button>

      <ul
        className={classnames("pagination-container", {
          [className]: className,
        })}
      >
        {paginationRange.map((pageNumber, index) => {
          if (pageNumber === DOTS) {
            return (
              <li key={`dots-${index}`} className="pagination-item dots">
                &#8230;
              </li>
            );
          }

          return (
            <li
              key={pageNumber}
              className={classnames("pagination-item", {
                selected: pageNumber === currentPage,
              })}
              onClick={() => onPageChange(pageNumber)}
            >
              {pageNumber}
            </li>
          );
        })}
      </ul>

      <button
        className="arrow-button"
        onClick={onNext}
        disabled={currentPage === lastPage}
      >
        <span className="arrow-icon-right" />
      </button>
    </div>
  );
};

export default Pagination;
