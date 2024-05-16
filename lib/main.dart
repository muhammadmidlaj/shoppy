import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';
import 'package:shoppy/core/di/injection.dart';
import 'package:shoppy/core/hive/hive_init.dart';
import 'package:shoppy/core/utils/app_colors.dart';
import 'package:shoppy/presentation/bloc/cart_bloc/cart_bloc.dart';
import 'package:shoppy/presentation/bloc/customer_bloc/customer_bloc.dart';
import 'package:shoppy/presentation/bloc/order_bloc/order_bloc.dart';
import 'package:shoppy/presentation/bloc/product_bloc/product_bloc.dart';
import 'package:shoppy/presentation/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await init();
  await initHive();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => locator<ProductBloc>()),
        BlocProvider(create: (context) => locator<CartBloc>()),
        BlocProvider(create: (context) => locator<CustomerBloc>()),
        BlocProvider(create: (context) => locator<OrderBloc>()),
      ],
      child: OKToast(
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Shoppy',
            theme: ThemeData(
              colorScheme:
                  ColorScheme.fromSeed(seedColor: AppColorPallete.primaryColor),
              useMaterial3: true,
            ),
            home: const SplashScreen()),
      ),
    );
  }
}
