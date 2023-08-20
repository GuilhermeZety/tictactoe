import 'package:dartz/dartz.dart';
import 'package:tictactoe/app/core/common/errors/failures.dart';
import 'package:tictactoe/app/core/common/features/usecases/usecase.dart';
import 'package:tictactoe/app/core/shared/room/domain/repositories/room_repository.dart';

class CloseRoom extends Usecase<bool, CloseRoomParams> {
  final RoomRepository repository;

  CloseRoom({
    required this.repository,
  });

  @override
  Future<Either<Failure, bool>> call(
    CloseRoomParams params,
  ) async {
    return await repository.closeRoom(params.roomId);
  }
}

class CloseRoomParams {
  final int roomId;

  CloseRoomParams({
    required this.roomId,
  });
}
