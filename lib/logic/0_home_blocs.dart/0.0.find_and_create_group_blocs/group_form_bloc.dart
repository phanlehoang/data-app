import 'dart:async';

import 'package:demo_app2/presentation/widgets/vietnamese/vietnamese_field_bloc_validators.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import '../../../data/data_provider/group_provider.dart';

class GroupFormBloc extends FormBloc<String, String> {
  final groupId = TextFieldBloc(
      validators: [
        VietnameseFieldBlocValidators.lightRequired,
      ],
      asyncValidatorDebounceTime: const Duration(milliseconds: 300),
      asyncValidators: [GroupValidator.idExist]);
  //add field blocs
  @override
  GroupFormBloc() {
    addFieldBlocs(fieldBlocs: [
      groupId,
    ]);
  }
  // function when validate success

  @override
  FutureOr<void> onSubmitting() {}
}
