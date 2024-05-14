import 'package:shoppy/domain/entity/product.dart';
import 'package:shoppy/domain/entity/product_hive_model.dart';

class ProductMapper {
  static ProductHiveModel toHiveModel(Product product) =>
      ProductHiveModel(product.quantity, product.totalAmount,
          id: product.id,
          name: product.name,
          image: product.image,
          price: product.price,
          createdDate: product.createdDate,
          createdTime: product.createdTime,
          modifiedDate: product.modifiedDate,
          modifiedTime: product.modifiedTime,
          flag: product.flag);

  static Product toProductModel(ProductHiveModel product) => Product(
      id: product.id,
      name: product.name,
      image: product.image,
      price: product.price,
      createdDate: product.createdDate,
      createdTime: product.createdTime,
      modifiedDate: product.modifiedDate,
      modifiedTime: product.modifiedTime,
      flag: product.flag);

  static List<ProductHiveModel> toHiveList(List<Product> productList) =>
      productList.map((product) => toHiveModel(product)).toList();
  static List<Product> toProductList(List<ProductHiveModel> productList) =>
      productList.map((product) => toProductModel(product)).toList();
}
