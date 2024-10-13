import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:manga_notes/features/auth_screen/auth_screen.dart';
import 'package:manga_notes/features/favourite_screen/favourite_screen.dart';
import 'package:manga_notes/repositories/repositories.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<bool>? _checkAuthorizationFuture;

  @override
  void initState() {
    super.initState();
    _checkAuthorizationFuture = GetIt.I<DataBase>().checkAuthorization();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<bool>(
        future: _checkAuthorizationFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data == false) {
            return AuthScreen();
          } else if (snapshot.hasData && snapshot.data == true) {
            return FavouriteScreen();
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
