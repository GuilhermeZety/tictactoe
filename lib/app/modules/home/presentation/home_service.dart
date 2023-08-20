import 'package:flutter_modular/flutter_modular.dart';
import 'package:tictactoe/app/core/shared/room/domain/usecases/create_room.dart';
import 'package:tictactoe/main.dart';

class HomeService {
  Future<int> createRoom() async {
    var response = await Modular.get<CreateRoom>()(CreateRoomParams(hostUuid: session.userUuid!));

    return response.fold(
      (l) => throw l,
      (r) => r,
    );
  }
}
