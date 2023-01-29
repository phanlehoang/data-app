//create a simple app
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:demo_app2/logic/global/current_export.dart';
import 'package:demo_app2/logic/status_cubit/time_check/time_check_cubit.dart';
import 'package:demo_app2/presentation/router/app_router.dart';
import 'package:demo_app2/presentation/widgets/nice_widgets/nice_export.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logic/1_patient_blocs/current_profile_cubit.dart';
import 'logic/1_patient_blocs/medical_blocs/current_medical_method_cubit.dart';
import 'logic/status_cubit/internet/internet_cubit.dart';
import 'logic/status_cubit/navigator_bar_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp(
    appRouter: AppRouter(),
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;

  const MyApp({Key? key, required this.appRouter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        //internet cubit
        BlocProvider<InternetCubit>(
          create: (internetCubitContext) => InternetCubit(
            connectivity: Connectivity(),
          ),
        ),
        BlocProvider<BottomNavigatorBarCubit>(
          create: (navigatorBarCubitContext) => BottomNavigatorBarCubit(),
        ),
        //navigator patient cubit
        BlocProvider<PatientNavigatorBarCubit>(
          create: (navigatorBarCubitContext) => PatientNavigatorBarCubit(),
        ),
        //doctor navigator cubit
        BlocProvider<DoctorNavigatorBarCubit>(
          create: (navigatorBarCubitContext) => DoctorNavigatorBarCubit(),
        ),
        //current group id cubit
        BlocProvider<CurrentGroupIdCubit>(
          create: (currentGroupIdCubitContext) => CurrentGroupIdCubit(),
        ),
        //current profile cubit
        BlocProvider<CurrentProfileCubit>(
          create: (currentProfileCubitContext) => CurrentProfileCubit(),
        ),
        //current method cubit
        BlocProvider<CurrentMedicalMethodCubit>(
          create: (currentMethodCubitContext) => CurrentMedicalMethodCubit(),
        ),
        //time check cubit
        BlocProvider<TimeCheckCubit>(
          create: (timeCheckCubitContext) => TimeCheckCubit(
            ticker: secondStream(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: winterTheme(Brightness.light),
        onGenerateRoute: appRouter.onGeneratedRoute,
      ),
    );
  }
}
