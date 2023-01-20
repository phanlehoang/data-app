// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import 'package:data_app/data/data_provider/sonde_provider/sonde_fast_insulin_provider.dart';
import 'package:data_app/data/models/sonde/sonde_lib.dart';
import 'package:data_app/logic/1_patient_blocs/current_profile_cubit.dart';
import 'package:data_app/presentation/widgets/nice_widgets/0_nice_screen.dart';
import 'package:data_app/presentation/widgets/nice_widgets/2_nice_button.dart';

import '../../../../../data/data_provider/regimen_provider.dart';
import '../../../../../data/models/enums.dart';
import '../../../../../data/models/glucose-insulin_controller/give_insulin_logic.dart';
import '../../../../../data/models/models_export.dart';
import '../../../../../logic/1_patient_blocs/medical_blocs/sonde_blocs/sonde_cubit.dart';
import '../../../../../logic/1_patient_blocs/medical_blocs/sonde_blocs/sonde_fast_insulin_cubit.dart';
import '2_1_1_checking_glucose_widget.dart';

class GivingInsulinWidget extends StatelessWidget {
  //sonde cubit
  final SondeCubit sondeCubit;
  final SondeFastInsulinCubit sondeFastInsulinCubit;
  const GivingInsulinWidget({
    Key? key,
    required this.sondeCubit,
    required this.sondeFastInsulinCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NiceScreen(
        child: Column(
      children: [
        BlocBuilder(
          bloc: sondeFastInsulinCubit,
          builder: (context, state) {
            final  value = sondeFastInsulinCubit.state;
            switch (value.status) {
              case RegimenStatus.givingInsulin:
                {
                  num glu = value.regimen.lastGlu();
                  String guide = GlucoseSolve.insulinGuideString(
                    regimen: value.regimen,
                    sondeState: sondeCubit.state,
                  );
                  String plusGuide = GlucoseSolve.plusInsulinGuide(glu );
                  num plus = GlucoseSolve.plusInsulinAmount(glu);
                  num insulin = GlucoseSolve.insulinGuide(
                    regimen: value.regimen,
                    sondeState: sondeCubit.state,
                  );
                  return Column(
                    children: [
                      Text('Tạm ngừng thuốc hạ đường máu'),
                                            Text(plusGuide),

                      Text(guide),
                      BlocProvider<CheckedSubmit>(
                          create: (context) => CheckedSubmit(
                                sondeFastInsulinCubit: sondeFastInsulinCubit,
                                profile:
                                    context.read<CurrentProfileCubit>().state,
                                insulin: insulin,
                                plus: plus,
                              ),
                          child: Builder(builder: (_) {
                            return FormBlocListener<CheckedSubmit, String,
                                String>(
                              onSuccess: (cc, state) {
                                ScaffoldMessenger.of(cc).showSnackBar(
                                  SnackBar(
                                    content: Text('Success'),
                                  ),
                                );
                               
                              },
                              onFailure: (cc, state) {
                                ScaffoldMessenger.of(cc).showSnackBar(
                                  SnackBar(
                                    content: Text('Failure'),
                                  ),
                                );
                              },
                              child: NiceButton(
                                text: 'Submit',
                                onTap: () {
                                  _.read<CheckedSubmit>().submit();
                                },
                              ),
                            );
                          }))
                    ],
                  );
                }

              default:
                {
                  return Text('default');
                }
            }
          },
        )
      ],
    ));
  }
}

Future<void> addInsulin(
    {required Profile profile, required num insulin}) async {}

class CheckedSubmit extends FormBloc<String, String> {
  final Profile profile;
  final num insulin;
  final num plus;
  final SondeFastInsulinCubit sondeFastInsulinCubit;
  CheckedSubmit({
    required this.sondeFastInsulinCubit,
    required this.profile,
    required this.insulin,
    required this.plus,
  });
  @override
  FutureOr<void> onSubmitting() async {
    MedicalTakeInsulin medicalTakeInsulin = MedicalTakeInsulin(
      insulinUI: insulin,
      time: DateTime.now(),
      insulinType: InsulinType.Actrapid,
    );
    
    try {
      var fastInsulinStateRef = RefProvider.fastInsulinStateRef(profile);
      //update take insulin 
      var add = await fastInsulinStateRef.update(
        {
          'regimen.medicalTakeInsulins': FieldValue.arrayUnion(
            [medicalTakeInsulin .toMap()],
          ),
          'regimen.medicalActions': FieldValue.arrayUnion(
            [medicalTakeInsulin.toMap()],
          ),
        },
      );
      
      //update status to checkingGlucose
      var updateStatus =
          await fastInsulinStateRef.update({
            'status': 'checkingGlucose'
          });
      var updateBonus = await FirebaseFirestore.instance
          .collection('groups')
          .doc(profile.room)
          .collection('patients')
          .doc(profile.id)
          .collection('medicalMethods')
          .doc('Sonde')
          .update({'bonusInsulin': FieldValue.increment(plus)});
    } catch (e) {
      emitFailure(failureResponse: e.toString());
    }
    //   sondeFastInsulinCubit.emit(loadingNoInsulinSondeState());
    emitSuccess();
  }
}
