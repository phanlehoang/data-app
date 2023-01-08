import 'dart:async';

import 'package:data_app/presentation/widgets/vietnamese/validations_vietnamese.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import '../../data/data_provider/group_provider.dart';

class GroupFormBloc extends FormBloc<String, String> {
  final groupId = TextFieldBloc(
      validators: [
        VietnameseFieldBlocValidators.lightRequired,
      ],
      asyncValidatorDebounceTime: const Duration(milliseconds: 100),
      asyncValidators: [GroupValidator.idExist]);
  //add field blocs
  @override
  GroupFormBloc() {
    addFieldBlocs(fieldBlocs: [
      groupId,
    ]);
  }
  @override
  FutureOr<void> onSubmitting() {
    //  emitSuccess();
  }
}

class GroupCreateFormBloc extends FormBloc<String, String> {
  final groupId = TextFieldBloc(
      validators: [
        VietnameseFieldBlocValidators.required,
      ],
      asyncValidatorDebounceTime: const Duration(milliseconds: 100),
      asyncValidators: [GroupValidator.idCreateValid]);
  final groupName = TextFieldBloc(
    validators: [
      VietnameseFieldBlocValidators.required,
    ],
  );
  //add field blocs
  @override
  GroupCreateFormBloc() {
    addFieldBlocs(fieldBlocs: [
      groupId,
      groupName,
    ]);
  }
  @override
  FutureOr<void> onSubmitting() {
    emitSuccess();
  }
}
