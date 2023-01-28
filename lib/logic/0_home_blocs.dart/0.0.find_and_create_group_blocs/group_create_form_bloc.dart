import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import '../../../data/data_provider/group_provider.dart';
import '../../../presentation/widgets/vietnamese/vietnamese_field_bloc_validators.dart';

export 'group_form_bloc.dart';

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
  //to map<String, dynamic> factory
  factory GroupCreateFormBloc.fromMap(Map<String, dynamic> map) {
    return GroupCreateFormBloc()
      ..groupId.updateValue(map['groupId'])
      ..groupName.updateValue(map['groupName']);
  }
  //to map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'groupId': groupId.value,
      'groupName': groupName.value,
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
    //delay 100ms
    try {
      var ans = await GroupCreate.createGroup(
        groupId.value,
        this.toMap(),
      );
      if (ans == null)
        emitSuccess();
      else
        emitFailure(failureResponse: ans);
    } catch (e) {
      print(e);
    }
  }

  //close
  @override
  Future<void> close() async {
    groupId.close();
    groupName.close();
    super.close();
  }
}
