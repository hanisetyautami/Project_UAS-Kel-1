class Product {
  final String id;
  final String name;
  final String seller;
  final double pricePerKg;
  final double rating;
  final int stock;
  final String description;
  final List<String> imageUrls;

  Product({
    required this.id,
    required this.name,
    required this.seller,
    required this.pricePerKg,
    required this.rating,
    required this.stock,
    required this.description,
    required this.imageUrls,
  });

  // Data dummy untuk contoh di Detail Produk
  static Product jaheMerahSuper = Product(
    id: 'P001',
    name: 'Jahe Merah Super',
    seller: 'Petani Budi',
    pricePerKg: 25000.0,
    rating: 4.3,
    stock: 200,
    description:
        'Jahe Merah murni dan hasil panen terbatas (02/11/2025). Dibudidayakan organic, di lahan menggunakan Bansel. Cocok untuk bumbu, bahan baku herbal dan rempah kualitas ekspor.',
    imageUrls: [
      'assets/jahe_merah_1.png', // Ganti dengan path aset gambar Anda
      'assets/jahe_merah_2.png',
      // Tambahkan lebih banyak URL jika perlu
    ],
  );
}