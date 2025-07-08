class MediaCollection {
  final int id;
  final String title;
  final String subtitle; // artista o creatore
  final String coverUrl;
  final String type; // "album" o "playlist" o altri

  MediaCollection({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.coverUrl,
    required this.type,
  });
}
