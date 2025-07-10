import React from "react";
import { Link, Outlet } from "react-router-dom";
import {RxTriangleRight, RxTriangleDown } from "react-icons/rx";
import "../css/Anagrafiche.css"

const Anagrafiche = ({ currentUser, onLogout, currentLocation }) => {
  return (
    <div>
      <nav>
        <div className="mylink-anagrafiche">
            <Link to="clienti" className="mylink">
            Clienti
            </Link>
            <Link to="fornitori" className="mylink">
            Fornitori
            </Link>
        </div>
      </nav>
      <hr />
      {/* Qui verranno renderizzati ClientiTable o FornitoriTable */}
        <Outlet />
      
    </div>
  );
};

export default Anagrafiche;
