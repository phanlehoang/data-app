import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import '../../../logic/form_blocs/group_form.dart';

class FindGroup extends StatelessWidget {
  const FindGroup({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GroupFormBloc>(
      create: (context) => GroupFormBloc(),
      child: Builder(
        builder: (context) {
          final formBloc = context.watch<GroupFormBloc>();
          return FormBlocListener<GroupFormBloc, String, String>(
            onSubmitting: (context, state) => Center(
              child: CircularProgressIndicator(),
            ),
            onSuccess: (context, state) {
              print('success');
              print(state.successResponse);
            },
            onFailure: (context, state) {
              print('failure');
              print(state.failureResponse);
            },
            child: Column(
              children: [
                TextFieldBlocBuilder(
                  textFieldBloc: formBloc.groupId,
                  decoration: InputDecoration(
                    labelText: 'Group ID',
                    prefixIcon: Icon(Icons.group),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
