import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:tictactoe/app/core/common/enums/player_type.dart';
import 'package:tictactoe/app/core/shared/room/domain/entities/room_entity.dart';
import 'package:tictactoe/app/modules/game/presentation/game_service.dart';
import 'package:tictactoe/app/modules/new_room/presentation/components/exit_room_modal.dart';
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
      if (_ == null) {
        emit(GameExit());
      }
      room = _;
      if (room != null && room!.replay == (true, true)) {
        room!.replay = (false, false);
        service.update(room!);
      }
      emit(GameUpdated());
      if (_ != null && (_.board.where((element) => element == 1).length > 2 || _.board.where((element) => element == 2).length > 2)) {
        List<int> hostIndex = [];
        List<int> opponentIndex = [];

        for (var i = 0; i < _.board.length; i++) {
          if (_.board[i] == 1) {
            hostIndex.add(i);
          }
          if (_.board[i] == 2) {
            opponentIndex.add(i);
          }
        }

        //1
        if (hostIndex.length > 2) {
          for (var winPossibility in service.winPossibilities) {
            if (hostIndex.contains(winPossibility[0]) && hostIndex.contains(winPossibility[1]) && hostIndex.contains(winPossibility[2])) {
              emit(GameWin(playerUuid: room!.hostUuid));
              return;
            }
          }
        }
        //2
        if (opponentIndex.length > 2) {
          for (var winPossibility in service.winPossibilities) {
            if (opponentIndex.contains(winPossibility[0]) && opponentIndex.contains(winPossibility[1]) && opponentIndex.contains(winPossibility[2])) {
              emit(GameWin(playerUuid: room!.opponentUuid));
              return;
            }
          }
        }

        if (_.board.every((element) => element != 0)) {
          emit(const GameWin(playerUuid: null));
          return;
        }
      }
      if (state is GameInitial) emit(GameUpdated());
      emit(GameInitial());
    });
  }

  Future<void> select(int index) async {
    if (room?.turn != playerType) return;
    if (room?.board[index] != 0) return;

    await service.select(room!, index, playerType);

    if (room!.board.where((element) => element == 1).length > 2 || room!.board.where((element) => element == 2).length > 2) {
      List<int> hostIndex = [];
      List<int> opponentIndex = [];

      for (var i = 0; i < room!.board.length; i++) {
        if (room!.board[i] == 1) {
          hostIndex.add(i);
        }
        if (room!.board[i] == 2) {
          opponentIndex.add(i);
        }
      }

      //1
      if (hostIndex.length > 2) {
        for (var winPossibility in service.winPossibilities) {
          if (hostIndex.contains(winPossibility[0]) && hostIndex.contains(winPossibility[1]) && hostIndex.contains(winPossibility[2])) {
            log('host WIN');
            await service.addVictory(room!, PlayerType.host);
            emit(GameWin(playerUuid: room!.hostUuid));
            return;
          }
        }
      }
      //2
      if (opponentIndex.length > 2) {
        for (var winPossibility in service.winPossibilities) {
          if (opponentIndex.contains(winPossibility[0]) && opponentIndex.contains(winPossibility[1]) && opponentIndex.contains(winPossibility[2])) {
            log('opponent WIN');
            await service.addVictory(room!, PlayerType.opponent);
            emit(GameWin(playerUuid: room!.opponentUuid));
            return;
          }
        }
      }

      if (room!.board.every((element) => element != 0)) {
        emit(const GameWin(playerUuid: null));
        return;
      }
    }
  }

  void exitRoom(BuildContext context) async {
    var sure = await ExitRoomModal.show(context);

    if (sure == true) {
      await service.exit(room!.id);
      emit(GameExit());
    }
  }

  Future<void> playNext() async {
    await service.playNext(room!, playerType);
    var stt = state;

    emit(GameUpdated());
    emit(stt);
  }

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
