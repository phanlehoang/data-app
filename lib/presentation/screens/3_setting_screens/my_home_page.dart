import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../authentication/login/home_screen_main_login.dart';
import '../../../authentication/login/login.dart';
import '../../../authentication/manage_patient/manager.dart';
import '../../widgets/nice_widgets/sizeDevide.dart';

class MyHomePage extends StatefulWidget {
  final String keyLocalLogin;
  final String keyCodeLocal;
  const MyHomePage(
      {Key? key,
      required this.title,
      required this.keyLocalLogin,
      required this.keyCodeLocal})
      : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String keyLocalLogin = "";
  String keyCodeLocal = "";
  late Future<String> _fetchData;

  @override
  void initState() {
    _fetchData = getData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widthDevide = MediaQuery.of(context).size.width;
    heightDevide = MediaQuery.of(context).size.height;
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return FutureBuilder(
        future: _fetchData,
        builder: (context, snapshot) {
          Widget children;
          children = keyLocalLogin == ""
              ? Login()
              : HomeScreenMainLogin(
                  keyLogin: keyLocalLogin,
                  keyCode: keyCodeLocal,
                );
          return Container(
            child: children,
          );
        });
  }

  Future<String> getData() async {
    keyLocalLogin = this.widget.keyLocalLogin;

    if (keyLocalLogin != "") {
      await Manager(key: keyLocalLogin).readNameUser();
      await Manager(key: keyLocalLogin).readNameEmailUser();
      keyCodeLocal = this.widget.keyCodeLocal;
      if (keyCodeLocal != "") {
        // String keyLoginCreatorTemp = '';
        await FirebaseFirestore.instance
            .collection(keyCodeLocal)
            .doc('informationGroup')
            .get()
            .then((DocumentSnapshot value) async {
          Manager(key: keyLocalLogin).nameGroupJoin =
              await value['name_group'] ?? 'none';
        });
        // keyLoginCreatorTemp = value['keylogin_of_creator'] ?? 'error keylocal';
        // print("nameGroupCreator: ${value['keylogin_of_creator']}");
        Manager(key: keyLocalLogin).keyCodeGroup = keyCodeLocal;
        // await Manager(key: keyLocalLogin).readDataFireStoreDBManager();
      }
    }
    return "done";
  }
}
