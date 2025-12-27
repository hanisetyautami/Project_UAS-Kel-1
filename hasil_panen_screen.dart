import 'package:flutter/material.dart';

class HasilPanenScreen extends StatefulWidget {
  const HasilPanenScreen({super.key});

  @override
  State<HasilPanenScreen> createState() => _HasilPanenScreenState();
}

class _HasilPanenScreenState extends State<HasilPanenScreen> {
  // Data simulasi hasil panen
  final List<Map<String, dynamic>> _dataPanen = [
    {'komoditas': 'Jahe Merah', 'berat': '150 Kg', 'tanggal': '12 Des 2023', 'status': 'Terjual'},
    {'komoditas': 'Kunyit', 'berat': '80 Kg', 'tanggal': '10 Des 2023', 'status': 'Gudang'},
    {'komoditas': 'Jahe Gajah', 'berat': '210 Kg', 'tanggal': '05 Des 2023', 'status': 'Terjual'},
    {'komoditas': 'Temulawak', 'berat': '45 Kg', 'tanggal': '01 Des 2023', 'status': 'Proses'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F8E9), // Light Green
      appBar: AppBar(
        title: const Text("Riwayat Hasil Panen"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Bar Pencarian Responsif
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Cari riwayat panen...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // Daftar Kartu Hasil Panen
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              itemCount: _dataPanen.length,
              itemBuilder: (context, index) {
                final item = _dataPanen[index];
                return _buildPanenCard(item);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPanenCard(Map<String, dynamic> item) {
    Color statusColor;
    switch (item['status']) {
      case 'Terjual': statusColor = Colors.green; break;
      case 'Gudang': statusColor = Colors.orange; break;
      default: statusColor = Colors.blue;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(15),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFF4CAF50).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.eco, color: Color(0xFF4CAF50)),
        ),
        title: Text(
          item['komoditas'],
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Text("Berat: ${item['berat']} | ${item['tanggal']}"),
            const SizedBox(height: 5),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                item['status'],
                style: TextStyle(color: statusColor, fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: () {
          // Logika untuk melihat detail panen jika diperlukan
        },
      ),
    );
  }
}