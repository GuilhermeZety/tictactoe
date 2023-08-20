import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tictactoe/app/core/common/errors/failures.dart';

abstract class Usecase<ReturnType, Params> {
  Future<Either<Failure, ReturnType>> call(Params params);
}

abstract class StreamUsecase<ReturnType, Params> {
  Future<Either<Failure, Stream<ReturnType>>> call(Params params);
}

//Parametros para serem passados caso não tenha parametros
class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
