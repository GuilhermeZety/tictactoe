// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:tictactoe/app/core/common/errors/failures.dart';
import 'package:tictactoe/app/core/common/features/usecases/usecase.dart';
import 'package:tictactoe/app/core/shared/room/domain/entities/room_entity.dart';
import 'package:tictactoe/app/core/shared/room/domain/repositories/room_repository.dart';

class GetRoomStream extends StreamUsecase<RoomEntity, GetRoomStreamParams> {
  final RoomRepository repository;

  GetRoomStream({
    required this.repository,
  });

  @override
  Future<Either<Failure, Stream<RoomEntity>>> call(
    GetRoomStreamParams params,
  ) async {
    return await repository.getRoomStream(params.roomId);
  }
}

class GetRoomStreamParams {
  final int roomId;

  GetRoomStreamParams({
    required this.roomId,
  });
}
