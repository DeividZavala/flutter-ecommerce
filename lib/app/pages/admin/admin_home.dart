import 'package:ecommerce/app/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import "package:flutter/material.dart";

class AdminHome extends ConsumerWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Home"),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(firebaseAuthProvider).signOut();
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Center(
        child: Text("Admin Home"),
      ),
    );
  }
}
