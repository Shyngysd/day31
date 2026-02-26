import 'package:go_router/go_router.dart';
import '../screens/home_screen.dart';
import '../screens/products_list_screen.dart';
import '../screens/product_detail_screen.dart';
import '../screens/settings_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
        name: 'home',
      ),
      GoRoute(
        path: '/products',
        builder: (context, state) => const ProductsListScreen(),
        name: 'products',
      ),
      GoRoute(
        path: '/product/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return ProductDetailScreen(productId: id);
        },
        name: 'product-detail',
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
        name: 'settings',
      ),
    ],
  );
}
