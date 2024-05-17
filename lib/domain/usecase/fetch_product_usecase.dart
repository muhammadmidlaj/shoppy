import 'package:shoppy/core/usecase/usecase.dart';
import 'package:shoppy/core/utils/typedef.dart';
import 'package:shoppy/domain/repositories/repository.dart';

class FetchProductUseCase implements UseCase<ProductList, NoParams> {
  final Repository _repository;

  FetchProductUseCase(this._repository);

  @override
  Result<ProductList> call(NoParams params) async {
    return _repository.fetchProducts();
  }
}
