import 'package:equatable/equatable.dart';

//Modelo padrão para erros futuros
class Failure extends Equatable {
  final String title;
  final String? description;
  final StackTrace? stackTrace;

  @override
  List<Object?> get props => [title, description, stackTrace];

  const Failure({required this.title, this.description, this.stackTrace});
}

//General Failures
class ServerFailure extends Failure {
  const ServerFailure({required super.title, super.description, super.stackTrace});
}

class DatabaseFailure extends Failure {
  const DatabaseFailure({required super.title, super.description, super.stackTrace});
}
