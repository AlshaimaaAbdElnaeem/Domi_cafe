import 'package:dartz/dartz.dart';
import 'package:domi_cafe/core/utils/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

