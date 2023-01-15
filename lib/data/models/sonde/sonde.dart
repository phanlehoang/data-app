// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';

import '../enums.dart';

class CurrentSondeStatusCubit extends Cubit<SondeStatus> {
  CurrentSondeStatusCubit() : super(SondeStatus.firstAsk);
  void update(SondeStatus newStatus) {
    emit(newStatus);
  }
}
