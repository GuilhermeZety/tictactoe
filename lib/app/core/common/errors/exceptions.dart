// ignore_for_file: public_member_api_docs, sort_constructors_first
class ServerException implements Exception {
  final String? message;
  final StackTrace? stackTrace;
  ServerException({
    this.message,
    this.stackTrace,
  });
}

class DBException implements Exception {
  final String? message;
  final StackTrace? stackTrace;
  DBException({
    this.message,
    this.stackTrace,
  });
}
