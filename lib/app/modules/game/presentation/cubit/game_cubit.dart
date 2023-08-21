import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:tictactoe/app/core/common/enums/player_type.dart';
import 'package:tictactoe/app/core/shared/room/domain/entities/room_entity.dart';
import 'package:tictactoe/app/modules/game/presentation/game_service.dart';
import 'package:tictactoe/main.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit() : super(GameInitial());
  GameService service = GameService();

  RoomEntity? room;
  PlayerType get playerType => room?.hostUuid == session.userUuid ? PlayerType.host : PlayerType.opponent;

  Future init(int roomId) async {
    emit(GameLoading());
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

  EdgeInsets indexPadding(int index) {
    const double width = 2;
    switch (index) {
      case 0:
      case 1:
      case 3:
      case 4:
        return const EdgeInsets.only(right: width, bottom: width);
      case 2:
      case 5:
        return const EdgeInsets.only(bottom: width);
      case 6:
      case 7:
        return const EdgeInsets.only(right: width);
    }
    return const EdgeInsets.all(0);
  }
}
