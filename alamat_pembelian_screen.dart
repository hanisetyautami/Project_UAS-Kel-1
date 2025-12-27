import 'package:flutter/material.dart';

class AlamatPembelianScreen extends StatefulWidget {
  const AlamatPembelianScreen({super.key});

  @override
  _AlamatPembelianPageState createState() => _AlamatPembelianPageState();
}

class _AlamatPembelianPageState extends State<AlamatPembelianScreen> {
  // Simulasi data dari akun login
  final String namaAkunLogin = "Budi Santoso"; 

  // Controller untuk input yang bisa diubah
  final TextEditingController _namaPenerimaController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Set default nama penerima sama dengan nama akun saat pertama buka
    _namaPenerimaController.text = namaAkunLogin;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Konfirmasi Alamat")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // FIELD NAMA PEMESAN (Terkunci/Read-only)
            Text("Nama Pemesan (Akun)", style: TextStyle(fontWeight: FontWeight.bold)),
            TextFormField(
              initialValue: namaAkunLogin,
              enabled: false, // Membuat field tidak bisa diedit
              decoration: InputDecoration(
                fillColor: Colors.grey[200],
                filled: true,
                prefixIcon: Icon(Icons.person),
              ),
            ),
            
            SizedBox(height: 20),

            // FIELD NAMA PENERIMA (Bisa diubah)
            Text("Nama Penerima di Lokasi", style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              controller: _namaPenerimaController,
              decoration: InputDecoration(
                hintText: "Masukkan nama penerima",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 20),

            // FIELD ALAMAT (Bisa diubah)
            Text("Alamat Lengkap Pengiriman", style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              controller: _alamatController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "Contoh: Jl. Anggrek No. 12, Jakarta",
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                // Proses data yang dikirim
                print("Pemesan: $namaAkunLogin");
                print("Penerima: ${_namaPenerimaController.text}");
                print("Alamat: ${_alamatController.text}");
              },
              child: Center(child: Text("Simpan & Lanjutkan")),
            )
          ],
        ),
      ),
    );
  }
}