import 'package:flutter/material.dart';

class DoctorImage extends StatelessWidget {
  const DoctorImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Container(
              color: Colors.white,
              // width: widthDevideMethod(0.1),
              // height: heightDevideMethod(0.372),
            ),
            Container(
              alignment: Alignment.center,
              child: SizedBox(
                  height: 200,
                  width: 330,
                  // width: widthDevideMethod(0.7),
                  child: Align(
                    alignment: Alignment.center,
                    child: Image.asset("assets/images/doctor.jpg",
                        //    height: 200, width: 200,
                        fit: BoxFit.fitHeight),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
