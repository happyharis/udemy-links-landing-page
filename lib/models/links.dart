class Link {
  final String url;
  final String title;
  final int position;

  Link({
    this.url,
    this.title,
    this.position,
  });

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'title': title,
      'position': position,
    };
  }

  static Link fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Link(
      url: map['url'],
      title: map['title'],
      position: map['position'],
    );
  }

  @override
  String toString() => 'Link url: $url, title: $title, position: $position';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Link &&
        o.url == url &&
        o.title == title &&
        o.position == position;
  }

  @override
  int get hashCode => url.hashCode ^ title.hashCode ^ position.hashCode;
}
