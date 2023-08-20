import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/app/core/shared/room/data/models/room_model.dart';
import 'package:tictactoe/app/modules/new_room/presentation/components/exit_room_modal.dart';
import 'package:tictactoe/main.dart';

part 'new_room_state.dart';

class NewRoomCubit extends Cubit<NewRoomState> {
  NewRoomCubit() : super(NewRoomInitial());

  RoomModel? room;
  late StreamSubscription roomSubscription;

  Future init(int roomId) async {
    roomSubscription = session.database.ref().child('rooms').child(roomId.toString()).onValue.listen((event) {
      if (event.snapshot.value != null) {
        room = RoomModel.fromMap(Map<String, dynamic>.from(event.snapshot.value as Map));
        emit(NewRoomUpdated());
        emit(NewRoomInitial());
      }
    });
  }

  void exitRoom(BuildContext context) async {
    var sure = await ExitRoomModal.show(context);

    if (sure == true) {
      await session.database.ref().child('rooms').child(room!.id.toString()).remove();
      emit(NewRoomExit());
    }
  }

  void dispose() {
    roomSubscription.cancel();
    super.close();
  }
}
