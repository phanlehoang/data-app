import 'dart:async';

import 'package:demo_app2/data/data_provider/patient_provider.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import '../../../presentation/widgets/vietnamese/vietnamese_field_bloc_validators.dart';

class WizardFormBloc extends FormBloc<String, String> {
  String groupId = 'Unknown';
  //step 1: tên, id
  final name = TextFieldBloc(
    validators: [VietnameseFieldBlocValidators.required],
  );
  final id = TextFieldBloc(
    validators: [
      VietnameseFieldBlocValidators.required,
      Hospital.checkLength10
    ],
  );
  //step 2: chiều cao, cân nặng
  final height = TextFieldBloc(
    validators: [
      VietnameseFieldBlocValidators.required,
    ],
  );
  final weight = TextFieldBloc(validators: [
    VietnameseFieldBlocValidators.required,
  ]);
  //step 3: địa chỉ, số điện thoại
  final address = TextFieldBloc(
    validators: [VietnameseFieldBlocValidators.required],
  );
  final phone = TextFieldBloc(
    validators: [
      VietnameseFieldBlocValidators.required,
    ],
  );
  //step 4: giới tính, ngày sinh
  final gender = SelectFieldBloc(
    items: ['Nam', 'Nữ'],
    validators: [VietnameseFieldBlocValidators.required],
  );
  final birthday = InputFieldBloc<DateTime?, dynamic>(
    initialValue: null,
    //  toJson: (value) => value?.toUtc().toIso8601String(),
    validators: [VietnameseFieldBlocValidators.required],
  );
  final method = SelectFieldBloc(
    items: ['TPN', 'Sonde'],
    validators: [VietnameseFieldBlocValidators.required],
  );
  //add field blocs to group
  @override
  WizardFormBloc({
    required this.groupId,
  }) {
    addFieldBlocs(step: 0, fieldBlocs: [
      name,
      id,
    ]);
    addFieldBlocs(step: 1, fieldBlocs: [
      weight,
      height,
    ]);
    addFieldBlocs(
      step: 2,
      fieldBlocs: [
        address,
        phone,
      ],
    );
    addFieldBlocs(step: 3, fieldBlocs: [gender, birthday]);
    addFieldBlocs(step: 4, fieldBlocs: [method]);
  }
  //to Map
  Map<String, dynamic> toMap() {
    return {
      'name': name.value,
      'id': id.value,
      'height': num.parse(height.value),
      'weight': num.parse(weight.value),
      'address': address.value,
      'phone': phone.value,
      'gender': gender.value,
      'birthday': birthday.value,
      'medicalMethod': method.value,
      'room': groupId,
    };
  }

  @override
  void emit(dynamic state) {
    try {
      super.emit(state);
    } catch (e) {
      if (e == StateError('Cannot emit new states after calling close')) {
        return;
      }
    }
  }

  @override
  Future<void> onSubmitting() async {
    //step

    if (state.currentStep < 4) {
      emitSuccess();
      return;
    }
    try {
      var ans = await PatientCreate.createPatient(toMap());
      if (ans != null) {
        emitFailure(failureResponse: ans);
        return;
      }
      emitSuccess(canSubmitAgain: true);
    } catch (e) {
      emitFailure(failureResponse: e.toString());
    }
  }

  //close
  @override
  Future<void> close() async {
    name.close();
    id.close();
    height.close();
    weight.close();
    address.close();
    phone.close();
  }
}
