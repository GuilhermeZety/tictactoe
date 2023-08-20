import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tictactoe/app/core/shared/room/domain/entities/room_entity.dart';
import 'package:tictactoe/app/modules/game/presentation/game_service.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit() : super(GameInitial());
  GameService service = GameService();

  RoomEntity? room;

  Future init(int roomId) async {
    await service.getRoom(roomId);

    if (service.roomStream == null) {
      emit(const GameError(message: 'Sala não encontrada'));
      return;
    }

    service.listenReturn((_) {
      room = _;
      if (state is GameInitial) emit(GameUpdated());
      emit(GameInitial());
    });
  }

  // void exitRoom(BuildContext context) async {
  //   var sure = await ExitRoomModal.show(context);

  //   if (sure == true) {
  //     await service.exit(room!.id);
  //     emit(GameExit());
  //   }
  // }

  void dispose() {
    service.dispose();
    super.close();
  }
}
