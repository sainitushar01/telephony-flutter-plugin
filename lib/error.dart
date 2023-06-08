import 'package:flutter/material.dart';

class ShowErrorScreen extends StatelessWidget {
  const ShowErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AlertDialog(
          title: const Text('Error Occurred'),
          content: const Text('Error occured while communicating with device'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'))
          ],
        ),
      ),
    );
  }
}
