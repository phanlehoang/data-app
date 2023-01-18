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
                            .doc('1'));
                //a medicalTakeInsulin to test
                MedicalTakeInsulin m = MedicalTakeInsulin(
                  time: DateTime(1999),
                  insulinType: InsulinType.Actrapid,
                  insulinUI: 100,
                );
                // Map<String, dynamic> mMap = m.toMap();
                // var trial2 = await FirebaseFirestore.instance
                //     .collection('list_adds')
                //     .doc('1')
                //     .set({
                //   'medical_take_insulins': [mMap, mMap]
                // });
                // thêm 1 medicalTakeInsulin vào list
                DocumentReference ref =
                    FirebaseFirestore.instance.collection('list_adds').doc('1');
                var trial3 = await ref.set(testReg().toMap());
                // var trial2 = await ref.update({
                //   'medical_take_insulins': FieldValue.arrayUnion([m.toMap()])
                // });
                // xóa 1 medicalTakeInsulin khỏi list
              },
              child: Text('${trial}'))
        ],
      ),
      bottomNavigationBar: BottomNavigatorBar(),
    );
  }
}

Regimen testReg() {
  MedicalTakeInsulin m = MedicalTakeInsulin(
    time: DateTime(1999),
    insulinType: InsulinType.Actrapid,
    insulinUI: 100,
  );
  //Medical check glu
  MedicalCheckGlucose m2 = MedicalCheckGlucose(
    time: DateTime(1999),
    glucoseUI: 100,
  );
  Regimen r = Regimen(
    medicalActions: [m, m2],
    medicalTakeInsulins: [m],
    medicalCheckGlucoses: [m2],
  );
  return r;
}
