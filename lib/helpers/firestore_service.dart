import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:links_landing_page/models/links.dart';
import 'package:links_landing_page/models/users.dart';

Stream<User> userData(String uid) {
  return Firestore.instance.document('users/$uid').snapshots().map((doc) {
    return User.fromDocument(doc);
  });
}

Stream<List<Link>> userLinksCollection(CollectionReference linksCollection) {
  if (linksCollection == null) return null;
  return linksCollection
      .orderBy('position', descending: false)
      .snapshots()
      .map((snapshot) {
    return snapshot.documents.map((doc) => Link.fromDocument(doc)).toList();
  });
}

CollectionReference linksCollection(String userId) {
  if (userId == null) return null;
  return Firestore.instance.collection('users/$userId/links');
}
