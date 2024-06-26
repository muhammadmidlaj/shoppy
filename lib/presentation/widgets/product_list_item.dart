import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shoppy/core/constants/api_constants.dart';
import 'package:shoppy/core/utils/app_colors.dart';
import 'package:shoppy/core/utils/app_typography.dart';
import 'package:shoppy/core/constants/gap_constants.dart';
import 'package:shoppy/domain/entity/product.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shoppy/presentation/bloc/cart_bloc/cart_bloc.dart';

class ProductListItem extends StatelessWidget {
  const ProductListItem({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColorPallete.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(15, 120, 119, 119),
            blurRadius: 12,
            offset: Offset(0, 0),
            spreadRadius: 3,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Align(
            alignment: Alignment.center,
            child: CachedNetworkImage(
              imageUrl: ApiConstants.baseImageUrl + product.image,
              placeholder: (context, url) {
                return const SpinKitFadingCircle(
                  color: AppColorPallete.primaryColor,
                );
              },
              errorWidget: (context, url, error) =>
                  const Icon(Icons.error_outline),
              height: 100,
              width: 80,
              fit: BoxFit.cover,
            ),
          ),
          GapConstant.h8,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name,
                style: AppTypoGraphy.labelLarge,
                overflow: TextOverflow.ellipsis,
              ),
              GapConstant.h4,
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "₹${product.price.toStringAsFixed(0)}/kg",
                      style: AppTypoGraphy.labelLarge.copyWith(
                          fontWeight: FontWeight.bold, letterSpacing: 0.5),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    GapConstant.w8,
                    BlocBuilder<CartBloc, CartState>(
                      builder: (context, state) {
                        if (getProductCount(product, state.cart.cartItems) ==
                            0) {
                          return IconButton.filled(
                            onPressed: () => addProductToCart(context),
                            icon: const Icon(Icons.add),
                            iconSize: 20,
                          );
                        }
                        return Expanded(
                            child: SizedBox(
                          height: 40,
                          // color: AppColorPallete.lightGrey,
                          child: Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Flexible(
                                child: IconButton.outlined(
                                  onPressed: () => decrementQuantity(context),
                                  alignment: Alignment.center,
                                  icon: const Icon(Icons.remove),
                                  iconSize: 15,
                                  constraints: const BoxConstraints(
                                      maxHeight: 30, maxWidth: 30),
                                ),
                              ),
                              Text(
                                getProductCount(product, state.cart.cartItems)
                                    .toString(),
                                style: AppTypoGraphy.bodyLarge,
                              ),
                              Flexible(
                                child: IconButton.filled(
                                  onPressed: () => incrementQuantity(context),
                                  alignment: Alignment.center,
                                  icon: const Icon(Icons.add),
                                  iconSize: 15,
                                  constraints: const BoxConstraints(
                                      maxHeight: 30, maxWidth: 30),
                                ),
                              ),
                            ],
                          ),
                        ));
                      },
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  int getProductCount(Product product, List<Product> productList) {
    for (Product element in productList) {
      if (product.id == element.id) {
        return element.quantity;
      }
    }
    return 0;
  }

  addProductToCart(BuildContext context) {
    context.read<CartBloc>().add(AddProductToCartEvent(product));
  }

  incrementQuantity(BuildContext context) {
    context.read<CartBloc>().add(CartProductIncrementEvent(product: product));
  }

  decrementQuantity(BuildContext context) {
    context.read<CartBloc>().add(CartProductDecrementEvent(product: product));
  }
}
