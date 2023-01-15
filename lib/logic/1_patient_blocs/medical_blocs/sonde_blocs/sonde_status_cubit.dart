// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';

import '../../../../data/models/enums.dart';

class CurrentSondeStatusCubit extends Cubit<SondeStatus> {
  final SondeStatus init;
  CurrentSondeStatusCubit({this.init = SondeStatus.firstAsk}) : super(init);
  void update(SondeStatus newStatus) {
    emit(newStatus);
  }
}
