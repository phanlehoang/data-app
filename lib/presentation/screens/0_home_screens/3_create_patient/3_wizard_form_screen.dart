import 'package:data_app/logic/current/current_group/current_group_cubit.dart';
import 'package:data_app/presentation/widgets/nice_widgets/nice_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import 'package:nice_buttons/nice_buttons.dart';

import '../../../../logic/form_blocs/2_wizard_form_bloc.dart';
import '../../../widgets/status/loading_dialog.dart';
import '3_1_step1_name_id.dart';
import '3_2_step2.dart';
import '3_3_contact.dart';
import '3_4_gender_birthday.dart';
import '3_5_medical_method.dart';

class WizardFormScreen extends StatelessWidget {
  const WizardFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tạo hồ sơ bệnh nhân'),
      ),
      body: SingleChildScrollView(
        child: BlocProvider(
            create: (_) => WizardFormBloc(
                groupId: context.read<CurrentGroupIdCubit>().state),
            child: Builder(builder: (newContext) {
              final wizardFormBloc = newContext.watch<WizardFormBloc>();
              return FormBlocListener(
                formBloc: wizardFormBloc,
                onSubmitting: (context, state) {
                  //  LoadingDialog.show(context);
                },
                onSubmissionFailed: (context, state) {},
                //   LoadingDialog.hide(context),
                onSuccess: (context, state) {
                  if (state.stepCompleted == 4) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Tạo hồ sơ thành công')));
                  }
                },

                onFailure: (context, state) {
                  //LoadingDialog.hide(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Tạo hồ sơ thất bại')));
                },
                child: Column(
                  children: [
                    Text('BN sẽ ở phòng ' + wizardFormBloc.groupId),
                    SingleChildScrollView(
                      //horizontal
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        width: 400,
                        child: StepperFormBlocBuilder<WizardFormBloc>(
                          formBloc: newContext.watch<WizardFormBloc>(),
                          type: StepperType.vertical,
                          //hiển thị các field của step trước
                          //hiển thị các field của step sau
                          stepsBuilder: (thisFormBloc) => [
                            accountStep(thisFormBloc!),
                            weightHeightStep(thisFormBloc),
                            contactAddressStep(thisFormBloc),
                            genderAndBirthday(thisFormBloc),
                            medicalMethod(thisFormBloc)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            })),
      ),
    );
  }
}
