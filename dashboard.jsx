import React, { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import { FaUserCircle } from "react-icons/fa";

function Dashboard() {
  const navigate = useNavigate();
  const [loggedInUser, setLoggedInUser] = useState(null);

  const bgUrl =
    "https://cdn.pixabay.com/photo/2023/03/12/13/58/spices-7846964_1280.png";

  // Cek login user
  useEffect(() => {
    const user = JSON.parse(localStorage.getItem("loggedInUser"));
    if (user) setLoggedInUser(user);
  }, []);

  // ============================
  //   HANDLE LOGOUT + SIMPAN HISTORY
  // ============================
  const handleLogout = () => {
    const user = JSON.parse(localStorage.getItem("loggedInUser"));

    // simpan ke history
    const history = JSON.parse(localStorage.getItem("loginHistory")) || [];
    history.push({
      email: user.email,
      action: "logout",
      time: new Date().toLocaleString(),
    });
    localStorage.setItem("loginHistory", JSON.stringify(history));

    localStorage.removeItem("loggedInUser");
    navigate("/login");
  };

  // ============================
  //   ADMINLAYOUT DI DALAM DASHBOARD
  // ============================
  const AdminLayout = () => (
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

        <a href="/riwayat_login" className="hover:text-green-600">
          Riwayat Login
        </a>
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

  // ============================
  //   TAMPILAN DASHBOARD
  // ============================
  return (
    <div
      className="min-h-screen flex flex-col justify-between font-poppins text-center bg-cover bg-center bg-no-repeat"
      style={{
        backgroundImage: `linear-gradient(rgba(62,225,51,0.45), rgba(62,225,51,0.65)), url(${bgUrl})`,
      }}
    >
      {/* Admin Layout di atas */}
      <AdminLayout />

      {/* Hero */}
      <section className="flex flex-col justify-center items-center flex-1 text-white px-4">

        {/* ⭐ Tambahan Welcome Admin */}
        {loggedInUser && (
          <h2 className="text-2xl sm:text-3xl font-semibold mb-2">
            Welcome, Admin!
          </h2>
        )}

        <h1 className="text-4xl sm:text-5xl font-bold mb-3">
          WELCOME TO PETUNGNI!
        </h1>
        <p className="text-lg sm:text-xl mb-6">Tani Cerdas, Bisnis Maju!</p>

        <button
          onClick={() => {
            if (loggedInUser) {
              navigate("/dashboard_monitoring");
            } else {
              alert("Silakan login terlebih dahulu!");
              navigate("/login");
            }
          }}
          className="bg-[#6e6259] hover:bg-[#554b43] text-white font-semibold px-6 py-3 rounded-lg transition"
        >
          GET STARTED
        </button>
      </section>

      {/* Footer */}
      <footer className="py-3 bg-white/80 text-sm text-gray-800">
        © 2025 PETUNGNI — Memberdayakan Petani Hortikultura Indonesia
      </footer>
    </div>
  );
}

export default Dashboard;
