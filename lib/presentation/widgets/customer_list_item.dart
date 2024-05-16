import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shoppy/core/constants/api_constants.dart';
import 'package:shoppy/core/constants/asset_constants.dart';
import 'package:shoppy/core/utils/app_colors.dart';
import 'package:shoppy/core/utils/app_typography.dart';
import 'package:shoppy/core/constants/gap_constants.dart';
import 'package:shoppy/domain/entity/customer.dart';
import 'package:shoppy/presentation/bloc/cart_bloc/cart_bloc.dart';
import 'package:shoppy/presentation/bloc/customer_bloc/customer_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomerListItem extends StatelessWidget {
  const CustomerListItem({super.key, required this.customer});
  final Customer customer;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerBloc, CustomerState>(
      builder: (context, state) {
        return InkWell(
          onTap: () => onCustomerSelection(context),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: state.selectedCustomer != Customer.empty() &&
                      state.selectedCustomer.id == customer.id
                  ? Colors.lightGreen.withOpacity(0.5)
                  : Colors.white,
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
              children: [
                customer.profilePic != null && customer.profilePic != ""
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl:
                              ApiConstants.baseImageUrl + customer.profilePic!,
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              const SpinKitFadingCircle(
                            color: AppColorPallete.primaryColor,
                          ),
                          errorWidget: (context, url, error) => const Icon(
                            Icons.error,
                            color: AppColorPallete.red,
                          ),
                        ),
                      )
                    : Container(
                        height: 80,
                        width: 80,
                        padding: const EdgeInsets.all(10),
                        color: AppColorPallete.lightGrey,
                        child: Image.asset(
                          AssetConstants.imUserProfile,
                          fit: BoxFit.cover,
                        ),
                      ),
                const SizedBox(height: 60, child: VerticalDivider()),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            customer.name,
                            style: AppTypoGraphy.bodyLarge,
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                AssetConstants.icPhone,
                                height: 20,
                                width: 20,
                              ),
                              GapConstant.size(w: 5),
                              SvgPicture.asset(
                                AssetConstants.icWhatsApp,
                                height: 25,
                                width: 25,
                              ),
                            ],
                          )
                        ],
                      ),
                      GapConstant.h4,
                      Text(
                        "ID :${customer.id}",
                        style: AppTypoGraphy.darkGreyBold12,
                      ),
                      GapConstant.h4,
                      Text(
                        "${customer.street}, ${customer.city}, ${customer.state}",
                        style: AppTypoGraphy.darkGreyBold12,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  onCustomerSelection(BuildContext context) {
    context.read<CustomerBloc>().add(CustomerSelectEvent(customer));
    context.read<CartBloc>().add(CartAddCustomerEvent(customer: customer));
  }
}
