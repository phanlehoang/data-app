//Loading dialog stless widget
import 'package:flutter/material.dart';

import '../nice_widgets/nice_export.dart';

class LoadingDialogScreen extends StatelessWidget {
  const LoadingDialogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loading Dialog'),
      ),
      body: Center(
        child: NiceScreen(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  LoadingDialog.show(context);
                },
                child: const Text('Show Loading Dialog'),
              ),
              ElevatedButton(
                onPressed: () {
                  LoadingDialog.hide(context);
                },
                child: const Text('Hide Loading Dialog'),
              ),
              GestureDetector(
                onTap: () {},
                child: FocusableActionDetector(
                  autofocus: true,
                  child: TextButton(
                    onPressed: () {
                      LoadingDialog.show(context);
                    },
                    child: const Text('Focusable Action Detector'),
                  ),
                ),
              ),
              NiceButton(
                onTap: () {
                  LoadingDialog.show(context);
                  Future.delayed(const Duration(seconds: 1), () {
                    LoadingDialog.hide(context);
                  });
                },
                text: 'loading dialog in 1s',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoadingDialog extends StatelessWidget {
  static void show(BuildContext context, {Key? key}) {
    showDialog(
      context: context,
      useRootNavigator: false,
      barrierDismissible: false,
      builder: (_) => LoadingDialog(key: key),
    ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));
  }

  static void hide(BuildContext context) {
    Navigator.pop(context);
  }

  const LoadingDialog({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => true,
        child: NiceContainer(
          child: Container(
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.width * 0.3,
              padding: EdgeInsets.all(20),
              child: CircularProgressIndicator()),
        ));
  }
}
