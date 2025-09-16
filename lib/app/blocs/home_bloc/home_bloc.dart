import 'package:bloc/bloc.dart';
import 'package:house_app/app/services/command_service.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final CommandService commandService;
  HomeBloc(this.commandService) : super(HomeInitial()) {
    on<HomeEventSendCommand>(_sendCommand);
  }

  Future<void> _sendCommand(HomeEventSendCommand event, Emitter emit) async {
    emit(HomeLoading());
    try {
      await commandService.sendCommand(event.command);
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
