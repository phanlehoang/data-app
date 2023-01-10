import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../../logic/status_cubit/navigator_bar_cubit.dart';

class PatientNavigatorBar extends StatelessWidget {
  const PatientNavigatorBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PatientNavigatorBarCubit, int>(
      builder: (_, state) {
        return SalomonBottomBar(
          onTap: (p0) {
            BlocProvider.of<PatientNavigatorBarCubit>(context).update(p0);
            patientNavigator(p0, context);
          },
          currentIndex: state,
          items: [
            SalomonBottomBarItem(
                icon: Icon(Icons.medical_services),
                title: Text("Điều trị"),
                selectedColor: Colors.orange,
                unselectedColor: Colors.white),
            SalomonBottomBarItem(
                icon: Icon(Icons.notes_rounded),
                title: Text("Lịch sử"),
                selectedColor: Colors.orange,
                unselectedColor: Colors.white),
            SalomonBottomBarItem(
                icon: Icon(Icons.person),
                title: Text("Hồ sơ"),
                selectedColor: Colors.orange,
                unselectedColor: Colors.white)
          ],
        );
      },
    );
  }
}

void patientNavigator(int index, BuildContext context) {
  switch (index) {
    case 0:
      Navigator.of(context).pushReplacementNamed('/patient');
      break;
    case 1:
      Navigator.of(context).pushReplacementNamed('/patient/history');
      break;
    case 2:
      Navigator.of(context).pushReplacementNamed('/patient/profile');
      break;
    default:
  }
}
