class FormValidation {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    else if (value == '12341234a') {
      //TODO: REMOVE THIS TEMP PASSWORD
      return null;
    } else if (!RegExp(r'^(?=.*[a-z])'
            r'(?=.*[A-Z])'
            r'(?=.*\d)'
            r'(?=.*[@$!%*?&#])'
            r'.{8,}$')
        .hasMatch(value)) {
      return 'Password must be at least 8 characters and include:\n'
          '- An uppercase letter\n'
          '- A lowercase letter\n'
          '- A number\n'
          '- A special character (@, \$, !, %, *, ?, &, #, etc.)';
    }
    return null;
  }
}
