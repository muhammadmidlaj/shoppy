import 'package:flutter/material.dart';
import 'package:shoppy/core/utils/app_colors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shoppy/core/utils/app_typography.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.onTap,
      required this.label,
      this.isLoading = false,
      this.padding,
      this.borderRadius,
      this.height});

  final Function onTap;
  final String label;
  final bool isLoading;

  final double? padding;
  final double? borderRadius;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(padding ?? 15),
                maximumSize: Size(size.width, height ?? 60),
                shadowColor: AppColorPallete.primaryColor.withOpacity(0.6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius ?? 10),
                ),
                backgroundColor: AppColorPallete.primaryColor),
            onPressed: () {
              onTap();
            },
            child: isLoading
                ? const SpinKitFadingCircle(
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
