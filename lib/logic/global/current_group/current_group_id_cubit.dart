import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class CurrentGroupIdCubit extends Cubit<String> {
  CurrentGroupIdCubit() : super('Unknown');
  void update(String group) {
    emit(group);
  }

  //close
  @override
  Future<void> close() {
    return super.close();
  }
}
