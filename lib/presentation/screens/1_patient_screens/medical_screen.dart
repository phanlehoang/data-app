import 'package:flutter/material.dart';

import '../../widgets/bars/bottom_navitgator_bar.dart';
import '../../widgets/bars/patient_navigator_bar.dart';

class PatientMedicalScreen extends StatelessWidget {
  const PatientMedicalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: PatientNavigatorBar(),
      ),
      body: Column(),
      bottomNavigationBar: BottomNavigatorBar(),
    );
  }
}
