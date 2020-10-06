import 'package:flutter/material.dart';

class FullScreenScaffoldLoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: CircularProgressIndicator(
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }
}
