import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../error/failures.dart';

abstract class BaseUseCase<T, Param> {
  Future<Either<Failure, T>> call(Param param);
}

class NoParam extends Equatable {
  @override
  List<Object?> get props => [];
}
