String validateEmail(String value) {
  if (value.isEmpty) {
    return 'Please enter a email';
  } else if (!RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(value)) {
    return 'Please enter a valid email';
  } else {
    return null;
  }
}
