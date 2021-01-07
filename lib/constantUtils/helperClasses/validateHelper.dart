class ValidateHelper {
  String validateLoginPassword(String value) {
    if (value != value)
      return "パスワードを入力してください。";
    else
      return null;
  }
}
