part of 'notification.bloc.dart';

class NotificationState extends Equatable {
  const NotificationState({
    this.status,
  });

  final HandleStatus? status;

  const NotificationState.initial()
      : this(
          status: HandleStatus.initial,
        );

  NotificationState copyWith({
    HandleStatus? status,
  }) {
    return NotificationState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        status,
      ];
}
