part of 'game_cubit.dart';

sealed class GameState extends Equatable {
  const GameState();

  @override
  List<Object> get props => [];
}

final class GameInitial extends GameState {}

final class GameLoading extends GameState {}

final class GameUpdated extends GameState {}

final class GameExit extends GameState {}

final class GameWin extends GameState {
  //IF VALUE IS NULL IS DRAW
  final String? playerUuid;

  const GameWin({required this.playerUuid});
}

final class GameError extends GameState {
  final String message;

  const GameError({required this.message});
}
