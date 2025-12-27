import 'package:flutter/material.dart';

void main() {
  runApp(const AgriApp());
}

class AgriApp extends StatelessWidget {
  const AgriApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green, useMaterial3: true),
      home: const RoleSelectionPage(),
    );
  }
}

// --- 1. HALAMAN PEMILIHAN PERAN (LOGIN SIMULATION) ---
class RoleSelectionPage extends StatelessWidget {
  const RoleSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.eco, size: 80, color: Colors.green),
            const SizedBox(height: 20),
            const Text("Masuk Sebagai", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            _roleButton(context, "PETANI", Colors.green, () {
              Navigator.push(context, MaterialPageRoute(builder: (c) => const FarmerDashboard(userName: "Pak Slamet")));
            }),
            const SizedBox(height: 15),
            _roleButton(context, "KONSUMEN", Colors.orange, () {
              Navigator.push(context, MaterialPageRoute(builder: (c) => const ConsumerDashboard()));
            }),
          ],
        ),
      ),
    );
  }

  Widget _roleButton(BuildContext context, String label, Color color, VoidCallback onTap) {
    return SizedBox(
      width: 250,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: color, foregroundColor: Colors.white),
        onPressed: onTap,
        child: Text(label),
      ),
    );
  }
}

// --- 2. DASHBOARD PETANI ---
class FarmerDashboard extends StatefulWidget {
  final String userName;
  const FarmerDashboard({super.key, required this.userName});

  @override
  State<FarmerDashboard> createState() => _FarmerDashboardState();
}

class _FarmerDashboardState extends State<FarmerDashboard> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      _buildFarmerHome(),
      const Center(child: Text("Monitoring Tanaman")),
      const Center(child: Text("Riwayat Penjualan")),
      const Center(child: Text("Profil Petani")),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F8E9),
      body: SafeArea(child: pages[_index]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Beranda"),
          BottomNavigationBarItem(icon: Icon(Icons.analytics), label: "Monitoring"),
          BottomNavigationBarItem(icon: Icon(Icons.receipt), label: "Sales"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Akun"),
        ],
      ),
    );
  }

  Widget _buildFarmerHome() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Halo, ${widget.userName}!", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              IconButton(icon: const Icon(Icons.logout), onPressed: () => Navigator.pop(context)),
            ],
          ),
          const Text("Rp 7.800.000", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
          const Text("Total Pendapatan Panen", style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 25),
          Row(
            children: [
              _actionCard(Icons.add_task, "CATAT PANEN"),
              const SizedBox(width: 15),
              _actionCard(Icons.inventory, "STOK HASIL"),
            ],
          ),
          const SizedBox(height: 20),
          const Text("Pesanan Masuk", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _notifCard("Jahe Merah", "Dipesan oleh Budi Santoso"),
        ],
      ),
    );
  }

  Widget _actionCard(IconData icon, String label) {
    return Expanded(
      child: Container(
        height: 100,
        decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 30),
            const SizedBox(height: 5),
            Text(label, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _notifCard(String item, String desc) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          const Icon(Icons.shopping_bag, color: Colors.green),
          const SizedBox(width: 15),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(item, style: const TextStyle(fontWeight: FontWeight.bold)), Text(desc, style: const TextStyle(fontSize: 12))])),
          const Text("TERIMA", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

// --- 3. DASHBOARD KONSUMEN ---
class ConsumerDashboard extends StatefulWidget {
  const ConsumerDashboard({super.key});

  @override
  State<ConsumerDashboard> createState() => _ConsumerDashboardState();
}

class _ConsumerDashboardState extends State<ConsumerDashboard> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      _buildMarketContent(),
      const Center(child: Text("Halaman Chat")),
      const Center(child: Text("Transaksi Saya")),
      const Center(child: Text("Profil Konsumen")),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Market Tanaman Obat"),
        actions: [IconButton(icon: const Icon(Icons.logout), onPressed: () => Navigator.pop(context))],
      ),
      body: pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        selectedItemColor: Colors.orange,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.store), label: "Market"),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chat"),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: "Pesanan"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Akun"),
        ],
      ),
    );
  }

  Widget _buildMarketContent() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildProductCard("Jahe Merah Segar", "Pak Slamet", "Rp 25.000"),
        const SizedBox(height: 10),
        _buildProductCard("Kunyit Organik", "Ibu Sarah", "Rp 15.000"),
      ],
    );
  }

  Widget _buildProductCard(String name, String farmer, String price) {
    return Card(
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.eco)),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("Petani: $farmer\n$price"),
        isThreeLine: true,
        trailing: ElevatedButton(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (c) => CheckoutPage(productName: name, farmerName: farmer))),
          child: const Text("Beli"),
        ),
      ),
    );
  }
}

// --- 4. HALAMAN CHECKOUT (DENGAN LOGIKA ALAMAT DAPAT DIUBAH) ---
class CheckoutPage extends StatefulWidget {
  final String productName;
  final String farmerName;
  const CheckoutPage({super.key, required this.productName, required this.farmerName});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  // Nama Akun Login (Terkunci)
  final String userAccountName = "Budi Santoso";

  // Controller untuk field yang bisa diubah
  final TextEditingController _penerimaController = TextEditingController(text: "Budi Santoso");
  final TextEditingController _alamatController = TextEditingController(text: "Jl. Mawar No. 123, Jakarta");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Checkout")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Detail Produk", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("${widget.productName} dari ${widget.farmerName}"),
            const Divider(height: 30),
            
            // Field Nama Pemesan (Sesuai Akun - Read Only)
            const Text("Nama Pemesan (Akun Login)", style: TextStyle(fontSize: 12, color: Colors.grey)),
            TextFormField(
              initialValue: userAccountName,
              readOnly: true,
              decoration: InputDecoration(filled: true, fillColor: Colors.grey[200], border: const OutlineInputBorder()),
            ),
            
            const SizedBox(height: 15),

            // Field Nama Penerima (Bisa Diubah)
            const Text("Nama Penerima di Alamat", style: TextStyle(fontSize: 12, color: Colors.grey)),
            TextField(
              controller: _penerimaController,
              decoration: const InputDecoration(border: OutlineInputBorder(), hintText: "Masukkan nama penerima"),
            ),

            const SizedBox(height: 15),

            // Field Alamat (Bisa Diubah)
            const Text("Alamat Pengiriman", style: TextStyle(fontSize: 12, color: Colors.grey)),
            TextField(
              controller: _alamatController,
              maxLines: 2,
              decoration: const InputDecoration(border: OutlineInputBorder(), hintText: "Masukkan alamat lengkap"),
            ),

            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Pesanan Berhasil Dikirim!")));
                  Navigator.pop(context);
                },
                child: const Text("KONFIRMASI PEMBELIAN", style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }
}