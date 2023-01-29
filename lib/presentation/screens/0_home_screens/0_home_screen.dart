//create a home screen
import 'package:demo_app2/data/data_provider/search_document.dart';
import 'package:demo_app2/logic/global/current_group/current_group_id_cubit.dart';
import 'package:demo_app2/logic/0_home_blocs.dart/0.0.find_and_create_group_blocs/group_form_bloc.dart';
import 'package:demo_app2/presentation/widgets/nice_widgets/add_patient_icon.dart';
import 'package:demo_app2/presentation/widgets/nice_widgets/nice_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:nice_buttons/nice_buttons.dart';

import '../../../data/data_provider/group_provider.dart';
import '../../../data/data_provider/patient_provider.dart';
import '../../widgets/bars/bottom_navitgator_bar.dart';
import '3_create_patient/3_wizard_form_screen.dart';
import '2_create_group_screen.dart';
import '1_find_group.dart';
import '4_list_patients.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //var trial = searchGroupId('groups', id)
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: NiceInternetScreen(
        child: Column(
          children: [
            GroupDecoration(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: FindGroup()),
                SizedBox(width: 10),
                SizedBox(
                    width: MediaQuery.of(context).size.width / 4.5,
                    child: ButtonToCreateGroup()),
              ],
            ),
            NiceScreen(child: ListSyncPatients()),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigatorBar(),
    );
  }
}

class ButtonToCreatePatient extends StatelessWidget {
  const ButtonToCreatePatient({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: context.read<CurrentGroupIdCubit>(),
      builder: (BuildContext context, state) {
        if (state == 'Unknown')
          return Container();
        else
          return Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: NiceButtons(
                    child: AddPatientIcon(),
                    onTap: (finish) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WizardFormScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
      },
    );
  }
}

class ButtonToCreateGroup extends StatelessWidget {
  const ButtonToCreateGroup({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CreateGroupScreen(),
          ),
        );
      },
      child: Text('Tạo nhóm ',
          style: // thêm màu cho chữ, thêm gạch chân, thêm đậm, thêm kích thước
              TextStyle(
            color: Colors.green,
            decoration: TextDecoration.underline,
            fontWeight: FontWeight.bold,
            fontSize: 10,
          )),
    );
  }
}
