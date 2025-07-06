//===============================================================
//File: timestamp.js
// script per generare un timestamp con data dd/mm/yy hh:mm:ss
//@author: "villari.andrea@libero.it"
//@version: "1.0.0 2025-07-01"
//===============================================================

const mytimestamp = () => {
    const now = new Date();
    const giorno = String(now.getDate()).padStart(2, '0');
    const mese = String(now.getMonth() + 1).padStart(2, '0');
    const anno = now.getFullYear();
    const ore = String(now.getHours()).padStart(2, '0');
    const minuti = String(now.getMinutes()).padStart(2, '0');
    const secondi = String(now.getSeconds()).padStart(2, '0');
    
    return `${anno}-${mese}-${giorno} ${ore}:${minuti}:${secondi}`;
}

//console.log(mytimestamp());

module.exports = mytimestamp;
