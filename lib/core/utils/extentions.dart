import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

extension StringExtention on String {
  String capitalizeFirstLetter() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  String getInitials() {
    return "${this[0].toUpperCase()}${split(' ').last[0].toUpperCase()}";
  }

  showMessage() {
    return showToast(
      this,
      position: ToastPosition.bottom,
      dismissOtherToast: true,
      textAlign: TextAlign.center,
      radius: 5,
      textPadding: const EdgeInsets.all(8),
    );
  }
}
