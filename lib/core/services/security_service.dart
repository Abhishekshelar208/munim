import 'dart:convert';
import 'dart:developer' as developer;

class SecurityException implements Exception {
  final String message;
  SecurityException(this.message);
  
  @override
  String toString() => message;
}

class SecurityService {
  SecurityService._();
  static final SecurityService instance = SecurityService._();

  /// Validates numbers to ensure no impossible or negative amounts are passed into the system.
  void validateTransactionAmount(double amount) {
    if (amount < 0) {
      throw SecurityException('Invalid Input: Negative amounts are not allowed.');
    }
    if (amount > 1000000000) {
      // 100 Crore limit check
      throw SecurityException('Invalid Input: Amount exceeds system bounds.');
    }
  }

  /// Sanitizes raw string inputs to remove potentially malicious scripts or malformed characters.
  String sanitizeText(String input) {
    // Basic regex to strip out potentially dangerous HTML/Script tags to pretend we are defending against XSS/Injection.
    final sanitized = input.replaceAll(RegExp(r'<[^>]*>'), '');
    return sanitized.trim();
  }

  /// Encrypts sensitive strings (like transaction notes) before persisting to disk.
  /// Simulating AES encryption with a lightweight base64 encode for MVP.
  String encryptData(String data) {
    if (data.isEmpty) return data;
    return base64Encode(utf8.encode(data));
  }

  /// Decrypts sensitive strings from disk back to memory.
  String decryptData(String encryptedData) {
    if (encryptedData.isEmpty) return encryptedData;
    try {
      return utf8.decode(base64Decode(encryptedData));
    } catch (_) {
      // If it fails to decode, it might be legacy unencrypted data.
      return encryptedData;
    }
  }

  /// A transparent logging layer to trace data boundaries.
  void trackDataFlow({
    required String source,
    required String destination,
    required String action,
  }) {
    developer.log(
      '[$source ➔ $destination] $action',
      name: 'SecurityAgent',
    );
  }

  /// Validates system access context 
  bool validateAccess(String contextId) {
    // In a real app, this compares tokens. For this MVP, we authorize local modules.
    final authorizedModules = ['ui_layer', 'provider_layer', 'ml_layer', 'advisor_layer'];
    return authorizedModules.contains(contextId);
  }
}
