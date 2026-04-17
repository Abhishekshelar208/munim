import 'package:intl/intl.dart';

class CurrencyFormatter {
  CurrencyFormatter._();

  static final NumberFormat _rupeeFormat = NumberFormat.currency(
    locale: 'en_IN',
    symbol: '₹',
    decimalDigits: 0,
  );

  static final NumberFormat _rupeeDecimalFormat = NumberFormat.currency(
    locale: 'en_IN',
    symbol: '₹',
    decimalDigits: 2,
  );

  static final NumberFormat _compactFormat = NumberFormat.compact(locale: 'en_IN');

  static String format(double amount) => _rupeeFormat.format(amount);

  static String formatDecimal(double amount) =>
      _rupeeDecimalFormat.format(amount);

  static String compact(double amount) {
    if (amount >= 10000000) {
      return '₹${(amount / 10000000).toStringAsFixed(1)}Cr';
    } else if (amount >= 100000) {
      return '₹${(amount / 100000).toStringAsFixed(1)}L';
    } else if (amount >= 1000) {
      return '₹${(amount / 1000).toStringAsFixed(1)}K';
    }
    return format(amount);
  }

  static String formatChange(double amount) {
    final prefix = amount >= 0 ? '+' : '';
    return '$prefix${format(amount)}';
  }
}
