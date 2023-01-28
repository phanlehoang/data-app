import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/data_provider/sonde_provider/sonde_fast_insulin_provider.dart';
import '../../../data/models/sonde/4_regimen.dart';
import '../../../logic/1_patient_blocs/current_profile_cubit.dart';
import '../../../logic/global/current_group/current_group_cubit.dart';
import '../../widgets/bars/bottom_navitgator_bar.dart';
import '../../widgets/bars/patient_navigator_bar.dart';
import '../../widgets/nice_widgets/0_nice_screen.dart';

class PatientHistoryScreen extends StatelessWidget {
  const PatientHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: PatientNavigatorBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder(
              stream: RefProvider.fastInsulinHistoryRef(
                      context.read<CurrentProfileCubit>().state)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                } else {
                  if (snapshot.data == null) return Text('No data');

                  var docs = snapshot.data!.docs;
                  return Column(children: [
                    for (var doc in docs)
                      Text(
                        RegimenAndCho.fromMap(
                                doc.data() as Map<String, dynamic>)
                            .toString(),
                      )
                  ]);
                }
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigatorBar(),
    );
  }
}
