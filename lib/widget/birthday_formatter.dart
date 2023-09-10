import 'package:flutter/services.dart';

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;
    final length = text.length;

    if (length == 2 && !text.contains('/')) {
      return TextEditingValue(
        text: '$text/',
        selection: const TextSelection.collapsed(offset: 3),
      );
    } else if (length == 5 && !text.contains('/', 3)) {
      return TextEditingValue(
        text: '$text/',
        selection: const TextSelection.collapsed(offset: 6),
      );
    } else if (length > 10) {
      return TextEditingValue(
        text: text.substring(0, 10),
        selection: const TextSelection.collapsed(offset: 10),
      );
    }

    return newValue;
  }
}
