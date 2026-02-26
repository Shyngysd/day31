import 'package:intl/intl.dart';

class AppLocalizations {
  final String locale;

  AppLocalizations({required this.locale});

  static AppLocalizations of(String locale) {
    return AppLocalizations(locale: locale);
  }

  // App titles
  String get appTitle => locale == 'ru' ? 'День 31' : 'Day 31';
  String get homeTitle => locale == 'ru' ? 'Главная' : 'Home';
  String get productsTitle => locale == 'ru' ? 'Товары' : 'Products';
  String get settingsTitle => locale == 'ru' ? 'Настройки' : 'Settings';

  // Product related
  String get productPrice => locale == 'ru' ? 'Цена' : 'Price';
  String get productDescription => locale == 'ru' ? 'Описание' : 'Description';
  String get noProducts => locale == 'ru' ? 'Товары не найдены' : 'No products found';

  // Settings
  String get language => locale == 'ru' ? 'Язык' : 'Language';
  String get logout => locale == 'ru' ? 'Выход' : 'Logout';
  String get token => locale == 'ru' ? 'Токен:' : 'Token:';
  String get saveToken => locale == 'ru' ? 'Сохранить токен' : 'Save Token';

  // Navigation
  String get productDetails => locale == 'ru' ? 'Детали товара' : 'Product Details';

  // Currency formatting
  String formatCurrency(double amount) {
    final format = NumberFormat.currency(
      locale: locale,
      symbol: locale == 'ru' ? '₽' : '\$',
    );
    return format.format(amount);
  }

  // Date formatting
  String formatDate(DateTime date) {
    final format = DateFormat('dd.MM.yyyy', locale);
    return format.format(date);
  }

  String formatDateTime(DateTime dateTime) {
    final format = DateFormat('dd.MM.yyyy HH:mm', locale);
    return format.format(dateTime);
  }
}
