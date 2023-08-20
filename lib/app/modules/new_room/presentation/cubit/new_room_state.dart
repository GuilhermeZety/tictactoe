part of 'new_room_cubit.dart';

sealed class NewRoomState extends Equatable {
  const NewRoomState();

  @override
  List<Object> get props => [];
}

final class NewRoomInitial extends NewRoomState {}

final class NewRoomUpdated extends NewRoomState {}

final class NewRoomExit extends NewRoomState {}

final class NewRoomJoin extends NewRoomState {
  final int roomId;

  const NewRoomJoin({required this.roomId});
}
