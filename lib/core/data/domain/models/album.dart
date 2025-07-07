class Album {
  final int id;
  final String title;
  final String cover;
  final String cover_small;
  final String cover_medium;
  final String cover_big;
  final String cover_xl;
  final String md5_image;
  final String tracklist;
  final String type;

 const Album({
    required this.id,
    required this.title,
    required this.cover,
    required this.cover_small,
    required this.cover_medium,
    required this.cover_big,
    required this.cover_xl,
    required this.md5_image,
    required this.tracklist,
    required this.type,
  });
}