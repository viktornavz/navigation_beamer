import 'package:beamersal/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isAuthenticated =
        Provider.of<AuthenticationNotifier>(context).isAuthenticated;

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: isAuthenticated
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Successfully logged in.'),
                  SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () => context.beamToNamed('/books'),
                    child: Text('Beam to books location'),
                  ),
                ],
              )
            : ElevatedButton(
                onPressed: () =>
                    Provider.of<AuthenticationNotifier>(context, listen: false)
                        .login(),
                child: Text('Login'),
              ),
      ),
    );
  }
}
