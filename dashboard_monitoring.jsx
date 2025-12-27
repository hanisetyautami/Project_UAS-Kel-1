import React, { useState } from "react";
import {
  FaHome,
  FaUser,
  FaImage,
  FaChartLine,
  FaCalendarAlt,
  FaSignOutAlt,
  FaBars,
  FaPlus,
  FaTrash,
} from "react-icons/fa";
import {
  LineChart,
  Line,
  XAxis,
  YAxis,
  Tooltip,
  ResponsiveContainer,
  CartesianGrid,
} from "recharts";

function DashboardMonitoring() {
  const [activeMenu, setActiveMenu] = useState("Dashboard");
  const [isSidebarOpen, setIsSidebarOpen] = useState(true);

  // === DATA PETANI ===
  const [petaniData, setPetaniData] = useState([
    {
      id: 1,
      nama: "Budi Santoso",
      email: "budi@gmail.com",
      lahan: 3,
      jenis: "Padi",
      alamat: "Desa Sukamaju",
      harga: 3600,
      foto: "",
    },
    {
      id: 2,
      nama: "Siti Aminah",
      email: "siti@gmail.com",
      lahan: 2,
      jenis: "Jagung",
      alamat: "Desa Mekarjaya",
      harga: 2800,
      foto: "",
    },
    {
      id: 3,
      nama: "Jekson",
      email: "jekson@gmail.com",
      lahan: 5,
      jenis: "Kedelai",
      alamat: "Desa Tegalrejo",
      harga: 1200,
      foto: "",
    },
  ]);

  const [petaniBaru, setPetaniBaru] = useState({
    nama: "",
    email: "",
    lahan: "",
    jenis: "",
    alamat: "",
    harga: "",
    foto: "",
  });
  const [searchTerm, setSearchTerm] = useState("");

  // === TAMBAH PETANI ===
  const handleTambahPetani = () => {
    if (
      petaniBaru.nama &&
      petaniBaru.email &&
      petaniBaru.lahan &&
      petaniBaru.jenis &&
      petaniBaru.alamat &&
      petaniBaru.harga
    ) {
      setPetaniData([
        ...petaniData,
        { ...petaniBaru, id: Date.now(), foto: petaniBaru.foto || "" },
      ]);
      setPetaniBaru({
        nama: "",
        email: "",
        lahan: "",
        jenis: "",
        alamat: "",
        harga: "",
        foto: "",
      });
    } else {
      alert("Harap isi semua data petani termasuk harga rata-rata!");
    }
  };

  // === HAPUS PETANI ===
  const handleHapusPetani = (id) =>
    setPetaniData(petaniData.filter((p) => p.id !== id));

  // === FILTER PENCARIAN ===
  const filteredPetani = petaniData.filter((p) =>
    p.nama.toLowerCase().includes(searchTerm.toLowerCase())
  );

  // === DATA GRAFIK HARGA DARI PETANI ===
  const dataGrafik = petaniData.map((p) => ({
    nama: p.nama,
    harga: Number(p.harga),
  }));

  // === DATA GAMBAR TANAMAN ===
  const [tanamanList, setTanamanList] = useState([]);
  const [tanamanBaru, setTanamanBaru] = useState({
    nama: "",
    deskripsi: "",
    gambar: "",
  });

  const handleTambahTanaman = () => {
    if (tanamanBaru.nama && tanamanBaru.deskripsi && tanamanBaru.gambar) {
      setTanamanList([...tanamanList, { ...tanamanBaru, id: Date.now() }]);
      setTanamanBaru({ nama: "", deskripsi: "", gambar: "" });
    }
  };

  const handleHapusTanaman = (id) =>
    setTanamanList(tanamanList.filter((t) => t.id !== id));

  // === DASHBOARD SUMMARY ===
  const totalPetani = petaniData.length;
  const totalLahan = petaniData.reduce((sum, p) => sum + Number(p.lahan), 0);
  const rataHarga =
    totalPetani > 0
      ? (
          petaniData.reduce((sum, p) => sum + Number(p.harga), 0) / totalPetani
        ).toFixed(2)
      : 0;

  // === LOGOUT ===
  const handleLogout = () => {
    alert("Berhasil logout!");
    window.location.href = "/login";
  };

  return (
    <div className="flex min-h-screen bg-gray-100">
      {/* === SIDEBAR === */}
      <div
        className={`${
          isSidebarOpen ? "w-60" : "w-16"
        } bg-green-800 text-white transition-all duration-300 flex flex-col`}
      >
        <div className="flex items-center justify-between px-4 py-3 font-bold text-lg">
          {isSidebarOpen && <span>PETUNGI</span>}
          <button
            onClick={() => setIsSidebarOpen(!isSidebarOpen)}
            className="text-white"
          >
            <FaBars />
          </button>
        </div>

        {/* MENU */}
        <nav className="flex-1">
          {[
            { name: "Dashboard", icon: <FaHome /> },
            { name: "Data Petani", icon: <FaUser /> },
            { name: "Gambar Tanaman", icon: <FaImage /> },
            { name: "Grafik", icon: <FaChartLine /> },
            { name: "Kalender", icon: <FaCalendarAlt /> },
            { name: "Akun", icon: <FaUser /> },
          ].map((item) => (
            <button
              key={item.name}
              onClick={() => setActiveMenu(item.name)}
              className={`flex items-center gap-3 w-full text-left px-4 py-2 hover:bg-green-700 ${
                activeMenu === item.name ? "bg-green-700" : ""
              }`}
            >
              {item.icon}
              {isSidebarOpen && <span>{item.name}</span>}
            </button>
          ))}
        </nav>

        <button
          onClick={handleLogout}
          className="bg-red-600 hover:bg-red-700 flex items-center justify-center gap-2 py-3"
        >
          <FaSignOutAlt /> {isSidebarOpen && "Logout"}
        </button>
      </div>

      {/* === KONTEN UTAMA === */}
      <div className="flex-1 p-5">
        {/* === DASHBOARD === */}
        {activeMenu === "Dashboard" && (
          <div>
            <h2 className="text-xl font-semibold mb-4">Dashboard Monitoring</h2>

            <div className="grid md:grid-cols-3 gap-4 mb-6">
              <div className="bg-white p-4 rounded-xl shadow text-center">
                <p>Jumlah Petani</p>
                <p className="text-green-700 text-xl font-bold">{totalPetani}</p>
              </div>
              <div className="bg-white p-4 rounded-xl shadow text-center">
                <p>Total Lahan</p>
                <p className="text-green-700 text-xl font-bold">{totalLahan} Ha</p>
              </div>
              <div className="bg-white p-4 rounded-xl shadow text-center">
                <p>Rata-rata Harga Panen</p>
                <p className="text-green-700 text-xl font-bold">
                  Rp {rataHarga}
                </p>
              </div>
            </div>

            <div className="bg-white p-4 rounded-xl shadow">
              <h3 className="text-center font-semibold mb-3">
                Grafik Harga Panen per Petani
              </h3>
              <ResponsiveContainer width="100%" height={300}>
                <LineChart data={dataGrafik}>
                  <XAxis dataKey="nama" />
                  <YAxis />
                  <Tooltip />
                  <CartesianGrid strokeDasharray="3 3" />
                  <Line
                    type="monotone"
                    dataKey="harga"
                    stroke="#16a34a"
                    strokeWidth={2}
                    dot={{ r: 5 }}
                  />
                </LineChart>
              </ResponsiveContainer>
            </div>
          </div>
        )}

        {/* === DATA PETANI === */}
        {activeMenu === "Data Petani" && (
          <div>
            <h2 className="text-xl font-semibold mb-4">Data Petani</h2>

            {/* Form Tambah Petani */}
            <div className="bg-white p-4 rounded-xl shadow mb-4">
              <div className="grid md:grid-cols-2 gap-3">
                <input
                  type="text"
                  placeholder="Nama Petani"
                  value={petaniBaru.nama}
                  onChange={(e) =>
                    setPetaniBaru({ ...petaniBaru, nama: e.target.value })
                  }
                  className="border p-2 rounded"
                />
                <input
                  type="email"
                  placeholder="Email"
                  value={petaniBaru.email}
                  onChange={(e) =>
                    setPetaniBaru({ ...petaniBaru, email: e.target.value })
                  }
                  className="border p-2 rounded"
                />
                <input
                  type="number"
                  placeholder="Luas Lahan (Ha)"
                  value={petaniBaru.lahan}
                  onChange={(e) =>
                    setPetaniBaru({ ...petaniBaru, lahan: e.target.value })
                  }
                  className="border p-2 rounded"
                />
                <input
                  type="text"
                  placeholder="Jenis Tanaman"
                  value={petaniBaru.jenis}
                  onChange={(e) =>
                    setPetaniBaru({ ...petaniBaru, jenis: e.target.value })
                  }
                  className="border p-2 rounded"
                />
                <input
                  type="number"
                  placeholder="Harga Rata-rata (Rp/kg)"
                  value={petaniBaru.harga}
                  onChange={(e) =>
                    setPetaniBaru({ ...petaniBaru, harga: e.target.value })
                  }
                  className="border p-2 rounded"
                />
              </div>
              <textarea
                placeholder="Alamat"
                value={petaniBaru.alamat}
                onChange={(e) =>
                  setPetaniBaru({ ...petaniBaru, alamat: e.target.value })
                }
                className="border p-2 rounded w-full my-2"
              />

              <input
                type="file"
                accept="image/*"
                onChange={(e) => {
                  const file = e.target.files[0];
                  if (file) {
                    const fotoURL = URL.createObjectURL(file);
                    setPetaniBaru({ ...petaniBaru, foto: fotoURL });
                  }
                }}
                className="border p-2 rounded w-full mb-3"
              />

              <button
                onClick={handleTambahPetani}
                className="bg-green-700 text-white px-4 py-2 rounded hover:bg-green-800"
              >
                <FaPlus className="inline mr-2" /> Tambah Petani
              </button>
            </div>

            <input
              type="text"
              placeholder="Cari petani..."
              value={searchTerm}
              onChange={(e) => setSearchTerm(e.target.value)}
              className="border p-2 rounded w-full mb-3"
            />

            <div className="overflow-x-auto bg-white rounded-xl shadow p-4">
              <table className="min-w-full border">
                <thead className="bg-green-100">
                  <tr>
                    <th className="p-2 border">Foto</th>
                    <th className="p-2 border">Nama</th>
                    <th className="p-2 border">Email</th>
                    <th className="p-2 border">Luas Lahan</th>
                    <th className="p-2 border">Jenis Tanaman</th>
                    <th className="p-2 border">Harga (Rp/kg)</th>
                    <th className="p-2 border">Alamat</th>
                    <th className="p-2 border">Aksi</th>
                  </tr>
                </thead>
                <tbody>
                  {filteredPetani.map((p) => (
                    <tr key={p.id}>
                      <td className="border p-2 text-center">
                        {p.foto ? (
                          <img
                            src={p.foto}
                            alt="foto petani"
                            className="w-10 h-10 rounded-full mx-auto object-cover"
                          />
                        ) : (
                          <div className="w-10 h-10 bg-gray-300 rounded-full mx-auto" />
                        )}
                      </td>
                      <td className="border p-2">{p.nama}</td>
                      <td className="border p-2">{p.email}</td>
                      <td className="border p-2 text-center">{p.lahan}</td>
                      <td className="border p-2 text-center">{p.jenis}</td>
                      <td className="border p-2 text-center">{p.harga}</td>
                      <td className="border p-2">{p.alamat}</td>
                      <td className="border p-2 text-center">
                        <button
                          onClick={() => handleHapusPetani(p.id)}
                          className="text-red-600 hover:text-red-800"
                        >
                          <FaTrash />
                        </button>
                      </td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </div>
        )}

        {/* === GRAFIK TERPISAH === */}
        {activeMenu === "Grafik" && (
          <div className="bg-white p-6 rounded-xl shadow">
            <h2 className="text-xl font-semibold mb-4 text-center">
              Grafik Harga Panen
            </h2>
            <ResponsiveContainer width="100%" height={400}>
              <LineChart data={dataGrafik}>
                <XAxis dataKey="nama" />
                <YAxis />
                <Tooltip />
                <CartesianGrid strokeDasharray="3 3" />
                <Line
                  type="monotone"
                  dataKey="harga"
                  stroke="#16a34a"
                  strokeWidth={2}
                  dot={{ r: 6 }}
                />
              </LineChart>
            </ResponsiveContainer>
          </div>
        )}

        {/* === AKUN ADMIN === */}
        {activeMenu === "Akun" && (
          <div className="bg-white p-6 rounded-xl shadow">
            <h2 className="text-xl font-semibold mb-4">Akun Admin</h2>
            <p>Total Petani: {totalPetani}</p>
            <p>Total Lahan: {totalLahan} Ha</p>
            <p>Rata-rata Harga Panen: Rp {rataHarga}</p>
          </div>
        )}

        {/* === GAMBAR TANAMAN === */}
        {activeMenu === "Gambar Tanaman" && (
          <div>
            <h2 className="text-xl font-semibold mb-4">Gambar Tanaman</h2>
            <div className="bg-white p-4 rounded-xl shadow mb-4">
              <input
                type="text"
                placeholder="Nama Tanaman"
                value={tanamanBaru.nama}
                onChange={(e) =>
                  setTanamanBaru({ ...tanamanBaru, nama: e.target.value })
                }
                className="border p-2 rounded w-full mb-2"
              />
              <textarea
                placeholder="Deskripsi Tanaman"
                value={tanamanBaru.deskripsi}
                onChange={(e) =>
                  setTanamanBaru({ ...tanamanBaru, deskripsi: e.target.value })
                }
                className="border p-2 rounded w-full mb-2"
              />
              <input
                type="file"
                accept="image/*"
                onChange={(e) => {
                  const file = e.target.files[0];
                  if (file) {
                    const imageURL = URL.createObjectURL(file);
                    setTanamanBaru({ ...tanamanBaru, gambar: imageURL });
                  }
                }}
                className="border p-2 rounded w-full mb-2"
              />
              {tanamanBaru.gambar && (
                <img
                  src={tanamanBaru.gambar}
                  alt="Preview"
                  className="w-40 h-40 object-cover rounded mb-3 mx-auto"
                />
              )}
              <button
                onClick={handleTambahTanaman}
                className="bg-green-700 text-white px-4 py-2 rounded hover:bg-green-800"
              >
                <FaPlus className="inline mr-2" /> Tambah Tanaman
              </button>
            </div>

            <div className="grid md:grid-cols-3 gap-4">
              {tanamanList.map((t) => (
                <div
                  key={t.id}
                  className="bg-white rounded-xl shadow p-4 relative"
                >
                  <img
                    src={t.gambar}
                    alt={t.nama}
                    className="w-full h-40 object-cover rounded mb-2"
                  />
                  <h3 className="font-semibold">{t.nama}</h3>
                  <p className="text-sm text-gray-600 mb-2">{t.deskripsi}</p>
                  <button
                    onClick={() => handleHapusTanaman(t.id)}
                    className="absolute top-2 right-2 text-red-600 hover:text-red-800"
                  >
                    <FaTrash />
                  </button>
                </div>
              ))}
            </div>
          </div>
        )}

        {/* === KALENDER === */}
        {activeMenu === "Kalender" && (
          <div className="bg-white p-6 rounded-xl shadow">
            <h2 className="text-xl font-semibold mb-4">Kalender Tanam</h2>
            <iframe
              title="Kalender Google"
              src="https://calendar.google.com/calendar/embed?src=en.indonesian%23holiday%40group.v.calendar.google.com&ctz=Asia%2FJakarta"
              className="w-full h-[600px] border-0 rounded-xl"
            />
          </div>
        )}
      </div>
    </div>
  );
}

export default DashboardMonitoring;
