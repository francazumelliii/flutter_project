class MediaCollection {
  final int id;
  final String title;
  final String subtitle;
  final String coverUrl;
  final String type;

  MediaCollection({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.coverUrl,
    required this.type,
  });

  factory MediaCollection.fromJson(Map<String, dynamic> json, {required String type}) {
    String getSubtitle() {
      if (type == 'album') {
        return (json['artist']?['name'] ?? '') as String;
      } else if (type == 'playlist') {
        return (json['creator']?['name'] ?? '') as String;
      }
      return '';
    }

    String getCoverUrl() {
      if (type == 'album') {
        return json['cover_xl'] ?? json['cover_big'] ?? '';
      } else {
        return json['picture_xl'] ?? json['picture_big'] ?? '';
      }
    }

    return MediaCollection(
      id: json['id'],
      title: json['title'] ?? '',
      subtitle: getSubtitle(),
      coverUrl: getCoverUrl(),
      type: type,
    );
  }
}
