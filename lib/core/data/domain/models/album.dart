class Album {
  final int id;
  final String title;
  final String artist;
  final String coverUrl;

  Album({
    required this.id,
    required this.title,
    required this.artist,
    required this.coverUrl,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      title: json['title'] ?? '',
      artist: json['artist']?['name'] ?? '',
      coverUrl: json['cover_xl'] ?? '',
    );
  }
}
