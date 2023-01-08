//create a home screen
import 'package:data_app/data/data_provider/search_document.dart';
import 'package:data_app/logic/form_blocs/group_form.dart';
import 'package:data_app/presentation/widgets/nice_widgets/nice_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import '../../widgets/bars/bottom_navitgator_bar.dart';
import 'create_group_screen.dart';
import 'find_group.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //var trial = searchGroupId('groups', id)
    return Scaffold(
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          children: [
            GroupDecoration(),
            FindGroup(),
            SizedBox(height: 20),
            //button to create group
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GreenButton(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateGroupScreen(),
                      ),
                    );
                  },
                  text: 'Tạo nhóm',
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigatorBar(),
    );
  }
}
