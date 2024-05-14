import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppy/core/utils/gap_constants.dart';
import 'package:shoppy/presentation/bloc/customer_bloc/customer_bloc.dart';
import 'package:shoppy/presentation/widgets/customer_list_item.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key, required this.isFromNavigationbar});
  final bool isFromNavigationbar;

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  final TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    context.read<CustomerBloc>().add(const CustomerFetchEvent());
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerBloc, CustomerState>(
      listener: (context, state) {
        if (state is CustomerSelectedState) {
          log("selectedstate ${state.selectedCustomer}");
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: _customeAppBar(),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(30)),
                  child: Center(
                    child: TextFormField(
                      controller: searchController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search",
                          prefixIcon: const Icon(Icons.search_rounded),
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
                ),
                GapConstant.h12,
                if (state is CustomerLoadedState ||
                    state is CustomerSelectedState)
                  Expanded(
                      child: ListView.builder(
                    itemCount: state.customerList.length,
                    itemBuilder: (context, index) => CustomerListItem(
                      customer: state.customerList[index],
                    ),
                  ))
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
      title: const Text("Customers"),
      centerTitle: true,
      actions: const [Icon(Icons.menu), GapConstant.w8],
    );
  }
}
