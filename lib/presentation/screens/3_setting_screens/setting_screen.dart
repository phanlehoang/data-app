import 'package:async/async.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app2/presentation/screens/3_setting_screens/my_home_page.dart';
import 'package:demo_app2/presentation/widgets/nice_widgets/0_nice_screen.dart';
import 'package:demo_app2/presentation/widgets/status/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:responsive_notebook_background/responsive_notebook_background.dart';

import '../../widgets/bars/bottom_navitgator_bar.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyHomePage(
        keyCodeLocal: '',
        keyLocalLogin: '',
        title: '',
      ),
      bottomNavigationBar: BottomNavigatorBar(),
    );
  }
}

class DataFromRefTrial extends StatelessWidget {
  final String address;
  const DataFromRefTrial({
    Key? key,
    required this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //reference
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection(address).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        } else {
          final groups = snapshot.data!.docs;

          return Column(children: [
            for (var group in groups)
              Container(
                child: Column(
                  children: [
                    Text('8' + group.data().toString()),
                  ],
                ),
              ),
          ]);
        }
      },
    );
  }
}

class StreamBuilderTrial extends StatelessWidget {
  const StreamBuilderTrial({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('cars').snapshots(),
      // ignore: missing_return
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        } else {
          final groups = snapshot.data!.docs;

          return Column(children: [
            for (var group in groups)
              Container(
                child: Column(
                  children: [
                    Text(group.data().toString()),
                    ChildrenCar(
                      groupId: group.id,
                    ),
                  ],
                ),
              ),
          ]);
        }
      },
    );
  }
}

class ChildrenCar extends StatelessWidget {
  final groupId;
  const ChildrenCar({
    Key? key,
    this.groupId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('cars')
          .doc(groupId)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        } else {
          final children_car = snapshot.data!;

          return Column(children: [
            Container(
              child: Column(
                children: [
                  Text(children_car.data().toString()),
                ],
              ),
            ),
          ]);
        }
      },
    );
  }
}

class CancelFutureTrial extends StatefulWidget {
  const CancelFutureTrial({Key? key}) : super(key: key);

  @override
  _CancelFutureTrialState createState() => _CancelFutureTrialState();
}

class _CancelFutureTrialState extends State<CancelFutureTrial> {
  // this future will return some text once it completes
  Future<String?> _myFuture() async {
    await Future.delayed(const Duration(seconds: 5));
    print('still running');
    return 'Future completed';
  }

  // keep a reference to CancelableOperation
  CancelableOperation? _myCancelableFuture;

  // This is the result returned by the future
  String? _text;

  // Help you know whether the app is "loading" or not
  bool _isLoading = false;

  // This function is called when the "start" button is pressed
  void _getData() async {
    setState(() {
      _isLoading = true;
    });

    _myCancelableFuture = CancelableOperation.fromFuture(
      _myFuture(),
      onCancel: () => 'Future has been canceld',
    );
    final value = await _myCancelableFuture?.value;

    // update the UI
    setState(() {
      _text = value;
      _isLoading = false;
    });
  }

  // this function is called when the "cancel" button is tapped
  void _cancelFuture() async {
    final result = await _myCancelableFuture?.cancel();
    setState(() {
      _text = result;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('KindaCode.com')),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : Text(
                _text ?? 'Press Start Button',
                style: const TextStyle(fontSize: 28),
              ),
      ),
      // This button is used to trigger _getDate() and _cancelFuture() functions
      // the function is called depends on the _isLoading variable
      floatingActionButton: ElevatedButton(
        onPressed: () => _isLoading ? _cancelFuture() : _getData(),
        child: Text(_isLoading ? 'Cancel' : 'Start'),
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            primary: _isLoading ? Colors.red : Colors.indigo),
      ),
    );
  }
}
