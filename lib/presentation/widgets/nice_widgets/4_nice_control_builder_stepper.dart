import 'package:demo_app2/presentation/widgets/nice_widgets/nice_export.dart';
import 'package:flutter/material.dart';

//create a widget is a function
Widget niceControlBuilder(BuildContext context, ControlsDetails details) {
  return Row(
    children: [
      GreenButton(
        onTap: details.onStepContinue,
        text: 'Tiếp tục',
      ),
      SizedBox(width: 10),
      GreyButton(
        onTap: details.onStepCancel,
        text: 'Hủy',
      ),
    ],
  );
}
