import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppy/data/datasource/remote_data_source.dart';
import 'package:shoppy/presentation/bloc/cart_bloc/cart_bloc.dart';
import 'package:shoppy/presentation/screens/customer_screen.dart';
import 'package:shoppy/presentation/screens/home_screen.dart';
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
    context.read<CartBloc>().add(const CartFetchLocalEvent());
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

  List<BottomNavigationBarItem> navigationItems = const [
    BottomNavigationBarItem(
        icon: Icon(Icons.home_outlined),
        activeIcon: Icon(Icons.home_filled),
        label: "Home"),
    BottomNavigationBarItem(
        icon: Icon(Icons.square_outlined),
        activeIcon: Icon(Icons.square),
        label: "Product"),
    BottomNavigationBarItem(
        icon: Icon(Icons.group_outlined),
        activeIcon: Icon(Icons.group),
        label: "Customers")
  ];
  @override
  Widget build(BuildContext context) {
    final RemoteDataSource remoteDataSource =
        RemoteDataSourceImpl(http.Client());
    remoteDataSource.fetchProducts();
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
