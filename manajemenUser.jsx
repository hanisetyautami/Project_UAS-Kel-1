import React, { useEffect, useState } from "react";

function ManajemenUser() {
  const [users, setUsers] = useState([]);
  const [formData, setFormData] = useState({
    username: "",
    email: "",
    password: "",
    role: "petani",
  });
  const [editIndex, setEditIndex] = useState(null);

  // Load user dari localStorage
  useEffect(() => {
    const data = JSON.parse(localStorage.getItem("users")) || [];
    setUsers(data);
  }, []);

  // Save ke localStorage
  const saveUsers = (updatedUsers) => {
    setUsers(updatedUsers);
    localStorage.setItem("users", JSON.stringify(updatedUsers));
  };

  // Input handler
  const handleChange = (e) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  // Tambah atau Edit user
  const handleSubmit = (e) => {
    e.preventDefault();

    if (!formData.username || !formData.email || !formData.password) {
      alert("Semua field wajib diisi!");
      return;
    }

    let updatedUsers = [...users];

    if (editIndex !== null) {
      // EDIT MODE
      updatedUsers[editIndex] = formData;
      setEditIndex(null);
    } else {
      // TAMBAH MODE
      updatedUsers.push(formData);
    }

    saveUsers(updatedUsers);

    setFormData({
      username: "",
      email: "",
      password: "",
      role: "petani",
    });
  };

  // Edit User
  const handleEdit = (index) => {
    setFormData(users[index]);
    setEditIndex(index);
  };

  // Hapus User
  const handleDelete = (index) => {
    if (!window.confirm("Yakin hapus user ini?")) return;

    const updatedUsers = users.filter((_, i) => i !== index);
    saveUsers(updatedUsers);
  };

  return (
    <div className="p-6 max-w-4xl mx-auto">
      <h1 className="text-3xl font-bold mb-6">Manajemen User</h1>

      {/* FORM TAMBAH / EDIT */}
      <form
        className="bg-white p-5 rounded shadow-md mb-6"
        onSubmit={handleSubmit}
      >
        <h2 className="text-xl font-semibold mb-4">
          {editIndex !== null ? "Edit User" : "Tambah User"}
        </h2>

        <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
          <input
            type="text"
            name="username"
            placeholder="Username"
            value={formData.username}
            onChange={handleChange}
            className="border p-2 rounded"
          />

          <input
            type="email"
            name="email"
            placeholder="Email"
            value={formData.email}
            onChange={handleChange}
            className="border p-2 rounded"
          />

          <input
            type="password"
            name="password"
            placeholder="Password"
            value={formData.password}
            onChange={handleChange}
            className="border p-2 rounded"
          />

          <select
            name="role"
            value={formData.role}
            onChange={handleChange}
            className="border p-2 rounded"
          >
            <option value="admin">Admin</option>
            <option value="petani">Petani</option>
            <option value="konsumen">Konsumen</option>
          </select>
        </div>

        <button
          type="submit"
          className="mt-4 bg-green-600 text-white px-4 py-2 rounded hover:bg-green-700"
        >
          {editIndex !== null ? "Simpan Perubahan" : "Tambah User"}
        </button>
      </form>

      {/* TABEL USER */}
      <div className="overflow-x-auto bg-white shadow-md rounded">
        <table className="w-full text-left">
          <thead className="bg-green-600 text-white">
            <tr>
              <th className="py-2 px-3">Username</th>
              <th className="py-2 px-3">Email</th>
              <th className="py-2 px-3">Role</th>
              <th className="py-2 px-3 text-center">Aksi</th>
            </tr>
          </thead>

          <tbody>
            {users.length === 0 ? (
              <tr>
                <td colSpan="4" className="text-center py-4 text-gray-500">
                  Belum ada user.
                </td>
              </tr>
            ) : (
              users.map((user, index) => (
                <tr key={index} className="border-b">
                  <td className="py-2 px-3">{user.username}</td>
                  <td className="py-2 px-3">{user.email}</td>
                  <td className="py-2 px-3 capitalize">{user.role}</td>
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

export default ManajemenUser;
