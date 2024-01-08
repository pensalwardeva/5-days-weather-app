import 'package:flutter/services.dart';

class NoSpaceInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text == ' ') {
      return oldValue;
    }
    final trimmedText = newValue.text.trimLeft();

    return TextEditingValue(
      text: trimmedText,
      selection: TextSelection.collapsed(offset: newValue.selection.baseOffset),
    );
  }
}
