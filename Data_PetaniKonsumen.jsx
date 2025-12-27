import React, { useState, useEffect } from "react";
import {
  FaEdit,
  FaTrash,
  FaLeaf,
  FaBars,
  FaUserCircle,
  FaSignOutAlt,
  FaUsers,
  FaTable,
  FaChartBar,
} from "react-icons/fa";

const DataPetaniKonsumen = () => {
  const [search, setSearch] = useState("");
  const [filter, setFilter] = useState("Semua");
  const [isSidebarOpen, setIsSidebarOpen] = useState(true);
  const [activeMenu, setActiveMenu] = useState("dashboard");

  // =============================
  // LOCAL STORAGE HELPERS
  // =============================
  const loadData = (key) => JSON.parse(localStorage.getItem(key)) || [];
  const saveData = (key, data) => localStorage.setItem(key, JSON.stringify(data));

  // =============================
  // STATE
  // =============================
  const [dataPetani, setDataPetani] = useState([]);
  const [dataKonsumen, setDataKonsumen] = useState([]);
  const [dataRelasi, setDataRelasi] = useState([]);

  // LOAD INITIAL DATA
  useEffect(() => {
    setDataPetani(loadData("dataPetani"));
    setDataKonsumen(loadData("dataKonsumen"));
    setDataRelasi(loadData("dataRelasi"));
  }, []);

  // =============================
  // CRUD PETANI
  // =============================
  const addPetani = () => {
    const newItem = {
      id: Date.now(),
      nama: "Petani Baru",
      alamat: "Belum diisi",
      komoditas: "Belum diisi",
    };
    const updated = [...dataPetani, newItem];
    setDataPetani(updated);
    saveData("dataPetani", updated);
  };

  const deletePetani = (id) => {
    if (!window.confirm("Hapus data petani?")) return;
    const updated = dataPetani.filter((item) => item.id !== id);
    setDataPetani(updated);
    saveData("dataPetani", updated);
  };

  // =============================
  // CRUD KONSUMEN
  // =============================
  const addKonsumen = () => {
    const newItem = {
      id: Date.now(),
      nama: "Konsumen Baru",
      kontak: "-",
      alamat: "-",
      status: "Pending",
    };
    const updated = [...dataKonsumen, newItem];
    setDataKonsumen(updated);
    saveData("dataKonsumen", updated);
  };

  const deleteKonsumen = (id) => {
    if (!window.confirm("Hapus data konsumen?")) return;
    const updated = dataKonsumen.filter((item) => item.id !== id);
    setDataKonsumen(updated);
    saveData("dataKonsumen", updated);
  };

  // =============================
  // CRUD RELASI
  // =============================
  const addRelasi = () => {
    const newItem = {
      id: Date.now(),
      petaniId: "",
      konsumenId: "",
      tanaman: "Baru",
      jadwal: "2025-01-01",
      status: "Pending",
    };
    const updated = [...dataRelasi, newItem];
    setDataRelasi(updated);
    saveData("dataRelasi", updated);
  };

  const deleteRelasi = (id) => {
    if (!window.confirm("Hapus data ini?")) return;
    const updated = dataRelasi.filter((item) => item.id !== id);
    setDataRelasi(updated);
    saveData("dataRelasi", updated);
  };

  // =============================
  // MAIN CONTENT RENDER
  // =============================
  const renderContent = () => {
    // =======================
    // DASHBOARD MONITORING
    // =======================
    if (activeMenu === "dashboard") {
      return (
        <div className="bg-white p-6 rounded-lg shadow text-center">
          <h2 className="text-2xl font-bold text-green-700 mb-4 flex items-center justify-center gap-2">
            <FaChartBar /> Dashboard
          </h2>
          <p>Selamat datang di Sistem PETUNGNI 👨‍🌾</p>

          <div className="grid grid-cols-1 sm:grid-cols-2 gap-4 mt-6">
            <div className="bg-green-100 p-4 rounded-lg">
              <h3 className="font-semibold">Total Petani</h3>
              <p className="text-3xl font-bold text-green-700">
                {dataPetani.length}
              </p>
            </div>

            <div className="bg-green-100 p-4 rounded-lg">
              <h3 className="font-semibold">Total Konsumen</h3>
              <p className="text-3xl font-bold text-green-700">
                {dataKonsumen.length}
              </p>
            </div>
          </div>
        </div>
      );
    }

    // =======================
    // DATA PETANI
    // =======================
    if (activeMenu === "data_petanikonsumen") {
      return (
        <>
          <h1 className="text-2xl font-semibold text-green-700 mb-6 text-center">
            <FaTable className="inline mr-2" /> Data Petani & Relasi
          </h1>

          {/* Tombol Tambah */}
          <button
            onClick={addPetani}
            className="bg-green-600 text-white px-3 py-2 rounded mb-3 hover:bg-green-700"
          >
            + Tambah Petani
          </button>

          <div className="overflow-x-auto bg-white rounded-lg shadow mb-6">
            <table className="w-full border-collapse">
              <thead className="bg-green-700 text-white text-sm">
                <tr>
                  <th className="py-2 px-4 border">ID</th>
                  <th className="py-2 px-4 border">Nama</th>
                  <th className="py-2 px-4 border">Alamat</th>
                  <th className="py-2 px-4 border">Komoditas</th>
                  <th className="py-2 px-4 border">Aksi</th>
                </tr>
              </thead>

              <tbody>
                {dataPetani.map((item) => (
                  <tr key={item.id} className="text-center hover:bg-green-50">
                    <td className="border py-2">{item.id}</td>
                    <td className="border py-2">{item.nama}</td>
                    <td className="border py-2">{item.alamat}</td>
                    <td className="border py-2">{item.komoditas}</td>
                    <td className="border py-2 flex justify-center gap-2">
                      <button className="bg-blue-600 text-white px-2 py-1 text-xs rounded flex items-center gap-1">
                        <FaEdit /> Edit
                      </button>
                      <button
                        onClick={() => deletePetani(item.id)}
                        className="bg-red-600 text-white px-2 py-1 text-xs rounded flex items-center gap-1"
                      >
                        <FaTrash /> Hapus
                      </button>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>

          {/* ===================== */}
          {/* RELASI SECTION        */}
          {/* ===================== */}

          <h2 className="text-xl font-semibold text-green-700 mb-4">
            Relasi Petani – Konsumen
          </h2>

          <button
            onClick={addRelasi}
            className="bg-green-600 text-white px-3 py-2 rounded mb-3 hover:bg-green-700"
          >
            + Tambah Relasi
          </button>

          <div className="overflow-x-auto bg-white rounded-lg shadow mb-10">
            <table className="w-full border-collapse">
              <thead className="bg-green-700 text-white text-sm">
                <tr>
                  <th className="py-2 px-4 border">ID</th>
                  <th className="py-2 px-4 border">Petani</th>
                  <th className="py-2 px-4 border">Konsumen</th>
                  <th className="py-2 px-4 border">Tanaman</th>
                  <th className="py-2 px-4 border">Jadwal</th>
                  <th className="py-2 px-4 border">Status</th>
                  <th className="py-2 px-4 border">Aksi</th>
                </tr>
              </thead>

              <tbody>
                {dataRelasi.map((item) => {
                  const petani = dataPetani.find((p) => p.id == item.petaniId);
                  const konsumen = dataKonsumen.find((k) => k.id == item.konsumenId);

                  return (
                    <tr key={item.id} className="text-center hover:bg-green-50">
                      <td className="border py-2">{item.id}</td>
                      <td className="border py-2">{petani?.nama || "-"}</td>
                      <td className="border py-2">{konsumen?.nama || "-"}</td>
                      <td className="border py-2">{item.tanaman}</td>
                      <td className="border py-2">{item.jadwal}</td>
                      <td className="border py-2">{item.status}</td>

                      <td className="border py-2 flex justify-center gap-2">
                        <button className="bg-blue-600 text-white px-2 py-1 text-xs rounded flex items-center gap-1">
                          <FaEdit /> Edit
                        </button>

                        <button
                          onClick={() => deleteRelasi(item.id)}
                          className="bg-red-600 text-white px-2 py-1 text-xs rounded flex items-center gap-1"
                        >
                          <FaTrash /> Hapus
                        </button>
                      </td>
                    </tr>
                  );
                })}
              </tbody>
            </table>
          </div>
        </>
      );
    }

    // =======================
    // DATA KONSUMEN
    // =======================
    if (activeMenu === "data_konsumen") {
      return (
        <>
          <h2 className="text-2xl font-semibold text-green-700 mb-4 text-center">
            <FaUsers className="inline mr-2" /> Data Konsumen
          </h2>

          <button
            onClick={addKonsumen}
            className="bg-green-600 text-white px-3 py-2 rounded mb-3 hover:bg-green-700"
          >
            + Tambah Konsumen
          </button>

          <div className="overflow-x-auto bg-white rounded-lg shadow">
            <table className="w-full border-collapse">
              <thead className="bg-green-700 text-white text-sm">
                <tr>
                  <th className="py-2 px-4 border">ID</th>
                  <th className="py-2 px-4 border">Nama</th>
                  <th className="py-2 px-4 border">Kontak</th>
                  <th className="py-2 px-4 border">Alamat</th>
                  <th className="py-2 px-4 border">Status</th>
                  <th className="py-2 px-4 border">Aksi</th>
                </tr>
              </thead>

              <tbody>
                {dataKonsumen.map((item) => (
                  <tr key={item.id} className="text-center hover:bg-green-50">
                    <td className="border py-2">{item.id}</td>
                    <td className="border py-2">{item.nama}</td>
                    <td className="border py-2">{item.kontak}</td>
                    <td className="border py-2">{item.alamat}</td>
                    <td className="border py-2">{item.status}</td>

                    <td className="border py-2 flex justify-center gap-2">
                      <button className="bg-blue-600 text-white px-2 py-1 text-xs rounded flex items-center gap-1">
                        <FaEdit /> Edit
                      </button>
                      <button
                        onClick={() => deleteKonsumen(item.id)}
                        className="bg-red-600 text-white px-2 py-1 text-xs rounded flex items-center gap-1"
                      >
                        <FaTrash /> Hapus
                      </button>
                    </td>
                  </tr>
                ))}
              </tbody>

            </table>
          </div>
        </>
      );
    }

    // =======================
    // AKUN
    // =======================
    if (activeMenu === "akun") {
      return (
        <div className="bg-white p-6 rounded-lg shadow text-center">
          <FaUserCircle className="text-green-700 text-6xl mx-auto mb-3" />
          <h2 className="text-xl font-semibold text-green-700">
            Admin PETUNGNI
          </h2>
          <p className="text-gray-600">admin@petungni.com</p>
        </div>
      );
    }
  };

  // =============================
  // RETURN / UI LAYOUT
  // =============================
  return (
    <div className="min-h-screen bg-green-50 flex">
      {/* Sidebar */}
      <aside
        className={`${
          isSidebarOpen ? "w-64" : "w-20"
        } bg-green-700 text-white flex flex-col justify-between transition-all duration-300`}
      >
        <div>
          <div className="flex items-center justify-between px-4 py-3 bg-green-800">
            <h2 className="text-xl font-semibold">
              {isSidebarOpen ? "PETUNGNI" : "P"}
            </h2>
            <button onClick={() => setIsSidebarOpen(!isSidebarOpen)}>
              <FaBars />
            </button>
          </div>

          {/* Menu */}
          <nav className="flex flex-col px-3 gap-2 mt-4">
            <button
              onClick={() => setActiveMenu("dashboard")}
              className={`flex items-center gap-2 px-3 py-2 rounded hover:bg-green-600 ${
                activeMenu === "dashboard" ? "bg-green-800" : ""
              }`}
            >
              <FaChartBar /> {isSidebarOpen && "Dashboard"}
            </button>

            <button
              onClick={() => setActiveMenu("data_petanikonsumen")}
              className={`flex items-center gap-2 px-3 py-2 rounded hover:bg-green-600 ${
                activeMenu === "data_petanikonsumen" ? "bg-green-800" : ""
              }`}
            >
              <FaTable /> {isSidebarOpen && "Data Petani"}
            </button>

            <button
              onClick={() => setActiveMenu("data_konsumen")}
              className={`flex items-center gap-2 px-3 py-2 rounded hover:bg-green-600 ${
                activeMenu === "data_konsumen" ? "bg-green-800" : ""
              }`}
            >
              <FaUsers /> {isSidebarOpen && "Data Konsumen"}
            </button>

            <button
              onClick={() => setActiveMenu("akun")}
              className={`flex items-center gap-2 px-3 py-2 rounded hover:bg-green-600 ${
                activeMenu === "akun" ? "bg-green-800" : ""
              }`}
            >
              <FaUserCircle /> {isSidebarOpen && "Akun"}
            </button>
          </nav>
        </div>

        <div className="p-4 border-t border-green-600">
          <button
            onClick={() => alert("Logout berhasil")}
            className="w-full flex items-center justify-center gap-2 bg-red-600 hover:bg-red-700 px-3 py-2 rounded text-white"
          >
            <FaSignOutAlt />
            {isSidebarOpen && "Logout"}
          </button>
        </div>
      </aside>

      {/* Konten Utama */}
      <main className="flex-1 p-6 overflow-auto">{renderContent()}</main>
    </div>
  );
};

export default DataPetaniKonsumen;
