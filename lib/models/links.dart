import 'package:cloud_firestore/cloud_firestore.dart';

class Link {
  final String url;
  final String title;
  final String documentID;
  final int position;
  final DocumentReference documentReference;

  Link({
    this.url,
    this.title,
    this.documentID,
    this.position,
    this.documentReference,
  });

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'title': title,
      'position': position,
    };
  }

  static Link fromDocument(DocumentSnapshot document) {
    if (document == null || document.data == null) return null;

    return Link(
      documentID: document.documentID,
      url: document.data['url'],
      title: document.data['title'],
      position: document.data['position'],
      documentReference: document.reference,
    );
  }

  @override
  String toString() => 'Link url: $url, title: $title, position: $position';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Link && o.url == url && o.title == title;
  }

  @override
  int get hashCode => url.hashCode ^ title.hashCode;
}
