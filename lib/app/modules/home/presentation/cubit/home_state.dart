part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeNewRoom extends HomeState {
  final int roomId;

  const HomeNewRoom(this.roomId);
}

final class HomeEnterRoom extends HomeState {}

final class HomeError extends HomeState {
  final String message;

  const HomeError({required this.message});
}
