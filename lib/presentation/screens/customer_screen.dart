import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:shoppy/core/constants/asset_constants.dart';
import 'package:shoppy/core/constants/text_constants.dart';
import 'package:shoppy/core/utils/app_colors.dart';
import 'package:shoppy/core/utils/app_typography.dart';
import 'package:shoppy/core/utils/extentions.dart';
import 'package:shoppy/core/constants/gap_constants.dart';
import 'package:shoppy/core/utils/shimmer_components.dart';
import 'package:shoppy/core/utils/toast_components.dart';
import 'package:shoppy/presentation/bloc/customer_bloc/customer_bloc.dart';
import 'package:shoppy/presentation/screens/cart_screen.dart';
import 'package:shoppy/presentation/screens/product_screen.dart';
import 'package:shoppy/presentation/widgets/customer_list_view.dart';
import 'package:shoppy/presentation/widgets/customer_search_field.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key, required this.isFromNavigationbar});
  final bool isFromNavigationbar;

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  // final TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    context.read<CustomerBloc>().add(const CustomerFetchEvent());
    super.initState();
  }

  @override
  void dispose() {
    // searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerBloc, CustomerState>(
      listener: (context, state) {
        if (state is CustomerSelectedState) {
          log("selectedstate ${state.selectedCustomer}");
        }
        if (state is CustomerFailureState) {
          state.message.showMessage(ToastType.error);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: _customeAppBar(),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              children: [
                if (state is CustomerLoadingState)
                  const Expanded(
                    child: ShimmerListView(),
                  ),

                if (state is CustomerLoadedState ||
                    state is CustomerSelectedState ||
                    state is CustomerSelectionClearedState)
                  const CustomerListView()
                // Expanded(
                //     child: Stack(
                //   children: [
                //     ListView.builder(
                //       padding: const EdgeInsets.only(bottom: 40),
                //       physics: const BouncingScrollPhysics(),
                //       itemCount: state.customerList.length,
                //       itemBuilder: (context, index) => CustomerListItem(
                //         customer: state.customerList[index],
                //       ),
                //     ),
                //     BlocBuilder<CartBloc, CartState>(
                //       builder: (context, state) {
                //         log(state.toString());
                //         if (state.selectedCustomer != Customer.empty()) {
                //           return Align(
                //               alignment: Alignment.bottomCenter,
                //               child: CustomButton(
                //                 label: state.cart.cartItems.isEmpty
                //                     ? "Add products "
                //                     : "Go to cart",
                //                 onTap: () => state.cart.cartItems.isEmpty
                //                     ? navigateToProductScreen(context)
                //                     : navigateToCartScreen(context),
                //               ));
                //         }
                //         return const SizedBox();
                //       },
                //     )
                //   ],
                // ))
              ],
            ),
          ),
        );
      },
    );
  }

  AppBar _customeAppBar() {
    return AppBar(
        leading: !widget.isFromNavigationbar
            ? IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.keyboard_arrow_left))
            : const SizedBox(),
        title: const Text(
          "Customers",
          style: AppTypoGraphy.appBarTitle,
        ),
        centerTitle: true,
        actions: const [Icon(Icons.menu), GapConstant.w8],
        bottom: const PreferredSize(
            preferredSize: Size.fromHeight(60), child: CustomerSearchField()));
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
