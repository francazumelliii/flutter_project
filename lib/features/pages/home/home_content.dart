import 'package:flutter/material.dart';
import '../../../core/widgets/sliders/item_slider.dart';

class HomeContent extends StatelessWidget {
  final List<Map<String, String>> tracks;
  final List<Map<String, String>> albums;
  final List<Map<String, String>> playlists;
  final int currentIndex;
  final void Function(int index) onTrackSelected;
  final void Function(int albumId) onAlbumTap;
  final void Function(int playlistId) onPlaylistTap;

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
      shrinkWrap: true,
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
            final albumId = int.parse(albums[index]['albumId']!);
            onAlbumTap(albumId);
          },
        ),

        ItemSlider(
          title: 'Top Playlists',
          items: playlists,
          currentIndex: -1,
          onTap: (index) {
            final playlistId = int.parse(playlists[index]['playlistId']!);
            onPlaylistTap(playlistId);
          },
        ),
      ],
    );
  }
}
