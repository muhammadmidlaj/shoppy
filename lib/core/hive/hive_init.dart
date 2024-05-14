import "package:hive_flutter/hive_flutter.dart";
import "package:path_provider/path_provider.dart";
import "package:shoppy/core/utils/hive_constants.dart";
import "package:shoppy/domain/entity/customer_hive_model.dart";
import "package:shoppy/domain/entity/product_hive_model.dart";

Future<void> initHive() async {
  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);

  Hive.registerAdapter(ProductHiveModelAdapter());
  Hive.registerAdapter(CustomerHiveModelAdapter());

  await Hive.openBox<ProductHiveModel>(HiveConstants.productBox);
  await Hive.openBox<CustomerHiveModel>(HiveConstants.customerBox);
}
