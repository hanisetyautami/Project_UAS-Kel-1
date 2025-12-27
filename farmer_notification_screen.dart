import 'package:flutter/material.dart';

class FarmerNotificationScreen extends StatelessWidget {
  final String farmerName;

  const FarmerNotificationScreen({super.key, required this.farmerName});

  @override
  Widget build(BuildContext context) {
    // Simulasi data pesanan yang masuk ke petani tertentu
    final List<Map<String, String>> orders = [
      {
        "product": "Jahe Merah Unggul",
        "buyer": "Budi Santoso",
        "date": "18 Des 2025",
        "status": "Perlu Dikirim",
        "price": "Rp25.000"
      },
      {
        "product": "Pupuk Organik Cair",
        "buyer": "Siti Aminah",
        "date": "17 Des 2025",
        "status": "Selesai",
        "price": "Rp45.000"
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Pesanan Masuk - $farmerName"),
        backgroundColor: Colors.green[700],
        foregroundColor: Colors.white,
      ),
      body: orders.isEmpty
          ? const Center(child: Text("Belum ada pesanan masuk"))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(order['date']!, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: order['status'] == "Perlu Dikirim" ? Colors.orange[100] : Colors.green[100],
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                order['status']!,
                                style: TextStyle(
                                  color: order['status'] == "Perlu Dikirim" ? Colors.orange[900] : Colors.green[900],
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                        Text(order['product']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 4),
                        Text("Pembeli: ${order['buyer']}"),
                        Text("Total: ${order['price']}", style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 12),
                        if (order['status'] == "Perlu Dikirim")
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Pesanan ${order['product']} dikonfirmasi!"))
                                );
                              },
                              child: const Text("Proses & Kirim", style: TextStyle(color: Colors.white)),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}