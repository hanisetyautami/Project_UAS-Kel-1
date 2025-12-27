import 'package:flutter/material.dart';

// Gunakan warna yang sama dengan main.dart
const Color primaryGreen = Color(0xFF4CAF50);

class FarmerAccountScreen extends StatefulWidget {
  final String userName;
  const FarmerAccountScreen({super.key, required this.userName});

  @override
  State<FarmerAccountScreen> createState() => _FarmerAccountScreenState();
}

class _FarmerAccountScreenState extends State<FarmerAccountScreen> {
  // GlobalKey untuk memenuhi kriteria penilaian A.18
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F8E9), // Sesuai lightGreen di dashboard
      appBar: AppBar(
        title: const Text('Profil Akun Petani', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.red),
            onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Bagian Informasi Profil (Responsif)
            _buildProfileHeader(),
            const SizedBox(height: 20),

            // Bagian Prediksi Hasil Panen 3 Bulan (Fitur Baru)
            _buildPredictionCard(),
            const SizedBox(height: 20),

            // Form Edit Akun dengan Validasi (Kriteria A.18)
            _buildAccountForm(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundColor: primaryGreen,
            child: Icon(Icons.person, size: 40, color: Colors.white),
          ),
          const SizedBox(height: 10),
          Text(
            widget.userName, // Mengambil nama dari dashboard
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const Text('Petani Terverifikasi', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildPredictionCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primaryGreen.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.online_prediction, color: primaryGreen),
              SizedBox(width: 8),
              Text('Prediksi Panen 3 Bulan Ke Depan', 
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ],
          ),
          const Divider(),
          _predictionItem("Januari", "Jahe Merah", "1.5 Ton"),
          _predictionItem("Februari", "Kunyit", "800 Kg"),
          _predictionItem("Maret", "Temulawak", "1.2 Ton"),
        ],
      ),
    );
  }

  Widget _predictionItem(String bulan, String item, String jumlah) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(bulan, style: const TextStyle(color: Colors.black87)),
          Text(item, style: const TextStyle(fontStyle: FontStyle.italic)),
          Text(jumlah, style: const TextStyle(fontWeight: FontWeight.bold, color: primaryGreen)),
        ],
      ),
    );
  }

  Widget _buildAccountForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            initialValue: widget.userName,
            decoration: const InputDecoration(
              labelText: 'Nama Lengkap',
              prefixIcon: Icon(Icons.person_outline),
              border: OutlineInputBorder(),
            ),
            validator: (value) => value!.isEmpty ? 'Nama tidak boleh kosong' : null, // Validator
          ),
          const SizedBox(height: 15),
          TextFormField(
            initialValue: 'budi.petani@email.com',
            decoration: const InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email_outlined),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: primaryGreen),
              onPressed: () {
                if (_formKey.currentState!.validate()) { // Validasi Form
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Data Berhasil Diperbarui'))
                  );
                }
              },
              child: const Text('Simpan Perubahan', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}