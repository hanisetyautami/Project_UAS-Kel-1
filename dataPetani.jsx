import React, { useEffect, useState } from "react";

function DataPetani() {
  const [petani, setPetani] = useState([]);
  const [formData, setFormData] = useState({
    nama: "",
    alamat: "",
    komoditas: "",
    luasLahan: "",
  });
  const [editIndex, setEditIndex] = useState(null);

  // Load data petani dari localStorage
  useEffect(() => {
    const data = JSON.parse(localStorage.getItem("dataPetani")) || [];
    setPetani(data);
  }, []);

  // Save data ke localStorage
  const saveData = (updated) => {
    setPetani(updated);
    localStorage.setItem("dataPetani", JSON.stringify(updated));
  };

  // Handle input perubahan
  const handleChange = (e) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  // Tambah / Edit petani
  const handleSubmit = (e) => {
    e.preventDefault();

    if (!formData.nama || !formData.alamat || !formData.komoditas) {
      alert("Semua field wajib diisi!");
      return;
    }

    let updatedData = [...petani];

    if (editIndex !== null) {
      // Mode edit
      updatedData[editIndex] = formData;
      setEditIndex(null);
    } else {
      // Mode tambah
      updatedData.push(formData);
    }

    saveData(updatedData);

    setFormData({
      nama: "",
      alamat: "",
      komoditas: "",
      luasLahan: "",
    });
  };

  // Edit
  const handleEdit = (index) => {
    setFormData(petani[index]);
    setEditIndex(index);
  };

  // Hapus
  const handleDelete = (index) => {
    if (!window.confirm("Yakin ingin menghapus data ini?")) return;

    const updated = petani.filter((_, i) => i !== index);
    saveData(updated);
  };

  return (
    <div className="p-6 max-w-5xl mx-auto">
      <h1 className="text-3xl font-bold mb-6">Data Petani</h1>

      {/* FORM */}
      <form
        onSubmit={handleSubmit}
        className="bg-white p-5 rounded shadow-md mb-6"
      >
        <h2 className="text-xl font-semibold mb-4">
          {editIndex !== null ? "Edit Data Petani" : "Tambah Data Petani"}
        </h2>

        <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
          <input
            type="text"
            name="nama"
            placeholder="Nama Petani"
            value={formData.nama}
            onChange={handleChange}
            className="border p-2 rounded"
          />

          <input
            type="text"
            name="alamat"
            placeholder="Alamat"
            value={formData.alamat}
            onChange={handleChange}
            className="border p-2 rounded"
          />

          <input
            type="text"
            name="komoditas"
            placeholder="Komoditas (contoh: Cabai, Tomat)"
            value={formData.komoditas}
            onChange={handleChange}
            className="border p-2 rounded"
          />

          <input
            type="number"
            name="luasLahan"
            placeholder="Luas Lahan (m²)"
            value={formData.luasLahan}
            onChange={handleChange}
            className="border p-2 rounded"
          />
        </div>

        <button
          type="submit"
          className="mt-4 bg-green-600 text-white px-4 py-2 rounded hover:bg-green-700"
        >
          {editIndex !== null ? "Simpan Perubahan" : "Tambah Petani"}
        </button>
      </form>

      {/* TABEL */}
      <div className="overflow-x-auto bg-white shadow-md rounded">
        <table className="w-full text-left">
          <thead className="bg-green-600 text-white">
            <tr>
              <th className="py-2 px-3">Nama</th>
              <th className="py-2 px-3">Alamat</th>
              <th className="py-2 px-3">Komoditas</th>
              <th className="py-2 px-3">Luas Lahan (m²)</th>
              <th className="py-2 px-3 text-center">Aksi</th>
            </tr>
          </thead>

          <tbody>
            {petani.length === 0 ? (
              <tr>
                <td colSpan="5" className="text-center py-4 text-gray-500">
                  Belum ada data petani.
                </td>
              </tr>
            ) : (
              petani.map((p, index) => (
                <tr key={index} className="border-b">
                  <td className="py-2 px-3">{p.nama}</td>
                  <td className="py-2 px-3">{p.alamat}</td>
                  <td className="py-2 px-3">{p.komoditas}</td>
                  <td className="py-2 px-3">{p.luasLahan || "-"}</td>
                  <td className="py-2 px-3 text-center">
                    <button
                      onClick={() => handleEdit(index)}
                      className="bg-blue-500 text-white px-3 py-1 rounded mr-2 hover:bg-blue-600"
                    >
                      Edit
                    </button>
                    <button
                      onClick={() => handleDelete(index)}
                      className="bg-red-500 text-white px-3 py-1 rounded hover:bg-red-600"
                    >
                      Hapus
                    </button>
                  </td>
                </tr>
              ))
            )}
          </tbody>
        </table>
      </div>
    </div>
  );
}

export default DataPetani;
