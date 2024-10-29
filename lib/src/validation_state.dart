
enum ValidationState {
  initial,
  valid,
  invalid,
  loading,
}

class ValidationResult {
  final bool isValid;
  final String? errorMessage;
  final String? successMessage;

  ValidationResult({
    required this.isValid,
    this.errorMessage,
    this.successMessage,
  });

  static ValidationResult success([String? message]) => ValidationResult(
        isValid: true,
        successMessage: message,
      );

  static ValidationResult error(String message) => ValidationResult(
        isValid: false,
        errorMessage: message,
      );
}
