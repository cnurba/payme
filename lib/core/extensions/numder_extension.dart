extension NumberExtension on num {
  /// Returns the number formatted as a string with commas as thousands separators.
  String formatAsNumber() {
    final value = toString().replaceAll(',', '');
    final buffer = StringBuffer();
    for (int i = 0; i < value.length; i++) {
      if (i > 0 && (value.length - i) % 3 == 0) {
        buffer.write(',');
      }
      buffer.write(value[i]);
    }
    final formatted = buffer.toString();
    return formatted.contains('.') ? formatted.replaceAll(RegExp(r'\.0+$'), '') : formatted;
  }
}
