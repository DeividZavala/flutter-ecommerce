import 'package:ecommerce/models/user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ecommerce/app/providers.dart';
import "package:flutter/material.dart";

class AuthWidget extends ConsumerWidget {
  final WidgetBuilder nonSignInBuilder;
  final WidgetBuilder signInBuilder;
  final WidgetBuilder adminSignedInBuilder;

  const AuthWidget(
      {required this.adminSignedInBuilder,
      required this.signInBuilder,
      required this.nonSignInBuilder,
      Key? key})
      : super(key: key);

  final String adminEmail = "admin@admin.com";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStateChange = ref.watch(authStateChangesProvider);

    return authStateChange.when(
        data: (user) => user != null
            ? signedInHandler(context, ref, user)
            : nonSignInBuilder(context),
        error: (_, __) =>
            const Scaffold(body: Center(child: Text("Something went wrong"))),
        loading: () =>
            const Scaffold(body: Center(child: CircularProgressIndicator())));
  }

  FutureBuilder<UserData?> signedInHandler(context, WidgetRef ref, User user) {
    final database = ref.read(databaseProvider)!;
    final potentialUserFuture = database.getUser(user.uid);
    return FutureBuilder<UserData?>(
        future: potentialUserFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final potentialUser = snapshot.data;
            if (potentialUser == null) {
              database.addUser(UserData(
                  email: user.email != null ? user.email! : "",
                  uid: user
                      .uid)); // no need to await as you don't depend on that
            }
            if (user.email == adminEmail) {
              return adminSignedInBuilder(context);
            }
            return signInBuilder(context);
          }
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
