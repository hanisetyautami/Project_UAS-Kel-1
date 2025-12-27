import 'package:flutter/material.dart';
import '../widgets/chart_widget.dart'; 
import 'catat_panen_screen.dart'; 
import 'hasil_panen_screen.dart'; 

class DashboardScreen extends StatefulWidget {
  final String userName;
  const DashboardScreen({super.key, required this.userName});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  final Color primaryGreen = const Color(0xFF4CAF50);

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      _buildHomeContent(),   
      _buildSearchContent(), 
      _buildSalesContent(),  
      _buildAccountContent(),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F8E9),
      body: SafeArea(child: pages[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        selectedItemColor: primaryGreen,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ""),
        ],
      ),
    );
  }

  // --- 1. BERANDA (Disesuaikan dengan Gambar 2 + Fitur Notif) ---
  Widget _buildHomeContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Selamat Datang, ${widget.userName}!', 
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
              const CircleAvatar(backgroundColor: Color(0xFFE0E0E0), child: Icon(Icons.person, color: Colors.white)),
            ],
          ),
          const SizedBox(height: 10),
          // Saldo Besar
          const Text('Rp 7.800.000', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
          const Text('Dashboard Petani', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 25),
          
          // Tombol Aksi Utama (Grid Hijau)
          _buildActionButtons(),
          
          const SizedBox(height: 20),

          // --- FITUR BARU: NOTIFIKASI PESANAN MASUK ---
          // Ini berdiri sendiri, tidak ikut widget consumer/pembeli
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: Colors.yellow.shade100, borderRadius: BorderRadius.circular(10)),
                  child: const Icon(Icons.lightbulb_outline, color: Colors.orange),
                ),
                const SizedBox(width: 15),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Terverifikasi potensi laba 15% dari Jahe", style: TextStyle(fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 15),

          // Notifikasi Pesanan Baru (Dari Gambar 1)
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.green.shade100),
            ),
            child: Row(
              children: [
                const Badge(
                  child: Icon(Icons.shopping_bag_outlined, color: Colors.green, size: 30),
                ),
                const SizedBox(width: 15),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Ada Pesanan Baru!", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("Jahe Merah - Budi Santoso", style: TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () => setState(() => _selectedIndex = 2), // Lari ke tab penjualan
                  child: const Text("PROSES", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                )
              ],
            ),
          ),

          const SizedBox(height: 20),
          
          // Harga Pasar
          _buildMarketPriceCard(),

          const SizedBox(height: 25),
          const Text("Tren Pendapatan Bulanan Terakhir", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          const ChartWidget(),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  // Widget Tambahan: Harga Pasar sesuai desain
  Widget _buildMarketPriceCard() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(10)),
            child: const Icon(Icons.bar_chart, color: Colors.redAccent),
          ),
          const SizedBox(width: 15),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Harga Pasar Komoditas (Minggu ini)", style: TextStyle(fontSize: 13)),
              Text("Jahe Merah • Rp 14,500/Kg", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
            ],
          )
        ],
      ),
    );
  }

  // --- HELPER WIDGETS (TETAP SAMA DENGAN PENYESUAIAN STYLE) ---

  Widget _buildActionButtons() {
    return Row(
      children: [
        _actionBtn(Icons.calculate_outlined, "CATAT PANEN BARU", () => Navigator.push(context, MaterialPageRoute(builder: (c) => const CatatPanenScreen()))),
        const SizedBox(width: 15),
        _actionBtn(Icons.inventory_2_outlined, "HASIL PANEN", () => Navigator.push(context, MaterialPageRoute(builder: (c) => const HasilPanenScreen()))),
      ],
    );
  }

  Widget _actionBtn(IconData icon, String label, VoidCallback onTap) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 100,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(color: primaryGreen, borderRadius: BorderRadius.circular(15)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 30), 
              const SizedBox(height: 8), 
              Text(label, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold))
            ],
          ),
        ),
      ),
    );
  }

  // Widget konten lainnya (Search, Sales, Account) tetap menggunakan logika Anda yang lama
  Widget _buildSearchContent() => Center(child: Text("Monitoring Tanaman"));
  Widget _buildSalesContent() => Center(child: Text("Riwayat Penjualan"));
  Widget _buildAccountContent() => Center(child: Text("Profil Pengguna"));
}