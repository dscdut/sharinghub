part of 'home.bloc.dart';

class HomeState extends Equatable {
  final HandleStatus status;
  final String? error;
  final List<HomeProjectModel>? items;

  const HomeState({
    this.status = HandleStatus.initial,
    this.error,
    this.items,
  });

  const HomeState.loading({
    this.error,
    this.items,
  }) : status = HandleStatus.loading;

  const HomeState.getSuccess({
    required this.items,
  })  : status = HandleStatus.success,
        error = null;

  const HomeState.getFailure({
    required this.error,
  })  : status = HandleStatus.error,
        items = const [];

  @override
  List<Object?> get props => [
        status,
        error,
        items,
      ];
}
