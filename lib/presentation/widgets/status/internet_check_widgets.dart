// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/status_cubit/internet/internet_cubit.dart';

class InternetCheck extends StatelessWidget {
  final Widget child;
  const InternetCheck({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InternetCubit, InternetState>(
      builder: (context, state) {
        if (state == InternetLoading()) {
          return LoadingInternet();
        } else if (state == InternetConnected()) {
          return child;
        } else
          return NoInternet();
      },
    );
  }
}

class NoInternet extends StatelessWidget {
  const NoInternet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      //ko thoát ra được
      title: Text('Đang không có Internet'),
      content: Container(
        height: 100,
        child: Column(
          children: [
            Center(
                child:
                    Text('Bạn phải có kết nối Internet thì mới chạy được app')),
          ],
        ),
      ),
    );
  }
}

class HavingInternet extends StatelessWidget {
  const HavingInternet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 10,
    );
  }
}

class LoadingInternet extends StatelessWidget {
  const LoadingInternet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('Đang load internet');
  }
}
