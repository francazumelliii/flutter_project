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
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          child: Text(
            'Popular Tracks',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        ItemSlider(
          title: '',
          items: tracks,
          currentIndex: currentIndex,
          onTap: onTrackSelected,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          child: Text(
            'Top Albums',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        ItemSlider(
          title: '',
          items: albums,
          currentIndex: -1,
          onTap: (index) {
            final albumId = int.parse(albums[index]['albumId']!);
            onAlbumTap(albumId);
          },
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          child: Text(
            'Top Playlists',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        ItemSlider(
          title: '',
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
