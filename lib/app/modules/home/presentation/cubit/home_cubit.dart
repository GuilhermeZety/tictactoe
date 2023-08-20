import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tictactoe/app/core/shared/room/data/models/room_model.dart';
import 'package:tictactoe/main.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  Future createRoom() async {
    int id = 1000;
    var allrooms = await session.database.ref().child('rooms').get();

    if (allrooms.children.isNotEmpty) {
      id = int.parse(allrooms.children.last.key ?? '0') + 1;
    }
    RoomModel newRoom = RoomModel(id: id, hostUuid: session.userUuid!);

    await session.database.ref().child('rooms').child(newRoom.id.toString()).set(newRoom.toMap());

    if (state is HomeNewRoom) emit(HomeInitial());
    emit(HomeNewRoom(newRoom.id));
  }
}
