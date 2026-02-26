import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../l10n/app_localizations.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productId;

  const ProductDetailScreen({
    super.key,
    required this.productId,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late String _locale;

  @override
  void initState() {
    super.initState();
    _locale = 'en';
  }

  Map<String, dynamic> _getProductData() {
    const products = {
      '1': {
        'id': 1,
        'name': 'Premium Headphones',
        'price': 199.99,
        'imageUrl': 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=600',
        'description': 'High-quality wireless headphones with noise cancellation. Perfect for music lovers and professionals.',
        'features': ['Noise Cancellation', '30-hour battery', 'Bluetooth 5.0', 'Premium comfort'],
      },
      '2': {
        'id': 2,
        'name': 'Smart Watch',
        'price': 299.99,
        'imageUrl': 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=600',
        'description': 'Advanced fitness tracking and notifications. Stay connected all day long.',
        'features': ['Heart rate monitor', 'GPS', 'Water resistant', '7-day battery'],
      },
      '3': {
        'id': 3,
        'name': 'Wireless Speaker',
        'price': 79.99,
        'imageUrl': 'https://images.unsplash.com/photo-1589003077984-894e133814c9?w=600',
        'description': 'Portable speaker with powerful bass and clear sound. Perfect for parties.',
        'features': ['360-degree sound', 'Waterproof', 'Fast charging', 'Long battery life'],
      },
      '4': {
        'id': 4,
        'name': 'Camera',
        'price': 499.99,
        'imageUrl': 'https://images.unsplash.com/photo-1612198188060-c7c2a3b66eab?w=600',
        'description': 'Professional DSLR camera for photography enthusiasts and professionals.',
        'features': ['24MP resolution', '4K video', 'One-hand operation', 'Compact design'],
      },
    };
    return products[widget.productId] ?? products['1']!;
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(_locale);
    final product = _getProductData();

    return Scaffold(
      appBar: AppBar(
        title: Text('${loc.productDetails} #${widget.productId}'),
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: product['imageUrl'],
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                width: double.infinity,
                height: 300,
                color: Colors.grey[300],
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                width: double.infinity,
                height: 300,
                color: Colors.grey[300],
                child: const Center(
                  child: Icon(Icons.error_outline, color: Colors.red, size: 48),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['name'],
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    loc.formatCurrency(product['price'].toDouble()),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    loc.productDescription,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product['description'],
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Features',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  ...(product['features'] as List<String>)
                      .map((feature) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                  size: 20,
                                ),
                                const SizedBox(width: 12),
                                Text(feature),
                              ],
                            ),
                          )),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${product['name']} added to cart!',
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.deepPurple,
                      ),
                      child: const Text(
                        'Add to Cart',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
