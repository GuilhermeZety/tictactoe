import 'package:firebase_database/firebase_database.dart';
import 'package:tictactoe/app/core/common/errors/exceptions.dart';
import 'package:tictactoe/app/core/common/extensions/entities_extension.dart';

import 'package:tictactoe/app/core/shared/room/data/datasources/datasource/room_datasource.dart';
import 'package:tictactoe/app/core/shared/room/data/models/room_model.dart';
import 'package:tictactoe/app/core/shared/room/domain/entities/room_entity.dart';
import 'package:tictactoe/main.dart';

class RoomDatasourceImpl extends RoomDatasource {
  final FirebaseDatabase database;
  RoomDatasourceImpl({
    required this.database,
  });

  @override
  Future<RoomModel> getRoom(int roomId) async {
    var stream = await database
        .ref()
        .child('rooms')
        .child(
          roomId.toString(),
        )
        .get();
    if (stream.value == null) throw ServerException(message: 'Sala não encontrada', stackTrace: StackTrace.current);

    return RoomModel.fromMap(
      Map<String, dynamic>.from(stream.value as Map),
    );
  }

  @override
  Future<Stream<RoomModel>> getRoomStream(int roomId) async {
    var stream = database
        .ref()
        .child('rooms')
        .child(
          roomId.toString(),
        )
        .onValue;

    return stream.map<RoomModel>(
      (event) => RoomModel.fromMap(
        Map<String, dynamic>.from(event.snapshot.value as Map),
      ),
    );
  }

  @override
  Future<int> createRoom(String hostUuid) async {
    int id = 1000;
    var allrooms = await database.ref().child('rooms').get();

    if (allrooms.children.isNotEmpty) {
      id = int.parse(allrooms.children.last.key ?? '0') + 1;
    }
    RoomModel newRoom = RoomModel(id: id, hostUuid: session.userUuid!);

    await database.ref().child('rooms').child(newRoom.id.toString()).set(newRoom.toMap());

    return id;
  }

  @override
  Future<bool> closeRoom(int roomId) async {
    await database.ref().child('rooms').child(roomId.toString()).remove();
    return true;
  }

  @override
  Future<bool> updateRoom(RoomEntity room) async {
    await database.ref().child('rooms').child(room.id.toString()).update(room.as<RoomModel>().toMap());
    return true;
  }
}
