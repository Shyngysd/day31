import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/product.dart';
import '../l10n/app_localizations.dart';

class ProductsListScreen extends StatefulWidget {
  const ProductsListScreen({super.key});

  @override
  State<ProductsListScreen> createState() => _ProductsListScreenState();
}

class _ProductsListScreenState extends State<ProductsListScreen> {
  late String _locale;

  @override
  void initState() {
    super.initState();
    _locale = 'en';
  }

  // Пример данных products
  final List<Product> products = [
    Product(
      id: 1,
      name: 'Premium Headphones',
      price: 199.99,
      imageUrl: 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=400',
      description: 'High-quality wireless headphones with noise cancellation',
      currency: 'USD',
    ),
    Product(
      id: 2,
      name: 'Smart Watch',
      price: 299.99,
      imageUrl: 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=400',
      description: 'Advanced fitness tracking and notifications',
      currency: 'USD',
    ),
    Product(
      id: 3,
      name: 'Wireless Speaker',
      price: 79.99,
      imageUrl: 'https://images.unsplash.com/photo-1589003077984-894e133814c9?w=400',
      description: 'Portable speaker with powerful bass',
      currency: 'USD',
    ),
    Product(
      id: 4,
      name: 'Camera',
      price: 499.99,
      imageUrl: 'https://images.unsplash.com/photo-1612198188060-c7c2a3b66eab?w=400',
      description: 'Professional DSLR camera',
      currency: 'USD',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(_locale);

    return Scaffold(
      appBar: AppBar(
        title: Text(loc.productsTitle),
        backgroundColor: Colors.deepPurple,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() => _locale = value);
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(value: 'en', child: Text('English')),
              const PopupMenuItem(value: 'ru', child: Text('Русский')),
            ],
          ),
        ],
      ),
      body: products.isEmpty
          ? Center(child: Text(loc.noProducts))
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ProductCard(
                  product: product,
                  locale: _locale,
                  onTap: () {
                    context.pushNamed(
                      'product-detail',
                      pathParameters: {'id': product.id.toString()},
                    );
                  },
                );
              },
            ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  final String locale;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.product,
    required this.locale,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(locale);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: InkWell(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cached Network Image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
              child: CachedNetworkImage(
                imageUrl: product.imageUrl,
                width: 120,
                height: 120,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  width: 120,
                  height: 120,
                  color: Colors.grey[300],
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  width: 120,
                  height: 120,
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(Icons.error_outline, color: Colors.red),
                  ),
                ),
              ),
            ),
            // Product Info
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      product.description,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      loc.formatCurrency(product.price),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
