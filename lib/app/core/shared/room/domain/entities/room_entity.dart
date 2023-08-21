import 'package:equatable/equatable.dart';
import 'package:tictactoe/app/core/common/enums/player_type.dart';

// ignore: must_be_immutable
abstract class RoomEntity extends Equatable {
  int id;
  String hostUuid;
  String? opponentUuid;
  PlayerType turn;
  List<int> board;
  (int host, int opponent) victories;

  RoomEntity({
    required this.id,
    required this.hostUuid,
    required this.turn,
    this.board = const [0, 0, 0, 0, 0, 0, 0, 0, 0],
    this.opponentUuid,
    this.victories = const (0, 0),
  });

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, hostUuid, opponentUuid];
}
