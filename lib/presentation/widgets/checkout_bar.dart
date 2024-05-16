// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shoppy/core/utils/app_colors.dart';
// import 'package:shoppy/core/utils/app_typography.dart';
// import 'package:shoppy/core/utils/gap_constants.dart';
// import 'package:shoppy/presentation/bloc/cart_bloc/cart_bloc.dart';
// import 'package:shoppy/widgets/custom_button.dart';

// class CheckoutBar extends StatelessWidget {
//   const CheckoutBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<CartBloc, CartState>(
//       builder: (context, state) {
//         if (context.read<CartBloc>().cart.cartItems.isNotEmpty) {
//           return Positioned(
//             bottom: 10,
//             right: 0,
//             left: 0,
//             child: Container(
//               alignment: Alignment.center,
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//               height: 80,
//               width: MediaQuery.of(context).size.width,
//               decoration: BoxDecoration(
//                 color: AppColorPallete.lightGreen.withOpacity(0.9),
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         "Subtotal",
//                         style: AppTypoGraphy.labelLarge
//                             .copyWith(color: AppColorPallete.white),
//                       ),
//                       Text(
//                         "\$${context.read<CartBloc>().totalAmount.toStringAsFixed(0)}",
//                         style: AppTypoGraphy.titleLarge
//                             .copyWith(color: AppColorPallete.white),
//                         overflow: TextOverflow.ellipsis,
//                       )
//                     ],
//                   ),
//                   GapConstant.w28,
//                   Expanded(
//                       child: CustomButton(
//                     label: "Checkout now",
//                     borderRadius: 20,
//                     onTap: () => navigateToCustomerScreen(context),
//                   ))
//                 ],
//               ),
//             ),
//           );
//         }
//         return const SizedBox();
//       },
//     );
//   }
//   navigateToCustomerScreen(context) {}
// }
