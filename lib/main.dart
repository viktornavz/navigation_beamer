import 'package:beamer/beamer.dart';
import 'package:beamersal/routes/locations.dart';
import 'package:beamersal/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  final routerDelegate = BeamerDelegate(
    locationBuilder: BeamerLocationBuilder(
      beamLocations: [
        HomeLocation(),
        LoginLocation(),
        BooksLocation(),
      ],
    ),
    guards: [
      // Guard /books and /books/* by beaming to /login if the user is unauthenticated:
      BeamGuard(
        pathBlueprints: ['/books', '/books/*'],
        check: (context, location) =>
            context.read<AuthenticationNotifier>().isAuthenticated,
        beamToNamed: '/login',
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthenticationNotifier(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerDelegate: routerDelegate,
        routeInformationParser: BeamerParser(),
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}
