import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String name;
  final String id;
  User({
    this.name,
    this.id,
  });

  static User empty() {
    return User(id: '', name: '');
  }

  static User fromDocument(DocumentSnapshot document) {
    if (document == null || document.data == null) return null;

    return User(
      name: document.data['name'],
      id: document.documentID,
    );
  }

  @override
  String toString() => 'User(name: $name, id: $id)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is User && o.name == name && o.id == id;
  }

  @override
  int get hashCode => name.hashCode ^ id.hashCode;
}
