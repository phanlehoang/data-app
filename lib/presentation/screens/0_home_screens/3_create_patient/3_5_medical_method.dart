//medicalMethod is a function return FormBlocStep
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import '../../../../logic/0_home_blocs.dart/0.1.create_patient_blocs/profile_wizard_form_bloc.dart';
import '../../../widgets/nice_widgets/nice_export.dart';

FormBlocStep medicalMethod(WizardFormBloc thisFormBloc) {
  return FormBlocStep(
      title: Text('Phương pháp điều trị'),
      content: NiceScreen(
        child: Column(
          children: <Widget>[
            //other kind of FieldBlocBuilder
            DropdownFieldBlocBuilder<String>(
              //theme của các item trong dropdown
              showEmptyItem: false,
              //  isExpanded: false,,
              //list of items

              selectFieldBloc: thisFormBloc.method,
              //width of list
              itemBuilder: (context, value) => FieldItem(
                child: Text(value),
              ),
              decoration: const InputDecoration(
                labelText: 'Chọn phương pháp điều trị',
                prefixIcon: Icon(Icons.medical_services_outlined),
                border: OutlineInputBorder(),
              ),
            )
          ],
        ),
      ));
}
