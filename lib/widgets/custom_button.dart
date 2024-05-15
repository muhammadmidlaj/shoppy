import 'package:flutter/material.dart';
import 'package:shoppy/core/utils/app_colors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shoppy/core/utils/app_typography.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      this.onTap,
      required this.label,
      this.isLoading = false,
      this.padding,
      this.borderRadius,
      this.icon});

  final Function? onTap;
  final String label;
  final bool isLoading;
  final String? icon;
  final double? padding;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            style: ButtonStyle(
                padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry>(
                  (Set<MaterialState> states) {
                    return EdgeInsets.all(padding ?? 15.0);
                  },
                ),
                maximumSize: MaterialStateProperty.all(Size(size.width, 60)),
                shadowColor: MaterialStateProperty.all(
                    AppColorPallete.primaryColor.withOpacity(0.5)),
                elevation: MaterialStateProperty.all(4.0),
                backgroundColor:
                    MaterialStateProperty.all(AppColorPallete.primaryColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
                ))),
            onPressed: () {
              if (onTap != null) {
                onTap!();
              }
            },
            icon: icon != null
                ? Image.asset(
                    icon!,
                    color: AppColorPallete.white,
                    height: 18,
                  )
                : const SizedBox(),
            label: isLoading
                ? const SpinKitCircle(
                    color: Colors.white,
                    size: 25.0,
                  )
                : Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypoGraphy.labelLarge
                        .copyWith(color: AppColorPallete.white),
                  ),
          ),
        ),
      ],
    );
  }
}
