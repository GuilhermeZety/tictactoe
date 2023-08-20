part of 'join_room_cubit.dart';

sealed class JoinRoomState extends Equatable {
  const JoinRoomState();

  @override
  List<Object> get props => [];
}

final class JoinRoomInitial extends JoinRoomState {}

final class JoinRoomUpdated extends JoinRoomState {}

final class JoinRoomExit extends JoinRoomState {}

final class JoinRoomJoin extends JoinRoomState {
  final int roomId;

  const JoinRoomJoin({required this.roomId});
}
