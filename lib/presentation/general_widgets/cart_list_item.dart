import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shoppy/core/utils/api_constants.dart';
import 'package:shoppy/core/utils/app_colors.dart';
import 'package:shoppy/core/utils/app_typography.dart';
import 'package:shoppy/core/utils/gap_constants.dart';
import 'package:shoppy/domain/entity/product.dart';
import 'package:shoppy/presentation/bloc/cart_bloc/cart_bloc.dart';

class CartListItem extends StatelessWidget {
  const CartListItem({
    super.key,
    required this.product,
  });
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 0),
            blurRadius: 10,
            color: Color.fromRGBO(196, 193, 193, 0.698),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CachedNetworkImage(
            imageUrl: ApiConstants.baseImageUrl + product.image,
            height: 50,
            width: 60,
            fit: BoxFit.fill,
            placeholder: (context, url) => SpinKitFadingCircle(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          GapConstant.w4,
          SizedBox(
            width: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  product.name,
                  style: AppTypoGraphy.bodyLarge
                      .copyWith(color: AppColorPallete.darkGreen),
                  maxLines: 1,
                  //overflow: TextOverflow.ellipsis,
                ),
                RichText(
                    text: TextSpan(
                        text: "\$${product.price.toStringAsFixed(0)}",
                        style: AppTypoGraphy.bodyLarge
                            .copyWith(color: AppColorPallete.darkGreen),
                        children: [
                      TextSpan(
                          text: "/kg",
                          style: AppTypoGraphy.bodySmall.copyWith(
                              color: AppColorPallete.grey,
                              fontWeight: FontWeight.w500))
                    ])),
              ],
            ),
          ),
          SizedBox(
            height: 40,
            // width: 100,
            // color: AppColorPallete.lightGrey,
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                IconButton.outlined(
                  onPressed: () => decrementQuantity(context),
                  alignment: Alignment.center,
                  icon: const Icon(Icons.remove),
                  iconSize: 15,
                  constraints:
                      const BoxConstraints(maxHeight: 30, maxWidth: 30),
                ),
                Text(
                  product.quantity.toString(),
                  style: AppTypoGraphy.bodyLarge,
                ),
                IconButton.filled(
                  onPressed: () => incrementQuantity(context),
                  alignment: Alignment.center,
                  icon: const Icon(Icons.add),
                  iconSize: 15,
                  constraints:
                      const BoxConstraints(maxHeight: 30, maxWidth: 30),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 50,
            child: AutoSizeText(
              "\$${product.totalAmount.toStringAsFixed(0)}",
              style: AppTypoGraphy.titleLarge,
              maxLines: 1,
              //overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }

  incrementQuantity(BuildContext context) {
    context.read<CartBloc>().add(CartProductIncrementEvent(product: product));
  }

  decrementQuantity(BuildContext context) {
    context.read<CartBloc>().add(CartProductDecrementEvent(product: product));
  }
}
