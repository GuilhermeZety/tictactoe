import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/main.dart';
part 'join_room_state.dart';

class JoinRoomCubit extends Cubit<JoinRoomState> {
  JoinRoomCubit() : super(JoinRoomInitial());

  TextEditingController roomController = TextEditingController();

  Future init() async {}

  void joinRoom(int id) async {
    var room = await session.database.ref().child('rooms').child(id.toString()).get();

    if (room.value != null) {
      await session.database.ref().child('rooms').child(id.toString()).update({'opponentUuid': session.userUuid});
      emit(JoinRoomJoin(roomId: id));
    } else {
      emit(JoinRoomInitial());
    }
  }
}
