import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shoppy/core/constants/asset_constants.dart';
import 'package:shoppy/core/di/injection.dart';
import 'package:shoppy/core/network/connection_checker.dart';
import 'package:shoppy/core/utils/app_colors.dart';
import 'package:shoppy/data/datasource/remote_data_source.dart';
import 'package:shoppy/presentation/bloc/cart_bloc/cart_bloc.dart';
import 'package:shoppy/presentation/screens/customer_screen.dart';
import 'package:shoppy/presentation/screens/home_screen.dart';
import 'package:shoppy/presentation/screens/order_success_screen.dart';
import 'package:shoppy/presentation/screens/product_screen.dart';
import 'package:http/http.dart' as http;

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  @override
  void initState() {
    super.initState();
  }

  int currentIndex = 0;

  List<Widget> screenList = const [
    HomeScreen(),
    ProductScreen(
      isFromNavigationbar: true,
    ),
    CustomerScreen(
      isFromNavigationbar: true,
    )
  ];

  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> navigationItems = [
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          AssetConstants.icHome,
          colorFilter: ColorFilter.mode(
              currentIndex == 0
                  ? AppColorPallete.primaryColor
                  : AppColorPallete.semiGrey,
              BlendMode.srcIn),
        ),
        label: "Home",
      ),
      BottomNavigationBarItem(
          icon: SvgPicture.asset(
            AssetConstants.icBox,
            colorFilter: ColorFilter.mode(
                currentIndex == 1
                    ? AppColorPallete.primaryColor
                    : AppColorPallete.semiGrey,
                BlendMode.srcIn),
          ),
          label: "Product"),
      BottomNavigationBarItem(
          icon: SvgPicture.asset(
            AssetConstants.icUsers,
            colorFilter: ColorFilter.mode(
                currentIndex == 2
                    ? AppColorPallete.primaryColor
                    : AppColorPallete.semiGrey,
                BlendMode.srcIn),
          ),
          label: "Customers")
    ];

    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: screenList,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        backgroundColor: Colors.white,
        unselectedItemColor: const Color(0xFF9E9E9E),
        selectedItemColor: Colors.green,
        type: BottomNavigationBarType.fixed,
        items: navigationItems,
        onTap: onTabSelection,
      ),
    );
  }

  void onTabSelection(int index) {
    setState(() {
      currentIndex = index;
    });
  }
}
