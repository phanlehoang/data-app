// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:data_app/presentation/widgets/status/internet_check_widgets.dart';
import 'package:flutter/material.dart';

//nice screen stateless widget
class NiceScreen extends StatelessWidget {
  final Widget child;
  const NiceScreen({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double a = MediaQuery.of(context).size.width * 0.01;

    return Container(
      padding: EdgeInsetsDirectional.fromSTEB(a, a, a, a),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        reverse: true,
        child: child,
      ),
    );
  }
}

class NiceInternetScreen extends StatelessWidget {
  final Widget child;
  const NiceInternetScreen({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InternetCheck(
      child: NiceScreen(
        child: child,
      ),
    );
  }
}

class SimpleScreen extends StatelessWidget {
  final Widget child;
  const SimpleScreen({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double a = MediaQuery.of(context).size.width * 0.01;

    return Container(
      padding: EdgeInsetsDirectional.fromSTEB(a * 2, a * 2, a * 2, a * 2),
      child: child,
    );
  }
}
