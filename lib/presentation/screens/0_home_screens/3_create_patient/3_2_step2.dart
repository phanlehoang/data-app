import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import '../../../../logic/form_blocs/2_wizard_form_bloc.dart';

FormBlocStep weightHeightStep(WizardFormBloc wizardFormBloc) {
  return FormBlocStep(
    title: const Text('Cân nặng, chiều cao'),
    content: Column(
      children: <Widget>[
        TextFieldBlocBuilder(
          textFieldBloc: wizardFormBloc.weight,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Cân nặng (kg)',
            prefixIcon: Icon(Icons.person),
          ),
        ),
        TextFieldBlocBuilder(
          textFieldBloc: wizardFormBloc.height,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Chiều cao (cm)',
          ),
        ),
      ],
    ),
  );
}
//how to change style of button in step 
//https://stackoverflow.com/questions/59157889/how-to-change-style-of-button-in-st





