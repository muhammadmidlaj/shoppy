import 'package:shoppy/core/usecase/usecase.dart';
import 'package:shoppy/core/utils/typedef.dart';
import 'package:shoppy/domain/repositories/repository.dart';

class SearchCustomerUseCase
    implements UseCase<CustomerList, SearchCustomerParams> {
  final Repository _repository;

  SearchCustomerUseCase(this._repository);
  @override
  Result<CustomerList> call(SearchCustomerParams params) async {
    return _repository.searchCustomers(params.searchText);
  }
}

class SearchCustomerParams {
  final String searchText;

  SearchCustomerParams({required this.searchText});
}
