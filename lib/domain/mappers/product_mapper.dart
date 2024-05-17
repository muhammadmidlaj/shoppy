import 'package:shoppy/core/utils/typedef.dart';
import 'package:shoppy/data/model/product_model.dart';
import 'package:shoppy/domain/entity/product.dart';
import 'package:shoppy/domain/entity/product_hive_model.dart';

class ProductMapper {
  static ProductHiveModel toHiveModel(Product product) => ProductHiveModel(
        product.quantity,
        product.totalAmount,
        id: product.id,
        name: product.name,
        image: product.image,
        price: product.price,
        createdDate: product.createdDate,
        createdTime: product.createdTime,
        modifiedDate: product.modifiedDate,
        modifiedTime: product.modifiedTime,
        flag: product.flag,
      );

  static Product toProduct(ProductHiveModel product) => Product(
      id: product.id,
      name: product.name,
      image: product.image,
      price: product.price,
      createdDate: product.createdDate,
      createdTime: product.createdTime,
      modifiedDate: product.modifiedDate,
      modifiedTime: product.modifiedTime,
      flag: product.flag,
      quantity: product.quantity,
      totalAmount: product.totalAmount);
  static ProductModel toProductModel(Product product) => ProductModel(
        id: product.id,
        name: product.name,
        image: product.image,
        price: product.price,
        createdDate: product.createdDate,
        createdTime: product.createdTime,
        modifiedDate: product.modifiedDate,
        modifiedTime: product.modifiedTime,
        flag: product.flag,
      );

  static List<ProductModel> toModelList(List<Product> productList) =>
      productList.map((product) => toProductModel(product)).toList();

  static List<ProductHiveModel> toHiveList(ProductList productList) =>
      productList.map((product) => toHiveModel(product)).toList();
  static ProductList toProductList(List<ProductHiveModel> productList) =>
      productList.map((product) => toProduct(product)).toList();
}
