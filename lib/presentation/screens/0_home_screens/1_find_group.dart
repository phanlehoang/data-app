import 'package:data_app/logic/current/current_group/current_group_cubit.dart';
import 'package:data_app/presentation/widgets/status/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import '../../../logic/form_blocs/1_group_form.dart';

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
          final currentGroupId = context.read<CurrentGroupIdCubit>();
          //value in field
          //nếu ô thay đôi thì mới update
          if (formBloc.groupId.value != '') {
            if (formBloc.state.isValid()) {
              currentGroupId.update(formBloc.groupId.value);
            } else
              currentGroupId.update('Unknown');
          }

          return FormBlocListener<GroupFormBloc, String, String>(
            onSubmitting: (context, state) {
              LoadingDialog.show(context);
            },
            onLoading: (context, state) {
              LoadingDialog.show(context);
            },
            onSuccess: (context, state) {
              LoadingDialog.hide(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Đã tìm thấy nhóm.'),
                ),
              );
            },
            onFailure: (context, state) {
              LoadingDialog.hide(context);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Có lỗi xảy ra. Vui lòng kiểm tra lại mạng.'),
                ),
              );
            },
            child: Column(
              children: [
                TextFieldBlocBuilder(
                  textFieldBloc: formBloc.groupId,
                  decoration: InputDecoration(
                    labelText: 'Group ID',
                    //hint text
                    hintText: currentGroupId.state,
                    prefixIcon: Icon(Icons.group),
                  ),
                ),
                Text('Mã nhóm hiện tại là: ' + currentGroupId.state),
              ],
            ),
          );
        },
      ),
    );
  }
}
