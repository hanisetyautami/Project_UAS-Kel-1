import React from "react";
import { Routes, Route, NavLink } from "react-router-dom";
import Dashboard from "./pages/dashboard";
import Login from "./pages/Login";
import Register from "./pages/Register";
import "./css/dashboard 2.css";

function App() {
  return (
    <div className="app">
      <header className="app-header">
        <div className="logo">PETUNGNI</div>
        <nav className="nav">
          <NavLink to="/" end className={({isActive}) => isActive ? "link active" : "link"}>Home</NavLink>
          <NavLink to="/login" className={({isActive}) => isActive ? "link active" : "link"}>Login</NavLink>
          <NavLink to="/register" className={({isActive}) => isActive ? "link active" : "link"}>Register</NavLink>
        </nav>
      </header>

      <main className="app-main">
        <Routes>
          <Route path="/" element={<Dashboard />} />
          <Route path="/login" element={<Login />} />
          <Route path="/register" element={<Register />} />
        </Routes>
      </main>

      <footer className="app-footer">© 2025 PETUNGNI</footer>
    </div>
  );
}

export default App;
