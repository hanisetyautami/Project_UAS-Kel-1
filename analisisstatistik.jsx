import React, { useState, useEffect } from "react";
import {
  FaBars,
  FaTachometerAlt,
} from "react-icons/fa";
import axios from "axios";

// Hapus LUAS_LAHAN_DUMMY, karena data ini sekarang diambil dari Backend

const AnalisisStatistik = () => {
  const [isSidebarOpen, setIsSidebarOpen] = useState(true);
  const [activeMenu, setActiveMenu] = useState("dashboard");
  const [dataHasilPanen, setDataHasilPanen] = useState([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(null);
  
  // 💡 Menambahkan state untuk tahun, menggunakan tahun yang valid
  const [tahunDipilih, setTahunDipilih] = useState(2019); // Contoh: Set tahun ke nilai yang valid di DB Anda

  // ==============================
  // FETCH DATA BACKEND
  // ==============================
  useEffect(() => {
    const fetchData = async () => {
      setLoading(true);
      setError(null);

      try {
        // 🔥 PERBAIKAN 1: Mengubah URL API ke endpoint yang baru dan valid
        // Endpoint: http://localhost:5000/api/statistik/TAHUN
        const API_URL = `http://localhost:5000/api/statistik/${tahunDipilih}`; 
        
        // Catatan: Menggunakan localhost:5000 sama dengan 127.0.0.1:5000

        const res = await axios.get(API_URL);

        // API Flask sekarang mengembalikan array of objects
        // Contoh: [{komoditas: 'Jahe', luas_lahan: 650, produksi: 120, produktivitas: 0.18}, ...]
        const apiData = res.data; 

        // 🔥 PERBAIKAN 2: Data sudah diformat di backend, kita hanya perlu memetakannya ke state.
        const formattedData = apiData.map((item, index) => ({
             id: index + 1,
             komoditas: item.komoditas,
             // Ambil langsung dari respons API (yang sudah dihitung)
             luas: Number(item.luas_lahan), 
             produksi: Number(item.produksi),
             produktivitas: Number(item.produktivitas), // Produktivitas sudah dihitung oleh Flask
        }));
        

        setDataHasilPanen(formattedData);
      } catch (err) {
        // Axios error handling
        console.error("Fetch Error:", err);
        if (err.response && err.response.status === 404) {
            setError(`Data untuk tahun ${tahunDipilih} tidak ditemukan.`);
        } else {
            // Ini akan menangani error CORS/Network
            setError("Gagal mengambil data dari server. Pastikan server Flask berjalan.");
        }
      } finally {
        setLoading(false);
      }
    };

    fetchData();
    // 💡 Jalankan ulang useEffect jika tahunDipilih berubah
  }, [tahunDipilih]); 

  // ==============================
  // TABLE
  // ==============================
  const renderTable = () => (
    <div className="overflow-x-auto">
      {loading && <p className="text-blue-500">Memuat data...</p>}
      {error && <p className="text-red-500 font-bold">{error}</p>}

      {dataHasilPanen.length === 0 && !loading && !error ? (
        <div className="text-center py-10 text-gray-500 border border-dashed">
          Data hasil panen tidak ditemukan.
        </div>
      ) : (
        <table className="w-full border-collapse border text-center">
          <thead className="bg-green-700 text-white">
            <tr>
              <th className="border py-2">No</th>
              <th className="border py-2">Komoditas</th>
              <th className="border py-2">Luas Lahan (Ha)</th>
              <th className="border py-2">Produksi (Ton)</th>
              <th className="border py-2">Produktivitas (Ton/Ha)</th>
            </tr>
          </thead>
          <tbody>
            {dataHasilPanen.map((item, index) => (
              // Menggunakan index sebagai key jika item.id tidak unik/tidak ada di response
              <tr key={index} className="hover:bg-green-50">
                <td className="border py-2">{index + 1}</td>
                <td className="border py-2 text-left pl-4">
                  {item.komoditas}
                </td>
                <td className="border py-2">{item.luas}</td>
                <td className="border py-2">{item.produksi}</td>
                <td className="border py-2">{item.produktivitas}</td>
              </tr>
            ))}
          </tbody>
        </table>
      )}
    </div>
  );

  // ==============================
  // RENDER
  // ==============================
  return (
    <div className="flex bg-gray-100 min-h-screen">
      {/* SIDEBAR */}
      <div
        className={`bg-green-800 text-white p-5 ${
          isSidebarOpen ? "w-64" : "w-16"
        }`}
      >
        {/* ... (kode sidebar tidak diubah) ... */}
        <div className="flex justify-between items-center">
          <h1 className={isSidebarOpen ? "text-xl font-bold" : "hidden"}>
            Biofarmaka
          </h1>
          <FaBars
            className="cursor-pointer"
            onClick={() => setIsSidebarOpen(!isSidebarOpen)}
          />
        </div>

        <button
          className={`mt-6 flex items-center gap-3 p-2 rounded ${
            activeMenu === "dashboard"
              ? "bg-green-600"
              : "hover:bg-green-700"
          }`}
          onClick={() => setActiveMenu("dashboard")}
        >
          <FaTachometerAlt />
          {isSidebarOpen && "Dashboard"}
        </button>
      </div>

      {/* CONTENT */}
      <div className="flex-1 p-6 bg-white rounded shadow">
        <h2 className="text-2xl font-semibold text-green-700 mb-4">
          Dashboard Produksi Hasil Panen (Tahun: {tahunDipilih})
        </h2>
        {/* Tambahkan input untuk tahun jika Anda ingin membuatnya dinamis */}
        <div className="mb-4">
            <label className="mr-2 font-medium">Pilih Tahun Data:</label>
            <input 
                type="number"
                value={tahunDipilih}
                onChange={(e) => setTahunDipilih(Number(e.target.value))}
                className="border p-1 rounded w-24"
            />
        </div>
        {renderTable()}
      </div>
    </div>
  );
};

export default AnalisisStatistik;