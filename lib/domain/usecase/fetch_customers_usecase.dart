import 'package:shoppy/core/usecase/usecase.dart';
import 'package:shoppy/core/utils/typedef.dart';
import 'package:shoppy/domain/repositories/repository.dart';

class FetchCustomersUseCase implements UseCase<CustomerList, NoParams> {
  final Repository _repository;

  FetchCustomersUseCase(this._repository);
  @override
  Result<CustomerList> call(NoParams params) async {
    return _repository.fetchCustomers();
  }
}
