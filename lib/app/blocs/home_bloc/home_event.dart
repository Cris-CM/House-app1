part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

final class HomeEventSendCommand extends HomeEvent {
  final String command;

  HomeEventSendCommand(this.command);
}

final class HomeEventToggleLight extends HomeEvent {
  final bool sendOn;

  HomeEventToggleLight(this.sendOn);
}
