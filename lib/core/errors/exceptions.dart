import 'package:equatable/equatable.dart';

class ServerException extends Equatable implements Exception {
  final String? message;

  const ServerException([this.message]);

  @override
  List<Object?> get props => [message];

  @override
  String toString() => '$message';
}

class FetchDataException extends ServerException {
  const FetchDataException([message]) : super('Error During Communication');
}

class BadRequestException extends ServerException {
  const BadRequestException([message]) : super(message);
}

class UnauthorizedException extends ServerException {
  const UnauthorizedException([message]) : super(message);
}

class NotFoundException extends ServerException {
  const NotFoundException([message]) : super(message);
}

class ForbiddenException extends ServerException {
  const ForbiddenException([message]) : super('Forbidden');
}

class ConflictException extends ServerException {
  const ConflictException([message]) : super('Conflict');
}

class UnProcessableEntityException extends ServerException {
  const UnProcessableEntityException([message]) : super(message);
}

class InternalServerErrorException extends ServerException {
  const InternalServerErrorException([message])
      : super('Internal Server Error');
}

class NoInternetException extends ServerException {
  const NoInternetException([message]) : super('No Internet');
}

class CachedException implements Exception {}
