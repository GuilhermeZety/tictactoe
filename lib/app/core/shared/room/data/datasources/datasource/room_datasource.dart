import 'package:tictactoe/app/core/shared/room/data/models/room_model.dart';
import 'package:tictactoe/app/core/shared/room/domain/entities/room_entity.dart';

abstract class RoomDatasource {
  Future<Stream<RoomModel>> getRoomStream(int roomId);
  Future<RoomModel> getRoom(int roomId);
  Future<int> createRoom(String hostUuid);
  Future<bool> closeRoom(int roomId);
  Future<bool> updateRoom(RoomEntity room);
}
