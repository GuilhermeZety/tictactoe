import 'package:equatable/equatable.dart';

//Modelo padrão para erros futuros
class Failure extends Equatable {
  final String message;
  final StackTrace? stackTrace;

  @override
  List<Object?> get props => [message, stackTrace];

  const Failure({required this.message, this.stackTrace});
}

//General Failures
class ServerFailure extends Failure {
  const ServerFailure({required super.message, super.stackTrace});
}

class DatabaseFailure extends Failure {
  const DatabaseFailure({required super.message, super.stackTrace});
}
