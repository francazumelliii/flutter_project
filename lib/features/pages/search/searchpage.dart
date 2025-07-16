import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/data/domain/models/audio_track.dart';
import '../../../core/data/services/data_service.dart';
import '../../../core/data/domain/controllers/audio_player_controller.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/widgets/lists/track_list/list_item.dart';
import '../albums/albumpage.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  final DataService dataService = DataService();

  List<AudioTrack> tracks = [];
  bool loading = false;

  void search(String query) async {
    if (query.isEmpty) {
      setState(() => tracks = []);
      return;
    }

    setState(() => loading = true);

    try {
      final result = await dataService.get('/search?q=$query');
      final list = result['data'] as List;
      final loaded = list.map((e) => AudioTrack.fromJson(e)).toList();
      setState(() => tracks = loaded);
    } catch (_) {
      setState(() => tracks = []);
    }

    setState(() => loading = false);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final audioCtrl = context.watch<AudioPlayerController>();
    final current = audioCtrl.currentIndex;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: TextField(
          controller: _controller,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.search, color: Colors.white),
            hintText: 'Search tracks...',
            hintStyle: TextStyle(color: Colors.white54),
            border: InputBorder.none,
          ),
          onSubmitted: search,
          textInputAction: TextInputAction.search,
        ),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : tracks.isEmpty
          ? const Center(child: Text('No results', style: TextStyle(color: Colors.white54)))
          : ListView.builder(
        padding: const EdgeInsets.all(Dimensions.paddingLarge),
        itemCount: tracks.length,
        itemBuilder: (context, index) {
          final track = tracks[index];
          final isSelected = index == current;

          return Padding(
            padding: EdgeInsets.only(
              bottom: index == tracks.length - 1 ? 0 : Dimensions.spacingSmall,
            ),
            child: TrackListItem(
              index: index,
              track: track,
              isSelected: isSelected,
              onTap: () {
                audioCtrl.setPlaylist(tracks);
                audioCtrl.playTrack(index);
              },
              onAlbumTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AlbumPage(albumId: track.albumId)),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
