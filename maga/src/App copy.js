import "./App.css";
import { useState } from "react";
import Login from "./components/Login";
import MovimentiForm from "./components/MovimentiForm";
import { HashRouter as Router, Routes, Route } from "react-router-dom";
import RicambiManager from "./components/RicambiManager";
import Nav from "./components/Nav";
/*import CausaliManager from "./components/CausaliManager";*/
/*import RicambiList from "./components/RicambiList"; */

function App() {
  const [loggedIn, setLoggedIn] = useState(false);
  return (
    <div className="App">
      {loggedIn ? (
        <Router>
          <Nav />
          <Routes>
            <Route path="/" element={<Login />} />
            <Route path="/movimenti" element={<MovimentiForm />} />
            <Route path="/articoli" element={<RicambiManager />} />
          </Routes>
        </Router>
      ) : (
        <Login onSuccess={() => setLoggedIn(true)} />
      )}
      {/*<Nav />
        <Routes>
          <Route path="/" element={<Login />} />
          <Route path="/movimenti" element={<MovimentiForm />} />
          <Route path="/articoli" element={<RicambiManager />} />
        </Routes>*/}
    </div>
  );
}

export default App;
