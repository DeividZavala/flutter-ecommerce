import "dart:io";
import "package:firebase_storage/firebase_storage.dart";

class StorageService {
  final String uid;

  FirebaseStorage storage = FirebaseStorage.instance;

  StorageService({required this.uid});

  Future<String> uploadFile(String filePath) async {
    try {
      final dateTime = DateTime.now().toIso8601String();
      final ref = storage.ref("$uid/$dateTime");
      final uploadTask = await ref.putFile(File(filePath));
      return await uploadTask.ref.getDownloadURL();
    } catch (e) {
      print(e);
    }
    return "";
  }
}
