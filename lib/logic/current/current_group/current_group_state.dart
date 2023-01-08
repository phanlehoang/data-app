part of 'current_group_cubit.dart';

abstract class CurrentGroupState {
  final bool isActive;
  const CurrentGroupState(
    this.isActive,
  );

  @override
  List<Object> get props => [];
}

class CurrentGroupInitial extends CurrentGroupState {
  const CurrentGroupInitial() : super(false);
}
