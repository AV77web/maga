import Nav from "./Nav";
import React, { useState } from "react";
import "../css/Sidebar.css";

/*import { keyboard } from "@testing-library/user-event/dist/keyboard";*/

function Sidebar() {
  const [isOpen, setIsOpen] = useState(false);

  // funzione per aprire/chiudere la sidebar

  const toggleSidebar = () => {
    setIsOpen(!isOpen);
  };

  return (
    <>
      <button
        className="button1"
        onClick={toggleSidebar}
        aria-label="Toggle menu"
      >
        ☰
      </button>
      {/* Sidebar */}
      <aside className={isOpen ? "open" : ""}>
        <h2>Menu</h2>
        {/* Container per i bottoni di filtro 
        <div className="sidebar-filter-controls">
          <button className="sidebar-filter-button">PER CATEGORIA</button>
          <button className="sidebar-filter-button">
            PER COSTRUTTORE MACCHINA
          </button> 
        </div>*/}
        <Nav className="nav-item"></Nav>
      </aside>

      {/* Overlay per chiudere la sidebar cliccando fuori */}
      {isOpen && <div className="sidebar-overlay" onClick={toggleSidebar} />}
    </>
  );
}

export default Sidebar;
