export const sortByKey = (array, key, direction = "asc") => {
  return [...array].sort((a, b) => {
    const valA = a[key]?.toLowerCase() ?? "";
    const valB = b[key]?.toLowerCase() ?? "";
    if (valA < valB) return direction === "asc" ? -1 : 1;
    if (valA > valB) return direction === "asc" ? 1 : -1;
    return 0;
  });
};
