import React, { useState, useEffect } from "react";
import axios from "axios";

const AnalisisStatistik = () => {
  const [dataHasilPanen, setDataHasilPanen] = useState([]);
  const [tahunDipilih, setTahunDipilih] = useState(2019);
  const [error, setError] = useState(null);

  useEffect(() => {
    const fetchData = async () => {
      try {
        setError(null);
        // FIX: Gunakan IP laptop Anda jika localhost gagal. 
        // Contoh: http://192.168.56.1:5000/api/statistik/${tahunDipilih}
        const response = await axios.get(`http://localhost:5000/api/statistik/${tahunDipilih}`);
        
        setDataHasilPanen(response.data);
      } catch (err) {
        console.error("Koneksi BE Gagal:", err);
        setError("Gagal terhubung ke Server Flask. Pastikan Backend sudah dijalankan.");
      }
    };
    fetchData();
  }, [tahunDipilih]);

  return (
    <div className="p-6">
      <h2 className="text-2xl font-bold text-green-700">Dashboard Produksi ({tahunDipilih})</h2>
      
      {/* Input Tahun */}
      <div className="my-4">
        <label>Pilih Tahun: </label>
        <input 
          type="number" 
          value={tahunDipilih} 
          onChange={(e) => setTahunDipilih(e.target.value)}
          className="border p-1 rounded"
        />
      </div>

      {error ? (
        <p className="text-red-600 bg-red-100 p-3 rounded border border-red-400">{error}</p>
      ) : (
        <table className="w-full border-collapse border">
          <thead className="bg-green-700 text-white">
            <tr>
              <th className="border p-2">Komoditas</th>
              <th className="border p-2">Luas Lahan</th>
              <th className="border p-2">Produksi (Ton)</th>
            </tr>
          </thead>
          <tbody>
            {dataHasilPanen.map((item, index) => (
              <tr key={index} className="text-center">
                <td className="border p-2">{item.komoditas}</td>
                <td className="border p-2">{item.luas_lahan} Ha</td>
                <td className="border p-2">{item.produksi} Ton</td>
              </tr>
            ))}
          </tbody>
        </table>
      )}
    </div>
  );
};

export default AnalisisStatistik;