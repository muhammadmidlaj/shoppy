import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shoppy/core/constants/asset_constants.dart';
import 'package:shoppy/core/constants/gap_constants.dart';
import 'package:shoppy/core/utils/app_colors.dart';
import 'package:shoppy/core/utils/app_typography.dart';
import 'package:shoppy/domain/entity/customer.dart';
import 'package:shoppy/general_widgets/custom_button.dart';
import 'package:shoppy/presentation/bloc/cart_bloc/cart_bloc.dart';
import 'package:shoppy/presentation/bloc/customer_bloc/customer_bloc.dart';
import 'package:shoppy/presentation/screens/cart_screen.dart';
import 'package:shoppy/presentation/screens/product_screen.dart';
import 'package:shoppy/presentation/widgets/customer_list_item.dart';

class CustomerListView extends StatelessWidget {
  const CustomerListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerBloc, CustomerState>(
      builder: (context, state) {
        if (state.customerList.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AssetConstants.icUsers,
                  height: 100,
                  width: 100,
                  colorFilter: ColorFilter.mode(
                      AppColorPallete.primaryColor.withOpacity(0.8),
                      BlendMode.srcIn),
                ),
                GapConstant.h20,
                Text(
                  "No customers found",
                  style: AppTypoGraphy.titleLarge
                      .copyWith(color: AppColorPallete.darkGreen),
                ),
              ],
            ),
          );
        }
        return Expanded(
            child: Stack(
          children: [
            ListView.builder(
              padding: const EdgeInsets.only(bottom: 40),
              physics: const BouncingScrollPhysics(),
              itemCount: state.customerList.length,
              itemBuilder: (context, index) => CustomerListItem(
                customer: state.customerList[index],
              ),
            ),
            BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                log(state.toString());
                if (state.selectedCustomer != Customer.empty()) {
                  return Align(
                      alignment: Alignment.bottomCenter,
                      child: CustomButton(
                        label: state.cart.cartItems.isEmpty
                            ? "Add products "
                            : "Go to cart",
                        onTap: () => state.cart.cartItems.isEmpty
                            ? navigateToProductScreen(context)
                            : navigateToCartScreen(context),
                      ));
                }
                return const SizedBox();
              },
            )
          ],
        ));
      },
    );
  }

  navigateToProductScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const ProductScreen(
        isFromNavigationbar: false,
      ),
    ));
  }

  navigateToCartScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const CartScreen(),
    ));
  }
}
