// SCREENS
import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () => context.beamToNamed('/books'),
              child: Text('Beam to books location'),
            ),
            ElevatedButton(
              onPressed: () => context.beamToNamed('/books/2'),
              child: Text('Beam to forbidden book'),
            ),
          ],
        ),
      ),
    );
  }
}
