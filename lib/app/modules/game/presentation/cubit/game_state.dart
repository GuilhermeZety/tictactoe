part of 'game_cubit.dart';

sealed class GameState extends Equatable {
  const GameState();

  @override
  List<Object> get props => [];
}

final class GameInitial extends GameState {}
final class GameUpdated extends GameState {}
final class GameExit extends GameState {}
