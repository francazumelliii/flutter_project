import 'package:flutter/material.dart';
import '../../../core/widgets/sliders/item_slider.dart';

class HomeContent extends StatelessWidget {
  final List<Map<String, String>> tracks;
  final List<Map<String, String>> albums;
  final List<Map<String, String>> playlists;
  final int currentIndex;
  final void Function(int) onTrackSelected;
  final void Function(int) onAlbumTap;
  final void Function(int) onPlaylistTap;

  const HomeContent({
    super.key,
    required this.tracks,
    required this.albums,
    required this.playlists,
    required this.currentIndex,
    required this.onTrackSelected,
    required this.onAlbumTap,
    required this.onPlaylistTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ItemSlider(
          title: 'Top Tracks',
          items: tracks,
          currentIndex: currentIndex,
          onTap: onTrackSelected,
        ),
        ItemSlider(
          title: 'Top Albums',
          items: albums,
          currentIndex: -1,
          onTap: (index) {
            final id = int.tryParse(albums[index]['albumId'] ?? '');
            if (id != null) onAlbumTap(id);
          },
        ),
        ItemSlider(
          title: 'Top Playlists',
          items: playlists,
          currentIndex: -1,
          onTap: (index) {
            final id = int.tryParse(playlists[index]['playlistId'] ?? '');
            if (id != null) onPlaylistTap(id);
          },
        ),
      ],
    );
  }
}
