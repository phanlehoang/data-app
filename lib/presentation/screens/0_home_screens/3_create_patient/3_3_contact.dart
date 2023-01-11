// addressStep is a function that returns a FormBlocStep
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import '../../../../logic/0_home_blocs.dart/0.1.create_patient_blocs/profile_wizard_form_bloc.dart';

FormBlocStep contactAddressStep(WizardFormBloc thisFormBloc) {
  return FormBlocStep(
    title: Text('Liên hệ'),
    content: Column(
      children: [
        TextFieldBlocBuilder(
          textFieldBloc: thisFormBloc.address,
          keyboardType: TextInputType.streetAddress,
          decoration: InputDecoration(
            labelText: 'Địa chỉ',
            prefixIcon: Icon(Icons.home_filled),
          ),
        ),
        TextFieldBlocBuilder(
          textFieldBloc: thisFormBloc.phone,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            labelText: 'Số điện thoại',
            prefixIcon: Icon(Icons.phone),
          ),
        ),
      ],
    ),
  );
}
