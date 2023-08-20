import 'package:tictactoe/app/core/shared/room/data/datasources/datasource/room_datasource.dart';
import 'package:tictactoe/app/core/shared/room/data/models/room_model.dart';
import 'package:tictactoe/main.dart';

class RoomDatasourceImpl extends RoomDatasource {
  @override
  Future<Stream<RoomModel>> getRoom(int roomId) async {
    var stream = session.database.ref().child('rooms').child(roomId.toString()).onValue;

    return stream.map<RoomModel>((event) => RoomModel.fromMap(Map<String, dynamic>.from(event.snapshot.value as Map)));
  }
}
