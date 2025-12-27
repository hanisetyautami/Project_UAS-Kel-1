import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
  final String productName;
  final String price;
  final String farmerName;
  final String farmerEmail; // 1. Tambahkan variabel penampung email

  const CheckoutScreen({
    super.key, 
    required this.productName, 
    required this.price, 
    required this.farmerName,
    required this.farmerEmail // 2. Tambahkan di constructor
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String selectedPayment = "Pilih Metode Pembayaran";

  // Fungsi Simulasi Notifikasi ke Petani
  void _sendNotificationToFarmer() {
    // Sekarang menggunakan widget.farmerEmail untuk tujuan pengiriman
    print("SISTEM: Mengirim sinyal notifikasi ke API...");
    print("TUJUAN NOTIFIKASI: Akun ${widget.farmerEmail}"); 
    print("PESAN: Pesanan baru ${widget.productName} dari konsumen telah masuk.");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout", style: TextStyle(color: Colors.black, fontSize: 18)),
        backgroundColor: Colors.white,
        elevation: 0.5,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildInfoTile(Icons.location_on, "Alamat Pengiriman", "Budi Santoso | 081234567890\nJl. Herbal No. 123, Sukabumi"),
            const Divider(thickness: 8, color: Color(0xFFF5F5F5)),
            
            // Detail Produk & Nama Petani
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.store, size: 18, color: Colors.green),
                      const SizedBox(width: 8),
                      // Menampilkan Nama Petani dan Email-nya secara transparan
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Petani: ${widget.farmerName}", style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                          Text(widget.farmerEmail, style: const TextStyle(fontSize: 10, color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildProductCard(),
                ],
              ),
            ),
            
            const Divider(thickness: 8, color: Color(0xFFF5F5F5)),
            _buildPaymentPickerTile(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  // --- Widget Button Buat Pesanan ---
  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: Colors.black12))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Total Tagihan"),
              Text(widget.price, style: const TextStyle(fontSize: 18, color: Colors.orange, fontWeight: FontWeight.bold)),
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange[800], padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12)),
            onPressed: selectedPayment.contains("Pilih") ? null : () {
              _sendNotificationToFarmer(); // Sekarang mengirim ke email yang tepat
              _showSuccess();
            },
            child: const Text("Buat Pesanan", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _showSuccess() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 70),
            const SizedBox(height: 15),
            const Text("Pembayaran Berhasil!", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 8),
            // Informasi konfirmasi tujuan notifikasi
            Text("Pesanan telah diteruskan ke ${widget.farmerName}.", textAlign: TextAlign.center),
            Text("(${widget.farmerEmail})", style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
        actions: [
          Center(child: TextButton(onPressed: () => Navigator.popUntil(context, (route) => route.isFirst), child: const Text("OK"))),
        ],
      ),
    );
  }

  // Widget pendukung tetap dipertahankan
  Widget _buildProductCard() {
    return Row(
      children: [
        Container(width: 70, height: 70, decoration: BoxDecoration(color: Colors.green[50], borderRadius: BorderRadius.circular(8)), child: const Icon(Icons.eco, color: Colors.green)),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.productName, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(widget.price, style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        const Text("x1"),
      ],
    );
  }

  Widget _buildInfoTile(IconData icon, String title, String sub) => ListTile(leading: Icon(icon, color: Colors.green), title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)), subtitle: Text(sub));

  Widget _buildPaymentPickerTile() {
    return ListTile(
      leading: const Icon(Icons.payment, color: Colors.green),
      title: const Text("Metode Pembayaran"),
      subtitle: Text(selectedPayment, style: TextStyle(color: selectedPayment.contains("Pilih") ? Colors.red : Colors.black)),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(title: const Text("VA Mandiri/BCA"), onTap: () { setState(() => selectedPayment = "VA ATM"); Navigator.pop(context); }),
              ListTile(title: const Text("E-Money (Dana/OVO)"), onTap: () { setState(() => selectedPayment = "E-Money"); Navigator.pop(context); }),
            ],
          ),
        );
      },
    );
  }
}