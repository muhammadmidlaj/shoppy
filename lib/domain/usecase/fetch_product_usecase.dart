import 'package:shoppy/core/usecase/usecase.dart';
import 'package:shoppy/core/utils/typedef.dart';
import 'package:shoppy/domain/entity/product.dart';
import 'package:shoppy/domain/repositories/repository.dart';

class FetchProductUseCase implements UseCase<List<Product>, NoParams> {
  final Repository _repository;

  FetchProductUseCase(this._repository);

  @override
  Result<List<Product>> call(NoParams params) async {
    return _repository.fetchProducts();
  }
}
