class AudioTrack {
  final String title;
  final String subtitle;
  final String imageUrl;
  final String audioPreviewUrl;
  final int albumId;
  final int artistId;

  AudioTrack({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.audioPreviewUrl,
    required this.albumId,
    required this.artistId,
  });

  factory AudioTrack.fromJson(Map<String, dynamic> json) {
    return AudioTrack(
      title: json['title'] ?? '',
      subtitle: json['artist']?['name'] ?? '',
      imageUrl: json['album']?['cover_medium'] ?? '',
      audioPreviewUrl: json['preview'] ?? '',
      albumId: json['album']?['id'] ?? 0,
      artistId: json['artist']?['id'] ?? 0,
    );
  }
}
