import 'package:flutter/material.dart';
import '../models/product_model.dart';
import 'package:intl/intl.dart' as intl;


const Color primaryGreen = Color(0xFF4CAF50);

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    // Format harga ke mata uang Rupiah
    final formatter = intl.NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    final formattedPrice = formatter.format(product.pricePerKg);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: const [
          Icon(Icons.share, color: Colors.grey),
          SizedBox(width: 10),
          Icon(Icons.more_vert, color: Colors.grey),
          SizedBox(width: 10),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProductHeader(formattedPrice),
                  const SizedBox(height: 20),
                  _buildImageCarousel(),
                  const SizedBox(height: 20),
                  _buildSectionTitle('Deskripsi Produk'),
                  const SizedBox(height: 8),
                  Text(
                    product.description,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 20),
                  _buildSectionTitle('Informasi Penjual'),
                  const SizedBox(height: 8),
                  _buildSellerInfo(),
                  const SizedBox(height: 20),
                  _buildQuantitySelector(),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
          _buildFooterButton(context),
        ],
      ),
    );
  }

  Widget _buildProductHeader(String formattedPrice) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _buildCategoryTag('MENGONSUMSI'),
            const SizedBox(width: 8),
            _buildCategoryTag('CATAT PANEN BARU', isSelected: true),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          product.name,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Text(
          '$formattedPrice / Kg',
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: primaryGreen,
          ),
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            const Icon(Icons.star, color: Colors.amber, size: 16),
            const Text(' 4.3 ', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
              '(${product.stock} Stok Tersedia)',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Text(
          product.seller,
          style: TextStyle(color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildCategoryTag(String text, {bool isSelected = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: isSelected ? primaryGreen : Colors.grey[200],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildImageCarousel() {
    return Center(
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage(product.imageUrls[0]),
            fit: BoxFit.cover,
          ),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: product.imageUrls
                  .map((url) => _buildImageDot(url == product.imageUrls[0]))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageDot(bool isActive) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? primaryGreen : Colors.white.withOpacity(0.5),
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildSellerInfo() {
    return Row(
      children: [
        const CircleAvatar(
          backgroundColor: primaryGreen,
          radius: 20,
          child: Icon(Icons.person, color: Colors.white, size: 20),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(product.seller,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(
              'Lihat Profil Penjual',
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuantitySelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('1 Kg', style: TextStyle(fontWeight: FontWeight.bold)),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              IconButton(icon: const Icon(Icons.remove, size: 20), onPressed: () {}),
              const Text('1', style: TextStyle(fontWeight: FontWeight.bold)),
              IconButton(icon: const Icon(Icons.add, size: 20), onPressed: () {}),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFooterButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Jahe Merah Super ditambahkan ke keranjang!'),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryGreen,
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text(
            'TAMBAH KE KERANJANG',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
