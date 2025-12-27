import React, { useState } from "react";
import { Link, useNavigate } from "react-router-dom";

function Register() {
  const navigate = useNavigate();
  const [formData, setFormData] = useState({
    name: "",
    email: "",
    password: "",
    confirmPassword: "",
  });

  const handleChange = (e) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  const handleSubmit = (e) => {
    e.preventDefault();

    if (formData.password !== formData.confirmPassword) {
      alert("Password tidak cocok!");
      return;
    }

    const users = JSON.parse(localStorage.getItem("users")) || [];
    const existing = users.find((u) => u.email === formData.email);

    if (existing) {
      alert("Email sudah terdaftar!");
      return;
    }

    users.push({
      name: formData.name,
      email: formData.email,
      password: formData.password,
    });

    localStorage.setItem("users", JSON.stringify(users));
    alert("Registrasi berhasil!");
    navigate("/login");
  };

  return (
    <div className="min-h-screen flex flex-col justify-center items-center bg-gradient-to-r from-indigo-400 to-purple-400">
      <div className="bg-white p-8 rounded-2xl shadow-lg w-full max-w-md">
        <h2 className="text-2xl font-bold text-green-600 mb-4 text-center">
          REGISTRASI
        </h2>
        <form onSubmit={handleSubmit} className="space-y-4">
          <input
            type="text"
            name="name"
            placeholder="Nama Lengkap"
            onChange={handleChange}
            required
            className="w-full border rounded-lg px-3 py-2 focus:ring-2 focus:ring-green-400 outline-none"
          />
          <input
            type="email"
            name="email"
            placeholder="Email"
            onChange={handleChange}
            required
            className="w-full border rounded-lg px-3 py-2 focus:ring-2 focus:ring-green-400 outline-none"
          />
          <input
            type="password"
            name="password"
            placeholder="Password"
            onChange={handleChange}
            required
            className="w-full border rounded-lg px-3 py-2 focus:ring-2 focus:ring-green-400 outline-none"
          />
          <input
            type="password"
            name="confirmPassword"
            placeholder="Konfirmasi Password"
            onChange={handleChange}
            required
            className="w-full border rounded-lg px-3 py-2 focus:ring-2 focus:ring-green-400 outline-none"
          />
          <button
            type="submit"
            className="w-full bg-green-500 text-white py-2 rounded-lg hover:bg-green-600 transition"
          >
            REGISTER
          </button>
        </form>
        <p className="text-center text-sm mt-4">
          Sudah punya akun?{" "}
          <Link to="/login" className="text-green-600 font-semibold">
            Login di sini
          </Link>
        </p>
      </div>
    </div>
  );
}

export default Register;
