import 'package:fpdart/fpdart.dart';

import '../model/error_model.dart';

abstract interface class Usecase<SuccessType, Params> {
  Future<Either<ErrorModel, SuccessType>> call(Params params);
}

class NoParams {}
