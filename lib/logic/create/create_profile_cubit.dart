import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/profile.dart';

class CreateProfileCubit extends Cubit<Profile> {
  CreateProfileCubit() : super(Profile());
}
