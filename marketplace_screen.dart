import 'package:flutter/material.dart';

class ConsumerDashboard extends StatelessWidget {
  const ConsumerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: TextField(
          decoration: InputDecoration(
            hintText: "Cari jahe, kunyit, atau pupuk...",
            prefixIcon: const Icon(Icons.search, color: Colors.green),
            contentPadding: const EdgeInsets.symmetric(vertical: 0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            fillColor: Colors.grey[200],
            filled: true,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black),
            onPressed: () {
              // Menuju halaman Checkout
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWalletSection(),
            _buildCategorySection(),
            _buildSectionHeader("Tanaman Obat Segar", () {}),
            _buildProductList(true), // Produk Tanaman
            _buildSectionHeader("Peralatan Tanam", () {}),
            _buildProductList(false), // Peralatan
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green[800],
        unselectedItemColor: Colors.grey,
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.eco), label: "Market"),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chat Petani"),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: "Transaksi"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Akun"),
        ],
        onTap: (index) {
          // Logika pindah halaman Chat atau Akun
        },
      ),
    );
  }

  // --- KOMPONEN UI ---

  Widget _buildWalletSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.green[700]!, Colors.green[400]!]),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _walletItem(Icons.account_balance_wallet, "Saldo", "Rp500.000"),
          Container(width: 1, height: 30, color: Colors.white24),
          _walletItem(Icons.payment, "Metode", "E-Wallet/ATM"),
        ],
      ),
    );
  }

  Widget _walletItem(IconData icon, String title, String value) {
    return Column(
      children: [
        Row(children: [
          Icon(icon, color: Colors.white, size: 20),
          const SizedBox(width: 8),
          Text(title, style: const TextStyle(color: Colors.white70)),
        ]),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildCategorySection() {
    List<Map<String, dynamic>> categories = [
      {"name": "Bibit", "icon": Icons.grass},
      {"name": "Tanaman", "icon": Icons.local_florist},
      {"name": "Pupuk", "icon": Icons.opacity},
      {"name": "Alat", "icon": Icons.handyman},
    ];

    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.green[50],
                  child: Icon(categories[index]['icon'], color: Colors.green),
                ),
                Text(categories[index]['name'], style: const TextStyle(fontSize: 12)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductList(bool isPlant) {
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 16),
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            width: 150,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[200]!),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                  ),
                  child: Center(child: Icon(isPlant ? Icons.eco : Icons.handyman, size: 40, color: Colors.green)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(isPlant ? "Jahe Merah Unggul" : "Sekop Tanaman", style: const TextStyle(fontWeight: FontWeight.bold)),
                      const Text("Petani: Pak Slamet", style: TextStyle(fontSize: 11, color: Colors.grey)),
                      const SizedBox(height: 8),
                      const Text("Rp25.000", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          minimumSize: const Size(double.infinity, 30),
                        ),
                        onPressed: () {
                          // Logika transaksi / Checkout
                        },
                        child: const Text("Beli", style: TextStyle(fontSize: 12, color: Colors.white)),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(String title, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          GestureDetector(onTap: onTap, child: const Text("Lihat Semua", style: TextStyle(color: Colors.green, fontSize: 12))),
        ],
      ),
    );
  }
}