import 'package:dartz/dartz.dart';
import 'package:tictactoe/app/core/common/errors/failures.dart';
import 'package:tictactoe/app/core/common/features/usecases/usecase.dart';
import 'package:tictactoe/app/core/shared/room/domain/repositories/room_repository.dart';

class CreateRoom extends Usecase<int, CreateRoomParams> {
  final RoomRepository repository;

  CreateRoom({
    required this.repository,
  });

  @override
  Future<Either<Failure, int>> call(
    CreateRoomParams params,
  ) async {
    return await repository.createRoom(params.hostUuid);
  }
}

class CreateRoomParams {
  final String hostUuid;

  CreateRoomParams({
    required this.hostUuid,
  });
}
