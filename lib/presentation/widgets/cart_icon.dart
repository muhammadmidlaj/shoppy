import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppy/core/utils/app_colors.dart';
import 'package:shoppy/core/utils/app_typography.dart';
import 'package:shoppy/presentation/bloc/cart_bloc/cart_bloc.dart';
import 'package:shoppy/presentation/screens/cart_screen.dart';

class CartIcon extends StatelessWidget {
  const CartIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return InkWell(
          onTap: () => navigateToCartScreen(context),
          child: SizedBox(
            height: 50,
            width: 50,
            child: Stack(
              children: [
                Container(
                    height: 40,
                    width: 40,
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColorPallete.white,
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(15, 120, 119, 119),
                            blurRadius: 12,
                            offset: Offset(0, 0),
                            spreadRadius: 5,
                          )
                        ]),
                    child: const Icon(
                      Icons.shopping_cart_outlined,
                      color: AppColorPallete.primaryColor,
                    )),
                state.cart.cartItems.isNotEmpty
                    ? Positioned(
                        top: 0,
                        right: 5,
                        child: CircleAvatar(
                          radius: 10,
                          backgroundColor: AppColorPallete.red,
                          child: Text(
                            state.cart.cartItems.length.toString(),
                            style: AppTypoGraphy.labelMedium.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColorPallete.white),
                          ),
                        ),
                      )
                    : const SizedBox()
              ],
            ),
          ),
        );
      },
    );
  }

  navigateToCartScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const CartScreen(),
    ));
  }
}
