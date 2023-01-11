import 'package:data_app/logic/current/current_patient/current_profile_cubit.dart';
import 'package:data_app/logic/status_cubit/navigator_bar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/group_repo.dart';
import '../../../logic/current/current_group/current_group_cubit.dart';
import '../../widgets/nice_widgets/nice_export.dart';
import '../export_screen.dart';

class ListOfPatients extends StatelessWidget {
  const ListOfPatients({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ListShortPatientsCubit>(
      create: (context) => ListShortPatientsCubit(),
      child: BlocBuilder<CurrentGroupIdCubit, String>(
        builder: (context, _state) {
          final cGroupCubit = context.read<CurrentGroupIdCubit>();
          if (cGroupCubit.state == 'Unknown') {
            return Text('Chưa có nhóm nào được chọn');
          } else {
            return ListShortPatientsShow(cGroupCubit: cGroupCubit);
          }
        },
      ),
    );
  }
}

class ListShortPatientsShow extends StatelessWidget {
  const ListShortPatientsShow({
    Key? key,
    required this.cGroupCubit,
  }) : super(key: key);

  final CurrentGroupIdCubit cGroupCubit;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CurrentGroupIdCubit, String>(
      listener: (ncontext, nstate) {
        // if (nstate == 'Unknown') {
        //   ncontext.read<ListShortPatientsCubit>().clear();
        // } else {
        //   ncontext
        //       .read<ListShortPatientsCubit>()
        //       .getPatientIdsFromGroupId(nstate);
        // }
      },
      builder: (ncontext, nstate) {
        if (nstate == 'Unknown') {
          ncontext.read<ListShortPatientsCubit>().clear();
        } else {
          ncontext
              .read<ListShortPatientsCubit>()
              .getPatientIdsFromGroupId(nstate);
        }
        return BlocBuilder<ListShortPatientsCubit, ListShortPatientsState>(
          builder: (_context, shortPatientsState) {
            switch (shortPatientsState.runtimeType) {
              case ListShortPatientsInitial:
                return Text('Chưa có nhóm nào được chọn');
              case ListShortPatientsLoading:
                return Center(child: CircularProgressIndicator());
              case ListShortPatientsError:
                return Text('Lỗi');
              case ListShortPatientsLoaded:
                {
                  List<ShortPatient> shortPatients =
                      shortPatientsState.shortPatients;
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              'Nhóm ${cGroupCubit.state} có ${shortPatients.length} bệnh nhân'),
                          ButtonToCreatePatient(),
                        ],
                      ),
                      for (var i = 0; i < shortPatients.length; i++)
                        NiceItem(
                          index: i,
                          title: shortPatients[i].name,
                          subtitle: shortPatients[i].id,
                          trailing: Text(shortPatients[i].medicalMethod),
                          onTap: () {
                            print('tapped ${shortPatients[i].name}');
                            //go to patient screen
                            _context
                                .read<CurrentProfileCubit>()
                                .update(shortPatients[i]);
                            Navigator.of(_context)
                                .pushReplacementNamed('/patient');
                            //patient navigation bar
                            _context.read<PatientNavigatorBarCubit>().update(0);
                            _context.read<BottomNavigatorBarCubit>().update(1);
                          },
                        )
                    ],
                  );
                }
              default:
                return Text('Lỗi');
            }
          },
        );
      },
    );
  }
}
