import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shoppy/core/constants/asset_constants.dart';
import 'package:shoppy/core/constants/gap_constants.dart';
import 'package:shoppy/core/utils/app_colors.dart';
import 'package:shoppy/core/utils/app_typography.dart';
import 'package:shoppy/presentation/screens/layout_screen.dart';

class OrderSuccessScreen extends StatefulWidget {
  const OrderSuccessScreen({super.key});

  @override
  State<OrderSuccessScreen> createState() => _OrderSuccessScreenState();
}

class _OrderSuccessScreenState extends State<OrderSuccessScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const LayoutScreen(),
          ),
          (route) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LottieBuilder.asset(AssetConstants.lottieSuccess),
            Text(
              "Order Successful",
              style: AppTypoGraphy.titleLarge
                  .copyWith(color: AppColorPallete.darkGreen),
            ),
            GapConstant.h12,
            Text(
              "You will be redirected to home screen",
              style:
                  AppTypoGraphy.bodyLarge.copyWith(color: AppColorPallete.grey),
            )
          ],
        ),
      ),
    );
  }
}
