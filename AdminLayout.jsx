import React from "react";
import { FaUserCircle } from "react-icons/fa";
import { useNavigate } from "react-router-dom";

function AdminLayout({ loggedInUser, handleLogout }) {
  const navigate = useNavigate();

  return (
    <header className="flex justify-between items-center px-5 py-3 bg-white/80 border-b shadow-sm backdrop-blur-sm">

      {/* Logo */}
      <div className="flex items-center gap-2">
        <div className="bg-green-600 text-white font-bold px-2 py-1 rounded">
          P
        </div>
        <h2 className="text-lg font-semibold text-gray-800">PETUNGNI</h2>
      </div>

      {/* Menu Navbar */}
      <nav className="flex gap-5 text-sm sm:text-base">
        <a href="/dashboard" className="hover:text-green-600">Home</a>
        <a href="/dashboard_monitoring" className="hover:text-green-600">
          Dashboard Monitoring
        </a>
        <a href="/data_petanikonsumen" className="hover:text-green-600">
          Data Petani & Konsumen
        </a>
        <a href="/analisisstatistik" className="hover:text-green-600">
          Analisis & Statistik
        </a>

        {/* 🔥 Menu Baru: Riwayat Login */}
        <a href="/riwayat_login" className="hover:text-green-600">
          Riwayat Login
        </a>

        <a href="/manajemen_user" className="hover:text-green-600">
          Manajemen User
        ""</a>

      </nav>

      {/* User Info */}
      <div className="flex items-center gap-3">
        {loggedInUser ? (
          <>
            <div className="flex items-center bg-green-100 px-3 py-1 rounded-full">
              <FaUserCircle className="text-green-600 text-xl mr-2" />
              <span className="text-green-700 font-semibold">
                {loggedInUser.username || loggedInUser.email}
              </span>
            </div>

            <button
              onClick={handleLogout}
              className="bg-red-500 text-white px-3 py-1 rounded hover:bg-red-600"
            >
              Logout
            </button>
          </>
        ) : (
          <>
            <button
              onClick={() => navigate("/login")}
              className="bg-gray-800 text-white px-3 py-1 rounded"
            >
              Login
            </button>
            <button
              onClick={() => navigate("/register")}
              className="bg-green-600 text-white px-3 py-1 rounded"
            >
              Register
            </button>
          </>
        )}
      </div>
    </header>
  );
}

export default AdminLayout;
