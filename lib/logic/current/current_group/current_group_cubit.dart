import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'current_group_state.dart';

class CurrentGroupCubit extends Cubit<CurrentGroupState> {
  CurrentGroupCubit() : super(CurrentGroupInitial());
}
