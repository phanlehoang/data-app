import 'package:flutter/cupertino.dart';
//import material
import 'package:flutter/material.dart';

import '1_nice_container.dart';

class NiceItem extends StatelessWidget {
  final int index;
  final String? title;
  final String? subtitle;
  final Widget trailing;
  final onTap;
  const NiceItem({
    Key? key,
    required this.index,
    required this.title,
    required this.subtitle,
    required this.trailing,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      //horizontal
      scrollDirection: Axis.horizontal,
      //width

      child: Container(
        width: 300,
        child: Column(
          //width
          mainAxisSize: MainAxisSize.min,
          children: [
            SimpleContainer(
              child: ListTile(
                title: Text('Item $index'),
                subtitle: Text('Subtitle $index'),
                leading: Container(
                  child: ClipOval(
                    child: Image.asset(
                      "assets/images/gentle_girl.jpg",
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                trailing: Column(
                  children: [
                    trailing,
                    const Icon(Icons.arrow_forward_ios),
                  ],
                ),
                onTap: onTap,
              ),
            ),
            //const Divider(),
          ],
        ),
      ),
    );
  }
}