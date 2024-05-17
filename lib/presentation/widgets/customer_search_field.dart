import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppy/core/constants/gap_constants.dart';
import 'package:shoppy/core/utils/app_colors.dart';
import 'package:shoppy/core/utils/app_typography.dart';
import 'package:shoppy/core/utils/debouncer.dart';
import 'package:shoppy/presentation/bloc/customer_bloc/customer_bloc.dart';

class CustomerSearchField extends StatefulWidget {
  const CustomerSearchField({super.key});

  @override
  State<CustomerSearchField> createState() => _CustomerSearchFieldState();
}

class _CustomerSearchFieldState extends State<CustomerSearchField> {
  final TextEditingController searchController = TextEditingController();
  final Debouncer debouncer = Debouncer();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      decoration: BoxDecoration(
          border: Border.all(color: AppColorPallete.darkGreen),
          borderRadius: BorderRadius.circular(30)),
      child: Center(
        child: TextFormField(
          controller: searchController,
          onChanged: (value) {
            debouncer.run(() {
              if (value.isEmpty) {
                context.read<CustomerBloc>().add(const CustomerFetchEvent());
              }
              context
                  .read<CustomerBloc>()
                  .add(CustomerSearchEvent(searchText: value));
            });
          },
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Search",
              prefixIcon: const Icon(
                Icons.search_rounded,
                color: AppColorPallete.grey,
              ),
              hintStyle: AppTypoGraphy.bodyLarge.copyWith(
                color: AppColorPallete.grey,
              ),
              suffixIcon: searchController.text.isEmpty
                  ? const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.qr_code),
                        GapConstant.w8,
                        Icon(Icons.person_add),
                        GapConstant.w12
                      ],
                    )
                  : const SizedBox()),
        ),
      ),
    );
  }
}
