import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppy/core/utils/api_constants.dart';
import 'package:shoppy/core/utils/app_typography.dart';
import 'package:shoppy/core/utils/gap_constants.dart';
import 'package:shoppy/domain/entity/customer.dart';
import 'package:shoppy/presentation/bloc/customer_bloc/customer_bloc.dart';

class CustomerListItem extends StatelessWidget {
  const CustomerListItem({super.key, required this.customer});
  final Customer customer;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerBloc, CustomerState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            context.read<CustomerBloc>().add(CustomerSelectEvent(customer));
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: customer.isSelected
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
                              ApiConstants.imageUrl + customer.profilePic!,
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Container(
                        height: 80,
                        width: 80,
                        color: Colors.grey,
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
                              const Icon(
                                Icons.circle_notifications,
                                color: Colors.blue,
                                size: 20,
                              ),
                              GapConstant.size(w: 5),
                              const Icon(
                                Icons.phone,
                                size: 20,
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
}
