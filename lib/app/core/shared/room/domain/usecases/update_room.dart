import 'package:dartz/dartz.dart';
import 'package:tictactoe/app/core/common/errors/failures.dart';
import 'package:tictactoe/app/core/common/features/usecases/usecase.dart';
import 'package:tictactoe/app/core/shared/room/domain/entities/room_entity.dart';
import 'package:tictactoe/app/core/shared/room/domain/repositories/room_repository.dart';

class UpdateRoom extends Usecase<bool, UpdateRoomParams> {
  final RoomRepository repository;

  UpdateRoom({
    required this.repository,
  });

  @override
  Future<Either<Failure, bool>> call(
    UpdateRoomParams params,
  ) async {
    return await repository.updateRoom(params.room);
  }
}

class UpdateRoomParams {
  final RoomEntity room;

  UpdateRoomParams({
    required this.room,
  });
}
