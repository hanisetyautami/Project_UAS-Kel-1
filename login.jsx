import React, { useState } from "react";
import { Link, useNavigate } from "react-router-dom";

function Login() {
  const navigate = useNavigate();
  const [formData, setFormData] = useState({
    username: "",
    password: "",
  });

  const handleChange = (e) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    const users = JSON.parse(localStorage.getItem("users")) || [];

    // Bisa login pakai email ATAU username
    const user = users.find(
      (u) =>
        (u.email === formData.username || u.username === formData.username) &&
        u.password === formData.password
    );

    if (user) {
      // Simpan user ke localStorage
      localStorage.setItem("loggedInUser", JSON.stringify(user));

      // ================================
      //     SIMPAN RIWAYAT LOGIN
      // ================================
      const history = JSON.parse(localStorage.getItem("loginHistory")) || [];
      history.push({
        email: user.email,
        action: "login",
        time: new Date().toLocaleString(),
      });
      localStorage.setItem("loginHistory", JSON.stringify(history));

      alert("Login berhasil!");
      navigate("/dashboard");
    } else {
      alert("Username atau password salah!");
    }
  };

  return (
    <div className="min-h-screen flex flex-col justify-center items-center bg-gradient-to-r from-blue-400 to-green-400 px-4">
      <div className="bg-white p-8 rounded-2xl shadow-lg w-full max-w-md">
        <h2 className="text-2xl font-bold text-green-600 mb-2 text-center">
          LOGIN ADMIN
        </h2>
        <p className="text-center text-gray-500 mb-6">
          Masuk ke dashboard administrasi
        </p>

        <form onSubmit={handleSubmit} className="space-y-4">
          <div>
            <label className="block font-semibold mb-1">Email atau Username</label>
            <input
              type="text"
              name="username"
              placeholder="Masukkan email atau username Anda"
              onChange={handleChange}
              required
              className="w-full border rounded-lg px-3 py-2 focus:ring-2 focus:ring-green-400 outline-none"
            />
          </div>

          <div>
            <label className="block font-semibold mb-1">Password</label>
            <input
              type="password"
              name="password"
              placeholder="Masukkan password Anda"
              onChange={handleChange}
              required
              className="w-full border rounded-lg px-3 py-2 focus:ring-2 focus:ring-green-400 outline-none"
            />
          </div>

          <button
            type="submit"
            className="w-full bg-green-500 text-white py-2 rounded-lg hover:bg-green-600 transition font-semibold"
          >
            LOGIN
          </button>
        </form>

        <p className="text-center text-sm mt-4">
          Belum punya akun?{" "}
          <Link to="/register" className="text-green-600 font-semibold">
            Daftar di sini
          </Link>
        </p>
      </div>
    </div>
  );
}

export default Login;
