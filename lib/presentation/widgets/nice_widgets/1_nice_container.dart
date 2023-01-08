// ignore_for_file: public_member_api_docs, sort_constructors_first
//nice container stateless widget
import 'package:flutter/material.dart';
import 'package:nice_buttons/nice_buttons.dart';

class NiceContainer extends StatelessWidget {
  final Widget child;
  const NiceContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        // padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              //color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}

//normal container
class SimpleContainer extends StatelessWidget {
  final Widget child;
  const SimpleContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      //color padding

      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: BorderRadius.circular(5),
        //viền đen
        border: Border.all(
          color: Theme.of(context).backgroundColor,
          width: 1,
        ),
      ),
      child: child,
    );
  }
}
