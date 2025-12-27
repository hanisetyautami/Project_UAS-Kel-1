import React, { useEffect, useState } from "react";
import { Link, useNavigate } from "react-router-dom";

function Navbar() {
  const navigate = useNavigate();
  const [loggedInUser, setLoggedInUser] = useState(null);

  useEffect(() => {
    const user = JSON.parse(localStorage.getItem("loggedInUser"));
    setLoggedInUser(user);
  }, []);

  const handleLogout = () => {
    localStorage.removeItem("loggedInUser");
    setLoggedInUser(null);
    navigate("/login");
  };

  return (
    <nav className="flex justify-between items-center px-8 py-3 bg-white shadow-md">
      {/* Logo */}
      <div className="flex items-center space-x-2">
        <div className="bg-green-600 text-white font-bold px-3 py-1 rounded-lg">P</div>
        <h2 className="text-xl font-semibold text-green-700">PETUNGNI</h2>
      </div>

      {/* Menu */}
      <div className="flex space-x-6">
        <Link to="/dashboard" className="hover:text-green-600 font-medium">
          Dashboard Monitoring
        </Link>
        <Link to="/data" className="hover:text-green-600 font-medium">
          Data Petani & Konsumen
        </Link>
        <Link to="/analisis" className="hover:text-green-600 font-medium">
          Analisis & Statistik
        </Link>
      </div>

      {/* User Info */}
      <div className="flex items-center space-x-4">
        {loggedInUser ? (
          <>
            <div className="flex items-center space-x-2 bg-green-100 px-3 py-1 rounded-full">
              <span className="text-green-700 font-semibold">
                {loggedInUser.username || loggedInUser.email}
              </span>
              <span className="text-green-700">👤</span>
            </div>
            <button
              onClick={handleLogout}
              className="bg-red-500 text-white px-3 py-1 rounded-md hover:bg-red-600 transition"
            >
              Logout
            </button>
          </>
        ) : (
          <>
            <Link
              to="/login"
              className="bg-gray-100 px-3 py-1 rounded-md hover:bg-gray-200"
            >
              Login
            </Link>
            <Link
              to="/register"
              className="bg-green-500 text-white px-3 py-1 rounded-md hover:bg-green-600"
            >
              Register
            </Link>
          </>
        )}
      </div>
    </nav>
  );
}

export default Navbar;
