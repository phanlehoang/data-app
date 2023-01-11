import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import '../../../../logic/0_home_blocs.dart/0.1.create_patient_blocs/profile_wizard_form_bloc.dart';

FormBlocStep accountStep(WizardFormBloc wizardFormBloc) {
  return FormBlocStep(
    title: const Text('Account'),
    content: Column(
      children: <Widget>[
        TextFieldBlocBuilder(
          textFieldBloc: wizardFormBloc.name,
          keyboardType: TextInputType.text,
          enableOnlyWhenFormBlocCanSubmit: true,
          decoration: const InputDecoration(
            labelText: 'Họ và tên',
            prefixIcon: Icon(Icons.person),
          ),
        ),
        TextFieldBlocBuilder(
          textFieldBloc: wizardFormBloc.id,
          decoration: const InputDecoration(
            labelText: 'ID',
          ),
        ),
      ],
    ),
  );
}
