import 'package:data_app/data/models/enums.dart';
import 'package:data_app/logic/1_patient_blocs/medical_blocs/choose_medical_method_bloc.dart';
import 'package:data_app/logic/1_patient_blocs/medical_blocs/current_medical_method_cubit.dart';
import 'package:data_app/logic/status_cubit/time_check/time_check_cubit.dart';
import 'package:data_app/presentation/screens/1_patient_screens/sonde_screens/sonde_screen.dart';
import 'package:data_app/presentation/widgets/nice_widgets/0_nice_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import '../../../logic/1_patient_blocs/current_profile_cubit.dart';
import '../../widgets/bars/bottom_navitgator_bar.dart';
import '../../widgets/bars/patient_navigator_bar.dart';
import '../../widgets/status/loading_dialog.dart';

class PatientMedicalScreen extends StatelessWidget {
  const PatientMedicalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: PatientNavigatorBar(),
      ),
      body: NiceInternetScreen(
        child: Column(
          children: [
            ChooseMedicalMethod(),
            BlocBuilder<CurrentMedicalMethodCubit, MedicalMethod>(
                builder: (context, state) {
              if (state == MedicalMethod.TPN) {
                return Text('TPN');
              }
              if (state == MedicalMethod.Sonde) {
                return Text('Sonde');
              }
              return Text('No method selected');
            }),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigatorBar(),
    );
  }
}

class ChooseMedicalMethod extends StatelessWidget {
  const ChooseMedicalMethod({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChooseMedicalMethodBloc(
        currentMedicalMethodCubit: context.read<CurrentMedicalMethodCubit>(),
        profile: context.read<CurrentProfileCubit>().state,
      ),
      child: Builder(
        builder: (context) {
          final chooseMedicalMethodBloc =
              context.watch<ChooseMedicalMethodBloc>();
          return FormBlocListener<ChooseMedicalMethodBloc, String, String>(
            onSubmitting: (context, state) {
              LoadingDialog.show(context);
            },
            onSuccess: (context, state) {
              LoadingDialog.hide(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Success'),
                ),
              );
            },
            onFailure: (context, state) {
              LoadingDialog.hide(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('fail')),
              );
            },
            child: Column(
              //size
              mainAxisSize: MainAxisSize.min,

              children: [
                Container(
                  width: 300,
                  child: DropdownFieldBlocBuilder<String>(
                    selectFieldBloc: chooseMedicalMethodBloc.medicalMethod,
                    itemBuilder: (context, value) => FieldItem(
                      child: Text(value),
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Phương pháp điều trị',
                      prefixIcon: Icon(Icons.medical_services_outlined),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    chooseMedicalMethodBloc.submit();
                    //navigate to sondeScreen
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SondeScreen(),
                      ),
                    );
                  },
                  child: Text('Chọn'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
