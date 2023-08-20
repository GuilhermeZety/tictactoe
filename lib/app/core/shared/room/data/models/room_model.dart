import 'dart:convert';

import 'package:tictactoe/app/core/shared/room/domain/entities/room_entity.dart';

// ignore: must_be_immutable
class RoomModel extends RoomEntity {
  RoomModel({required super.id, required super.hostUuid, super.opponentUuid});

  RoomModel copyWith({
    int? id,
    String? hostUuid,
    String? opponentUuid,
  }) {
    return RoomModel(
      id: id ?? this.id,
      hostUuid: hostUuid ?? this.hostUuid,
      opponentUuid: opponentUuid ?? this.opponentUuid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'hostUuid': hostUuid,
      'opponentUuid': opponentUuid,
    };
  }

  factory RoomModel.fromMap(Map<String, dynamic> map) {
    return RoomModel(
      id: map['id'] as int,
      hostUuid: map['hostUuid'] as String,
      opponentUuid: map['opponentUuid'] != null ? map['opponentUuid'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RoomModel.fromJson(String source) => RoomModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
