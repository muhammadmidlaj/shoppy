import 'package:flutter/material.dart';
import 'package:shoppy/core/utils/app_typography.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _customeAppBar(),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) => Container(
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
              Container(
                height: 50,
                width: 60,
                color: Colors.grey.withOpacity(0.6),
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Onion",
                    style: AppTypoGraphy.bodyLarge,
                  ),
                  Text(
                    "\$100 /kg",
                    style: AppTypoGraphy.bodyMedium,
                  ),
                ],
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
                      onPressed: () {},
                      alignment: Alignment.center,
                      icon: const Icon(Icons.remove),
                      iconSize: 15,
                      constraints:
                          const BoxConstraints(maxHeight: 30, maxWidth: 30),
                    ),
                    const Text(
                      "1",
                      style: AppTypoGraphy.bodyLarge,
                    ),
                    IconButton.filled(
                      onPressed: () {},
                      alignment: Alignment.center,
                      icon: const Icon(Icons.add),
                      iconSize: 15,
                      constraints:
                          const BoxConstraints(maxHeight: 30, maxWidth: 30),
                    ),
                  ],
                ),
              ),
              const Text(
                "\$10",
                style: AppTypoGraphy.titleLarge,
              )
            ],
          ),
        ),
      ),
    );
  }

  AppBar _customeAppBar() {
    return AppBar(
      leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.keyboard_arrow_left)),
      title: const Text("My Cart"),
      centerTitle: true,
    );
  }
}
