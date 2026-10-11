import 'package:flutter/material.dart';
import '../data/cart.dart';
import '../data/products.dart';
import '../models/product.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> _products = [];
  String _query = '';
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    // Ürünleri JSON dosyasından oku
    loadProducts().then((items) {
      setState(() {
        _products = items;
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Arama kutusuna yazılana göre listeyi süz
    final visible = _products
        .where((p) => p.name.toLowerCase().contains(_query.toLowerCase()))
        .toList();

    return Scaffold(
      body: SafeArea(
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 16),
                    _buildSearchBox(),
                    const SizedBox(height: 16),
                    _buildBanner(),
                    const SizedBox(height: 16),
                    _buildGrid(visible),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Discover',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            Text(
              'Find your perfect device.',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
        // Sepet ikonu ve üstündeki ürün sayısı
        Badge(
          isLabelVisible: cartItems.isNotEmpty,
          label: Text('${cartItems.length}'),
          child: IconButton(
            icon: const Icon(Icons.shopping_bag_outlined),
            onPressed: () {
              Navigator.pushNamed(context, '/cart')
                  .then((_) => setState(() {}));
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBox() {
    return TextField(
      onChanged: (value) => setState(() => _query = value),
      decoration: InputDecoration(
        hintText: 'Search products',
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildBanner() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset(
        'assets/images/banner.png',
        width: double.infinity,
        fit: BoxFit.fitWidth,
        cacheWidth: 800,
      ),
    );
  }

  Widget _buildGrid(List<Product> items) {
    if (items.isEmpty) {
      return const Padding(
        padding: EdgeInsets.only(top: 40),
        child: Center(child: Text('Ürün bulunamadı')),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.68,
      ),
      itemBuilder: (context, index) => _buildProductCard(items[index]),
    );
  }

  Widget _buildProductCard(Product product) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        // Ürün detayına git, ürünü Route Arguments ile gönder
        Navigator.pushNamed(context, '/detail', arguments: product)
            .then((_) => setState(() {}));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                product.imageAsset,
                width: double.infinity,
                fit: BoxFit.cover,
                cacheWidth: 400,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            product.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            product.tagline,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
          const SizedBox(height: 2),
          Text(
            product.price,
            style: const TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}