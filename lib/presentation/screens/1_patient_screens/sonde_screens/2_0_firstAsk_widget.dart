import 'package:data_app/data/data_provider/sonde_provider/sonde_state_provider.dart';
import 'package:data_app/data/models/enums.dart';
import 'package:data_app/data/models/sonde/export_sonde_models.dart';
import 'package:data_app/presentation/widgets/nice_widgets/0_nice_screen.dart';
import 'package:data_app/presentation/widgets/vietnamese/validations_vietnamese.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import '../../../../data/models/profile.dart';
import '../../../../logic/1_patient_blocs/current_profile_cubit.dart';

class FirstAskWidget extends StatelessWidget {
  final SondeCubit sondeCubit;
  const FirstAskWidget({
    Key? key,
    required this.sondeCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NiceScreen(
      child: Column(
        children: [
          Text('FirstAskWidget'),
          BlocBuilder(
            bloc: sondeCubit,
            builder: (context, state) {
              return Text(state.toString());
            },
          ),
          //first ask form
          BlocProvider<FirstAskBloc>(
              create: (context) => FirstAskBloc(
                    profile: context.read<CurrentProfileCubit>().state,
                    sondeCubit: sondeCubit,
                  ),
              child: Builder(
                builder: (context) {
                  final formBloc = context.read<FirstAskBloc>();
                  return FormBlocListener<FirstAskBloc, String, String>(
                    onSubmitting: (context, state) => Center(
                      child: CircularProgressIndicator(),
                    ),
                    //fail
                    onFailure: (context, state) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('error'),
                        ),
                      );
                    },
                    onSuccess: (context, state) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('success'),
                        ),
                      );
                    },
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text('Bạn có tiêm insulin không?'),
                          RadioButtonGroupFieldBlocBuilder(
                            selectFieldBloc: formBloc.yesOrNoInsulin,
                            itemBuilder: (context, value) =>
                                FieldItem(child: Text(value)),
                          ),
                          Text('Nhập số lượng CHO'),
                          TextFieldBlocBuilder(
                            textFieldBloc: formBloc.getCHO,
                            keyboardType: TextInputType.number,
                          ),
                          ElevatedButton(
                            onPressed: formBloc.submit,
                            child: Text('Tiếp tục'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ))
        ],
      ),
    );
  }
}

class FirstAskBloc extends FormBloc<String, String> {
  final SondeCubit sondeCubit;
  final Profile profile;
  final yesOrNoInsulin = SelectFieldBloc(
    items: ['Yes', 'No'],
    validators: [VietnameseFieldBlocValidators.required],
  );
  final getCHO = TextFieldBloc(
    validators: [VietnameseFieldBlocValidators.required],
  );

  FirstAskBloc({
    required this.profile,
    required this.sondeCubit,
  }) {
    addFieldBlocs(
      fieldBlocs: [
        yesOrNoInsulin,
        getCHO,
      ],
    );
  }

  @override
  void onSubmitting() async {
    print('onSubmitting');
    SondeStatus sondeStatus = yesOrNoInsulin.value == 'Yes'
        ? SondeStatus.yesInsulin
        : SondeStatus.noInsulin;
    var updateStatus = await SondeStateCreate.createSondeState(
      profile: profile,
      sondeState: SondeState(
        status: sondeStatus,
        cho: num.parse(getCHO.value),
        weight: profile.weight,
      ),
    );

    if (updateStatus == null) {
      emitSuccess();
    } else {
      emitFailure(failureResponse: updateStatus);
    }
  }
}
