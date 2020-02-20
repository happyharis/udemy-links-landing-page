import 'package:cloud_firestore/cloud_firestore.dart';

class Link {
  final String url;
  final String title;
  final String documentID;

  Link({
    this.url,
    this.title,
    this.documentID,
  });

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'title': title,
    };
  }

  static Link fromDocument(DocumentSnapshot document) {
    if (document == null || document.data == null) return null;

    return Link(
      documentID: document.documentID,
      url: document.data['url'],
      title: document.data['title'],
    );
  }

  @override
  String toString() => 'Link url: $url, title: $title';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Link && o.url == url && o.title == title;
  }

  @override
  int get hashCode => url.hashCode ^ title.hashCode;
}
