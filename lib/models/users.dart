import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String name;
  final String id;
  final String profilePicture;
  User({
    this.name,
    this.id,
    this.profilePicture,
  });

  static User empty() {
    return User(id: '', name: '', profilePicture: '');
  }

  static User fromDocument(DocumentSnapshot document) {
    if (document == null || document.data == null) return null;

    return User(
        name: document.data['name'],
        id: document.documentID,
        profilePicture: document.data['profile_picture']);
  }

  @override
  String toString() =>
      'User(name: $name, id: $id, profilePicture: $profilePicture)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is User &&
        o.name == name &&
        o.id == id &&
        o.profilePicture == profilePicture;
  }

  @override
  int get hashCode => name.hashCode ^ id.hashCode ^ profilePicture.hashCode;
}
