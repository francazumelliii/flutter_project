import 'package:flutter/material.dart';
import '../../../core/widgets/sliders/item_slider.dart';

class HomeContent extends StatelessWidget {
  final List<Map<String, String>> tracks;
  final List<Map<String, String>> albums;
  final int currentIndex;
  final void Function(int index) onTrackSelected;
  final void Function(int albumId) onAlbumTap;

  const HomeContent({
    super.key,
    required this.tracks,
    required this.albums,
    required this.currentIndex,
    required this.onTrackSelected,
    required this.onAlbumTap,
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
      ],
    );
  }
}
