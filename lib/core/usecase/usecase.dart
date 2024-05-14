
import 'package:shoppy/core/utils/typedef.dart';

abstract class UseCase<Type, Params> {
 Result<Type> call(Params params);
}

class NoParams {
  
}
