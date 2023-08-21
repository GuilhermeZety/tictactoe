import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/app/core/shared/room/domain/entities/room_entity.dart';
import 'package:tictactoe/app/modules/new_room/presentation/components/exit_room_modal.dart';
import 'package:tictactoe/app/modules/new_room/presentation/new_room_service.dart';

part 'new_room_state.dart';

class NewRoomCubit extends Cubit<NewRoomState> {
  NewRoomCubit() : super(NewRoomInitial());
  NewRoomService service = NewRoomService();

  RoomEntity? room;

  Future init(int roomId) async {
    await service.getRoom(roomId);

    if (service.roomStream == null) {
      emit(const NewRoomError(message: 'Sala não encontrada'));
      return;
    }

    service.listenReturn((_) {
      room = _;
      emit(NewRoomUpdated());
      if (room?.opponentUuid != null) {
        emit(NewRoomJoin(roomId: room!.id));
        return;
      }
      emit(NewRoomInitial());
    });
  }

  void exitRoom(BuildContext context) async {
    var sure = await ExitRoomModal.show(context);

    if (sure == true) {
      await service.exit(room!.id);
      emit(NewRoomExit());
    }
  }

  void dispose() {
    service.dispose();
    super.close();
  }
}
