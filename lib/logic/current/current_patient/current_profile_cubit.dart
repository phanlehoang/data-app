//profile cubit

import 'package:data_app/data/repositories/group_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/data_provider/patient_provider.dart';
import '../../../data/models/profile.dart';

class CurrentProfileCubit extends Cubit<Profile> {
  CurrentProfileCubit() : super(unknownProfile());

  Future<void> update(ShortPatient shortPatient) async {
    print('update called');
    var profile =
        await PatientRead.getPatient(shortPatient.room, shortPatient.id);
    print('profile: $profile');
    if (profile != null) {
      emit(profile);
    }
    print('CurrentProfileCubit: update');
  }
}
