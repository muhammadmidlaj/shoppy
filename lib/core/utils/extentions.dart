
import 'package:oktoast/oktoast.dart';

import 'package:shoppy/core/utils/toast_components.dart';

extension StringExtention on String {
  String capitalizeFirstLetter() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }

  String getInitials() {
    return "${this[0].toUpperCase()}${split(' ').last[0].toUpperCase()}";
  }

  showMessage(ToastType type) {
    return showToastWidget(
      ToastBar(message: this, toastType: type),
      position: ToastPosition.bottom,
      dismissOtherToast: true,
    );
  }
}
