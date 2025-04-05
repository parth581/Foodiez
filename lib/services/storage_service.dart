import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  static Future<String> uploadReview(File imageFile) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('Not authenticated');

    // Create reference with user UID and timestamp
    final ref = FirebaseStorage.instance.ref(
      'reviews/${user.uid}/${DateTime.now().millisecondsSinceEpoch}.jpg'
    );
    
    // Upload the file
    await ref.putFile(imageFile);
    
    // Return download URL for later use
    return await ref.getDownloadURL();
  }

  static Future<String> downloadReview(String imagePath) async {
    final ref = FirebaseStorage.instance.ref(imagePath);
    return await ref.getDownloadURL();
  }
}