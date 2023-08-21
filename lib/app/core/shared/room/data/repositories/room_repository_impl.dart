// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:tictactoe/app/core/common/errors/failures.dart';
import 'package:tictactoe/app/core/common/services/treater/treater_service.dart';
import 'package:tictactoe/app/core/shared/room/data/datasources/datasource/room_datasource.dart';
import 'package:tictactoe/app/core/shared/room/domain/entities/room_entity.dart';
import 'package:tictactoe/app/core/shared/room/domain/repositories/room_repository.dart';

class RoomRepositoryImpl extends RoomRepository {
  final RoomDatasource datasource;

  RoomRepositoryImpl({
    required this.datasource,
  });

  @override
  Future<Either<Failure, RoomEntity>> getRoom(int roomId) {
    return TreaterService()<RoomEntity>(
      () async {
        return await datasource.getRoom(roomId);
      },
      errorIdentification: 'Erro ao buscar a sala',
    );
  }

  @override
  Future<Either<Failure, Stream<RoomEntity?>>> getRoomStream(int roomId) {
    return TreaterService()<Stream<RoomEntity?>>(
      () async {
        return await datasource.getRoomStream(roomId);
      },
      errorIdentification: 'Erro ao buscar a sala',
    );
  }

  @override
  Future<Either<Failure, int>> createRoom(String hostUuid) {
    return TreaterService()<int>(
      () async {
        return await datasource.createRoom(hostUuid);
      },
      errorIdentification: 'Erro ao criar a sala',
    );
  }

  @override
  Future<Either<Failure, bool>> closeRoom(int roomId) {
    return TreaterService()<bool>(
      () async {
        return await datasource.closeRoom(roomId);
      },
      errorIdentification: 'Erro ao fechar a sala',
    );
  }

  @override
  Future<Either<Failure, bool>> updateRoom(RoomEntity room) {
    return TreaterService()<bool>(
      () async {
        return await datasource.updateRoom(room);
      },
      errorIdentification: 'Erro ao atualizar a sala',
    );
  }
}
