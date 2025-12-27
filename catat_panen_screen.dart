import 'package:flutter/material.dart';

class CatatPanenScreen extends StatelessWidget {
  const CatatPanenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Catat Panen Baru")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildInput("Nama Komoditas", "Contoh: Jahe Merah"),
            const SizedBox(height: 15),
            _buildInput("Berat Hasil (Kg)", "0", keyboardType: TextInputType.number),
            const SizedBox(height: 15),
            _buildInput("Lokasi Lahan", "Pilih blok lahan"),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4CAF50),
                minimumSize: const Size(double.infinity, 55),
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text("SIMPAN DATA", style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildInput(String label, String hint, {TextInputType? keyboardType}) {
    return TextFormField(
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(),
      ),
    );
  }
}