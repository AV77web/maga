import React from "react";
import "../css/Sidebar.css";
import Nav from "./Nav";

function Sidebar1({ isSidebarOpen, closeSidebar, onLogout, currentUser }) { // Aggiungi currentUser come prop
  return (
    <>
      {isSidebarOpen && (
        <div className="sidebar-overlay" onClick={closeSidebar}></div>
      )}
      <aside className={isSidebarOpen ? "open" : ""}>
        <Nav className="nav-item" onLogout={onLogout} currentUser={currentUser}></Nav> {/* Passa onLogout e currentUser a Nav */}
      </aside>
    </>
  );
}
export default Sidebar1;
