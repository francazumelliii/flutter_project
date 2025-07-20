import 'package:flutter/material.dart';
import '../../../core/data/domain/models/audio_track.dart';
import '../../../core/data/domain/controllers/audio_player_controller.dart';
import '../../../core/widgets/inputs/category_filter.dart';
import '../../../core/widgets/inputs/search_bar.dart';
import '../../../core/widgets/lists/track_list/track_list.dart';


class SearchContent extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSearch;
  final bool loading;
  final List<AudioTrack> tracks;
  final List<String> categories;
  final String selectedCategory;
  final Function(String) onCategorySelected;
  final AudioPlayerController audioCtrl;

  const SearchContent({
    super.key,
    required this.controller,
    required this.onSearch,
    required this.loading,
    required this.tracks,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
    required this.audioCtrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchBarWidget(
          controller: controller,
          onSearch: onSearch,
        ),
        CategoryFilter(
          categories: categories,
          selectedCategory: selectedCategory,
          onCategorySelected: onCategorySelected,
        ),
        Expanded(
          child: loading
              ? const Center(child: CircularProgressIndicator())
              : TrackList(tracks: tracks),
        ),
      ],
    );
  }
}
