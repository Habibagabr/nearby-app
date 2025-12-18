
bool isValidEmailSyntax(String email) {
  final regex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
  return regex.hasMatch(email);
}

bool isStrongPassword(String password) {
  final regex = RegExp(
    r'^(?=.*[A-Z])(?=.*[\W_]).{8,}$',
  );
  return regex.hasMatch(password);
}
