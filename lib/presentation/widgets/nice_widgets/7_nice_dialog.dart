//tạo dialog : Bạn có chắc là muốn ... không

import 'package:flutter/material.dart';

class MakeSureDialog extends StatelessWidget {
  final String title;
  final String content;
  final Function onPressed;
  const MakeSureDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return dialog lựa chọn
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Không'),
        ),
        TextButton(
          onPressed: () {
            onPressed();

            Navigator.pop(context);
          },
          child: Text('Có'),
        ),
      ],
    );
  }
}
