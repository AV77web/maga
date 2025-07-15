//=======================================
//File: App.jsx
//Componente principale dell'applicazione.
//@author: "villari.andrea@libero.it"
//@version: "1.0.0 2025-06-"
//========================================

import React from "react";
import { useState, useEffect, Suspense, lazy } from "react";
import {
  Routes,
  Route,
  Navigate,
  useNavigate,
  useLocation,
} from "react-router-dom";
import { logoutUser } from "./api/authApi";
import OrdersListPage from "./pages/OrdersListPage";
import OrderDetailPage from "./pages/OrderDetailPage";

import Anagrafiche from "./components/Anagrafiche";
import ArticoliTable from "./components/ArticoliTable";
import CausaliTable from "./components/CausaliTable";
import ContropartiTable from "./components/ContropartiTable";
import Ordini from "./components/Ordini";
import Login from "./components/Login";
import MovimentiTable from "./components/MovimentiTable";
import Register from "./components/Register";
import Sidebar1 from "./components/Sidebar1";

// Componente per proteggere le rotte
const ProtectedRoute = ({ isLoggedIn, children, allowedRoles, userRole }) => {
  if (!isLoggedIn) {
    return <Navigate to="/login" replace />;
  }
  if (allowedRoles && (!userRole || !allowedRoles.includes(userRole))) {
    return <Navigate to="/" replace />;
  }
  return children;
};

function App() {
  const [loggedIn, setLoggedIn] = useState(!!localStorage.getItem("authToken"));
  const [currentUser, setCurrentUser] = useState(() => {
    try {
      return JSON.parse(localStorage.getItem("user")) || null;
    } catch {
      localStorage.removeItem("user");
      return null;
    }
  });
  const [isSideBarOpen, setIsSideBarOpen] = useState(false);

  const navigate = useNavigate();
  const location = useLocation();

  const toggleSidebar = () => setIsSideBarOpen(!isSideBarOpen);
  const closeSidebar = () => setIsSideBarOpen(false);

  const handleLoginSuccess = () => {
    setLoggedIn(true);
    try {
      setCurrentUser(JSON.parse(localStorage.getItem("user")));
    } catch {
      setCurrentUser(null);
    }
    navigate("/");
  };

  const handleLogout = async () => {
    await logoutUser();
    localStorage.removeItem("authToken");
    localStorage.removeItem("user");
    setLoggedIn(false);
    setCurrentUser(null);
    navigate("/login");
  };

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

      <Routes>
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
        >
          {/* Sottorotta /causali */}
          <Route
            path="causali"
            element={
              <CausaliTable
                currentUser={currentUser}
                onLogout={handleLogout}
                currentLocation={location.pathname}
              />
            }
          />
        </Route>

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
          path="/ordini/*"
          element={
            <ProtectedRoute isLoggedIn={loggedIn} userRole={currentUser?.role}>
              <Routes>
                <Route index element={
                  <OrdersListPage
                    currentUser={currentUser}
                    onLogout={handleLogout}
                  />
                }/>
                <Route path="new" element={
                  <OrderDetailPage
                    currentUser={currentUser}
                    onLogout={handleLogout}
                  />
                }/>
                <Route path=":orderId" element={
                  <OrderDetailPage
                    currentUser={currentUser}
                    onLogout={handleLogout}
                  />
                }/>
              </Routes>
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
          <Route
            path="controparti"
            element={
              <ContropartiTable
                currentUser={currentUser}
                onLogout={handleLogout}
                currentLocation={location.pathname}
              />
            }
          />
        </Route>

        {/* Catch-all */}
        <Route
          path="*"
          element={<Navigate to={loggedIn ? "/" : "/login"} replace />}
        />
      </Routes>
    </>
  );
}

export default App;
