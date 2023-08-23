import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:tictactoe/app/core/common/enums/player_type.dart';
import 'package:tictactoe/app/core/shared/room/domain/entities/room_entity.dart';
import 'package:tictactoe/app/core/shared/room/domain/usecases/close_room.dart';
import 'package:tictactoe/app/core/shared/room/domain/usecases/get_room_stream.dart';
import 'package:tictactoe/app/core/shared/room/domain/usecases/update_room.dart';

class GameService {
  late StreamSubscription roomSubscription;
  Stream<RoomEntity?>? roomStream;

  Future<void> select(RoomEntity room, int index, PlayerType playerType) async {
    room.board[index] = playerType == PlayerType.host ? 1 : 2;
    room.turn = playerType == PlayerType.host ? PlayerType.opponent : PlayerType.host;

    await Modular.get<UpdateRoom>()(UpdateRoomParams(room: room));
  }

  Future<void> getRoom(int roomId) async {
    final response = await Modular.get<GetRoomStream>()(GetRoomStreamParams(roomId: roomId));

    if (response.isLeft()) {
      throw response.fold((l) => l, (r) => r);
    }

    roomStream = response.fold((l) => const Stream.empty(), (r) => r);
  }

  void listenReturn(Function(RoomEntity?) event) {
    if (roomStream == null) return;
    roomSubscription = roomStream!.listen(event);
  }

  Future exit(int roomId) async {
    await Modular.get<CloseRoom>()(CloseRoomParams(roomId: roomId));
  }

  void dispose() {
    roomSubscription.cancel();
  }

  List<List<int>> winPossibilities = [
    [0, 1, 2], // Horizontal
    [3, 4, 5],
    [6, 7, 8],
    
    [0, 3, 6], // Vertical
    [1, 4, 7],
    [2, 5, 8],

    [0, 4, 8], // Diagonal
    [2, 4, 6],
  ];
}
