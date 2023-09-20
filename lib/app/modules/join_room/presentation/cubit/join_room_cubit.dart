// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:tictactoe/app/core/common/errors/failures.dart';
import 'package:tictactoe/app/modules/join_room/presentation/join_room_service.dart';

part 'join_room_state.dart';

class JoinRoomCubit extends Cubit<JoinRoomState> {
  JoinRoomCubit() : super(JoinRoomInitial());
  JoinRoomService service = JoinRoomService();

  QRViewController? controller;
  TextEditingController roomController = TextEditingController();

  void joinRoom(int id) async {
    emit(JoinRoomLoading());

    try {
      var roomId = await service.joinRoom(id);
      emit(JoinRoomJoin(roomId: roomId));
    } on Failure catch (err) {
      emit(JoinRoomError(message: err.message));
      controller?.resumeCamera();
      //
    } catch (err) {
      emit(JoinRoomError(message: err.toString()));
      controller?.resumeCamera();
    }
  }

  void onQRViewCreated(QRViewController controller) {
    controller.scannedDataStream.listen((scanData) async {
      log(scanData.code.toString());
      print('QR ${scanData.code}');

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
