import 'package:shoppy/core/usecase/usecase.dart';
import 'package:shoppy/core/utils/typedef.dart';
import 'package:shoppy/domain/entity/customer.dart';
import 'package:shoppy/domain/repositories/repository.dart';

class FetchCustomersUseCase implements UseCase<List<Customer>, NoParams> {
  final Repository _repository;

  FetchCustomersUseCase(this._repository);
  @override
  Result<List<Customer>> call(NoParams params) async {
    return _repository.fetchCustomers();
  }
}
