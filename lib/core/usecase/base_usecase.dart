import 'package:dartz/dartz.dart';

import '../error/failures.dart';

abstract class BaseUseCase<T> {
  Future<Either<Failure, T>> call();
}
