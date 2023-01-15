//profile cubit

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/data_provider/patient_provider.dart';
import '../../data/models/profile.dart';

class CurrentProfileCubit extends Cubit<Profile> {
  CurrentProfileCubit() : super(unknownProfile());

  Future<void> getProfile(Profile profile) async {
    emit(profile);
  }
}
