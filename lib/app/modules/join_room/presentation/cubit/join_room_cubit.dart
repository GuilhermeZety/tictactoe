import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:tictactoe/main.dart';
part 'join_room_state.dart';

class JoinRoomCubit extends Cubit<JoinRoomState> {
  JoinRoomCubit() : super(JoinRoomInitial());

  QRViewController? controller;
  TextEditingController roomController = TextEditingController();

  void joinRoom(int id) async {
    emit(JoinRoomLoading());
    var room = await session.database.ref().child('rooms').child(id.toString()).get();

    if (room.value != null) {
      await session.database.ref().child('rooms').child(id.toString()).update({'opponentUuid': session.userUuid});
      emit(JoinRoomJoin(roomId: id));
    } else {
      emit(const JoinRoomError(message: 'Sala não encontrada'));
      controller?.resumeCamera();
      emit(JoinRoomInitial());
    }
  }

  void onQRViewCreated(QRViewController controller) {
    controller.scannedDataStream.listen((scanData) async {
      log(scanData.code.toString());

      if (scanData.code != null) {
        var roomId = int.tryParse(scanData.code ?? '');

        if (roomId != null) {
          await controller.pauseCamera();
          joinRoom(roomId);
        }
        return;
      }
    });
  }
}
