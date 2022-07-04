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
            ? user.email == adminEmail
                ? adminSignedInBuilder(context)
                : signInBuilder(context)
            : nonSignInBuilder(context),
        error: (_, __) =>
            const Scaffold(body: Center(child: Text("Something went wrong"))),
        loading: () =>
            const Scaffold(body: Center(child: CircularProgressIndicator())));
  }
}
