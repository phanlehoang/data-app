//GenderAndBirthday is a function return FormBlocStep
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import '../../../../logic/0_home_blocs.dart/0.1.create_patient_blocs/profile_wizard_form_bloc.dart';

FormBlocStep genderAndBirthday(WizardFormBloc thisFormBloc) {
  return FormBlocStep(
      title: Text('Giới tính, ngày sinh'),
      content: Column(
        children: <Widget>[
          RadioButtonGroupFieldBlocBuilder(
            //horizontal
            groupStyle: WrapGroupStyle(
              direction: Axis.horizontal,
            ),
            selectFieldBloc: thisFormBloc.gender,
            itemBuilder: (context, value) => FieldItem(child: Text(value)),
            decoration: const InputDecoration(
                labelText: 'Gender', prefixIcon: SizedBox()),
          ),
          DateTimeFieldBlocBuilder(
            dateTimeFieldBloc: thisFormBloc.birthday,
            format: DateFormat('dd/MM/yyyy'),
            initialDate: DateTime(2000),
            firstDate: DateTime(1900),
            lastDate: DateTime(2100),
            decoration: InputDecoration(
              labelText: 'Ngày sinh',
              prefixIcon: Icon(Icons.cake),
            ),
          ),
        ],
      ));
}
