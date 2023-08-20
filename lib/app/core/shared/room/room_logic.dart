import 'package:flutter_modular/flutter_modular.dart';
import 'package:tictactoe/app/core/shared/room/data/datasources/datasource/room_datasource_impl.dart';
import 'package:tictactoe/app/core/shared/room/data/repositories/room_repository_impl.dart';
import 'package:tictactoe/app/core/shared/room/domain/repositories/room_repository.dart';
import 'package:tictactoe/app/core/shared/room/domain/usecases/get_room.dart';

class RoomLogic {
  static void binds(Injector i) {
    i.addLazySingleton<RoomRepository>(
      () => RoomRepositoryImpl(
        datasource: RoomDatasourceImpl(),
      ),
    );
    i.addLazySingleton<GetRoom>(
      () => GetRoom(
        repository: i.get(),
      ),
    );
  }
}
