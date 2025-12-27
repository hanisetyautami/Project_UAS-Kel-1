import React, { useEffect, useState } from "react";

function RiwayatLogin() {
  const [history, setHistory] = useState([]);

  // load history dari localStorage
  useEffect(() => {
    const data = JSON.parse(localStorage.getItem("loginHistory")) || [];
    setHistory(data.reverse()); // terbaru di atas
  }, []);

  const handleClear = () => {
    if (window.confirm("Hapus semua riwayat login?")) {
      localStorage.removeItem("loginHistory");
      setHistory([]);
    }
  };

  return (
    <div className="p-6">
      <h1 className="text-2xl font-bold mb-5">Riwayat Login Admin</h1>

      <button
        onClick={handleClear}
        className="mb-4 bg-red-500 hover:bg-red-600 text-white px-3 py-1 rounded"
      >
        Hapus Semua Riwayat
      </button>

      <div className="overflow-x-auto shadow rounded">
        <table className="w-full bg-white">
          <thead className="bg-green-600 text-white">
            <tr>
              <th className="py-2 px-3 text-left">Email</th>
              <th className="py-2 px-3 text-left">Aksi</th>
              <th className="py-2 px-3 text-left">Waktu</th>
            </tr>
          </thead>
          <tbody>
            {history.length === 0 ? (
              <tr>
                <td colSpan="3" className="text-center py-4 text-gray-500">
                  Tidak ada riwayat login.
                </td>
              </tr>
            ) : (
              history.map((item, index) => (
                <tr key={index} className="border-b">
                  <td className="py-2 px-3">{item.email}</td>
                  <td className="py-2 px-3 capitalize">{item.action}</td>
                  <td className="py-2 px-3">{item.time}</td>
                </tr>
              ))
            )}
          </tbody>
        </table>
      </div>
    </div>
  );
}

export default RiwayatLogin;
