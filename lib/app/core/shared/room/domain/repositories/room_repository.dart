import 'package:dartz/dartz.dart';
import 'package:tictactoe/app/core/common/errors/failures.dart';
import 'package:tictactoe/app/core/shared/room/domain/entities/room_entity.dart';

abstract class RoomRepository {
  Future<Either<Failure, Stream<RoomEntity>>> getRoom(int roomId);
}
