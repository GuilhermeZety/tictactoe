import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:tictactoe/app/core/shared/room/domain/entities/room_entity.dart';
import 'package:tictactoe/app/core/shared/room/domain/usecases/close_room.dart';
import 'package:tictactoe/app/core/shared/room/domain/usecases/get_room_stream.dart';

class GameService {
  late StreamSubscription roomSubscription;
  Stream<RoomEntity?>? roomStream;

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
}
