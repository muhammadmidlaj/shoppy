import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shoppy/core/constants/gap_constants.dart';
import 'package:shoppy/core/utils/app_colors.dart';
import 'package:shoppy/core/utils/app_typography.dart';
import 'package:shoppy/presentation/bloc/cart_bloc/cart_bloc.dart';
import 'package:shoppy/presentation/bloc/customer_bloc/customer_bloc.dart';
import 'package:shoppy/presentation/screens/layout_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    context.read<CartBloc>().add(const CartFetchLocalEvent());
    Future.delayed(const Duration(seconds: 1), () {
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
    return BlocListener<CartBloc, CartState>(
      listener: (context, state) {
        if (state is ProductAddedState) {
          context
              .read<CustomerBloc>()
              .setSelectedCustomer(state.selectedCustomer);
        }
      },
      child: Scaffold(
        backgroundColor: AppColorPallete.primaryColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.shopping_bag,
              color: AppColorPallete.white,
              size: 40,
            ),
            GapConstant.h12,
            Text(
              "Shoppy",
              style: AppTypoGraphy.titleLarge
                  .copyWith(color: AppColorPallete.white),
            ),
            GapConstant.h8,
            const SpinKitWave(
              color: AppColorPallete.white,
              size: 25,
              itemCount: 6,
            )
          ],
        ),
      ),
    );
  }
}
