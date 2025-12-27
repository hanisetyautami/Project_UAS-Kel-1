import React from "react";
import { useNavigate } from "react-router-dom";
import { UserCircle2 } from "lucide-react";

const Sidebar = () => {
  const navigate = useNavigate();
  const isLoggedIn = localStorage.getItem("isLoggedIn") === "true";
  const username = localStorage.getItem("username") || "Guest";

  const handleLogout = () => {
    localStorage.clear();
    navigate("/login");
  };

  return (
    <aside className="w-64 bg-green-800 text-white flex flex-col">
      <div className="flex items-center gap-3 p-5 border-b border-green-700">
        {isLoggedIn ? (
          <div className="bg-white rounded-full w-10 h-10 flex items-center justify-center">
            <UserCircle2 className="text-green-700 w-8 h-8" />
          </div>
        ) : (
          <div className="bg-white text-green-700 rounded-full w-10 h-10 flex items-center justify-center font-bold text-lg">
            P
          </div>
        )}
        <div>
          <h1 className="text-lg font-bold">{isLoggedIn ? username : "PETUNGINI"}</h1>
          {isLoggedIn && <p className="text-xs text-green-200">Admin</p>}
        </div>
      </div>

      <nav className="flex-1 p-4 space-y-2 text-sm">
        <a href="/home" className="block py-2 px-3 rounded hover:bg-green-700">
          Home
        </a>
        <a href="/dashboard" className="block py-2 px-3 rounded hover:bg-green-700">
          Dashboard Monitoring
        </a>
        <a href="/data" className="block py-2 px-3 rounded hover:bg-green-700">
          Data Petani
        </a>
        <a href="/analisis" className="block py-2 px-3 rounded hover:bg-green-700">
          Analisis dan Statistik
        </a>
        <a href="/akun" className="block py-2 px-3 rounded hover:bg-green-700">
          Akun
        </a>
      </nav>

      {isLoggedIn && (
        <button
          onClick={handleLogout}
          className="m-4 bg-red-500 hover:bg-red-600 text-white py-2 rounded-lg"
        >
          Logout
        </button>
      )}
    </aside>
  );
};

export default Sidebar;
