//create a home screen
import 'package:data_app/data/data_provider/search_document.dart';
import 'package:data_app/data/repositories/group_repo.dart';
import 'package:data_app/logic/current/current_group/current_group_cubit.dart';
import 'package:data_app/logic/form_blocs/1_group_form.dart';
import 'package:data_app/presentation/widgets/nice_widgets/add_patient_icon.dart';
import 'package:data_app/presentation/widgets/nice_widgets/nice_export.dart';
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
import '4_list_short_patients.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //var trial = searchGroupId('groups', id)
    return Scaffold(
      body: NiceScreen(
        child: Column(
          children: [
            GroupDecoration(),
            Row(
              children: [
                SizedBox(width: 200, child: FindGroup()),
                SizedBox(width: 10),
                SizedBox(width: 100, child: ButtonToCreateGroup()),
              ],
            ),
            ButtonToCreatePatient(),
            NiceScreen(child: ListOfPatients()),
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
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 100,
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
    return GreenButton(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CreateGroupScreen(),
          ),
        );
      },
      text: 'Tạo nhóm',
    );
  }
}
