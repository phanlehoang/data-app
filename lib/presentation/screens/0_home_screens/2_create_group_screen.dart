//create class

import 'package:demo_app2/logic/global/current_group/current_group_id_cubit.dart';
import 'package:demo_app2/presentation/widgets/nice_widgets/nice_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import '../../../logic/0_home_blocs.dart/0.0.find_and_create_group_blocs/group_create_form_bloc.dart';
import '../../widgets/nice_widgets/sizeDevide.dart';
import '../../widgets/status/loading_dialog.dart';

class CreateGroupScreen extends StatelessWidget {
  const CreateGroupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tạo nhóm'),
      ),
      body: NiceInternetScreen(
        child: BlocProvider<GroupCreateFormBloc>(
          create: (context) => GroupCreateFormBloc(),
          child: Builder(
            builder: (context) {
              final formBloc = context.watch<GroupCreateFormBloc>();
              return FormBlocListener<GroupCreateFormBloc, String, String>(
                onSubmitting: (context, state) => LoadingDialog.show(context),
                onSubmissionFailed: (context, state) =>
                    LoadingDialog.hide(context),
                onSuccess: (context, state) {
                  LoadingDialog.hide(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Success'),
                    ),
                  );
                  //go to home screen
                  Navigator.pop(context);
                  Navigator.of(context).pushReplacementNamed('/');
                },
                onFailure: (context, state) {
                  print('failure');
                  print(state.failureResponse);
                },
                child: Column(
                  children: [
                    TextFieldBlocBuilder(
                      textFieldBloc: formBloc.groupName,
                      decoration: InputDecoration(
                        labelText: 'Tên nhóm',
                        prefixIcon: Icon(Icons.group),
                      ),
                    ),
                    TextFieldBlocBuilder(
                      textFieldBloc: formBloc.groupId,
                      decoration: InputDecoration(
                        labelText: 'Mã nhóm',
                        prefixIcon: Icon(Icons.group),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: formBloc.submit,
                      child: Text('Nộp'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class GroupDecoration extends StatelessWidget {
  //key
  GroupDecoration({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentGroupIdCubit, String>(
      builder: (context, state) {
        final currentGroupId = state;
        // if (state != 'Unknown')
        //   return Text('');
        // else
        return Container(
          padding: EdgeInsets.symmetric(
              vertical: heightDevideMethod(context, 0.05),
              horizontal: widthDevideMethod(context, 0.086)),
          height: heightDevideMethod(context, 0.6),
          color: Color(0xff091a31),
          child: Column(children: [
            //image group

            Image.asset(
              'assets/images/hospitalback.jpg',
            ),
            const Text(
              'NHẬP MÃ NHÓM',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            const Text(
              textAlign: TextAlign.center,
              'Mã nhóm cho phép mọi người có thể theo dõi một danh sách bệnh nhân cùng một nhóm',
              style: TextStyle(
                color: Colors.white,
              ),
            )
          ]),
        );
      },
    );
  }
}
