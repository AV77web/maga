//=======================================
//File: App.jsx
//Componente principale dell'applicazione.
//@author: "villari.andrea@libero.it"
//@version: "1.0.0 2025-06-"
//========================================

import React from "react";
import { useState, useEffect, Suspense, lazy } from "react";
import { logoutUser } from "./api/authApi"; // Importa la funzione di logout
import {
  Routes,
  Route,
  Navigate,
  useNavigate,
  useLocation,
} from "react-router-dom"; // ✅ basta questo
import Anagrafiche from "./components/Anagrafiche";
import ArticoliTable from "./components/ArticoliTable";
import CausaliTable from "./components/CausaliTable";
import ClientiTable from "./components/ClientiTable";
import FornitoriTable from "./components/FornitoriTable";
import Ordini from "./components/Ordini";
import Login from "./components/Login";
import MovimentiTable from "./components/MovimentiTable";
import Register from "./components/Register";
import Sidebar1 from "./components/Sidebar1";

/*const RicambiTableGrid = lazy(() => import("./components/RicambiTableGrid"));*/

//Componente per proteggere le rotte
const ProtectedRoute = ({ isLoggedIn, children, allowedRoles, userRole }) => {
  if (!isLoggedIn) {
    return <Navigate to="/login" replace />;
  }
  // If allowedRoles are specified, check if the user's role is among them
  if (allowedRoles && (!userRole || !allowedRoles.includes(userRole))) {
    // User is logged in but does not have the required role
    // Redirect to home or an "Access Denied" page. For now, home.
    return <Navigate to="/" replace />;
  }
  return children;
};

function App() {
  // Controlla se c'è un token in localStorage all'avvio per mantenere lo stato di login
  const [loggedIn, setLoggedIn] = useState(!!localStorage.getItem("authToken"));
  const [currentUser, setCurrentUser] = useState(() => {
    const storedUser = localStorage.getItem("user");
    if (storedUser) {
      try {
        return JSON.parse(storedUser);
      } catch (e) {
        console.error("Error parsing user from localStorage", e);
        localStorage.removeItem("user"); // Clear corrupted data if parsing fails
        return null;
      }
    }
    return null;
  });
  const [isSideBarOpen, setIsSideBarOpen] = useState(false);
  const navigate = useNavigate();
  // const location = useLocation(); // No longer needed for the removed useEffect

  const toggleSidebar = () => setIsSideBarOpen(!isSideBarOpen);
  const closeSidebar = () => setIsSideBarOpen(false);

  const handleLoginSuccess = () => {
    setLoggedIn(true);
    const userJson = localStorage.getItem("user"); // User data should have been set by Login.jsx
    if (userJson) {
      try {
        setCurrentUser(JSON.parse(userJson));
      } catch (error) {
        console.error(
          "Failed to parse user from localStorage on login success",
          error
        );
        setCurrentUser(null); // Fallback
      }
    }
    navigate("/"); // Reindirizza alla home page o alla pagina precedente desiderata
  };

  const handleLogout = async () => {
    await logoutUser(); // Chiama l'API di logout
    localStorage.removeItem("authToken");
    localStorage.removeItem("user"); // Rimuovi anche i dati utente se memorizzati
    setLoggedIn(false);
    setCurrentUser(null); // Clear current user state
    navigate("/login");
  };
  const location = useLocation(); // Get the current location object

  // The useEffect that redirected logged-in users from /login or /register
  // has been removed as route definitions now handle these cases.

  return (
    <>
      <button className="button1" onClick={toggleSidebar}>
        ☰
      </button>
      <Sidebar1
        isSidebarOpen={isSideBarOpen}
        closeSidebar={closeSidebar}
        onLogout={handleLogout}
        currentUser={currentUser}
        currentLocation={location.pathname}
      />

      {/*<Suspense fallback={<div>Caricamento...</div>}>*/}
      {/* Potresti aggiungere un pulsante di Logout nella Sidebar o in un Header */}
      {/* Esempio: loggedIn && <button onClick={handleLogout}>Logout</button> */}

      <Routes>
        {/*Rotte precedenti all'introuzione della Registrazione con bcrypt}
        {/*<Route path="/" element={<MovimentiTable />} />
        <Route path="/articoli" element={<RicambiManagerDialog4 />} />
        <Route path="/causali" element={<CausaliManager4/>}/>*/}

        {/* Rotte pubbliche */}
        <Route
          path="/login"
          element={
            !loggedIn ? (
              <Login onSuccess={handleLoginSuccess} />
            ) : (
              <Navigate to="/" />
            )
          }
        />
        {/* The /register route is now protected below */}

        {/* Rotte protette */}
        <Route
          path="/"
          element={
            <ProtectedRoute isLoggedIn={loggedIn} userRole={currentUser?.role}>
              <MovimentiTable
                currentUser={currentUser}
                onLogout={handleLogout}
                currentLocation={location.pathname}
              />
            </ProtectedRoute>
          }
        />
        <Route
          path="/register"
          element={
            <ProtectedRoute
              isLoggedIn={loggedIn}
              allowedRoles={["admin"]}
              userRole={currentUser?.role}
            >
              <Register />
            </ProtectedRoute>
          }
        />
        <Route
          path="/articoli"
          element={
            <ProtectedRoute isLoggedIn={loggedIn} userRole={currentUser?.role}>
              <ArticoliTable
                currentUser={currentUser}
                onLogout={handleLogout}
                currentLocation={location.pathname}
              />
            </ProtectedRoute>
          }
        />
        <Route
          path="/anagrafiche"
          element={
          <ProtectedRoute isLoggedIn={loggedIn} userRole={currentUser?.role}>
            <Anagrafiche
            currentUser={currentUser}
            onLogout={handleLogout}
            currentLocation={location.pathname}
          />
          </ProtectedRoute>
          }
          >
          {/* Sotto-rotte */}
          <Route
            path="clienti"
            element={
            <ClientiTable
            currentUser={currentUser}
            onLogout={handleLogout}
            currentLocation={location.pathname}
            />
          }
          />
          <Route
            path="fornitori"
            element={
            <FornitoriTable
              currentUser={currentUser}
              onLogout={handleLogout}
              currentLocation={location.pathname}
            />
          }
          />
          {/* Rotta di default quando si va su /anagrafiche */}
          <Route
          index
          element={<h2>Seleziona una sezione: Clienti o Fornitori</h2>}
          />
          </Route>

          
          <Route
           path="/causali"
           element={
            <ProtectedRoute isLoggedIn={loggedIn} userRole={currentUser?.role}>
              <CausaliTable
                currentUser={currentUser}
                onLogout={handleLogout}
                currentLocation={location.pathname}
              />
            </ProtectedRoute>
           }
           />
           {/* Reindirizza qualsiasi altra rotta non definita alla home se loggato, o al login se non loggato */}
          <Route
           path="*"
           element={<Navigate to={loggedIn ? "/" : "/login"} replace />}
          />
        </Routes>

      {/*</Suspense>*/}
    </>
  );
}

export default App;
