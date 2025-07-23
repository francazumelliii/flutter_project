import 'package:flutter/material.dart';
import '../../../core/data/domain/models/artist.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/data/domain/models/audio_track.dart';
import '../../../core/data/domain/models/album.dart';
import '../../../core/widgets/headers/artist_header/artist_header.dart';
import '../../../core/widgets/items/album_tile.dart';
import '../../../core/widgets/items/related_artist_tile.dart';
import '../../../core/widgets/lists/track_list/track_list.dart';
import '../../../core/widgets/sliders/section_slider.dart';

class ArtistContent extends StatelessWidget {
  const ArtistContent({
    super.key,
    required this.artist,
    required this.topTracks,
    required this.albums,
    required this.relatedArtists,
    required this.currentIndex,
    required this.onPlayAll,
    required this.onAlbumTap,
    required this.onRelatedArtistTap,
    required this.onCreateRadio,
  });

  final Artist artist;
  final List<AudioTrack> topTracks;
  final List<Album> albums;
  final List<Artist> relatedArtists;
  final int currentIndex;
  final VoidCallback onPlayAll;
  final void Function(int albumId) onAlbumTap;
  final void Function(int artistId) onRelatedArtistTap;
  final VoidCallback onCreateRadio;


  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        ArtistHeader(
          artist: artist,
          onPlayAll: onPlayAll,
          onCreateRadio: onCreateRadio,
        ),
        const SizedBox(height: Dimensions.paddingLarge),
        TrackList(tracks: topTracks),
        const SizedBox(height: Dimensions.paddingLarge),
        if (albums.isNotEmpty)
          SectionSlider<Album>(
            title: 'Album',
            items: albums,
            itemBuilder: (context, album) => AlbumTile(album: album),
            onTap: (album) => onAlbumTap(album.id),
          ),
        if (relatedArtists.isNotEmpty) ...[
          const SizedBox(height: Dimensions.paddingLarge),
          SectionSlider<Artist>(
            title: 'Artisti simili',
            items: relatedArtists,
            itemBuilder: (context, artist) => RelatedArtistTile(artist: artist),
            onTap: (artist) => onRelatedArtistTap(artist.id),
          ),
        ],
        const SizedBox(height: 80),
      ],
    );
  }
}
