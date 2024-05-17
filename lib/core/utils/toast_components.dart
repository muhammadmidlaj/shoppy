import 'package:flutter/material.dart';
import 'package:shoppy/core/constants/gap_constants.dart';
import 'package:shoppy/core/utils/app_colors.dart';
import 'package:shoppy/core/utils/app_typography.dart';

enum ToastType { success, error, warning }

class ToastBar extends StatelessWidget {
  const ToastBar({super.key, required this.message, required this.toastType});
  final String message;
  final ToastType toastType;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: getColorForToast(toastType),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            getIconForToast(toastType),
            size: 25,
            color: AppColorPallete.white,
          ),
          GapConstant.w12,
          Expanded(
            child: Text(
              message,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTypoGraphy.bodyLarge
                  .copyWith(color: AppColorPallete.white),
            ),
          )
        ],
      ),
    );
  }
}

IconData getIconForToast(ToastType toast) {
  switch (toast) {
    case ToastType.error:
      return Icons.error;
    case ToastType.success:
      return Icons.done;
    case ToastType.warning:
      return Icons.warning;

    default:
      return Icons.numbers;
  }
}

Color getColorForToast(ToastType toast) {
  switch (toast) {
    case ToastType.error:
      return AppColorPallete.red;
    case ToastType.success:
      return AppColorPallete.primaryColor;
    case ToastType.warning:
      return AppColorPallete.yellow;

    default:
      return AppColorPallete.grey;
  }
}
