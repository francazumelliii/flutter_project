import 'album.dart';
import 'artist.dart';

class Track {
  final int id;
  final String title;
  final String title_short;
  final String title_version;
  final String link;
  final double duration;
  final double rank;
  final bool explicit_lyrics;
  final double explicit_content_lyrics;
  final double explicit_content_cover;
  final String preview;
  final String md5_image;
  final int position;
  final Artist artist;
  final Album album;
  final String type;

  const Track({
    required this.id,
    required this.title,
    required this.title_short,
    required this.title_version,
    required this.link,
    required this.duration,
    required this.rank,
    required this.explicit_lyrics,
    required this.explicit_content_lyrics,
    required this.explicit_content_cover,
    required this.preview,
    required this.md5_image,
    required this.position,
    required this.artist,
    required this.album,
    required this.type,
  });
}
