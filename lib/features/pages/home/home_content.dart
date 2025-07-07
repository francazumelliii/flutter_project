import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../core/widgets/sliders/item_slider.dart';

class HomeContent extends StatelessWidget {
  final List<Map<String, String>> tracks;
  final int currentIndex;
  final void Function(int index) onTrackSelected;

  const HomeContent({
    super.key,
    required this.tracks,
    required this.currentIndex,
    required this.onTrackSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
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
      ],
    );
  }
}
