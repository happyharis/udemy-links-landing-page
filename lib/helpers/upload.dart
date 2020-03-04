import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:links_landing_page/models/users.dart';

/// A "select file/folder" window will appear. User will have to choose a file.
/// This file will be then read, and uploaded to firebase storage;
uploadImage({@required Function(File) onSelected}) async {
  // HTML input element
  InputElement uploadInput = FileUploadInputElement()..accept = 'image/*';
  uploadInput.click();

  uploadInput.onChange.listen(
    (changeEvent) {
      final file = uploadInput.files.first;
      final reader = FileReader();
      // The FileReader object lets web applications asynchronously read the
      // contents of files (or raw data buffers) stored on the user's computer,
      // using File or Blob objects to specify the file or data to read.
      // Source: https://developer.mozilla.org/en-US/docs/Web/API/FileReader

      reader.readAsDataUrl(file);
      // The readAsDataURL method is used to read the contents of the specified Blob or File.
      //  When the read operation is finished, the readyState becomes DONE, and the loadend is
      // triggered. At that time, the result attribute contains the data as a data: URL representing
      // the file's data as a base64 encoded string.
      // Source: https://developer.mozilla.org/en-US/docs/Web/API/FileReader/readAsDataURL

      reader.onLoadEnd.listen(
        // After file finiesh reading and loading, it will be uploaded to firebase storage
        (loadEndEvent) async {
          onSelected(file);
        },
      );
    },
  );
}

uploadToFirebase(File imageFile, String userId) async {
  final dateNow = DateTime.now();
  final filePath = 'profile_pictures/$userId-$dateNow.png';

  fb
      .storage()
      .refFromURL('gs://links-landing-page.appspot.com')
      .child(filePath)
      .put(imageFile);

  updateProfilePictureUrl(userId, filePath);
}

void removeOldProfilePicture(String oldPictureUrl) {
  fb
      .storage()
      .refFromURL('gs://links-landing-page.appspot.com')
      .child(oldPictureUrl)
      .delete();
}

void updateProfilePictureUrl(String userId, String profilePictureUrl) {
  Firestore.instance
      .document('users/$userId')
      .setData({'profile_picture': profilePictureUrl}, merge: true);
}

Stream<Uri> getUrl(User user) async* {
  final userProfilePicture = fb
      .storage()
      .refFromURL('gs://links-landing-page.appspot.com')
      .child(user.profilePicture)
      .getDownloadURL();

  yield* Stream.fromFuture(userProfilePicture);
}
