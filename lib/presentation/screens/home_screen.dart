import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:shoppy/core/constants/asset_constants.dart';

import 'package:shoppy/core/utils/app_colors.dart';
import 'package:shoppy/core/utils/app_typography.dart';
import 'package:shoppy/core/utils/extentions.dart';
import 'package:shoppy/core/constants/gap_constants.dart';

import 'package:shoppy/core/utils/shimmer_components.dart';
import 'package:shoppy/domain/entity/product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customeAppBar(),
      body: SafeArea(
        child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(
                    child: Column(
                  children: [
                    const SearchField(),
                    GapConstant.h12,
                    const BannerSection(),
                    GapConstant.h12,
                    const CategorySection(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Discovery",
                            style: AppTypoGraphy.bodyLarge
                                .copyWith(color: AppColorPallete.darkGreen),
                          ),
                          TextButton(
                              onPressed: () {},
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text("See all"),
                                  Icon(Icons.keyboard_arrow_right)
                                ],
                              ))
                        ],
                      ),
                    ),
                  ],
                ))
              ];
            },
            body: DiscoverySection()),

        // CustomScrollView(
        //   slivers: [
        //     SliverToBoxAdapter(
        //       child: Column(
        //         children: [
        //           TitleSection(),
        //           SearchField(),
        //           GapConstant.h12,
        //           BannerSection(),
        //           GapConstant.h12,
        //           CategorySection(),
        //           DiscoverySection()
        //         ],
        //       ),
        //     )
        //   ],
        //  Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     TitleSection(),
        //     SearchField(),
        //     GapConstant.h12,
        //     BannerSection(),
        //     GapConstant.h12,
        //     CategorySection(),
        //     DiscoverySection(),
        //   ],
        // ),
      ),
    );
  }

  AppBar customeAppBar() {
    return AppBar(
        title: Text(
          "Good day! 👋",
          style: AppTypoGraphy.titleLarge
              .copyWith(color: AppColorPallete.darkGreen),
        ),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.shopping_cart_outlined))
        ]);
  }
}

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const SearchScreen()));
      },
      child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 26),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
              color: AppColorPallete.white,
              //border: Border.all(),
              borderRadius: BorderRadius.circular(30),
              boxShadow: const [
                BoxShadow(
                    offset: Offset(0, 0),
                    blurRadius: 28,
                    spreadRadius: 11,
                    color: AppColorPallete.lightGrey)
              ]),
          child: Row(
            children: [
              const Icon(
                Icons.search_rounded,
                color: AppColorPallete.grey,
              ),
              GapConstant.w12,
              Text(
                "Search grocery",
                style: AppTypoGraphy.labelLarge
                    .copyWith(color: AppColorPallete.grey),
              )
            ],
          )),
    );
  }
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();

  List<Category> searchList = [];

  @override
  void initState() {
    searchList.addAll(categoryList);
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorPallete.white,
      appBar: AppBar(
        // backgroundColor: AppColorPallete.lightGreen,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.keyboard_arrow_left)),
        title: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
              color: AppColorPallete.white,
              //border: Border.all(),
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(
                    offset: Offset(0, 0),
                    blurRadius: 28,
                    spreadRadius: 5,
                    color: AppColorPallete.lightGrey)
              ]),
          child: TextFormField(
            controller: searchController,
            onChanged: (value) {
              searchList.clear();
              if (value.isEmpty) {
                searchList.addAll(categoryList);
                setState(() {});
                return;
              }

              List<Category> searchResult = categoryList
                  .where((element) => element.name
                      .toLowerCase()
                      .startsWith(value.toLowerCase()))
                  .toList();
              setState(() {
                searchList.addAll(searchResult);
              });
            },
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "Search",
              prefixIcon: Icon(Icons.search_rounded),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: ListView.separated(
          separatorBuilder: (context, index) => const Divider(),
          itemCount: searchList.length,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(10),
              color: Colors.white,
              child: Row(
                children: [
                  Image.asset(
                    searchList[index].imagePath,
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                  GapConstant.w20,
                  Text(searchList[index].name.capitalizeFirstLetter()),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

List<String> bannerImageList = [
  "https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/18d60b107187879.5fa16aecd880f.jpg",
  "https://static.vecteezy.com/system/resources/previews/002/038/227/large_2x/best-offer-sale-banner-for-online-shopping-vector.jpg",
  "https://image.freepik.com/free-vector/online-shopping-banner-with-large-smartphone-with-presents-boxes-around-blue-background_7993-6365.jpg",
  "https://thumbs.dreamstime.com/b/grocery-food-store-shopping-basket-promotional-sale-banner-grocery-food-store-shopping-basket-promotional-sale-banner-196209213.jpg",
  "https://static.vecteezy.com/system/resources/previews/000/178/364/original/super-sale-offer-and-discount-banner-template-for-marketing-and-vector.jpg"
];

class BannerSection extends StatelessWidget {
  const BannerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
          height: 200.0,
          initialPage: 0,
          reverse: false,
          enableInfiniteScroll: false,
          viewportFraction: 0.8,
          enlargeCenterPage: true,
          enlargeFactor: 0.1),
      items: bannerImageList.map((image) {
        return Builder(
          builder: (BuildContext context) {
            return ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: CachedNetworkImage(
                  imageUrl: image,
                  fit: BoxFit.cover,
                  height: 200,
                  width: 300,
                  placeholder: (context, url) => const ShimmerBox(),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error,
                    color: AppColorPallete.red,
                  ),
                ));
          },
        );
      }).toList(),
    );
  }
}

class Category {
  final String name;
  final String imagePath;

  Category({required this.name, required this.imagePath});
}

List<Category> categoryList = [
  Category(name: "Fruit", imagePath: AssetConstants.imFruits),
  Category(name: "Veggie", imagePath: AssetConstants.imVeggies),
  Category(name: "Spice", imagePath: AssetConstants.imSpices),
  Category(name: "Beverage", imagePath: AssetConstants.imBeverage),
  Category(name: "Meat", imagePath: AssetConstants.imMeat),
  Category(name: "Bread", imagePath: AssetConstants.imBread),
  Category(name: "Snack", imagePath: AssetConstants.imSnacks),
];

class CategorySection extends StatelessWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            "Categories",
            style: AppTypoGraphy.bodyLarge
                .copyWith(color: AppColorPallete.darkGreen),
          ),
        ),
        GapConstant.h12,
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            height: 80,
            width: MediaQuery.of(context).size.width,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: categoryList.length,
              separatorBuilder: (context, index) => GapConstant.w16,
              itemBuilder: (context, index) => Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(0, 0),
                          blurRadius: 1,
                          spreadRadius: 1,
                          color: AppColorPallete.lightGrey)
                    ]),
                width: 100,
                child: Column(
                  children: [
                    Image.asset(
                      categoryList[index].imagePath,
                      height: 50,
                      width: 50,
                    ),
                    Text(categoryList[index].name)
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class DiscoverySection extends StatefulWidget {
  const DiscoverySection({super.key});

  @override
  State<DiscoverySection> createState() => _DiscoverySectionState();
}

class _DiscoverySectionState extends State<DiscoverySection> {
  List<Product> favouriteProduct = [];
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(
        child: GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 12.0,
            childAspectRatio: 0.9,
          ),
          itemCount: productList.length,
          itemBuilder: (context, index) {
            return Container(
              //margin: const EdgeInsets.all(4),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(15, 120, 119, 119),
                    blurRadius: 12,
                    offset: Offset(0, 0),
                    spreadRadius: 5,
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 100,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Image.asset(
                              productList[index].image,
                              errorBuilder: (context, obj, error) =>
                                  const Icon(Icons.error_outline),
                              height: 100,
                              width: 80,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: IconButton(
                                onPressed: () {
                                  if (favouriteProduct
                                      .contains(productList[index])) {
                                    favouriteProduct.remove(productList[index]);
                                  } else {
                                    favouriteProduct.add(productList[index]);
                                  }
                                  setState(() {});
                                },
                                icon: Icon(
                                  favouriteProduct.contains(productList[index])
                                      ? Icons.favorite
                                      : Icons.favorite_outline,
                                  color: AppColorPallete.red,
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                  GapConstant.h8,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productList[index].name.capitalizeFirstLetter(),
                        style: AppTypoGraphy.labelLarge,
                        overflow: TextOverflow.ellipsis,
                      ),
                      GapConstant.h4,
                      IntrinsicHeight(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                            Text(
                              "₹${productList[index].price}/kg",
                              style: AppTypoGraphy.labelLarge.copyWith(
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            GapConstant.w8,
                            IconButton.filled(
                              onPressed: () {},
                              icon: const Icon(Icons.add),
                              iconSize: 20,
                            )
                          ]))
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      )
    ]);
  }
}

List<Product> productList = [
  Product(
      id: 1,
      name: "Chicken",
      image: AssetConstants.imChicken,
      price: 150,
      createdDate: DateTime.now(),
      createdTime: "",
      modifiedDate: DateTime.now(),
      modifiedTime: "",
      flag: true),
  Product(
      id: 2,
      name: "Beef",
      image: AssetConstants.imBeef,
      price: 200,
      createdDate: DateTime.now(),
      createdTime: "",
      modifiedDate: DateTime.now(),
      modifiedTime: "",
      flag: true),
  Product(
      id: 3,
      name: "Apple",
      image: AssetConstants.imApple,
      price: 80,
      createdDate: DateTime.now(),
      createdTime: "",
      modifiedDate: DateTime.now(),
      modifiedTime: "",
      flag: true),
  Product(
      id: 4,
      name: "Tomato",
      image: AssetConstants.imTomato,
      price: 30,
      createdDate: DateTime.now(),
      createdTime: "",
      modifiedDate: DateTime.now(),
      modifiedTime: "",
      flag: true),
];
