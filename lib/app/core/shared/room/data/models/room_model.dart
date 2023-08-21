import 'dart:convert';

import 'package:tictactoe/app/core/common/enums/player_type.dart';
import 'package:tictactoe/app/core/shared/room/domain/entities/room_entity.dart';

// ignore: must_be_immutable
class RoomModel extends RoomEntity {
  RoomModel({
    required super.id,
    required super.hostUuid,
    required super.turn,
    super.opponentUuid,
    super.board,
    super.victories = const (0, 0),
    super.replay = const (false, false),
  });

  RoomModel copyWith({
    int? id,
    String? hostUuid,
    String? opponentUuid,
    PlayerType? turn,
    List<int>? board,
    (int host, int opponent)? victories,
    (bool host, bool opponent)? replay,
  }) {
    return RoomModel(
      id: id ?? this.id,
      hostUuid: hostUuid ?? this.hostUuid,
      opponentUuid: opponentUuid ?? this.opponentUuid,
      turn: turn ?? this.turn,
      board: board ?? this.board,
      victories: victories ?? this.victories,
      replay: replay ?? this.replay,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'hostUuid': hostUuid,
      'opponentUuid': opponentUuid,
      'turn': turn.name,
      'board': board,
      'victories': [victories.$1, victories.$2],
      'replay': [victories.$1, victories.$2],
    };
  }

  factory RoomModel.fromMap(Map<String, dynamic> map) {
    return RoomModel(
      id: map['id'] as int,
      hostUuid: map['hostUuid'] as String,
      opponentUuid: map['opponentUuid'] != null ? map['opponentUuid'] as String : null,
      turn: PlayerType.values.firstWhere((element) => element.name == map['turn'] as String),
      board: List<int>.from(map['board']),
      victories: map['victories'] != null
          ? (
              (map['victories'] as List).first,
              (map['victories'] as List).last,
            )
          : (0, 0),
      replay: map['replay'] != null
          ? (
              (map['replay'] as List).first,
              (map['replay'] as List).last,
            )
          : (false, false),
    );
  }

  String toJson() => json.encode(toMap());

  factory RoomModel.fromJson(String source) => RoomModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
