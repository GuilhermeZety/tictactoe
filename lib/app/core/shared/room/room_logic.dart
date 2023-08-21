import 'package:flutter_modular/flutter_modular.dart';
import 'package:tictactoe/app/core/shared/room/data/datasources/datasource/room_datasource_impl.dart';
import 'package:tictactoe/app/core/shared/room/data/repositories/room_repository_impl.dart';
import 'package:tictactoe/app/core/shared/room/domain/repositories/room_repository.dart';
import 'package:tictactoe/app/core/shared/room/domain/usecases/close_room.dart';
import 'package:tictactoe/app/core/shared/room/domain/usecases/create_room.dart';
import 'package:tictactoe/app/core/shared/room/domain/usecases/get_room.dart';
import 'package:tictactoe/app/core/shared/room/domain/usecases/get_room_stream.dart';
import 'package:tictactoe/app/core/shared/room/domain/usecases/update_room.dart';

class RoomLogic {
  static void binds(Injector i) {
    i.add<RoomRepository>(
      () => RoomRepositoryImpl(
        datasource: RoomDatasourceImpl(
          database: i.get(),
        ),
      ),
    );
    i.addLazySingleton<GetRoomStream>(
      () => GetRoomStream(
        repository: i.get(),
      ),
    );
    i.addLazySingleton<GetRoom>(
      () => GetRoom(
        repository: i.get(),
      ),
    );
    i.addSingleton<CreateRoom>(
      () => CreateRoom(
        repository: i.get<RoomRepository>(),
      ),
    );
    i.addLazySingleton<CloseRoom>(
      () => CloseRoom(
        repository: i.get(),
      ),
    );
    i.addLazySingleton<UpdateRoom>(
      () => UpdateRoom(
        repository: i.get(),
      ),
    );
  }
}
