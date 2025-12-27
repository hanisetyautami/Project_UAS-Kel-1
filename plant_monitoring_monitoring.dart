// lib/screens/plant_monitoring_screen.dart
import 'package:flutter/material.dart';

class PlantMonitoringScreen extends StatefulWidget {
  const PlantMonitoringScreen({super.key});

  @override
  _PlantMonitoringScreenState createState() => _PlantMonitoringScreenState();
}

class _PlantMonitoringScreenState extends State<PlantMonitoringScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, String>> _allPlants = [
    {
      'name': 'Jahe Merah',
      'potensi': 'Sangat Tinggi',
      'deskripsi': 'Permintaan tinggi untuk herbal dan rempah, harga stabil.',
      'gambar': 'https://via.placeholder.com/150/FF4500/FFFFFF?text=Jahe' // Placeholder
    },
    {
      'name': 'Kunyit',
      'potensi': 'Tinggi',
      'deskripsi': 'Bahan baku jamu dan kosmetik, relatif mudah ditanam.',
      'gambar': 'https://via.placeholder.com/150/FFD700/000000?text=Kunyit' // Placeholder
    },
    {
      'name': 'Temulawak',
      'potensi': 'Sedang',
      'deskripsi': 'Banyak digunakan untuk obat tradisional, perlu penanganan khusus.',
      'gambar': 'https://via.placeholder.com/150/DAA520/FFFFFF?text=Temulawak' // Placeholder
    },
    {
      'name': 'Daun Sirih',
      'potensi': 'Tinggi',
      'deskripsi': 'Mudah tumbuh, permintaan lokal dan industri cukup baik.',
      'gambar': 'https://via.placeholder.com/150/228B22/FFFFFF?text=Sirih' // Placeholder
    },
    {
      'name': 'Sambiloto',
      'potensi': 'Sedang',
      'deskripsi': 'Obat herbal pahit, ceruk pasar spesifik.',
      'gambar': 'https://via.placeholder.com/150/4682B4/FFFFFF?text=Sambiloto' // Placeholder
    },
  ];

  List<Map<String, String>> _filteredPlants = [];

  @override
  void initState() {
    super.initState();
    _filteredPlants = _allPlants; // Tampilkan semua di awal
    _searchController.addListener(_filterPlants);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterPlants() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredPlants = _allPlants.where((plant) {
        return plant['name']!.toLowerCase().contains(query) ||
               plant['deskripsi']!.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Monitoring Tanaman Obat'),
        backgroundColor: Colors.green.shade700,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Cari tanaman obat...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredPlants.length,
              itemBuilder: (context, index) {
                final plant = _filteredPlants[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  elevation: 2,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(plant['gambar']!),
                      backgroundColor: Colors.grey[200],
                    ),
                    title: Text(
                      plant['name']!,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Potensi Keuntungan: ${plant['potensi']!}'),
                        Text(plant['deskripsi']!),
                      ],
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      // TODO: Navigasi ke detail tanaman obat
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Melihat detail ${plant['name']}')));
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}