import 'package:flutter_modular/flutter_modular.dart';
import 'package:tictactoe/app/core/common/errors/failures.dart';
import 'package:tictactoe/app/core/shared/room/domain/usecases/get_room.dart';
import 'package:tictactoe/app/core/shared/room/domain/usecases/update_room.dart';
import 'package:tictactoe/main.dart';

class JoinRoomService {
  Future<int> joinRoom(int roomId) async {
    var response = await Modular.get<GetRoom>()(GetRoomParams(roomId: roomId));

    return await response.fold((l) => throw l, (room) async {
      if (room.opponentUuid != null && room.opponentUuid != session.userUuid && room.hostUuid != session.userUuid) {
        throw const Failure(message: 'A sala já está cheia!');
      }
      if (room.hostUuid != session.userUuid) {
        room.opponentUuid = session.userUuid;
      }

      var update = await Modular.get<UpdateRoom>()(UpdateRoomParams(room: room));

      return update.fold((l) => throw l, (r) => room.id);
    });
  }
}
