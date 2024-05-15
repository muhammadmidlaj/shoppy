import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppy/core/utils/gap_constants.dart';
import 'package:shoppy/presentation/bloc/product_bloc/product_bloc.dart';
import 'package:shoppy/presentation/screens/cart_screen.dart';
import 'package:shoppy/presentation/general_widgets/products_grid_view.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key, required this.isFromNavigationbar});
  final bool isFromNavigationbar;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    context.read<ProductBloc>().add(const ProductFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _customeAppBar(),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ProductLoadedState) {
            return ProductGridView(
              products: state.products,
              isFromNavigationbar: widget.isFromNavigationbar,
            );
          }
          return const Center(
            child: Text("product screen"),
          );
        },
      ),
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
      title: const Text("Products"),
      centerTitle: true,
      actions: [
        IconButton(
            onPressed: () => navigateToCartScreen(context),
            icon: const Icon(Icons.shopping_cart_outlined)),
        GapConstant.w8
      ],
    );
  }

  navigateToCartScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const CartScreen(),
    ));
  }
}
