part of 'root.bloc.dart';

class RootState extends Equatable {
  final int currentIndex;

  const RootState({
    this.currentIndex = 0,
  });

  @override
  List<Object> get props => [currentIndex];

  RootState copyWith({
    int? currentIndex,
  }) {
    return RootState(
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}
