class Validators {
  static bool isValidEmail(String input) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(input);
  }

  static bool isValidPhone(String input) {
    final phoneRegex = RegExp(r'^01[0-2,5]{1}[0-9]{8}$');
    return phoneRegex.hasMatch(input);
  }

  static bool isValidUsername(String input) {
    final usernameRegex = RegExp(r'^[a-zA-Z0-9_]{4,20}$');
    return usernameRegex.hasMatch(input);
  }

  static bool isNotEmpty(String input) => input.trim().isNotEmpty;
}
