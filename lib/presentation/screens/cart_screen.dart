import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shoppy/core/constants/asset_constants.dart';
import 'package:shoppy/core/utils/app_colors.dart';
import 'package:shoppy/core/utils/app_typography.dart';
import 'package:shoppy/core/utils/extentions.dart';
import 'package:shoppy/core/constants/gap_constants.dart';
import 'package:shoppy/core/constants/text_constants.dart';
import 'package:shoppy/core/utils/toast_components.dart';
import 'package:shoppy/domain/entity/customer.dart';
import 'package:shoppy/presentation/bloc/cart_bloc/cart_bloc.dart';
import 'package:shoppy/presentation/bloc/customer_bloc/customer_bloc.dart';
import 'package:shoppy/presentation/bloc/order_bloc/order_bloc.dart';
import 'package:shoppy/presentation/widgets/cart_list_item.dart';
import 'package:shoppy/presentation/screens/order_success_screen.dart';
import 'package:shoppy/general_widgets/custom_button.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderBloc, OrderState>(listener: (context, orderstate) {
      if (orderstate is OrderCreatedState) {
        navigateToOrderSuccessScreen(context);
        AppTexts.orderCreateSuccessMessage.showMessage(ToastType.success);

        //clear cart and customer selection after order creation
        context.read<CartBloc>().add(const CartClearEvent());
        context.read<CustomerBloc>().add(const CustomerSelctionClearEvent());
      }
      if (orderstate is OrderFailureState) {
        orderstate.message.showMessage(ToastType.error);
      }
    }, builder: (context, orderState) {
      return Scaffold(
        appBar: _customeAppBar(),
        body: BlocBuilder<CartBloc, CartState>(
          builder: (context, cartState) {
            if (cartState.cart.cartItems.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AssetConstants.icEmptyCart,
                      height: 100,
                      width: 100,
                      colorFilter: ColorFilter.mode(
                          AppColorPallete.lightYellow.withOpacity(0.8),
                          BlendMode.srcIn),
                    ),
                    GapConstant.h20,
                    Text(
                      "Your shopping cart is empty",
                      style: AppTypoGraphy.titleLarge
                          .copyWith(color: AppColorPallete.darkGreen),
                    ),
                  ],
                ),
              );
            }
            return Stack(
              children: [
                ListView.builder(
                  padding: const EdgeInsets.only(bottom: 90),
                  itemCount: cartState.cart.cartItems.length,
                  itemBuilder: (context, index) => CartListItem(
                    product: cartState.cart.cartItems[index],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 26, vertical: 16),
                    margin: const EdgeInsets.all(16),
                    height: 90,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: AppColorPallete.lightGreen,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Subtotal",
                              style: AppTypoGraphy.bodyLarge
                                  .copyWith(color: AppColorPallete.darkGreen),
                            ),
                            Text(
                              "\$${context.read<CartBloc>().totalAmount.toStringAsFixed(0)}",
                              style: AppTypoGraphy.titleLarge
                                  .copyWith(color: AppColorPallete.darkGreen),
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                        GapConstant.w40,
                        Expanded(
                            child: CustomButton(
                                label: "Checkout now",
                                borderRadius: 20,
                                isLoading: orderState is OrderLoadingState,
                                onTap: () => {
                                      cartState.selectedCustomer !=
                                              Customer.empty()
                                          ? context
                                              .read<OrderBloc>()
                                              .add(
                                                  OrderCreateEvent(
                                                      customer: cartState
                                                          .selectedCustomer,
                                                      totalAmount:
                                                          cartState.totalAmount,
                                                      products: cartState
                                                          .cart.cartItems))
                                          : "Select Customer to order"
                                              .showMessage(ToastType.warning)
                                    }))
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ),
      );
    });
  }

  AppBar _customeAppBar() {
    return AppBar(
      leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.keyboard_arrow_left)),
      title: const Text(
        "My Cart",
        style: AppTypoGraphy.appBarTitle,
      ),
      centerTitle: true,
    );
  }

  navigateToOrderSuccessScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const OrderSuccessScreen(),
    ));
  }
}
