import 'package:ecommerce/services/firestore_service.dart';
import 'package:ecommerce/services/storage_service.dart';
import 'package:ecommerce/view_models/bag_view_model.dart';
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final databaseProvider = Provider<FirestoreService?>(
  (ref) {
    final auth = ref.watch(authStateChangesProvider);
    String? uid = auth.asData?.value?.uid;

    if (uid != null) {
      return FirestoreService(uid: uid);
    }
    return null;
  },
);

final storageProvider = Provider<StorageService?>((ref) {
  final auth = ref.watch(authStateChangesProvider);
  String? uid = auth.asData?.value?.uid;

  if (uid != null) {
    return StorageService(uid: uid);
  }
  return null;
});

final authStateChangesProvider = StreamProvider<User?>((ref) {
  return ref.watch(firebaseAuthProvider).authStateChanges();
});

final bagProvider = ChangeNotifierProvider<BagViewModel>((ref) {
  return BagViewModel();
});
