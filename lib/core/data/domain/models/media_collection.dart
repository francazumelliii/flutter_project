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

  factory MediaCollection.fromJson(Map<String, dynamic> json, String type) {
    String getSubtitle() {
      if (type == 'album') {
        if (json['artist'] != null && json['artist'] is Map<String, dynamic>) {
          return json['artist']['name'] ?? '';
        }
        return '';
      } else {
        if (json['creator'] != null && json['creator'] is Map<String, dynamic>) {
          return json['creator']['name'] ?? '';
        }
        return '';
      }
    }

    String getCoverUrl() {
      if (type == 'album') {
        return json['cover_xl'] ?? '';
      } else {
        return json['picture_xl'] ?? '';
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
