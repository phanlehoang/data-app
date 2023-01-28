//nice button
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:nice_buttons/nice_buttons.dart';

class NiceButton extends StatelessWidget {
  final onTap;
  final String text;
  const NiceButton({super.key, this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return NiceButtons(
      // startColor: Colors.indigo,
      // endColor: Colors.indigo.shade700,
      // borderColor: Colors.indigo.shade800,
      height: 50,
      width: getWidth(text),
      stretch: false,
      onTap: (finish) {
        onTap();
      },
      child: Text(text),
    );
  }
}

class GreenButton extends StatelessWidget {
  final onTap;
  final String text;
  const GreenButton({super.key, this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return NiceButtons(
        startColor: Colors.green,
        endColor: Colors.green.shade700,
        borderColor: Colors.green.shade800,
        height: 50,
        stretch: false,
        width: getWidth(text),
        onTap: (finish) {
          onTap();
        },
        child: Text(text));
  }
}

class GreyButton extends StatelessWidget {
  final onTap;
  final String text;
  const GreyButton({super.key, this.onTap, this.text = 'Hủy'});

  @override
  Widget build(BuildContext context) {
    return NiceButtons(
      //grey color
      startColor: Colors.grey,
      endColor: Colors.grey.shade700,
      borderColor: Colors.grey.shade800,

      height: 50,
      stretch: false,
      width: getWidth(text),
      onTap: (finish) {
        onTap();
      },
      child: Text(text),
    );
  }
}

//width of button function  text length
double getWidth(String text) {
  double width = 0;
  if (text.length > 8) {
    width = (text.length + 2) * 10;
  } else {
    width = 100;
  }
  return width;
}

class GreenGreyButton extends StatelessWidget {
  const GreenGreyButton({
    Key? key,
    required this.formBloc,
  }) : super(key: key);

  final formBloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormBloc<String, String>, FormBlocState<String, String>>(
        bloc: formBloc,
        builder: (context, state) {
          //check all validate
          switch (state.isValid()) {
            case true:
              return GreenButton(
                  text: 'Đăng nhập', onTap: () => formBloc.submit());
            default:
              return GreyButton(
                  text: 'Đăng nhập', onTap: () => formBloc.submit());
          }
        });
  }
}
