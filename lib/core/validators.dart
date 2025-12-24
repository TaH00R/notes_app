class Validators {
  Validators._();

  static String? nameValidator(String? name) {
    name = name?.trim();
    return name!.isEmpty ? 'Username cannot be empty' : null;
  }

  static String? emailValidator(String? email) {
    email = email?.trim();
    return email!.isEmpty
        ? 'Email cannot be empty'
        : RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)
        ? null
        : 'Invalid email format';
  }

  static String? passValidator(String? password) {
    password = password?.trim();

    if (password == null || password.isEmpty) {
      return 'Password cannot be empty';
    }

    String errorMessage = '';

    if (password.length < 8) {
      errorMessage += 'Password must be at least 8 characters long.\n';
    }

    if (password.length > 20) {
      errorMessage += 'Password cannot be more than 20 characters long.\n';
    }

    if (password.contains(' ')) {
      errorMessage += 'Password cannot contain spaces.\n';
    }

    return errorMessage.isEmpty ? null : errorMessage.trim();
  }
}
