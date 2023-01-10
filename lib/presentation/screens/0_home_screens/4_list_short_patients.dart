import 'package:data_app/logic/status_cubit/navigator_bar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/group_repo.dart';
import '../../../logic/current/current_group/current_group_cubit.dart';
import '../../widgets/nice_widgets/nice_export.dart';

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
        return BlocBuilder<ListShortPatientsCubit, List<ShortPatient>>(
          builder: (_context, shortPatients) {
            return Column(
              children: [
                Text(
                    'Nhóm ${cGroupCubit.state} có ${shortPatients.length} bệnh nhân'),
                for (var i = 0; i < shortPatients.length; i++)
                  NiceItem(
                    index: i,
                    title: shortPatients[i].name,
                    subtitle: shortPatients[i].id,
                    trailing: Text(shortPatients[i].medicalMethod),
                    onTap: () {
                      //go to patient screen
                      Navigator.of(_context).pushReplacementNamed('/patient');
                      //patient navigation bar
                      // _context.read<BottomNavigatorBarCubit>().emit(1);
                    },
                  )
              ],
            );
          },
        );
      },
    );
  }
}
