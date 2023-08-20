// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:tictactoe/app/core/common/errors/failures.dart';
import 'package:tictactoe/app/core/common/features/usecases/usecase.dart';
import 'package:tictactoe/app/core/shared/room/domain/entities/room_entity.dart';
import 'package:tictactoe/app/core/shared/room/domain/repositories/room_repository.dart';

class GetRoom extends StreamUsecase<RoomEntity, GetRoomParams> {
  final RoomRepository repository;

  GetRoom({
    required this.repository,
  });

  @override
  Future<Either<Failure, Stream<RoomEntity>>> call(
    GetRoomParams params,
  ) async {
    return await repository.getRoom(params.roomId);
  }
}

class GetRoomParams {
  final int roomId;

  GetRoomParams({
    required this.roomId,
  });
}
