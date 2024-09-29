class Regxs {
  static String emailRegx =
      r'^[a-z0-9]+([._%+-]?[a-z0-9]+)*@[a-z0-9-]+(\.[a-z]{2,})+$';

  // validate email format
  static bool validateEmail(String email) {
    return RegExp(emailRegx).hasMatch(email);
  }
}
