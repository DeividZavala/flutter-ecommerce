import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/models/product_model.dart';
import 'package:ecommerce/models/user_data.dart';

class FirestoreService {
  final String uid;
  FirestoreService({required this.uid});

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addProduct(Product product) async {
    final docId = firestore.collection("products").doc().id;
    await firestore.collection("products").doc(docId).set(product.toMap(docId));
  }

  Stream<List<Product>> getProducts() {
    return firestore.collection("products").snapshots().map(
          (snapshot) => snapshot.docs.map((doc) {
            final d = doc.data();
            return Product.fromMap(d);
          }).toList(),
        );
  }

  Future<void> deleteProduct(String id) async {
    await firestore.collection("products").doc(id).delete();
  }

  Future<void> addUser(
    UserData user,
  ) async {
    await firestore.collection("users").doc(user.uid).set(user.toMap());
  }

  Future<UserData?> getUser(String uid) async {
    final doc = await firestore.collection("users").doc(uid).get();
    return doc.exists ? UserData.fromMap(doc.data()!) : null;
  }
}
