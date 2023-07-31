import 'dart:io' as io;
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseStorageService {
  static final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

//  Reference storageReference = firebaseStorage.getR();
  Reference storageReference = FirebaseStorage.instance.ref();

  Future<UploadTask?> uploadImage({
    required XFile file,
    required Reference ref,
  }) async {
    UploadTask uploadTask;

    // Create a Reference to the file

    final metadata = SettableMetadata(
      contentType: 'image/jpeg/png',
      customMetadata: {'picked-file-path': file.path},
    );

    if (kIsWeb) {
      uploadTask = ref.putData(await file.readAsBytes(), metadata);
    } else {
      uploadTask = ref.putFile(io.File(file.path), metadata);
    }

    return Future.value(uploadTask);
  }

  Future<UploadTask?> uploadFile({
    required File file,
    required Reference ref,
  }) async {
    UploadTask uploadTask;

    // Create a Reference to the file

    final metadata = SettableMetadata(
      contentType: 'image/jpeg/png',
      customMetadata: {'picked-file-path': file.path},
    );

    if (kIsWeb) {
      uploadTask = ref.putData(await file.readAsBytes(), metadata);
    } else {
      uploadTask = ref.putFile(io.File(file.path), metadata);
    }

    return Future.value(uploadTask);
  }
}
