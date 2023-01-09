import 'package:flutter_bloc/flutter_bloc.dart';

import '../data_provider/group_provider.dart';

class ListPatientIdsCubit extends Cubit<List<String>> {
  ListPatientIdsCubit() : super([]);

  void update(List<String> patientIds) => emit(patientIds);

  void clear() => emit([]);

  Future<void> getPatientIdsFromGroupId(String groupId) async {
    var patientIds = await GroupRead.patients(groupId);
    update(patientIds);
  }
  //close

}
