// LOCATIONS
import 'package:beamer/beamer.dart';
import 'package:beamersal/data/datos.dart';
import 'package:beamersal/screens/book_screen.dart';
import 'package:beamersal/screens/bookde_screen.dart';
import 'package:beamersal/screens/home_screen.dart';
import 'package:beamersal/screens/login_screen.dart';
import 'package:flutter/material.dart';

class HomeLocation extends BeamLocation {
  @override
  List<String> get pathBlueprints => ['/'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
        BeamPage(
          key: ValueKey('home'),
          title: 'Home',
          child: HomeScreen(),
        ),
      ];
}

class LoginLocation extends BeamLocation {
  @override
  List<String> get pathBlueprints => ['/login'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
        BeamPage(
          key: ValueKey('login'),
          title: 'Login',
          child: LoginScreen(),
        ),
      ];
}

/**
 *  books.firstWhere((book) => book['id'] == state.pathParameters['bookId'])['title']
 */

class BooksLocation extends BeamLocation {
  @override
  List<String> get pathBlueprints => ['/books/:bookId'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
        ...HomeLocation().buildPages(context, state),
        if (state.uri.pathSegments.contains('books'))
          BeamPage(
            key: ValueKey('books'),
            title: 'Books',
            child: BooksScreen(),
          ),
        if (state.pathParameters.containsKey('bookId'))
          BeamPage(
            key: ValueKey('book-${state.pathParameters['bookId']}'),
            title: !books.contains(
                    (book) => book['id'] == state.pathParameters['bookId'])
                ? books.firstWhere((book) =>
                    book['id'] == state.pathParameters['bookId'])['title']
                : 'desconicido',
            child: !books.contains(
                    (book) => book['id'] == state.pathParameters['bookId'])
                ? BookDetailsScreen(
                    book: books.firstWhere(
                        (book) => book['id'] == state.pathParameters['bookId']),
                  )
                : Forbidden(),
          ),
      ];

  final forbiddenPage = BeamPage(
    key: ValueKey('forbidden'),
    title: 'Forbidden',
    child: Scaffold(
      body: Center(
        child: Text('Forbidden.'),
      ),
    ),
  );

  @override
  List<BeamGuard> get guards => [
        // Show forbiddenPage if the user tries to enter books/2:
        BeamGuard(
          pathBlueprints: ['/books/2'],
          check: (context, location) => false,
          showPage: forbiddenPage,
        ),
      ];
}
