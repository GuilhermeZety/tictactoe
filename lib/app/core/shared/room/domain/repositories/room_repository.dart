import 'package:dartz/dartz.dart';
import 'package:tictactoe/app/core/common/errors/failures.dart';
import 'package:tictactoe/app/core/shared/room/domain/entities/room_entity.dart';

abstract class RoomRepository {
  Future<Either<Failure, Stream<RoomEntity>>> getRoomStream(int roomId);
  Future<Either<Failure, RoomEntity>> getRoom(int roomId);
  Future<Either<Failure, int>> createRoom(String hostUuid);
  Future<Either<Failure, bool>> closeRoom(int roomId);
  Future<Either<Failure, bool>> updateRoom(RoomEntity room);
}
