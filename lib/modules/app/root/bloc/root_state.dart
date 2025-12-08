part of 'root_bloc.dart';

enum RootIndex { home, orders, profile }

class RootState extends Equatable {
  final RootIndex currentIndex;

  const RootState({
    required this.currentIndex,
  });

  RootState copyWith({
    RootIndex? currentIndex,
  }) =>
      RootState(
        currentIndex: currentIndex ?? this.currentIndex,
      );

  @override
  List<Object> get props => [
        currentIndex,
      ];
}
