import 'package:demo_app2/data/models/enum/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrentMedicalMethodCubit extends Cubit<MedicalMethod> {
  CurrentMedicalMethodCubit() : super(MedicalMethod.TPN);

  void update(MedicalMethod medicalMethod) {
    if (medicalMethod != null) emit(medicalMethod);
  }
}
