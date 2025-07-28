//==================================================
// File: DropdownExample.jsx
// Esempio di utilizzo del sistema di dropdown
// @author: "villari.andrea@libero.it"
// @version: "1.0.0 2025-07-28"
//==================================================

import React, { useState } from "react";
import { FaUser, FaCog, FaSignOutAlt, FaEye, FaEyeSlash } from "react-icons/fa";
import Dropdown from "./Dropdown/Dropdown";
import DropdownContent from "./DropdownContent/DropdownContent";
import DropdownItem from "./DropdownItem/DropdownItem";
import DropdownButton from "./DropdownButton/DropdownButton";

const DropdownExample = () => {
  const [isOpen, setIsOpen] = useState(false);
  const [selectedOption, setSelectedOption] = useState("");

  const handleOptionSelect = (option) => {
    setSelectedOption(option);
    setIsOpen(false);
  };

  return (
    <div style={{ padding: "20px" }}>
      <h2>Esempi di utilizzo del sistema Dropdown</h2>
      
      {/* Esempio 1: Dropdown semplice */}
      <div style={{ marginBottom: "20px" }}>
        <h3>1. Dropdown semplice</h3>
        <Dropdown
          trigger={<button>Menu semplice ▼</button>}
          isOpen={isOpen}
          onToggle={setIsOpen}
        >
          <DropdownContent>
            <DropdownItem onClick={() => handleOptionSelect("Opzione 1")}>
              Opzione 1
            </DropdownItem>
            <DropdownItem onClick={() => handleOptionSelect("Opzione 2")}>
              Opzione 2
            </DropdownItem>
            <DropdownItem type="separator" />
            <DropdownItem onClick={() => handleOptionSelect("Opzione 3")}>
              Opzione 3
            </DropdownItem>
          </DropdownContent>
        </Dropdown>
        {selectedOption && <p>Selezionato: {selectedOption}</p>}
      </div>

      {/* Esempio 2: Dropdown con icone */}
      <div style={{ marginBottom: "20px" }}>
        <h3>2. Dropdown con icone</h3>
        <Dropdown
          trigger={<DropdownButton icon={<FaUser />}>Menu utente</DropdownButton>}
          isOpen={isOpen}
          onToggle={setIsOpen}
        >
          <DropdownContent title="Menu Utente" showHeader={true}>
            <DropdownItem icon={<FaUser />} onClick={() => console.log("Profilo")}>
              Profilo
            </DropdownItem>
            <DropdownItem icon={<FaCog />} onClick={() => console.log("Impostazioni")}>
              Impostazioni
            </DropdownItem>
            <DropdownItem type="separator" />
            <DropdownItem icon={<FaSignOutAlt />} onClick={() => console.log("Logout")}>
              Logout
            </DropdownItem>
          </DropdownContent>
        </Dropdown>
      </div>

      {/* Esempio 3: Dropdown con checkbox */}
      <div style={{ marginBottom: "20px" }}>
        <h3>3. Dropdown con checkbox</h3>
        <Dropdown
          trigger={<button>Colonne visibili ▼</button>}
          isOpen={isOpen}
          onToggle={setIsOpen}
        >
          <DropdownContent title="Colonne" showHeader={true}>
            <DropdownItem type="checkbox" checked={true}>
              Nome
            </DropdownItem>
            <DropdownItem type="checkbox" checked={true}>
              Email
            </DropdownItem>
            <DropdownItem type="checkbox" checked={false}>
              Telefono
            </DropdownItem>
            <DropdownItem type="separator" />
            <DropdownItem icon={<FaEye />}>
              Mostra tutte
            </DropdownItem>
            <DropdownItem icon={<FaEyeSlash />}>
              Nascondi tutte
            </DropdownItem>
          </DropdownContent>
        </Dropdown>
      </div>
    </div>
  );
};

export default DropdownExample; 