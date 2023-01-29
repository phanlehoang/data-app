import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app2/logic/1_patient_blocs/current_profile_cubit.dart';
import 'package:demo_app2/presentation/widgets/nice_widgets/0_nice_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/profile.dart';
import '../../../logic/global/current_group/current_group_id_cubit.dart';
import '../../widgets/bars/bottom_navitgator_bar.dart';
import '../../widgets/bars/patient_navigator_bar.dart';
import 'medical_screen.dart';

// Tạo form để hiển thị thông tin của bệnh nhân
class PatientProfileScreen extends StatelessWidget {
  const PatientProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: PatientNavigatorBar(),
      ),
      // Tạo tên, tuổi, cân nặng, chiều cao của bệnh nhân, TextSize: 20, Thêm khoảng trắng ở giữa
      body: NiceInternetScreen(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('groups')
                .doc(context.read<CurrentGroupIdCubit>().state)
                .collection('patients')
                .doc(context.read<CurrentProfileCubit>().state.id)
                .snapshots(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }
              //
              if (snapshot.data!.data() == null) {
                return Text('No data');
              }
              // Lấy thông tin của bệnh nhân
              final profile = snapshot.data!['profile'];
              context
                  .read<CurrentProfileCubit>()
                  .getProfile(Profile.fromMap(profile));

              return BlocBuilder<CurrentProfileCubit, Profile>(
                builder: (context, profileState) {
                  return Container(
                    child: Column(
                      //thụt vào bên trái
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ChooseMedicalMethod(),
                        Text(
                          'Tên: ${profileState.name} ',
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          'Ngày sinh: ${shortBirthday(profileState.birthday)}',
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          'Cân nặng:${profileState.weight} ',
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          'Chiều cao: ${profileState.height}',
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        // Tạo nút để thêm thông tin bệnh nhân
                      ],
                    ),
                  );
                },
              );
            }),
      ),

      bottomNavigationBar: BottomNavigatorBar(),
    );
  }
}

String shortBirthday(DateTime birthday) {
  String day = birthday.day.toString();
  String month = birthday.month.toString();
  String year = birthday.year.toString();
  return day + '/' + month + '/' + year;
}
