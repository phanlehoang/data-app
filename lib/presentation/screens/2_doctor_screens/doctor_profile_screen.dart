import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_app/data/models/enums.dart';
import 'package:data_app/data/models/sonde/export_sonde_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../data/data_provider/regimen_provider.dart';
import '../../widgets/bars/bottom_navitgator_bar.dart';
import '../../widgets/bars/doctor_navigator_bar.dart';

class DoctorProfileScreen extends StatelessWidget {
  const DoctorProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    dynamic trial;
    return Scaffold(
      appBar: AppBar(
        title: Text("Hồ sơ bác sĩ"),

        //  flexibleSpace: DoctorNavigatorBar(),
      ),
      body: Column(
        //button
        children: [
          TextButton(
              onPressed: () async {
                trial =
                    await SondeNoInsulinRegimenProvider.readMedicalTakeInsulins(
                  ref: FirebaseFirestore.instance
                      .collection('list_adds')
                      .doc('1')
                      .collection('medicalTakeInsulins'),
                );
                //  print(trial);
              },
              child: Text('${trial}'))
        ],
      ),
      bottomNavigationBar: BottomNavigatorBar(),
    );
  }
}
