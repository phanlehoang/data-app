//create a simple app
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:data_app/logic/current/current_export.dart';
import 'package:data_app/presentation/router/app_router.dart';
import 'package:data_app/presentation/widgets/nice_widgets/nice_export.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logic/current/current_patient/current_profile_cubit.dart';
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
