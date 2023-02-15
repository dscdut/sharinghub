part of 'root.bloc.dart';

abstract class RootEvent extends Equatable {
  const RootEvent();

  @override
  List<Object> get props => [];
}

class RootBottomTabChange extends RootEvent {
  final int newIndex;

  const RootBottomTabChange({required this.newIndex});

  @override
  List<Object> get props => [newIndex];
}
