import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tictactoe/app/core/common/errors/failures.dart';
import 'package:tictactoe/app/modules/home/presentation/home_service.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  HomeService service = HomeService();

  Future createRoom() async {
    try {
      var roomId = await service.createRoom();

      if (state is HomeNewRoom) emit(HomeInitial());
      emit(HomeNewRoom(roomId));
      //
    } on Failure catch (err) {
      emit(HomeError(message: err.message));
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }
}
