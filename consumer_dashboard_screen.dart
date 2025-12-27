import 'package:flutter/material.dart';
import 'checkout_screen.dart';
import 'farmer_notification_screen.dart';

class ConsumerDashboard extends StatefulWidget {
  const ConsumerDashboard({super.key});

  @override
  State<ConsumerDashboard> createState() => _ConsumerDashboardState();
}

class _ConsumerDashboardState extends State<ConsumerDashboard> {
  int _currentIndex = 0;
  bool _isEditing = false;

  final TextEditingController _nameController = TextEditingController(text: "Budi Santoso");
  final TextEditingController _emailController = TextEditingController(text: "budi.santoso@email.com");
  final TextEditingController _phoneController = TextEditingController(text: "081234567890");

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      _buildHomeScreen(),
      const Center(child: Text("Halaman Chat")),
      const FarmerNotificationScreen(farmerName: "Pak Slamet"), 
      _buildProfilePage(),
    ];

    return Scaffold(
      appBar: _currentIndex == 0 ? _buildMarketAppBar() : (_currentIndex == 3 ? _buildProfileAppBar() : null),
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green[800],
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.eco), label: "Market"),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chat"),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: "Transaksi"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Akun"),
        ],
      ),
    );
  }

  Widget _buildHomeScreen() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWalletSection(),
          _buildCategorySection(),
          _buildSectionHeader("Tanaman Obat Segar"),
          _buildProductList(true),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildProductList(bool isPlant) {
    return SizedBox(
      height: 310, 
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 16),
        itemCount: 2, 
        itemBuilder: (context, index) {
          // --- TAMBAHAN LOGIKA AKUN PETANI PATEN ---
          List<String> names = ["Ibu Sarah", "Pak Slamet"];
          String currentFarmer = names[index];
          // Email otomatis dipatenkan agar notifikasi masuk ke akun yang benar
          String generatedEmail = "${currentFarmer.replaceAll(' ', '').toLowerCase()}petani@gmail.com";
          // -----------------------------------------
          
          return Container(
            width: 170,
            margin: const EdgeInsets.only(right: 12, bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 120,
                  width: double.infinity,
                  decoration: const BoxDecoration(color: Color(0xFFE8F5E9), borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
                  child: Icon(isPlant ? Icons.eco : Icons.handyman, color: Colors.green, size: 50),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(isPlant ? "Jahe Merah" : "Alat Kebun", style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text("Petani: $currentFarmer", style: const TextStyle(fontSize: 11, color: Colors.grey)),
                      const SizedBox(height: 8),
                      const Text("Rp25.000", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green, minimumSize: const Size(double.infinity, 36)),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CheckoutScreen(
                            productName: isPlant ? "Jahe Merah" : "Alat Kebun",
                            price: "Rp25.000",
                            farmerName: currentFarmer,
                            farmerEmail: generatedEmail, // Data email paten dikirim ke checkout
                          )));
                        },
                        child: const Text("Beli", style: TextStyle(color: Colors.white)),
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

  Widget _buildProfilePage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const CircleAvatar(radius: 50, backgroundColor: Colors.green, child: Icon(Icons.person, size: 60, color: Colors.white)),
          const SizedBox(height: 30),
          _buildEditField("Nama Lengkap", _nameController, Icons.person),
          _buildEditField("Email", _emailController, Icons.email),
          _buildEditField("No HP", _phoneController, Icons.phone),
          if (_isEditing)
            Padding(
              padding: const EdgeInsets.only(top: 20), // Perbaikan dari gambar error VS Code Anda
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () {
                    setState(() => _isEditing = false);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Berhasil disimpan")));
                  },
                  child: const Text("Simpan", style: TextStyle(color: Colors.white)),
                ),
              ),
            )
        ],
      ),
    );
  }

  Widget _buildEditField(String l, TextEditingController c, IconData i) => Padding(
    padding: const EdgeInsets.only(bottom: 15),
    child: TextField(controller: c, enabled: _isEditing, decoration: InputDecoration(labelText: l, prefixIcon: Icon(i), border: const OutlineInputBorder())),
  );

  PreferredSizeWidget _buildMarketAppBar() => AppBar(title: const Text("Market Tanaman Obat"), backgroundColor: Colors.white, foregroundColor: Colors.black, elevation: 0);
  PreferredSizeWidget _buildProfileAppBar() => AppBar(title: const Text("Akun"), actions: [IconButton(icon: Icon(_isEditing ? Icons.close : Icons.edit), onPressed: () => setState(() => _isEditing = !_isEditing))]);
  Widget _buildWalletSection() => Container(margin: const EdgeInsets.all(16), padding: const EdgeInsets.all(16), decoration: BoxDecoration(gradient: const LinearGradient(colors: [Colors.green, Colors.lightGreen]), borderRadius: BorderRadius.circular(10)), child: const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("Saldo E-Wallet", style: TextStyle(color: Colors.white)), Text("Rp500.000", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))]));
  Widget _buildCategorySection() => const Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [_CatItem(Icons.eco, "Bibit"), _CatItem(Icons.opacity, "Pupuk"), _CatItem(Icons.handyman, "Alat")]);
  Widget _buildSectionHeader(String t) => Padding(padding: const EdgeInsets.all(16), child: Text(t, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)));
}

class _CatItem extends StatelessWidget {
  final IconData icon; final String label;
  const _CatItem(this.icon, this.label);
  @override
  Widget build(BuildContext context) => Column(children: [CircleAvatar(backgroundColor: Colors.green[50], child: Icon(icon, color: Colors.green)), Text(label, style: const TextStyle(fontSize: 12))]);
}