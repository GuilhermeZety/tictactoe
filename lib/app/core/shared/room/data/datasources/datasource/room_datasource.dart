import 'package:tictactoe/app/core/shared/room/data/models/room_model.dart';

abstract class RoomDatasource {
  Future<Stream<RoomModel>> getRoom(int roomId);
}
